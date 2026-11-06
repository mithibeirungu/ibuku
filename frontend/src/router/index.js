import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

import HomeView from '@/views/HomeView.vue'
import CourseView from '@/views/CourseView.vue'
import RegistrationFormView from '@/views/RegistrationFormView.vue'
import CertificateView from '@/views/CertificateView.vue'
import AdminLoginView from '@/views/AdminLoginView.vue'
import AdminDashboardView from '@/views/AdminDashboardView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
    meta: { title: 'Home - Enter Course Code' }
  },
  {
    path: '/courses/:course_code',
    name: 'course',
    component: CourseView,
    meta: { title: 'Course Verification Portal' }
  },
  {
    path: '/courses/:course_code/register',
    name: 'register-new',
    component: RegistrationFormView,
    props: { mode: 'create' },
    meta: { title: 'Register Certificate Name' }
  },
  {
    path: '/courses/:course_code/certificate/:id',
    name: 'certificate-view',
    component: CertificateView,
    meta: { title: 'Certificate Name Verification' }
  },
  {
    path: '/courses/:course_code/certificate/:id/edit',
    name: 'certificate-edit',
    component: RegistrationFormView,
    props: { mode: 'edit' },
    meta: { title: 'Edit Certificate Name' }
  },
  {
    path: '/admin/login',
    name: 'admin-login',
    component: AdminLoginView,
    meta: { title: 'Admin Ledger Login' }
  },
  {
    path: '/admin/dashboard',
    name: 'admin-dashboard',
    component: AdminDashboardView,
    meta: { requiresAuth: true, title: 'Admin Archival Ledger Dashboard' }
  },
  {
    path: '/:pathMatch(.*)*',
    redirect: '/'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 }
  }
})

router.beforeEach(async (to, from, next) => {
  document.title = to.meta.title ? `${to.meta.title} | IBUKU` : 'IBUKU'

  const authStore = useAuthStore()

  if (to.meta.requiresAuth) {
    if (!authStore.isAuthenticated) {
      next({ name: 'admin-login', query: { redirect: to.fullPath } })
      return
    }
  }

  if (to.name === 'admin-login' && authStore.isAuthenticated) {
    next({ name: 'admin-dashboard' })
    return
  }

  next()
})

export default router

