<template>
  <div class="flex-1 max-w-7xl mx-auto w-full px-4 sm:px-6 py-6 sm:py-8 space-y-6">
    <!-- System Provisioning Ledger Banner -->
    <div class="gruvbox-card p-4 sm:p-5 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 border border-gruvbox-border shadow-sm">
      <div class="flex items-center space-x-3.5">
        <div class="w-10 h-10 rounded-lg bg-gruvbox-surface-light border border-gruvbox-border flex items-center justify-center text-gruvbox-teal flex-shrink-0">
          <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 17.25v1.007a3 3 0 01-.879 2.122L7.5 21h9l-.621-.621A3 3 0 0115 18.257V17.25m6-12V15a2.25 2.25 0 01-2.25 2.25H5.25A2.25 2.25 0 013 15V5.25m18 0A2.25 2.25 0 0018.75 3H5.25A2.25 2.25 0 003 5.25m18 0V12a2.25 2.25 0 01-2.25 2.25H5.25A2.25 2.25 0 013 12V5.25" />
          </svg>
        </div>
        <div>
          <div class="flex items-center space-x-2">
            <h2 class="text-sm font-bold text-gruvbox-fg">System Provisioning Ledger</h2>
            <span class="px-2 py-0.5 rounded bg-gruvbox-yellow-bg text-gruvbox-yellow-dark text-[10px] font-mono font-bold uppercase tracking-wider border border-gruvbox-yellow-dark/30">
              ACTIVE INSTANCE
            </span>
          </div>
          <p class="text-xs text-gruvbox-fg-muted mt-0.5 font-mono">
            Protocol v1.42 Gruvbox Archival Ledger &bull; Cryptographic hardware wallet auto-sign engaged.
          </p>
        </div>
      </div>

      <div class="text-[11px] font-mono text-gruvbox-fg-muted px-3 py-1 rounded bg-gruvbox-surface-light border border-gruvbox-border">
        <span>KEY: </span>
        <span class="text-gruvbox-fg font-bold">RSA-4096-ECC</span>
      </div>
    </div>

    <!-- 3 Stat Metrics Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <!-- Total Registrations -->
      <div class="gruvbox-card p-6 border border-gruvbox-border">
        <div class="flex items-center justify-between mb-2">
          <span class="text-[11px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-bold">
            TOTAL REGISTRATIONS
          </span>
          <div class="w-8 h-8 rounded bg-gruvbox-surface-light border border-gruvbox-border flex items-center justify-center text-gruvbox-fg">
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z" />
            </svg>
          </div>
        </div>
        <div class="flex items-baseline space-x-3 mb-4">
          <span class="text-4xl font-extrabold text-gruvbox-fg tracking-tight font-mono">
            {{ stats.total_registrations }}
          </span>
          <span class="px-2 py-0.5 rounded bg-gruvbox-green-bg border border-gruvbox-green/40 text-[10px] font-mono text-gruvbox-green-dark font-bold">
            &nearr; +14% vs prior
          </span>
        </div>
        <div class="flex items-center justify-between text-xs text-gruvbox-fg-muted font-mono pt-3 border-t border-gruvbox-border/60">
          <span>Active batch cohort</span>
          <span class="text-gruvbox-fg font-semibold">Fall 2026</span>
        </div>
      </div>

      <!-- Confirmed Valid -->
      <div class="gruvbox-card p-6 border border-gruvbox-border">
        <div class="flex items-center justify-between mb-2">
          <span class="text-[11px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-bold">
            CONFIRMED VALID
          </span>
          <div class="w-8 h-8 rounded bg-gruvbox-green-bg/70 border border-gruvbox-green/30 flex items-center justify-center text-gruvbox-green-dark">
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
        </div>
        <div class="flex items-baseline space-x-3 mb-4">
          <span class="text-4xl font-extrabold text-gruvbox-fg tracking-tight font-mono">
            {{ stats.confirmed_count }}
          </span>
          <span class="px-2 py-0.5 rounded bg-gruvbox-green-bg border border-gruvbox-green/40 text-[10px] font-mono text-gruvbox-green-dark font-bold">
            &check; {{ stats.confirmed_percentage }}% Cleared
          </span>
        </div>
        <div class="flex items-center justify-between text-xs text-gruvbox-fg-muted font-mono pt-3 border-t border-gruvbox-border/60">
          <span>Production stage</span>
          <span class="text-gruvbox-green-dark font-semibold">Ready for hard-copy press</span>
        </div>
      </div>

      <!-- Audit Exceptions -->
      <div class="gruvbox-card p-6 border border-gruvbox-border">
        <div class="flex items-center justify-between mb-2">
          <span class="text-[11px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-bold">
            AUDIT EXCEPTIONS
          </span>
          <div class="w-8 h-8 rounded bg-gruvbox-yellow-bg border border-gruvbox-yellow-dark/30 flex items-center justify-center text-gruvbox-yellow-dark">
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
            </svg>
          </div>
        </div>
        <div class="flex items-baseline space-x-3 mb-4">
          <span class="text-4xl font-extrabold text-gruvbox-fg tracking-tight font-mono">
            {{ String(stats.exceptions_count).padStart(2, '0') }}
          </span>
          <span class="px-2 py-0.5 rounded bg-gruvbox-yellow-bg border border-gruvbox-yellow-dark/40 text-[10px] font-mono text-gruvbox-yellow-dark font-bold flex items-center space-x-1">
            <svg class="w-3 h-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="12" y1="8" x2="12" y2="12"></line>
              <line x1="12" y1="16" x2="12.01" y2="16"></line>
            </svg>
            <span>Requires Action</span>
          </span>
        </div>
        <div class="flex items-center justify-between text-xs text-gruvbox-fg-muted font-mono pt-3 border-t border-gruvbox-border/60">
          <span>Hold status</span>
          <span class="text-gruvbox-yellow-dark font-semibold">Manual spelling review</span>
        </div>
      </div>
    </div>

    <!-- Create New Course Card (Matching Admin Dashboard.png) -->
    <div class="gruvbox-card p-6 sm:p-8 border border-gruvbox-border shadow-gruvbox">
      <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-4">
        <span class="text-[11px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-bold">
          UNIT PROVISIONING &bull; FORM REF #409
        </span>
        <span class="text-[11px] font-mono text-gruvbox-yellow-dark font-semibold flex items-center space-x-1">
          <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
            <path d="M7 11V7a5 5 0 0110 0v4"></path>
          </svg>
          <span>Auto-Sign Key: RSA-4096-ECC</span>
        </span>
      </div>

      <h2 class="text-xl font-bold text-gruvbox-fg mb-1">Create New Course / Unit</h2>
      <p class="text-xs text-gruvbox-fg-muted mb-6">
        Provision a new registration session for student certification and issue cryptographic enrolment seeds.
      </p>

      <form @submit.prevent="handleCreateCourse" class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <!-- Course Name -->
          <div>
            <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1 font-semibold">
              <label for="course-name">COURSE / UNIT NAME</label>
              <span class="text-gruvbox-red">REQUIRED</span>
            </div>
            <input
              id="course-name"
              v-model="newCourse.name"
              type="text"
              placeholder="CS-4091: Distributed Systems"
              class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm font-mono"
              required
            />
          </div>

          <!-- Session Date / Cutoff -->
          <div>
            <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1 font-semibold">
              <label for="registration-deadline">REGISTRATION DEADLINE</label>
              <span class="text-gruvbox-fg-muted">UTC</span>
            </div>
            <input
              id="registration-deadline"
              v-model="newCourse.registration_deadline"
              type="datetime-local"
              class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm font-mono"
              required
            />
          </div>

          <!-- Cryptographic Token Action -->
          <div>
            <div class="flex items-center justify-between text-[11px] font-mono text-gruvbox-fg-muted mb-1 font-semibold">
              <label>CRYPTOGRAPHIC TOKEN</label>
            </div>
            <button
              type="button"
              @click="generateRandomToken"
              class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm font-mono flex items-center justify-center space-x-2 hover:bg-gruvbox-surface-light text-gruvbox-fg transition-colors"
            >
              <svg class="w-4 h-4 text-gruvbox-green-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 4.875c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5A1.125 1.125 0 013.75 9.375v-4.5zM13.5 4.875c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5A1.125 1.125 0 0113.5 9.375v-4.5z" />
              </svg>
              <span>Generate Code &amp; QR</span>
            </button>
          </div>
        </div>

        <!-- Course Access Hash Banner (Shown if token generated or course created) -->
        <div v-if="activeCourseCode" class="p-4 rounded-lg bg-gruvbox-surface-light/70 border border-gruvbox-border flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div class="flex items-center space-x-3">
            <div class="w-10 h-10 rounded bg-gruvbox-surface border border-gruvbox-border flex items-center justify-center text-gruvbox-fg flex-shrink-0">
              <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="3" width="7" height="7"></rect>
                <rect x="14" y="3" width="7" height="7"></rect>
                <rect x="14" y="14" width="7" height="7"></rect>
                <rect x="3" y="14" width="7" height="7"></rect>
              </svg>
            </div>
            <div>
              <div class="flex items-center space-x-2">
                <span class="text-[10px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-bold">COURSE ACCESS HASH</span>
                <span class="w-1.5 h-1.5 rounded-full bg-gruvbox-green animate-pulse"></span>
              </div>
              <p class="font-mono font-bold text-sm text-gruvbox-fg">{{ activeCourseCode }}</p>
              <p class="text-[10px] font-mono text-gruvbox-fg-muted">Valid for 30 days post provision</p>
            </div>
          </div>

          <div class="flex items-center space-x-2">
            <button
              type="button"
              @click="copyCode(activeCourseCode)"
              class="px-3 py-1.5 text-xs font-mono rounded bg-gruvbox-surface border border-gruvbox-border hover:bg-gruvbox-border/50 text-gruvbox-fg flex items-center space-x-1.5"
            >
              <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect>
                <path d="M5 15H4a2 2 0 01-2-2V4a2 2 0 012-2h9a2 2 0 012 2v1"></path>
              </svg>
              <span>{{ copyStatus || 'Copy Hash' }}</span>
            </button>

            <button
              type="button"
              @click="openQrModal(activeCourseCode)"
              class="px-3 py-1.5 text-xs font-mono rounded bg-gruvbox-surface border border-gruvbox-border hover:bg-gruvbox-border/50 text-gruvbox-fg flex items-center space-x-1.5"
            >
              <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3" />
              </svg>
              <span>QR Sheet</span>
            </button>
          </div>
        </div>

        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pt-2">
          <label class="flex items-center space-x-2 text-xs font-mono text-gruvbox-fg-muted cursor-pointer">
            <input type="checkbox" checked class="rounded border-gruvbox-border text-gruvbox-green-dark focus:ring-0" />
            <span>Session will automatically register to the immutable public verification ledger.</span>
          </label>

          <button
            type="submit"
            :disabled="creatingCourse"
            class="btn-gruvbox-primary py-2.5 px-6 text-xs tracking-wider"
          >
            <span>+ Create Course Session</span>
          </button>
        </div>
      </form>
    </div>

    <!-- Registered Students Table Card (Matching Admin Dashboard.png) -->
    <div class="gruvbox-card p-6 sm:p-8 border border-gruvbox-border shadow-gruvbox">
      <!-- Section Header -->
      <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-4 mb-6">
        <div>
          <div class="flex items-center space-x-2 mb-1">
            <h2 class="text-xl font-bold text-gruvbox-fg">Registered Students</h2>
            <span class="px-2 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-xs font-mono font-bold text-gruvbox-fg">
              {{ studentsMeta.total_count || students.length }}
            </span>
            <span class="px-2 py-0.5 rounded bg-gruvbox-green-bg border border-gruvbox-green/50 text-[10px] font-mono text-gruvbox-green-dark font-bold uppercase">
              SESSION ACTIVE
            </span>
          </div>
          <p class="text-xs text-gruvbox-fg-muted font-mono">
            Archival roll for graduation certification printing and cryptographic key assignment.
          </p>
        </div>

        <!-- Filter Pills & Search & Export -->
        <div class="flex flex-wrap items-center gap-3">
          <!-- Status Filters -->
          <div class="flex items-center rounded bg-gruvbox-surface-light border border-gruvbox-border p-0.5 text-xs font-mono">
            <button
              @click="filterStatus = 'all'; fetchStudents()"
              class="px-3 py-1 rounded transition-colors"
              :class="filterStatus === 'all' ? 'bg-gruvbox-surface text-gruvbox-fg font-bold shadow-sm' : 'text-gruvbox-fg-muted'"
            >
              All ({{ stats.total_registrations }})
            </button>
            <button
              @click="filterStatus = 'confirmed'; fetchStudents()"
              class="px-3 py-1 rounded transition-colors"
              :class="filterStatus === 'confirmed' ? 'bg-gruvbox-surface text-gruvbox-fg font-bold shadow-sm' : 'text-gruvbox-fg-muted'"
            >
              Confirmed ({{ stats.confirmed_count }})
            </button>
            <button
              @click="filterStatus = 'pending_review'; fetchStudents()"
              class="px-3 py-1 rounded transition-colors"
              :class="filterStatus === 'pending_review' ? 'bg-gruvbox-surface text-gruvbox-fg font-bold shadow-sm' : 'text-gruvbox-fg-muted'"
            >
              Pending Review ({{ stats.exceptions_count }})
            </button>
          </div>

          <!-- Search Input -->
          <div class="relative">
            <input
              v-model="searchQuery"
              @input="debounceSearch"
              type="text"
              placeholder="Search candidate..."
              class="px-3 py-1.5 gruvbox-input rounded text-xs pl-8 w-44 font-mono"
            />
            <svg class="w-3.5 h-3.5 text-gruvbox-fg-muted absolute left-2.5 top-2.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
            </svg>
          </div>

          <!-- CSV Export Button -->
          <button
            type="button"
            @click="handleDownloadCsv"
            :disabled="downloadingCsv"
            class="px-3.5 py-1.5 rounded bg-gruvbox-green-dark text-gruvbox-bg text-xs font-mono font-bold flex items-center space-x-1.5 hover:bg-gruvbox-green-dark/90 transition-colors shadow-sm disabled:opacity-50"
          >
            <svg v-if="!downloadingCsv" class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3" />
            </svg>
            <svg v-else class="animate-spin w-3.5 h-3.5" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            <span>{{ downloadingCsv ? 'Exporting...' : 'Download CSV / XLSX' }}</span>
          </button>
        </div>
      </div>

      <!-- Students Table -->
      <div class="overflow-x-auto border border-gruvbox-border rounded-lg">
        <table class="w-full text-left text-xs font-mono border-collapse">
          <thead>
            <tr class="bg-gruvbox-surface-light border-b border-gruvbox-border text-[11px] text-gruvbox-fg-muted uppercase font-bold">
              <th class="py-3 px-4">KEY NUMBER</th>
              <th class="py-3 px-4">FULL NAME (TO BE PRINTED)</th>
              <th class="py-3 px-4">REGISTRATION DATE &amp; TIME</th>
              <th class="py-3 px-4">STATUS</th>
              <th class="py-3 px-4 text-right">ACTIONS</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gruvbox-border/60">
            <tr v-for="student in students" :key="student.id" class="hover:bg-gruvbox-surface-light/40 transition-colors">
              <!-- Key Number -->
              <td class="py-3.5 px-4">
                <span class="px-2.5 py-1 rounded bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg font-semibold">
                  {{ student.key_number }}
                </span>
              </td>

              <!-- Full Name + Initials Badge -->
              <td class="py-3.5 px-4">
                <div class="flex items-center space-x-3">
                  <div class="w-8 h-8 rounded-full bg-gruvbox-surface-light border border-gruvbox-border text-gruvbox-fg font-bold flex items-center justify-center text-[11px] flex-shrink-0">
                    {{ student.initials }}
                  </div>
                  <div>
                    <p class="font-bold text-gruvbox-fg font-sans text-sm">{{ student.full_name }}</p>
                    <p class="text-[11px] text-gruvbox-fg-muted">{{ student.email }}</p>
                  </div>
                </div>
              </td>

              <!-- Registration Date & Time -->
              <td class="py-3.5 px-4">
                <p class="text-gruvbox-fg">{{ student.registration_datetime }}</p>
                <p class="text-[10px] text-gruvbox-fg-muted">{{ student.batch_label }}</p>
              </td>

              <!-- Status Badge -->
              <td class="py-3.5 px-4">
                <span
                  class="px-2.5 py-0.5 rounded text-[11px] font-semibold inline-flex items-center space-x-1"
                  :class="student.status === 'confirmed' ? 'bg-gruvbox-green-bg text-gruvbox-green-dark border border-gruvbox-green/50' : 'bg-gruvbox-yellow-bg text-gruvbox-yellow-dark border border-gruvbox-yellow-dark/50'"
                >
                  <svg v-if="student.status === 'confirmed'" class="w-3 h-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
                  </svg>
                  <svg v-else class="w-3 h-3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <circle cx="12" cy="12" r="10"></circle>
                    <path d="M12 8v4"></path>
                    <path d="M12 16h.01"></path>
                  </svg>
                  <span>{{ student.status === 'confirmed' ? 'Confirmed' : 'Pending Review' }}</span>
                </span>
              </td>

              <!-- Actions -->
              <td class="py-3.5 px-4 text-right space-x-2">
                <router-link
                  :to="`/courses/${student.course_code}/certificate/${student.id}`"
                  class="px-2.5 py-1 rounded bg-gruvbox-surface-light hover:bg-gruvbox-border border border-gruvbox-border text-gruvbox-fg transition-colors"
                >
                  Print Preview
                </router-link>
                <button
                  @click="openEditStudent(student)"
                  class="px-2.5 py-1 rounded bg-gruvbox-surface-light hover:bg-gruvbox-border border border-gruvbox-border text-gruvbox-fg transition-colors"
                >
                  Edit
                </button>
              </td>
            </tr>

            <tr v-if="students.length === 0">
              <td colspan="5" class="py-8 text-center text-gruvbox-fg-muted">
                No registered student entries found matching criteria.
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mt-4 text-xs font-mono text-gruvbox-fg-muted">
        <div>
          <span>Showing 1-{{ students.length }} of {{ stats.total_registrations }} entries</span>
        </div>

        <div class="flex items-center space-x-1">
          <button class="px-2.5 py-1 rounded border border-gruvbox-border hover:bg-gruvbox-surface-light text-gruvbox-fg">
            Previous
          </button>
          <button class="px-2.5 py-1 rounded bg-gruvbox-green-dark text-gruvbox-bg font-bold">1</button>
          <button class="px-2.5 py-1 rounded border border-gruvbox-border hover:bg-gruvbox-surface-light text-gruvbox-fg">2</button>
          <button class="px-2.5 py-1 rounded border border-gruvbox-border hover:bg-gruvbox-surface-light text-gruvbox-fg">3</button>
          <button class="px-2.5 py-1 rounded border border-gruvbox-border hover:bg-gruvbox-surface-light text-gruvbox-fg">Next</button>
        </div>
      </div>
    </div>

    <!-- Authorized Administrators Console (Super-Admin Provisioning) -->
    <div class="gruvbox-card p-6 sm:p-8 border border-gruvbox-border shadow-gruvbox">
      <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-4">
        <span class="text-[11px] font-mono uppercase tracking-wider text-gruvbox-fg-muted font-bold">
          ACCESS CONTROL &bull; REGISTRAR LEDGER ROSTER
        </span>
        <span class="text-[11px] font-mono text-gruvbox-green-dark font-semibold flex items-center space-x-1">
          <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296 1.043 3.746 3.746 0 0111.964-3.07" />
          </svg>
          <span>Primary Super-Admin: mithibeirungu@gmail.com</span>
        </span>
      </div>

      <h2 class="text-xl font-bold text-gruvbox-fg mb-1">Provision &amp; Manage Administrators</h2>
      <p class="text-xs text-gruvbox-fg-muted mb-6">
        Authorized by Mithibe Irungu. Registered administrators can immediately sign into the portal using passwordless email OTP.
      </p>

      <!-- Register Admin Form -->
      <form @submit.prevent="handleRegisterAdmin" class="p-4 rounded-lg bg-gruvbox-surface-light/60 border border-gruvbox-border space-y-4 mb-6">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label class="block text-[11px] font-mono text-gruvbox-fg-muted uppercase font-bold mb-1">
              ADMIN EMAIL ADDRESS
            </label>
            <input
              v-model="newAdmin.email"
              type="email"
              placeholder="e.g. colleague@academic.edu"
              class="w-full px-3.5 py-2 gruvbox-input rounded text-xs font-mono"
              required
            />
          </div>

          <div>
            <label class="block text-[11px] font-mono text-gruvbox-fg-muted uppercase font-bold mb-1">
              OFFICER NAME / TITLE
            </label>
            <input
              v-model="newAdmin.name"
              type="text"
              placeholder="e.g. Dr. Alex Vance"
              class="w-full px-3.5 py-2 gruvbox-input rounded text-xs font-sans"
              required
            />
          </div>

          <div>
            <label class="block text-[11px] font-mono text-gruvbox-fg-muted uppercase font-bold mb-1">
              ASSIGNED ROLE
            </label>
            <div class="flex space-x-2">
              <select v-model="newAdmin.role" class="flex-1 px-3.5 py-2 gruvbox-input rounded text-xs font-mono">
                <option value="registrar">Registrar Officer</option>
                <option value="super_admin">Super-Admin</option>
              </select>
              <button
                type="submit"
                :disabled="registeringAdmin || !newAdmin.email.trim()"
                class="btn-gruvbox-primary py-2 px-4 text-xs font-mono"
              >
                <span>{{ registeringAdmin ? 'Adding...' : '+ Add Admin' }}</span>
              </button>
            </div>
          </div>
        </div>

        <div v-if="adminSuccessMsg" class="text-xs font-mono text-gruvbox-green-dark bg-gruvbox-green-bg p-2.5 rounded border border-gruvbox-green/50">
          {{ adminSuccessMsg }}
        </div>
        <div v-if="adminErrorMsg" class="text-xs font-mono text-gruvbox-red bg-gruvbox-red-bg p-2.5 rounded border border-gruvbox-red/50">
          {{ adminErrorMsg }}
        </div>
      </form>

      <!-- Admins List Table -->
      <div class="overflow-x-auto border border-gruvbox-border rounded-lg">
        <table class="w-full text-left text-xs font-mono border-collapse">
          <thead>
            <tr class="bg-gruvbox-surface-light border-b border-gruvbox-border text-[11px] text-gruvbox-fg-muted uppercase font-bold">
              <th class="py-2.5 px-4">ADMINISTRATOR</th>
              <th class="py-2.5 px-4">EMAIL</th>
              <th class="py-2.5 px-4">ROLE</th>
              <th class="py-2.5 px-4">DATE PROVISIONED</th>
              <th class="py-2.5 px-4 text-right">ACTION</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gruvbox-border/60">
            <tr v-for="adm in adminList" :key="adm.id" class="hover:bg-gruvbox-surface-light/40 transition-colors">
              <td class="py-3 px-4 font-bold text-gruvbox-fg font-sans flex items-center space-x-2">
                <span>{{ adm.name }}</span>
                <span v-if="adm.is_current" class="px-1.5 py-0.5 rounded bg-gruvbox-surface-light border border-gruvbox-border text-[10px] text-gruvbox-teal font-mono">YOU</span>
              </td>
              <td class="py-3 px-4 font-mono text-gruvbox-fg">
                {{ adm.email }}
              </td>
              <td class="py-3 px-4">
                <span
                  class="px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-wider"
                  :class="adm.is_primary ? 'bg-gruvbox-yellow-bg text-gruvbox-yellow-dark border border-gruvbox-yellow-dark/40' : 'bg-gruvbox-surface-light text-gruvbox-fg-muted border border-gruvbox-border'"
                >
                  {{ adm.is_primary ? 'PRIMARY SUPER-ADMIN' : adm.role }}
                </span>
              </td>
              <td class="py-3 px-4 text-gruvbox-fg-muted">
                {{ adm.created_at }}
              </td>
              <td class="py-3 px-4 text-right">
                <button
                  v-if="!adm.is_primary && !adm.is_current"
                  @click="handleDeleteAdmin(adm)"
                  class="text-gruvbox-red hover:underline font-mono text-[11px]"
                >
                  Revoke
                </button>
                <span v-else class="text-gruvbox-fg-muted text-[11px] italic">Protected</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- QR Sheet Modal -->
    <div v-if="showQrModal" class="fixed inset-0 bg-gruvbox-fg-dark/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="gruvbox-card max-w-sm w-full p-6 border border-gruvbox-border shadow-lg space-y-4">
        <div class="flex items-center justify-between">
          <h3 class="font-bold text-gruvbox-fg">Classroom QR Access Sheet</h3>
          <button @click="showQrModal = false" class="text-gruvbox-fg-muted hover:text-gruvbox-fg">
            &times;
          </button>
        </div>

        <p class="text-xs text-gruvbox-fg-muted">
          Display this QR Code on classroom screens or share directly for student enrollment.
        </p>

        <!-- QR Canvas Render -->
        <div class="p-4 bg-white rounded border border-gruvbox-border flex flex-col items-center justify-center">
          <canvas ref="qrCanvas" class="w-48 h-48"></canvas>
          <p class="mt-2 font-mono font-bold text-xs text-gray-800 tracking-wider">{{ modalCourseCode }}</p>
        </div>

        <div class="p-2.5 rounded bg-gruvbox-surface-light text-[11px] font-mono break-all text-gruvbox-fg">
          {{ modalCourseUrl }}
        </div>

        <div class="flex space-x-2 pt-2">
          <button @click="copyCode(modalCourseUrl)" class="flex-1 btn-gruvbox-secondary py-2 text-xs font-mono">
            {{ copyStatus || 'Copy Link' }}
          </button>
          <button @click="showQrModal = false" class="flex-1 btn-gruvbox-primary py-2 text-xs font-mono">
            Close
          </button>
        </div>
      </div>
    </div>

    <!-- Edit Student Modal -->
    <div v-if="editingStudent" class="fixed inset-0 bg-gruvbox-fg-dark/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="gruvbox-card max-w-md w-full p-6 border border-gruvbox-border shadow-lg space-y-4">
        <h3 class="font-bold text-gruvbox-fg">Modify Student Attestation</h3>
        <p class="text-xs text-gruvbox-fg-muted">
          Manual administrative spelling correction for Key: {{ editingStudent.key_number }}
        </p>

        <div>
          <label class="block text-[11px] font-mono font-bold text-gruvbox-fg mb-1">FULL NAME (OFFICIAL SPEC)</label>
          <input
            v-model="editingStudent.full_name"
            type="text"
            class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm font-medium"
          />
        </div>

        <div>
          <label class="block text-[11px] font-mono font-bold text-gruvbox-fg mb-1">STATUS</label>
          <select v-model="editingStudent.status" class="w-full px-3.5 py-2.5 gruvbox-input rounded text-sm font-mono">
            <option value="confirmed">Confirmed</option>
            <option value="pending_review">Pending Review</option>
          </select>
        </div>

        <div class="flex space-x-3 pt-2">
          <button @click="editingStudent = null" class="flex-1 btn-gruvbox-secondary py-2 text-xs font-mono">
            Cancel
          </button>
          <button @click="saveStudentUpdate" class="flex-1 btn-gruvbox-primary py-2 text-xs font-mono">
            Save Record
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, nextTick } from 'vue'
import QRCode from 'qrcode'
import { api } from '@/services/api'

const stats = reactive({
  total_registrations: 24,
  confirmed_count: 19,
  confirmed_percentage: 79.2,
  exceptions_count: 5
})

const students = ref([])
const studentsMeta = ref({})
const filterStatus = ref('all')
const searchQuery = ref('')
let searchTimeout = null

const activeCourseCode = ref('CS-4091')
const copyStatus = ref('')

const newCourse = reactive({
  name: '',
  registration_deadline: '',
  department: 'Dept. of Computer Science',
  cohort: 'Cohort: Q4 2026'
})

const creatingCourse = ref(false)

// QR Modal
const showQrModal = ref(false)
const modalCourseCode = ref('')
const qrCanvas = ref(null)

// Edit Student Modal
const editingStudent = ref(null)

// Admin Management State
const adminList = ref([])
const newAdmin = reactive({
  email: '',
  name: '',
  role: 'registrar'
})
const registeringAdmin = ref(false)
const adminSuccessMsg = ref('')
const adminErrorMsg = ref('')

const downloadingCsv = ref(false)

const exportCsvUrl = computed(() => api.getExportAllCsvUrl())

const modalCourseUrl = computed(() => {
  return `${window.location.origin}/courses/${modalCourseCode.value}`
})

async function fetchStats() {
  try {
    const data = await api.getAdminStats()
    Object.assign(stats, data)
  } catch (err) {
    console.error('Failed to load stats', err)
  }
}

async function fetchStudents() {
  try {
    const params = {
      status: filterStatus.value,
      search: searchQuery.value
    }
    const data = await api.getAdminStudents(params)
    students.value = data.data
    studentsMeta.value = data.meta
  } catch (err) {
    console.error('Failed to load students', err)
  }
}

function debounceSearch() {
  clearTimeout(searchTimeout)
  searchTimeout = setTimeout(() => {
    fetchStudents()
  }, 300)
}

function generateRandomToken() {
  const letters = 'CS BIO ENG SYS DATA'
  const prefixes = letters.split(' ')
  const prefix = prefixes[Math.floor(Math.random() * prefixes.length)]
  const num = Math.floor(1000 + Math.random() * 9000)
  activeCourseCode.value = `${prefix}-${num}`
  if (!newCourse.name) {
    newCourse.name = `${activeCourseCode.value}: Distributed Computing Systems`
  }
}

async function handleCreateCourse() {
  creatingCourse.value = true
  try {
    const payload = {
      name: newCourse.name,
      course_code: activeCourseCode.value,
      start_date: new Date().toISOString().split('T')[0],
      end_date: new Date(Date.now() + 30 * 86400000).toISOString().split('T')[0],
      registration_deadline: newCourse.registration_deadline || new Date(Date.now() + 7 * 86400000).toISOString(),
      department: newCourse.department,
      cohort: newCourse.cohort
    }
    const created = await api.createCourse(payload)
    activeCourseCode.value = created.course_code
    newCourse.name = ''
    fetchStats()
    openQrModal(created.course_code)
  } catch (err) {
    alert(err.message || 'Failed to create course session.')
  } finally {
    creatingCourse.value = false
  }
}

function copyCode(text) {
  navigator.clipboard.writeText(text)
  copyStatus.value = 'Copied!'
  setTimeout(() => {
    copyStatus.value = ''
  }, 2000)
}

function openQrModal(code) {
  modalCourseCode.value = code
  showQrModal.value = true
  nextTick(() => {
    if (qrCanvas.value) {
      QRCode.toCanvas(qrCanvas.value, modalCourseUrl.value, {
        width: 192,
        margin: 1,
        color: {
          dark: '#282828',
          light: '#ffffff'
        }
      })
    }
  })
}

function openEditStudent(student) {
  editingStudent.value = { ...student }
}

async function saveStudentUpdate() {
  if (!editingStudent.value) return
  try {
    await api.updateStudentStatus(editingStudent.value.id, {
      full_name: editingStudent.value.full_name,
      status: editingStudent.value.status
    })
    editingStudent.value = null
    fetchStudents()
    fetchStats()
  } catch (err) {
    alert(err.message || 'Failed to update student')
  }
}

async function fetchAdmins() {
  try {
    const list = await api.getAdmins()
    adminList.value = list
  } catch (err) {
    console.error('Failed to load administrators', err)
  }
}

async function handleRegisterAdmin() {
  registeringAdmin.value = true
  adminSuccessMsg.value = ''
  adminErrorMsg.value = ''
  try {
    const res = await api.registerAdmin({
      email: newAdmin.email,
      name: newAdmin.name,
      role: newAdmin.role
    })
    adminSuccessMsg.value = res.message || `Administrator ${newAdmin.email} registered successfully.`
    newAdmin.email = ''
    newAdmin.name = ''
    newAdmin.role = 'registrar'
    fetchAdmins()
  } catch (err) {
    adminErrorMsg.value = err.message || 'Failed to register administrator.'
  } finally {
    registeringAdmin.value = false
  }
}

async function handleDeleteAdmin(adm) {
  if (!confirm(`Are you sure you want to revoke administrative access for ${adm.email}?`)) {
    return
  }
  try {
    await api.deleteAdmin(adm.id)
    fetchAdmins()
  } catch (err) {
    alert(err.message || 'Failed to revoke administrator')
  }
}

async function handleDownloadCsv() {
  downloadingCsv.value = true
  try {
    await api.downloadCsv()
  } catch (err) {
    alert(err.message || 'Failed to download CSV export.')
  } finally {
    downloadingCsv.value = false
  }
}

onMounted(() => {
  // Set default deadline date for picker: 14 days from now
  const d = new Date()
  d.setDate(d.getDate() + 14)
  newCourse.registration_deadline = d.toISOString().slice(0, 16)

  fetchStats()
  fetchStudents()
  fetchAdmins()
})
</script>

