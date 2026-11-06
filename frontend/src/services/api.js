const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api/v1'

function getAuthHeader() {
  const token = localStorage.getItem('ibuku_admin_token')
  return token ? { Authorization: `Bearer ${token}` } : {}
}

async function request(endpoint, options = {}) {
  const url = `${API_BASE}${endpoint}`
  const headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    ...getAuthHeader(),
    ...options.headers
  }

  const response = await fetch(url, { ...options, headers })
  const contentType = response.headers.get('content-type')

  let data
  if (contentType && contentType.includes('application/json')) {
    data = await response.json()
  } else {
    data = await response.text()
  }

  if (!response.ok) {
    const errorMsg = data?.error || (data?.errors ? data.errors.join(', ') : 'Server request failed')
    const err = new Error(errorMsg)
    err.status = response.status
    err.data = data
    throw err
  }

  return data
}

export const api = {
  // Authentication (Stateless OTP)
  requestOtp: (email) => request('/auth/request_otp', {
    method: 'POST',
    body: JSON.stringify({ email })
  }),

  verifyOtp: (email, otp) => request('/auth/verify_otp', {
    method: 'POST',
    body: JSON.stringify({ email, otp })
  }),

  getCurrentAdmin: () => request('/auth/me'),

  // Courses
  lookupCourse: (code) => request(`/courses/lookup?code=${encodeURIComponent(code)}`),

  getCourse: (idOrCode) => request(`/courses/${encodeURIComponent(idOrCode)}`),

  createCourse: (courseData) => request('/courses', {
    method: 'POST',
    body: JSON.stringify({ course: courseData })
  }),

  // Registrations
  createRegistration: (courseIdOrCode, payload) => request(`/courses/${encodeURIComponent(courseIdOrCode)}/registrations`, {
    method: 'POST',
    body: JSON.stringify({ registration: payload })
  }),

  checkRegistration: (courseIdOrCode, keyNumber) => request(`/courses/${encodeURIComponent(courseIdOrCode)}/registrations/check?key_number=${encodeURIComponent(keyNumber)}`),

  getRegistration: (id) => request(`/registrations/${id}`),

  updateRegistration: (courseIdOrCode, id, payload) => request(`/courses/${encodeURIComponent(courseIdOrCode)}/registrations/${id}`, {
    method: 'PATCH',
    body: JSON.stringify({ registration: payload })
  }),

  // Admin Dashboard
  getAdminStats: () => request('/admin/dashboard/stats'),

  getAdminStudents: (params = {}) => {
    const qs = new URLSearchParams(params).toString()
    return request(`/admin/dashboard/students?${qs}`)
  },

  updateStudentStatus: (id, payload) => request(`/admin/dashboard/students/${id}`, {
    method: 'PATCH',
    body: JSON.stringify(payload)
  }),

  // Admin Management
  getAdmins: () => request('/admin/admins'),

  registerAdmin: (adminData) => request('/admin/admins', {
    method: 'POST',
    body: JSON.stringify(adminData)
  }),

  deleteAdmin: (id) => request(`/admin/admins/${id}`, {
    method: 'DELETE'
  }),

  // CSV export helper with Bearer token & Blob download
  downloadCsv: async (courseId = null) => {
    const params = new URLSearchParams()
    if (courseId) params.append('course_id', courseId)
    const endpoint = `/admin/dashboard/export_all_csv${params.toString() ? '?' + params.toString() : ''}`

    const url = `${API_BASE}${endpoint}`
    const headers = {
      ...getAuthHeader()
    }

    const response = await fetch(url, { headers })
    if (!response.ok) {
      throw new Error(`Failed to download CSV: HTTP ${response.status}`)
    }

    const blob = await response.blob()
    const contentDisposition = response.headers.get('content-disposition')
    let filename = `IBUKU_Registry_Export_${new Date().toISOString().slice(0, 10)}.csv`
    if (contentDisposition) {
      const match = contentDisposition.match(/filename="?([^";]+)"?/)
      if (match && match[1]) filename = match[1]
    }

    const blobUrl = window.URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = blobUrl
    a.download = filename
    document.body.appendChild(a)
    a.click()
    document.body.removeChild(a)
    window.URL.revokeObjectURL(blobUrl)
  },

  getExportAllCsvUrl: (courseId = null) => {
    const token = localStorage.getItem('ibuku_admin_token')
    const params = new URLSearchParams()
    if (courseId) params.append('course_id', courseId)
    if (token) params.append('token', token)
    const qs = params.toString()
    return `${API_BASE}/admin/dashboard/export_all_csv${qs ? '?' + qs : ''}`
  },

  getCourseCsvUrl: (courseId) => {
    const token = localStorage.getItem('ibuku_admin_token')
    const base = `${API_BASE}/courses/${courseId}/export_csv`
    return token ? `${base}?token=${token}` : base
  }
}

