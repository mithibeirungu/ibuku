import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    host: '0.0.0.0', // Essential for WSL2 port forwarding to Windows host
    port: 5173,
    strictPort: true,
    watch: {
      usePolling: true, // Optimizes file change detection across WSL2 / Windows 9p filesystem mounts
      interval: 100
    }
  }
})

