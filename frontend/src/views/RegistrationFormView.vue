<template>
  <div class="flex-1 max-w-5xl mx-auto w-full px-4 sm:px-6 py-6 sm:py-8 space-y-6">
    <!-- Header / Breadcrumbs -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs font-mono">
      <div class="flex items-center space-x-2 text-gruvbox-fg-muted">
        <router-link :to="`/courses/${courseCode}`" class="hover:text-gruvbox-fg flex items-center space-x-1">
          <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
          </svg>
          <span>REGISTRY</span>
        </router-link>
        <span>/</span>
        <span>CREDENTIAL_PIPELINE</span>
        <span>/</span>
        <span class="px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg font-medium">
          FORM_FLOW_03
        </span>
      </div>

      <div class="flex items-center space-x-2 text-[11px] font-mono">
        <span class="px-2.5 py-1 rounded bg-gruvbox-surface border border-gruvbox-border text-gruvbox-fg flex items-center space-x-1 shadow-sm">
          <svg class="w-3.5 h-3.5 text-gruvbox-green-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
          </svg>
          <span>LEDGER: #942,108</span>
        </span>
        <span class="px-2.5 py-1 rounded bg-gruvbox-surface border border-gruvbox-border text-gruvbox-fg-muted flex items-center space-x-1 shadow-sm">
          <svg class="w-3.5 h-3.5 text-gruvbox-yellow-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <polyline points="12 6 12 12 16 14"></polyline>
          </svg>
          <span>LATENCY: 14ms</span>
        </span>
      </div>
    </div>

    <!-- Main Title -->
    <div>
      <h1 class="text-2xl sm:text-3xl font-extrabold text-gruvbox-fg tracking-tight">
        Registration & Identity Verification
      </h1>
      <p class="text-xs sm:text-sm text-gruvbox-fg-muted mt-1 max-w-2xl leading-relaxed">
        Execute binding student record attestations and inspect identity records against centralized cryptographic registries prior to indelible ledger minting.
      </p>
    </div>

    <!-- Intercept Notice Banner -->
    <div v-if="interceptNotice" class="p-4 rounded-md bg-gruvbox-yellow-bg border border-gruvbox-yellow-dark/40 text-gruvbox-fg text-xs font-mono flex items-start space-x-3">
      <svg class="w-5 h-5 text-gruvbox-yellow-dark flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
      </svg>
      <div>
        <p class="font-bold text-gruvbox-yellow-dark mb-1">EXISTING ENROLLMENT INTERCEPTED</p>
        <p>{{ interceptNotice }}</p>
        <p class="text-[11px] text-gruvbox-fg-muted mt-1">Redirecting you to your certificate record in 2 seconds...</p>
      </div>
    </div>

    <!-- Main Form Grid (Matching Verification & Forms.png Left Card) -->
    <div class="max-w-2xl mx-auto w-full">
      <div class="gruvbox-card p-6 sm:p-8 border border-gruvbox-border shadow-gruvbox">
        <!-- Form Header -->
        <div class="flex items-center justify-between mb-6">
          <div class="flex items-center space-x-3">
            <div class="w-10 h-10 rounded-lg bg-gruvbox-surface-light border border-gruvbox-border flex items-center justify-center text-gruvbox-fg">
              <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zM4 19.235v-.11a6.375 6.375 0 0112.75 0v.109A12.318 12.318 0 0110.374 21c-2.331 0-4.512-.645-6.374-1.765z" />
              </svg>
            </div>
            <div>
              <h2 class="text-lg font-bold text-gruvbox-fg">
                {{ isEditMode ? 'Edit Certificate Name' : 'Register New Name' }}
              </h2>
              <p class="text-xs text-gruvbox-fg-muted">
                {{ isEditMode ? 'Orthographic adjustment before batch seal' : 'Authoritative credential entry & engraving prep' }}
              </p>
            </div>
          </div>

          <span class="px-2.5 py-1 rounded bg-gruvbox-surface-light border border-gruvbox-border text-[11px] font-mono text-gruvbox-fg-muted uppercase font-semibold">
            {{ isEditMode ? 'EDIT MODE' : 'Step 1 of 2' }}
          </span>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Key Number Field -->
          <div>
            <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1.5 font-semibold">
              <label for="key-number" class="flex items-center space-x-1.5">
                <svg class="w-3.5 h-3.5 text-gruvbox-yellow-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z" />
                </svg>
                <span>KEY NUMBER</span>
              </label>
              <span class="text-gruvbox-fg-muted">REQUIRED &bull; 8-DIGIT</span>
            </div>

            <div class="relative">
              <input
                id="key-number"
                v-model="form.key_number"
                type="text"
                placeholder="E.G. KEY-8824-A"
                class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm uppercase tracking-wider font-mono pr-10"
                :disabled="isEditMode"
                :class="{ 'opacity-70 bg-gruvbox-surface-light cursor-not-allowed': isEditMode }"
                @input="form.key_number = form.key_number.toUpperCase()"
                required
              />
              <div v-if="form.key_number.length >= 6" class="absolute inset-y-0 right-0 pr-3 flex items-center text-gruvbox-green-dark">
                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
            </div>
            <p class="text-[11px] font-mono text-gruvbox-fg-muted mt-1.5">
              ⓘ Assigned cryptographic token printed on official student index badge
            </p>
          </div>

          <!-- Full Name Field -->
          <div>
            <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1.5 font-semibold">
              <label for="full-name" class="flex items-center space-x-1.5">
                <svg class="w-3.5 h-3.5 text-gruvbox-teal" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
                </svg>
                <span>FULL NAME (TO BE PRINTED ON CERTIFICATE)</span>
              </label>
              <span class="text-gruvbox-fg-muted">LEGAL SPEC</span>
            </div>

            <div class="relative">
              <input
                id="full-name"
                v-model="form.full_name"
                type="text"
                placeholder="Dr. Eleanor Vance, M.Sc."
                class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm tracking-wide pr-10 font-medium"
                required
              />
              <button
                v-if="form.full_name"
                type="button"
                @click="form.full_name = ''"
                class="absolute inset-y-0 right-0 pr-3 flex items-center text-gruvbox-fg-muted hover:text-gruvbox-fg"
              >
                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            <p class="text-[11px] font-mono text-gruvbox-fg-muted mt-1.5">
              Ensure spelling, middle initials, accents, and honorifics strictly match photo ID
            </p>
          </div>

          <!-- Parchment Emulsion Print Preview (Real-time live rendering!) -->
          <div class="rounded-lg border border-gruvbox-border bg-gruvbox-surface-light/40 p-4 space-y-2">
            <div class="flex items-center justify-between text-[10px] font-mono text-gruvbox-fg-muted font-bold tracking-wider">
              <span class="flex items-center space-x-1">
                <svg class="w-3.5 h-3.5 text-gruvbox-fg-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6.72 13.829c-.24-1.205.08-2.471.86-3.414l6.5-7.8a2.5 2.5 0 013.84 3.2l-6.5 7.8c-.78.943-2.046 1.46-3.25 1.22l-4.5-1.006 1.05-4.5z" />
                </svg>
                <span>PARCHMENT EMULSION PRINT PREVIEW</span>
              </span>
              <span>KERNING: OPTICAL</span>
            </div>

            <!-- Parchment preview box -->
            <div class="parchment-frame rounded p-6 sm:p-8 text-center border border-gruvbox-border/80 relative">
              <p class="text-[10px] font-mono uppercase tracking-widest text-gruvbox-fg-muted font-bold mb-3">
                OFFICIAL DIPLOMA RECIPIENT LINE
              </p>

              <!-- Live Formatted Student Name in Elegant Serif Font -->
              <div class="min-h-[48px] flex items-center justify-center">
                <span
                  class="font-serif text-2xl sm:text-3xl text-gruvbox-fg-dark italic font-semibold tracking-wide transition-all select-none"
                  :class="{ 'opacity-30': !form.full_name }"
                >
                  {{ form.full_name || 'Candidate Name Preview' }}
                </span>
              </div>

              <!-- Decorative golden accent bar below name -->
              <div class="w-24 h-0.5 bg-gruvbox-yellow-dark mx-auto mt-3 rounded-full"></div>
            </div>
          </div>

          <!-- Security Hold Notice -->
          <div class="p-3.5 rounded bg-gruvbox-surface-light/60 border border-gruvbox-border text-xs flex items-start space-x-2.5 text-gruvbox-fg-muted">
            <svg class="w-4 h-4 text-gruvbox-orange flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m0-10.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.75c0 5.592 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.57-.598-3.75h-.152c-3.196 0-6.1-1.249-8.25-3.286zm0 13.036h.008v.008H12v-.008z" />
            </svg>
            <span class="leading-relaxed">
              Submitted records enter a 24-hour verification hold before permanent ledger minting and physical engraving stamp creation.
            </span>
          </div>

          <!-- Error Alert -->
          <div v-if="submissionError" class="p-3 rounded bg-gruvbox-red-bg border border-gruvbox-red/40 text-gruvbox-red text-xs font-mono">
            {{ submissionError }}
          </div>

          <!-- Action Buttons -->
          <div class="flex flex-col sm:flex-row items-center gap-3 pt-2">
            <button
              type="submit"
              :disabled="submitting || !form.key_number.trim() || !form.full_name.trim()"
              class="w-full sm:flex-1 btn-gruvbox-primary py-3 text-xs tracking-wider flex items-center justify-center space-x-2"
            >
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <span>{{ submitting ? 'PROCESSING...' : (isEditMode ? 'UPDATE CERTIFICATE NAME' : 'SUBMIT REGISTRATION') }}</span>
            </button>

            <button
              type="button"
              @click="handleReset"
              class="w-full sm:w-auto btn-gruvbox-secondary py-3 text-xs tracking-wider px-6"
            >
              Reset Form
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { api } from '@/services/api'

const props = defineProps({
  mode: {
    type: String,
    default: 'create' // 'create' or 'edit'
  }
})

const route = useRoute()
const router = useRouter()
const courseCode = ref(route.params.course_code)
const registrationId = ref(route.params.id)

const isEditMode = computed(() => props.mode === 'edit' || !!registrationId.value)

const form = reactive({
  key_number: '',
  full_name: '',
  email: ''
})

const submitting = ref(false)
const submissionError = ref('')
const interceptNotice = ref('')

async function loadExistingRecord() {
  if (!isEditMode.value || !registrationId.value) return

  try {
    const data = await api.getRegistration(registrationId.value)
    form.key_number = data.registration.key_number
    form.full_name = data.registration.full_name
    form.email = data.registration.email || ''
  } catch (err) {
    submissionError.value = 'Failed to load existing registration for editing.'
  }
}

function handleReset() {
  if (isEditMode.value) {
    loadExistingRecord()
  } else {
    form.key_number = ''
    form.full_name = ''
    form.email = ''
  }
  submissionError.value = ''
  interceptNotice.value = ''
}

async function handleSubmit() {
  submitting.value = true
  submissionError.value = ''
  interceptNotice.value = ''

  try {
    if (isEditMode.value) {
      // Update Name
      const res = await api.updateRegistration(courseCode.value, registrationId.value, {
        full_name: form.full_name
      })
      router.push(`/courses/${courseCode.value}/certificate/${res.registration.id}`)
    } else {
      // New Registration
      const res = await api.createRegistration(courseCode.value, {
        key_number: form.key_number,
        full_name: form.full_name,
        email: form.email
      })

      // Intercept check
      if (res.intercepted) {
        interceptNotice.value = res.message
        setTimeout(() => {
          router.push(res.redirect_to || `/courses/${courseCode.value}/certificate/${res.registration.id}`)
        }, 2200)
      } else {
        router.push(res.redirect_to || `/courses/${courseCode.value}/certificate/${res.registration.id}`)
      }
    }
  } catch (err) {
    submissionError.value = err.message || 'Error submitting registration to ledger.'
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadExistingRecord()
})
</script>

