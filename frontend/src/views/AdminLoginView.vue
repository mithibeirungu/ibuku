<template>
  <div class="flex-1 flex items-center justify-center p-4 sm:p-6 my-auto">
    <div class="w-full max-w-md gruvbox-card p-6 sm:p-8 relative overflow-hidden border border-gruvbox-border shadow-gruvbox">
      <!-- Top Decorative Accent -->
      <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-gruvbox-yellow via-gruvbox-green to-gruvbox-aqua"></div>

      <!-- Pill Header -->
      <div class="text-center mb-6">
        <span class="inline-flex items-center px-3 py-1 rounded bg-gruvbox-surface-light border border-gruvbox-border text-[11px] font-mono font-semibold tracking-widest text-gruvbox-yellow-dark uppercase">
          <svg class="w-3 h-3 mr-1.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 10-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H6.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z" />
          </svg>
          Registrar Access Control
        </span>
      </div>

      <!-- Main Heading -->
      <h1 class="text-2xl font-extrabold text-gruvbox-fg mb-1.5 tracking-tight text-center sm:text-left">
        Administrative Login
      </h1>
      <p class="text-xs sm:text-sm text-gruvbox-fg-muted mb-6 leading-relaxed">
        Guarded by secure, stateless email OTP authentication. No permanent password dependencies.
      </p>

      <!-- Step 1: Request OTP -->
      <form v-if="step === 1" @submit.prevent="handleRequestOtp" class="space-y-4">
        <div>
          <label for="admin-email" class="block text-[11px] font-mono font-semibold text-gruvbox-fg-muted uppercase mb-1.5">
            REGISTRAR AUTHORIZED EMAIL
          </label>
          <div class="relative">
            <input
              id="admin-email"
              v-model="email"
              type="email"
              placeholder="mithibeirungu@gmail.com"
              class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm font-mono pr-10"
              required
            />
            <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none text-gruvbox-fg-muted">
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" />
              </svg>
            </div>
          </div>
        </div>

        <!-- Quick Fill Super-Admin Button -->
        <div class="text-[11px] font-mono text-gruvbox-fg-muted flex flex-col sm:flex-row items-start sm:items-center justify-between gap-1">
          <span>Default Super-Admin:</span>
          <button
            type="button"
            @click="email = 'mithibeirungu@gmail.com'"
            class="text-gruvbox-teal underline hover:text-gruvbox-aqua-dark font-semibold"
          >
            mithibeirungu@gmail.com
          </button>
        </div>

        <div v-if="error" class="p-3 rounded bg-gruvbox-red-bg border border-gruvbox-red/40 text-xs font-mono text-gruvbox-red flex items-start space-x-2">
          <svg class="w-4 h-4 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
          </svg>
          <div>
            <p class="font-bold">SYSTEM NOTICE:</p>
            <p class="mt-0.5 leading-relaxed">{{ error }}</p>
          </div>
        </div>

        <button
          type="submit"
          :disabled="loading || !email.trim()"
          class="w-full btn-gruvbox-primary py-3 text-xs tracking-wider"
        >
          <span v-if="!loading">Request One-Time Passcode &rarr;</span>
          <span v-else>Dispatching Code...</span>
        </button>
      </form>

      <!-- Step 2: Verify OTP -->
      <form v-else @submit.prevent="handleVerifyOtp" class="space-y-4">
        <!-- Dev OTP Banner if returned -->
        <div v-if="devOtp" class="p-3 bg-gruvbox-green-bg border border-gruvbox-green/50 rounded text-xs font-mono text-gruvbox-green-dark">
          <p class="font-bold flex items-center space-x-1">
            <span>[DEV/DEMO OTP KEY]:</span>
            <span class="text-base tracking-widest bg-gruvbox-surface-light px-2 py-0.5 rounded border border-gruvbox-green select-all">{{ devOtp }}</span>
          </p>
          <button type="button" @click="otp = devOtp" class="text-[10px] underline mt-1 font-sans">
            Auto-fill this code
          </button>
        </div>

        <div>
          <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1.5 font-semibold">
            <label for="otp-code">6-DIGIT VERIFICATION PASSCODE</label>
            <button type="button" @click="step = 1; otp = ''; error = ''" class="text-gruvbox-teal hover:underline">
              Change email
            </button>
          </div>

          <input
            id="otp-code"
            v-model="otp"
            type="text"
            maxlength="6"
            placeholder="&bull; &bull; &bull; &bull; &bull; &bull;"
            class="w-full px-3.5 py-3 gruvbox-input rounded text-xl text-center tracking-[0.5em] font-mono font-bold"
            required
            autofocus
          />
          <p class="text-[11px] font-mono text-gruvbox-fg-muted mt-1.5 text-center">
            Passcode sent to {{ email }}. Expires in 10 minutes.
          </p>
        </div>

        <div v-if="error" class="p-3 rounded bg-gruvbox-red-bg border border-gruvbox-red/40 text-xs font-mono text-gruvbox-red flex items-start space-x-2">
          <svg class="w-4 h-4 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
          </svg>
          <div>
            <p class="font-bold">SYSTEM NOTICE:</p>
            <p class="mt-0.5 leading-relaxed">{{ error }}</p>
          </div>
        </div>

        <button
          type="submit"
          :disabled="loading || otp.length < 6"
          class="w-full btn-gruvbox-primary py-3 text-xs tracking-wider"
        >
          <span v-if="!loading">Verify & Enter Dashboard &rarr;</span>
          <span v-else>Verifying Ledger Auth...</span>
        </button>

        <button
          type="button"
          @click="handleRequestOtp"
          :disabled="loading"
          class="w-full btn-gruvbox-secondary py-2 text-xs font-mono"
        >
          Resend Passcode
        </button>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { api } from '@/services/api'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const step = ref(1)
const email = ref('mithibeirungu@gmail.com')
const otp = ref('')
const devOtp = ref('')
const loading = ref(false)
const error = ref('')

async function handleRequestOtp() {
  loading.value = true
  error.value = ''
  try {
    const res = await api.requestOtp(email.value)
    devOtp.value = res.dev_otp || ''
    step.value = 2
  } catch (err) {
    error.value = err.message || 'Failed to dispatch OTP. Please verify email address.'
  } finally {
    loading.value = false
  }
}

async function handleVerifyOtp() {
  loading.value = true
  error.value = ''
  try {
    const res = await api.verifyOtp(email.value, otp.value)
    authStore.setAuth(res.token, res.admin)

    const redirectPath = route.query.redirect || '/admin/dashboard'
    router.push(redirectPath)
  } catch (err) {
    error.value = err.message || 'Passcode verification failed.'
  } finally {
    loading.value = false
  }
}
</script>

