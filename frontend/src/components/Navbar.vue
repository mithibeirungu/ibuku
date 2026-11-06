<template>
  <header class="w-full border-b border-gruvbox-border bg-gruvbox-surface/40 backdrop-blur px-6 py-3.5 flex items-center justify-between sticky top-0 z-30">
    <!-- Brand / Logo -->
    <div class="flex items-center space-x-3">
      <router-link to="/" class="flex items-center space-x-2.5 group">
        <div class="w-8 h-8 rounded-md bg-gruvbox-surface border border-gruvbox-border flex items-center justify-center text-gruvbox-green-dark group-hover:border-gruvbox-green transition-colors">
          <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
          </svg>
        </div>
        <div class="flex items-center space-x-2">
          <span class="font-extrabold tracking-tight text-gruvbox-fg text-lg">IBUKU</span>
          <span class="text-[10px] font-mono px-1.5 py-0.5 rounded bg-gruvbox-border/50 text-gruvbox-fg-muted uppercase font-semibold">v1.0</span>
        </div>
      </router-link>
    </div>

    <!-- Center Context Pill -->
    <div v-if="contextPill" class="hidden md:flex items-center">
      <div class="px-3.5 py-1 rounded bg-gruvbox-surface border border-gruvbox-border text-xs font-mono text-gruvbox-fg font-medium flex items-center space-x-2 shadow-sm">
        <span class="w-1.5 h-1.5 rounded-full bg-gruvbox-green animate-pulse"></span>
        <span>{{ contextPill }}</span>
      </div>
    </div>

    <!-- Right-aligned Admin Section -->
    <div class="flex items-center space-x-3">
      <!-- Admin logged in -->
      <template v-if="authStore.isAuthenticated">
        <div class="flex items-center space-x-3">
          <div class="hidden sm:flex flex-col text-right">
            <span class="text-xs font-bold text-gruvbox-fg leading-tight">{{ authStore.admin?.name || 'Mithibe Irungu' }}</span>
            <span class="text-[10px] font-mono text-gruvbox-green-dark font-semibold tracking-wider uppercase">
              {{ authStore.admin?.role === 'super_admin' ? 'SUPER-ADMIN (L4)' : 'REGISTRAR (L4)' }}
            </span>
          </div>

          <router-link to="/admin/dashboard" title="Admin Dashboard" class="w-9 h-9 rounded-md bg-gruvbox-yellow-dark text-gruvbox-bg font-bold font-mono text-xs flex items-center justify-center hover:opacity-90 transition-opacity">
            {{ userInitials }}
          </router-link>

          <button @click="handleLogout" title="Sign Out" class="p-2 rounded-md text-gruvbox-fg-muted hover:text-gruvbox-red hover:bg-gruvbox-surface transition-colors">
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75" />
            </svg>
          </button>
        </div>
      </template>

      <!-- Guest user: Admin Login Button -->
      <template v-else>
        <router-link
          to="/admin/login"
          class="w-8 h-8 rounded-full border border-gruvbox-border bg-gruvbox-surface/80 hover:bg-gruvbox-surface flex items-center justify-center text-gruvbox-fg-muted hover:text-gruvbox-fg transition-all"
          title="Administrative Registrar Login"
        >
          <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
          </svg>
        </router-link>
      </template>
    </div>
  </header>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const contextPill = computed(() => {
  if (route.name === 'admin-dashboard') return 'Admin Dashboard'
  if (route.name === 'admin-login') return 'Admin Auth Portal'
  if (route.name === 'course') return 'Student Portal'
  if (route.name === 'register-new' || route.name === 'certificate-edit') return 'Verification & Forms'
  if (route.name === 'certificate-view') return 'Verification & Forms'
  return null
})

const userInitials = computed(() => {
  const name = authStore.admin?.name || 'Mithibe Irungu'
  return name.split(' ').map(n => n[0]).filter(Boolean).slice(0, 2).join('').toUpperCase() || 'MI'
})

function handleLogout() {
  authStore.logout()
  router.push('/')
}
</script>

