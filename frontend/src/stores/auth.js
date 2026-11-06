import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { api } from '@/services/api'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('ibuku_admin_token') || null)
  const admin = ref(JSON.parse(localStorage.getItem('ibuku_admin_profile') || 'null'))
  const loading = ref(false)

  const isAuthenticated = computed(() => !!token.value)

  function setAuth(newToken, adminData) {
    token.value = newToken
    admin.value = adminData
    localStorage.setItem('ibuku_admin_token', newToken)
    localStorage.setItem('ibuku_admin_profile', JSON.stringify(adminData))
  }

  function logout() {
    token.value = null
    admin.value = null
    localStorage.removeItem('ibuku_admin_token')
    localStorage.removeItem('ibuku_admin_profile')
  }

  async function checkAuth() {
    if (!token.value) return false
    try {
      loading.value = true
      const res = await api.getCurrentAdmin()
      admin.value = res.admin
      localStorage.setItem('ibuku_admin_profile', JSON.stringify(res.admin))
      return true
    } catch (e) {
      logout()
      return false
    } finally {
      loading.value = false
    }
  }

  return {
    token,
    admin,
    isAuthenticated,
    loading,
    setAuth,
    logout,
    checkAuth
  }
})

