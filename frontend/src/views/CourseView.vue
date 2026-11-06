<template>
  <div class="flex-1 max-w-5xl mx-auto w-full px-4 sm:px-6 py-6 sm:py-8 space-y-6">
    <!-- Breadcrumbs & Status -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs font-mono">
      <div class="flex items-center space-x-2 text-gruvbox-fg-muted">
        <router-link to="/" class="hover:text-gruvbox-fg flex items-center space-x-1">
          <span>&larr; Courses</span>
        </router-link>
        <span>/</span>
        <span class="text-gruvbox-fg font-semibold">{{ courseCode }}</span>
        <span>/</span>
        <span class="px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg font-medium">
          Action Selection
        </span>
      </div>

      <div class="flex items-center space-x-2 self-start sm:self-auto">
        <span class="px-2.5 py-1 rounded bg-gruvbox-surface border border-gruvbox-border text-gruvbox-fg font-mono text-[11px] font-semibold flex items-center space-x-1.5 shadow-sm">
          <svg class="w-3.5 h-3.5 text-gruvbox-green-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
          </svg>
          <span>SESSION: {{ course?.registration_open ? 'ACTIVE' : 'LOCKED' }}</span>
        </span>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="gruvbox-card p-12 text-center text-gruvbox-fg-muted font-mono">
      <div class="animate-spin inline-block w-8 h-8 border-3 border-gruvbox-green-dark border-t-transparent rounded-full mb-3"></div>
      <p>Loading course ledger details...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="gruvbox-card p-8 text-center border-gruvbox-red">
      <p class="text-gruvbox-red font-mono text-sm mb-4">{{ error }}</p>
      <router-link to="/" class="btn-gruvbox-secondary text-xs">Return to Home</router-link>
    </div>

    <!-- Course Content -->
    <template v-else-if="course">
      <!-- Course Hero Card -->
      <div class="gruvbox-card p-6 sm:p-8 relative overflow-hidden border border-gruvbox-border shadow-gruvbox">
        <!-- Top decorative gradient line -->
        <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-gruvbox-yellow via-gruvbox-green to-gruvbox-aqua"></div>

        <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-6">
          <div class="space-y-3">
            <!-- Tags -->
            <div class="flex flex-wrap items-center gap-2 text-xs font-mono font-medium">
              <span class="px-2.5 py-0.5 rounded bg-gruvbox-yellow-bg border border-gruvbox-yellow-dark/40 text-gruvbox-yellow-dark font-bold flex items-center space-x-1">
                <svg class="w-3 h-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" />
                </svg>
                <span>{{ course.course_code }}</span>
              </span>

              <span class="px-2.5 py-0.5 rounded bg-gruvbox-aqua-bg border border-gruvbox-aqua/40 text-gruvbox-aqua-dark font-semibold flex items-center space-x-1">
                <svg class="w-3 h-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342" />
                </svg>
                <span>{{ course.department || 'Dept. of Computer Science' }}</span>
              </span>

              <span class="px-2.5 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg-muted">
                {{ course.cohort || 'Cohort: Q4 2026' }}
              </span>
            </div>

            <!-- Title -->
            <h1 class="text-2xl sm:text-3xl font-extrabold text-gruvbox-fg tracking-tight">
              {{ course.name }}
            </h1>

            <!-- Dates -->
            <div class="flex items-center space-x-2 text-xs text-gruvbox-fg-muted font-medium">
              <svg class="w-4 h-4 text-gruvbox-fg-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                <line x1="16" y1="2" x2="16" y2="6"></line>
                <line x1="8" y1="2" x2="8" y2="6"></line>
                <line x1="3" y1="10" x2="21" y2="10"></line>
              </svg>
              <span>{{ course.formatted_date_range }}</span>
              <span>&bull;</span>
              <span>Academic Term Q4 2026</span>
            </div>
          </div>

          <!-- Cutoff Box -->
          <div class="border-l-0 lg:border-l lg:border-gruvbox-border lg:pl-8 flex flex-col justify-center">
            <span class="text-[10px] font-mono uppercase tracking-widest text-gruvbox-fg-muted font-semibold mb-1">
              PRINTING LEDGER CUTOFF
            </span>
            <span class="text-lg sm:text-xl font-mono font-bold text-gruvbox-fg mb-2">
              {{ course.formatted_deadline }}
            </span>
            <div>
              <span
                class="inline-flex items-center px-2.5 py-1 rounded text-xs font-mono font-medium"
                :class="course.registration_open ? 'bg-gruvbox-green-bg text-gruvbox-green-dark border border-gruvbox-green/50' : 'bg-gruvbox-red-bg text-gruvbox-red border border-gruvbox-red/50'"
              >
                <svg class="w-3 h-3 mr-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                  <path d="M7 11V7a5 5 0 0110 0v4"></path>
                </svg>
                <span>{{ course.registration_open ? 'Verification Open' : 'Verification Closed' }}</span>
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- Action Selection Header -->
      <div class="flex items-center justify-between">
        <div>
          <h2 class="text-xl font-extrabold text-gruvbox-fg tracking-tight">Select Student Action</h2>
          <p class="text-xs sm:text-sm text-gruvbox-fg-muted mt-0.5">
            Choose how you wish to process your certification record for this session.
          </p>
        </div>
        <div class="hidden sm:block">
          <span class="px-2.5 py-1 rounded bg-gruvbox-surface-light border border-gruvbox-border text-[11px] font-mono text-gruvbox-fg-muted font-semibold">
            STEP 02 OF 04
          </span>
        </div>
      </div>

      <!-- Two Action Cards Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Option 1: Register New Name -->
        <div class="gruvbox-card p-6 flex flex-col justify-between border border-gruvbox-border relative overflow-hidden group hover:border-gruvbox-green transition-all">
          <div class="absolute top-0 left-0 right-0 h-1 bg-gruvbox-green"></div>

          <div>
            <div class="flex items-center justify-between mb-4">
              <div class="w-10 h-10 rounded-lg bg-gruvbox-green-bg/70 border border-gruvbox-green/30 flex items-center justify-center text-gruvbox-green-dark">
                <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zM4 19.235v-.11a6.375 6.375 0 0112.75 0v.109A12.318 12.318 0 0110.374 21c-2.331 0-4.512-.645-6.374-1.765z" />
                </svg>
              </div>
              <span class="text-[10px] font-mono px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg-muted uppercase font-bold tracking-wider">
                OPTION 01 // NEW
              </span>
            </div>

            <h3 class="text-lg font-bold text-gruvbox-fg mb-2">Register New Name</h3>
            <p class="text-xs text-gruvbox-fg-muted mb-4 leading-relaxed">
              First time entering your details for this course session. Enter your authorization token and provide your official legal name exactly as it must appear on the physical parchment.
            </p>

            <!-- Feature Bullet Box -->
            <div class="p-3.5 rounded bg-gruvbox-surface-light/60 border border-gruvbox-border text-xs space-y-2 mb-6">
              <div class="flex items-center space-x-2 text-gruvbox-fg">
                <svg class="w-4 h-4 text-gruvbox-green-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
                </svg>
                <span>Requires one-time 8-digit Registration Token</span>
              </div>
              <div class="flex items-center space-x-2 text-gruvbox-fg">
                <svg class="w-4 h-4 text-gruvbox-green-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
                </svg>
                <span>Generates Archival Ledger Hash upon confirmation</span>
              </div>
              <div class="flex items-center space-x-2 text-gruvbox-fg">
                <svg class="w-4 h-4 text-gruvbox-green-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" />
                </svg>
                <span>Immediate live digital engraving preview</span>
              </div>
            </div>
          </div>

          <router-link
            :to="`/courses/${course.course_code}/register`"
            class="w-full btn-gruvbox-primary py-3 text-xs tracking-wider"
          >
            Register New Name &rarr;
          </router-link>
        </div>

        <!-- Option 2: Check Existing Name -->
        <div class="gruvbox-card p-6 flex flex-col justify-between border border-gruvbox-border relative overflow-hidden group hover:border-gruvbox-aqua transition-all">
          <div class="absolute top-0 left-0 right-0 h-1 bg-gruvbox-aqua"></div>

          <div>
            <div class="flex items-center justify-between mb-4">
              <div class="w-10 h-10 rounded-lg bg-gruvbox-aqua-bg/70 border border-gruvbox-aqua/30 flex items-center justify-center text-gruvbox-aqua-dark">
                <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
                </svg>
              </div>
              <span class="text-[10px] font-mono px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg-muted uppercase font-bold tracking-wider">
                OPTION 02 // AUDIT
              </span>
            </div>

            <h3 class="text-lg font-bold text-gruvbox-fg mb-2">Check Existing Name</h3>
            <p class="text-xs text-gruvbox-fg-muted mb-4 leading-relaxed">
              Verify, audit, or request orthographic adjustments to an existing registration submitted under your student key prior to the permanent batch cutoff and ledger immutability seal.
            </p>

            <!-- Feature Bullet Box -->
            <div class="p-3.5 rounded bg-gruvbox-surface-light/60 border border-gruvbox-border text-xs space-y-2 mb-6">
              <div class="flex items-center space-x-2 text-gruvbox-fg">
                <svg class="w-4 h-4 text-gruvbox-aqua-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25H12" />
                </svg>
                <span>Inspect typographical spelling & middle initials</span>
              </div>
              <div class="flex items-center space-x-2 text-gruvbox-fg">
                <svg class="w-4 h-4 text-gruvbox-aqua-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3" />
                </svg>
                <span>Download draft verification proof slip (PDF)</span>
              </div>
              <div class="flex items-center space-x-2 text-gruvbox-fg">
                <svg class="w-4 h-4 text-gruvbox-aqua-dark flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 21L3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5" />
                </svg>
                <span>Submit correction requests prior to {{ course.formatted_deadline }}</span>
              </div>
            </div>
          </div>

          <button
            @click="showCheckModal = true"
            class="w-full btn-gruvbox-secondary py-3 text-xs tracking-wider"
          >
            Check Existing Name &rarr;
          </button>
        </div>
      </div>

      <!-- Bottom Notice Card -->
      <div class="gruvbox-card p-4 sm:p-5 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 border border-gruvbox-border">
        <div class="flex items-start space-x-3">
          <div class="w-8 h-8 rounded bg-gruvbox-yellow-bg border border-gruvbox-yellow-dark/30 flex items-center justify-center text-gruvbox-yellow-dark flex-shrink-0 mt-0.5">
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
            </svg>
          </div>
          <div>
            <h4 class="text-[11px] font-mono uppercase tracking-wider font-bold text-gruvbox-fg">
              NOTICE ON OFFICIAL PRINTING LEDGER
            </h4>
            <p class="text-xs text-gruvbox-fg-muted mt-0.5 leading-relaxed">
              Registered names will be letterpress engraved on 240gsm high-tensile parchment using archival ink. Name alterations post-cutoff require Academic Registrar physical review.
            </p>
          </div>
        </div>

        <div class="flex-shrink-0">
          <span class="px-2.5 py-1 rounded bg-gruvbox-surface-light border border-gruvbox-border text-[11px] font-mono text-gruvbox-fg font-semibold flex items-center space-x-1">
            <svg class="w-3.5 h-3.5 text-gruvbox-green-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V6.75a4.5 4.5 0 10-9 0v3.75m-.75 11.25h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H6.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z" />
            </svg>
            <span>SHA-256 SIGNED REGISTRY</span>
          </span>
        </div>
      </div>
    </template>

    <!-- Check Name Key Modal -->
    <div v-if="showCheckModal" class="fixed inset-0 bg-gruvbox-fg-dark/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="gruvbox-card max-w-md w-full p-6 border border-gruvbox-border shadow-lg">
        <h3 class="text-lg font-bold text-gruvbox-fg mb-1">Verify Student Key</h3>
        <p class="text-xs text-gruvbox-fg-muted mb-4">
          Please input your 8-digit key number to look up your existing certification file.
        </p>

        <form @submit.prevent="handleCheckSubmit" class="space-y-4">
          <div>
            <label class="block text-[11px] font-mono text-gruvbox-fg-muted uppercase font-semibold mb-1">
              KEY NUMBER
            </label>
            <input
              v-model="checkKey"
              type="text"
              placeholder="E.G. KEY-7712-B"
              class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm uppercase tracking-wider font-mono"
              required
            />
          </div>

          <p v-if="checkError" class="text-xs font-mono text-gruvbox-red">
            {{ checkError }}
          </p>

          <div class="flex space-x-3 pt-2">
            <button
              type="button"
              @click="showCheckModal = false"
              class="flex-1 btn-gruvbox-secondary py-2.5 text-xs font-mono"
            >
              Cancel
            </button>
            <button
              type="submit"
              :disabled="checkingKey || !checkKey.trim()"
              class="flex-1 btn-gruvbox-primary py-2.5 text-xs font-mono"
            >
              <span v-if="!checkingKey">Inspect Record &rarr;</span>
              <span v-else>Searching...</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { api } from '@/services/api'

const route = useRoute()
const router = useRouter()
const courseCode = ref(route.params.course_code)

const course = ref(null)
const loading = ref(true)
const error = ref('')

// Check key state
const showCheckModal = ref(false)
const checkKey = ref('')
const checkingKey = ref(false)
const checkError = ref('')

async function fetchCourse() {
  loading.value = true
  error.value = ''
  try {
    const data = await api.lookupCourse(courseCode.value)
    course.value = data
  } catch (err) {
    error.value = err.message || `Course "${courseCode.value}" was not found.`
  } finally {
    loading.value = false
  }
}

async function handleCheckSubmit() {
  const key = checkKey.value.trim().toUpperCase()
  if (!key) return

  checkingKey.value = true
  checkError.value = ''

  try {
    const result = await api.checkRegistration(courseCode.value, key)
    showCheckModal.value = false
    router.push(`/courses/${courseCode.value}/certificate/${result.registration.id}`)
  } catch (err) {
    checkError.value = err.message || `No registration located for key ${key}.`
  } finally {
    checkingKey.value = false
  }
}

onMounted(() => {
  fetchCourse()
})
</script>

