<template>
  <div class="flex-1 flex items-center justify-center p-4 sm:p-6 my-auto">
    <div class="w-full max-w-md gruvbox-card p-6 sm:p-8 relative overflow-hidden shadow-gruvbox border border-gruvbox-border">
      <!-- Top Decorative Accent Bar -->
      <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-gruvbox-yellow via-gruvbox-green to-gruvbox-aqua"></div>

      <!-- Pill Header -->
      <div class="text-center mb-6">
        <span class="inline-flex items-center px-3 py-1 rounded bg-gruvbox-surface-light/70 border border-gruvbox-border text-[11px] font-mono font-semibold tracking-widest text-gruvbox-green-dark uppercase">
          <svg class="w-3 h-3 mr-1.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
            <path d="M7 11V7a5 5 0 0110 0v4"></path>
          </svg>
          Official Registration
        </span>
      </div>

      <!-- Main Heading & Subtitle -->
      <h1 class="text-2xl sm:text-3xl font-extrabold text-gruvbox-fg mb-2.5 tracking-tight text-center sm:text-left">
        Enter Course Code
      </h1>
      <p class="text-xs sm:text-sm text-gruvbox-fg-muted mb-6 leading-relaxed">
        Provide the 6-character course key provided by your instructor or institution to access your certificate issuance session.
      </p>

      <!-- Form -->
      <form @submit.prevent="handleContinue" class="space-y-4">
        <div>
          <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1.5 font-semibold">
            <label for="course-code" class="flex items-center space-x-1.5">
              <svg class="w-3.5 h-3.5 text-gruvbox-yellow-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z" />
              </svg>
              <span>COURSE VOUCHER KEY / ID</span>
            </label>
            <span>{{ courseCode.length }} / 7 CHARS</span>
          </div>

          <div class="relative">
            <input
              id="course-code"
              v-model="courseCode"
              type="text"
              maxlength="10"
              placeholder="E.G. CS-4091 OR BIO-102"
              class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm uppercase tracking-wider font-mono pr-10"
              :class="{ 'border-gruvbox-red': errorMessage }"
              @input="formatCode"
              required
            />
            <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none text-gruvbox-fg-muted">
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z" />
              </svg>
            </div>
          </div>

          <div class="flex items-center space-x-1.5 mt-2 text-[11px] font-mono text-gruvbox-fg-muted">
            <svg class="w-3.5 h-3.5 text-gruvbox-blue-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="12" y1="16" x2="12" y2="12"></line>
              <line x1="12" y1="8" x2="12.01" y2="8"></line>
            </svg>
            <span>Format: AAA-### (Standard Institutional Format)</span>
          </div>

          <p v-if="errorMessage" class="text-xs font-mono text-gruvbox-red mt-2">
            {{ errorMessage }}
          </p>
        </div>

        <button
          type="submit"
          :disabled="loading || !courseCode.trim()"
          class="w-full btn-gruvbox-primary py-3 text-xs tracking-wider font-mono flex items-center justify-center space-x-2 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <span v-if="!loading">CONTINUE TO COURSE &rarr;</span>
          <span v-else class="flex items-center space-x-2">
            <svg class="animate-spin h-4 w-4" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            <span>VERIFYING REGISTRY...</span>
          </span>
        </button>
      </form>

      <!-- Divider -->
      <div class="relative my-6">
        <div class="absolute inset-0 flex items-center">
          <div class="w-full border-t border-gruvbox-border"></div>
        </div>
        <div class="relative flex justify-center text-[10px] font-mono uppercase tracking-widest">
          <span class="bg-gruvbox-surface px-3 text-gruvbox-fg-muted font-semibold">Or Point Camera</span>
        </div>
      </div>

      <!-- QR Scanner Button -->
      <button
        type="button"
        @click="showScanner = true"
        class="w-full btn-gruvbox-secondary py-2.5 text-xs tracking-wider flex items-center justify-center space-x-2 text-gruvbox-fg font-mono"
      >
        <svg class="w-4 h-4 text-gruvbox-teal" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 4.875c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5A1.125 1.125 0 013.75 9.375v-4.5zM3.75 14.625c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5a1.125 1.125 0 01-1.125-1.125v-4.5zM13.5 4.875c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5A1.125 1.125 0 0113.5 9.375v-4.5z" />
          <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 6.75h.75v.75h-.75v-.75zM6.75 16.5h.75v.75h-.75v-.75zM16.5 6.75h.75v.75h-.75v-.75zM13.5 13.5h3v3h-3v-3zM16.5 16.5h3v3h-3v-3zM19.5 13.5h.75v.75h-.75v-.75zM13.5 19.5h.75v.75h-.75v-.75z" />
        </svg>
        <span>Scan QR Code via Camera</span>
      </button>

      <!-- Assistance Footer -->
      <div class="mt-6 pt-4 border-t border-gruvbox-border/60 flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted">
        <span class="flex items-center space-x-1">
          <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <path d="M9.09 9a3 3 0 015.83 1c0 2-3 3-3 3"></path>
            <line x1="12" y1="17" x2="12.01" y2="17"></line>
          </svg>
          <span>Need assistance?</span>
        </span>
        <button @click="showSupport = true" class="text-gruvbox-teal hover:underline font-semibold flex items-center space-x-1">
          <span>Contact registrar desk &rarr;</span>
        </button>
      </div>
    </div>

    <!-- QR Scanner Simulation Modal -->
    <div v-if="showScanner" class="fixed inset-0 bg-gruvbox-fg-dark/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="gruvbox-card max-w-sm w-full p-6 relative border border-gruvbox-border shadow-lg">
        <h3 class="text-base font-bold text-gruvbox-fg mb-2 flex items-center space-x-2">
          <svg class="w-4 h-4 text-gruvbox-teal" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M6.827 6.175A2.31 2.31 0 015.186 7.23c-.38.054-.757.112-1.134.175C2.999 7.58 2.25 8.507 2.25 9.574V18a2.25 2.25 0 002.25 2.25h15A2.25 2.25 0 0021.75 18V9.574c0-1.067-.75-1.994-1.802-2.169a47.865 47.865 0 00-1.134-.175 2.31 2.31 0 01-1.64-1.055l-.822-1.316a2.192 2.192 0 00-1.736-1.039 48.774 48.774 0 00-5.232 0 2.192 2.192 0 00-1.736 1.039l-.821 1.316z" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 12.75a4.5 4.5 0 11-9 0 4.5 4.5 0 019 0zM18.75 10.5h.008v.008h-.008V10.5z" />
          </svg>
          <span>Optical QR Code Reader</span>
        </h3>
        <p class="text-xs text-gruvbox-fg-muted mb-4">
          Point your device camera at the classroom screen or enter the deep-link payload from your instructor.
        </p>

        <!-- Simulated viewfinder -->
        <div class="h-44 bg-gruvbox-fg-dark/90 rounded border-2 border-dashed border-gruvbox-green flex flex-col items-center justify-center text-gruvbox-bg p-4 mb-4 relative overflow-hidden">
          <div class="absolute inset-x-0 h-0.5 bg-gruvbox-green/80 animate-bounce"></div>
          <p class="text-xs font-mono text-center text-gruvbox-surface-light">ALIGN QR CODE WITHIN BOUNDS</p>
          <span class="text-[10px] font-mono text-gruvbox-surface-subtle mt-2">Simulated Optical Node #04</span>
        </div>

        <div class="space-y-2 mb-4">
          <label class="text-[11px] font-mono text-gruvbox-fg font-semibold">Or Quick Jump to Seeded Course:</label>
          <div class="flex space-x-2">
            <button @click="selectQuickCode('CS-4091')" class="px-2.5 py-1 text-xs font-mono bg-gruvbox-surface-light hover:bg-gruvbox-border rounded border border-gruvbox-border">
              CS-4091
            </button>
            <button @click="selectQuickCode('BIO-102')" class="px-2.5 py-1 text-xs font-mono bg-gruvbox-surface-light hover:bg-gruvbox-border rounded border border-gruvbox-border">
              BIO-102
            </button>
          </div>
        </div>

        <button @click="showScanner = false" class="w-full btn-gruvbox-secondary py-2 text-xs font-mono">
          Cancel
        </button>
      </div>
    </div>

    <!-- Support Modal -->
    <div v-if="showSupport" class="fixed inset-0 bg-gruvbox-fg-dark/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="gruvbox-card max-w-sm w-full p-6 border border-gruvbox-border shadow-lg">
        <h3 class="text-base font-bold text-gruvbox-fg mb-2">Registrar Information Desk</h3>
        <p class="text-xs text-gruvbox-fg-muted mb-3 leading-relaxed">
          For assistance with your course token, please contact your department coordinator or the academic registry:
        </p>
        <div class="p-3 bg-gruvbox-surface-light/60 rounded border border-gruvbox-border font-mono text-xs space-y-1 mb-4">
          <p><strong>Email:</strong> registrar@ibuku.edu</p>
          <p><strong>Office:</strong> Hall of Registry, Suite 409</p>
          <p><strong>Hours:</strong> Mon - Fri 08:00 - 18:00 EST</p>
        </div>
        <button @click="showSupport = false" class="w-full btn-gruvbox-secondary py-2 text-xs font-mono">
          Dismiss
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { api } from '@/services/api'

const router = useRouter()
const courseCode = ref('')
const loading = ref(false)
const errorMessage = ref('')
const showScanner = ref(false)
const showSupport = ref(false)

function formatCode() {
  courseCode.value = courseCode.value.toUpperCase().replace(/\s+/g, '')
  errorMessage.value = ''
}

function selectQuickCode(code) {
  courseCode.value = code
  showScanner.value = false
  handleContinue()
}

async function handleContinue() {
  const code = courseCode.value.trim().toUpperCase()
  if (!code) return

  loading.value = true
  errorMessage.value = ''

  try {
    const course = await api.lookupCourse(code)
    router.push(`/courses/${course.course_code}`)
  } catch (err) {
    errorMessage.value = err.message || `Course "${code}" not found in ledger.`
  } finally {
    loading.value = false
  }
}
</script>

