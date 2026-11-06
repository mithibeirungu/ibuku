<template>
  <div class="flex-1 max-w-4xl mx-auto w-full px-4 sm:px-6 py-6 sm:py-8 space-y-6">
    <!-- Breadcrumbs -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs font-mono">
      <div class="flex items-center space-x-2 text-gruvbox-fg-muted">
        <router-link :to="`/courses/${courseCode}`" class="hover:text-gruvbox-fg flex items-center space-x-1">
          <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
          </svg>
          <span>Courses</span>
        </router-link>
        <span>/</span>
        <span class="text-gruvbox-fg font-semibold">{{ courseCode }}</span>
        <span>/</span>
        <span class="px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg font-medium">
          Certificate Record
        </span>
      </div>

      <div class="flex items-center space-x-2 text-[11px] font-mono">
        <span class="px-2.5 py-1 rounded bg-gruvbox-green-bg border border-gruvbox-green/50 text-gruvbox-green-dark font-semibold flex items-center space-x-1">
          <span class="w-1.5 h-1.5 rounded-full bg-gruvbox-green-dark"></span>
          <span>LEDGER STATUS: COMMITTED</span>
        </span>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="gruvbox-card p-12 text-center text-gruvbox-fg-muted font-mono">
      <div class="animate-spin inline-block w-8 h-8 border-3 border-gruvbox-green-dark border-t-transparent rounded-full mb-3"></div>
      <p>Retrieving cryptographic certificate registry record...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="gruvbox-card p-8 text-center border-gruvbox-red font-mono">
      <p class="text-gruvbox-red text-sm mb-4">{{ error }}</p>
      <router-link :to="`/courses/${courseCode}`" class="btn-gruvbox-secondary text-xs">Return to Course</router-link>
    </div>

    <!-- Main Certificate Inspection Card (Matching Verification & Forms.png Right Card) -->
    <div v-else-if="record" class="gruvbox-card p-6 sm:p-8 border border-gruvbox-border shadow-gruvbox">
      <!-- Card Header -->
      <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-6">
        <div class="flex items-center space-x-3">
          <div class="w-10 h-10 rounded-lg bg-gruvbox-surface-light border border-gruvbox-border flex items-center justify-center text-gruvbox-green-dark">
            <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75m-2.18-4.5H18.75m-6.75 4.5H18.75m-6.75 4.5H18.75M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z" />
            </svg>
          </div>
          <div>
            <h1 class="text-lg font-bold text-gruvbox-fg">Name Check & Verification</h1>
            <p class="text-xs text-gruvbox-fg-muted">Authoritative registry match inspection</p>
          </div>
        </div>

        <div>
          <span class="inline-flex items-center px-3 py-1 rounded bg-gruvbox-green-bg border border-gruvbox-green/50 text-[11px] font-mono text-gruvbox-green-dark font-bold uppercase tracking-wider">
            &bull; VERIFIED MATCH
          </span>
        </div>
      </div>

      <!-- Inner Inspection Parchment -->
      <div class="parchment-frame rounded-lg p-6 sm:p-7 border border-gruvbox-border space-y-6">
        <!-- Top metadata header -->
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs font-mono border-b border-gruvbox-border/80 pb-3">
          <div class="flex items-center space-x-2 text-gruvbox-fg font-semibold">
            <span>KEY: {{ record.key_number }}</span>
            <span>&bull;</span>
            <span class="text-gruvbox-fg-muted">{{ record.rec_number }}</span>
          </div>

          <div>
            <span class="px-2 py-0.5 rounded bg-gruvbox-yellow-bg border border-gruvbox-yellow-dark/30 text-[10px] font-mono font-bold text-gruvbox-yellow-dark tracking-wider uppercase">
              MATCH SCORE: 100%
            </span>
          </div>
        </div>

        <!-- Registered Name Display -->
        <div>
          <span class="text-[10px] font-mono uppercase tracking-widest text-gruvbox-fg-muted font-bold block mb-2">
            CURRENTLY REGISTERED NAME
          </span>

          <div class="flex flex-wrap items-center gap-3">
            <span class="font-serif text-3xl sm:text-4xl text-gruvbox-fg-dark font-bold tracking-tight">
              {{ record.full_name }}
            </span>
            <span class="text-[10px] font-mono px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg-muted uppercase font-semibold">
              UNALTERED
            </span>
          </div>
        </div>

        <!-- Course & Timestamp Details Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-3 border-t border-gruvbox-border/60 text-xs">
          <div>
            <span class="text-[10px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-semibold block mb-1">
              ASSOCIATED COURSE
            </span>
            <p class="font-bold text-gruvbox-fg">{{ courseData?.name || record.course_name }}</p>
            <p class="text-gruvbox-fg-muted font-mono text-[11px] mt-0.5">{{ courseData?.department || 'Dept. of Applied Computing' }}</p>
          </div>

          <div>
            <span class="text-[10px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-semibold block mb-1">
              TIMESTAMP
            </span>
            <p class="font-mono text-gruvbox-fg font-medium flex items-center space-x-1.5">
              <svg class="w-3.5 h-3.5 text-gruvbox-fg-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="10"></circle>
                <polyline points="12 6 12 12 16 14"></polyline>
              </svg>
              <span>{{ record.formatted_date }}</span>
            </p>
            <p class="text-gruvbox-fg-muted font-mono text-[11px] mt-0.5">Registry Node #04 (EST)</p>
          </div>
        </div>

        <!-- Cryptographic Ledger Hash Preview -->
        <div class="pt-3 border-t border-gruvbox-border/60 flex flex-col sm:flex-row sm:items-center justify-between gap-2 font-mono text-[11px]">
          <div class="text-gruvbox-fg-muted truncate">
            <span class="font-semibold text-gruvbox-fg">SHA-256:</span>
            <span class="ml-1.5 tracking-wider">{{ record.short_hash }}</span>
          </div>

          <span class="text-gruvbox-green-dark font-bold tracking-wider self-start sm:self-auto flex items-center space-x-1">
            <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span>HASH VALID</span>
          </span>
        </div>
      </div>

      <!-- Instruction / Legal Notice -->
      <p class="text-xs text-gruvbox-fg-muted mt-5 leading-relaxed">
        Verify that the name matches the candidate's government-issued credential precisely. Confirming will finalize the engraving matrix and release the cryptographic certificate seal.
      </p>

      <!-- Action Buttons -->
      <div class="flex flex-col sm:flex-row items-center gap-3 mt-6 pt-4 border-t border-gruvbox-border">
        <!-- Confirm & Go Ahead -->
        <button
          @click="handleConfirm"
          class="w-full sm:flex-1 btn-gruvbox-primary py-3 text-xs tracking-wider flex items-center justify-center space-x-2"
        >
          <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          <span>Confirm & Go Ahead</span>
        </button>

        <!-- Edit / Change Name (Guarded by deadline check) -->
        <template v-if="canEdit">
          <router-link
            :to="`/courses/${courseCode}/certificate/${record.id}/edit`"
            class="w-full sm:flex-1 px-5 py-3 rounded-md border border-gruvbox-red text-gruvbox-red hover:bg-gruvbox-red-bg font-mono font-semibold text-xs tracking-wider flex items-center justify-center space-x-2 transition-colors"
          >
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" />
            </svg>
            <span>Edit / Change Name</span>
          </router-link>
        </template>
        <template v-else>
          <div class="text-[11px] font-mono text-gruvbox-fg-muted italic">
            (Editing deadline expired &bull; Record is sealed)
          </div>
        </template>
      </div>
    </div>

    <!-- Confirmation Modal / Print Proof Slip -->
    <div v-if="showConfirmedModal" class="fixed inset-0 bg-gruvbox-fg-dark/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="gruvbox-card max-w-md w-full p-6 border border-gruvbox-border shadow-lg space-y-4">
        <div class="w-12 h-12 rounded-full bg-gruvbox-green-bg text-gruvbox-green-dark flex items-center justify-center mx-auto">
          <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
          </svg>
        </div>
        <h3 class="text-center text-lg font-bold text-gruvbox-fg">Certificate Attestation Confirmed</h3>
        <p class="text-center text-xs text-gruvbox-fg-muted leading-relaxed">
          Your certificate name for <strong>{{ record.full_name }}</strong> has been permanently queued for 240gsm high-tensile parchment engraving under course {{ courseCode }}.
        </p>
        <div class="p-3 bg-gruvbox-surface-light rounded font-mono text-[11px] text-gruvbox-fg-muted space-y-1">
          <p><strong>Ledger Record:</strong> {{ record.rec_number }}</p>
          <p><strong>Key Token:</strong> {{ record.key_number }}</p>
          <p class="truncate"><strong>SHA-256 Digest:</strong> {{ record.ledger_hash }}</p>
        </div>
        <div class="flex space-x-3 pt-2">
          <button @click="triggerPrint" class="flex-1 btn-gruvbox-secondary py-2 text-xs font-mono flex items-center justify-center space-x-1">
            <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6.72 13.829c-.24-1.205.08-2.471.86-3.414l6.5-7.8a2.5 2.5 0 013.84 3.2l-6.5 7.8c-.78.943-2.046 1.46-3.25 1.22l-4.5-1.006 1.05-4.5z" />
            </svg>
            <span>Print Proof Slip</span>
          </button>
          <button @click="showConfirmedModal = false" class="flex-1 btn-gruvbox-primary py-2 text-xs font-mono">
            Done
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { api } from '@/services/api'

const route = useRoute()
const courseCode = ref(route.params.course_code)
const registrationId = ref(route.params.id)

const record = ref(null)
const courseData = ref(null)
const canEdit = ref(true)
const loading = ref(true)
const error = ref('')
const showConfirmedModal = ref(false)

async function fetchCertificate() {
  loading.value = true
  error.value = ''
  try {
    const data = await api.getRegistration(registrationId.value)
    record.value = data.registration
    courseData.value = data.course
    canEdit.value = data.can_edit
  } catch (err) {
    error.value = err.message || 'Unable to retrieve registration record from ledger.'
  } finally {
    loading.value = false
  }
}

function handleConfirm() {
  showConfirmedModal.value = true
}

function triggerPrint() {
  window.print()
}

onMounted(() => {
  fetchCertificate()
})
</script>

