<template>
  <div class="min-h-screen flex flex-col bg-gruvbox-bg text-gruvbox-fg font-sans">
    <Navbar />
    <main class="flex-1 flex flex-col">
      <router-view />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()

onMounted(() => {
  if (authStore.token) {
    authStore.checkAuth()
  }
})
</script>

