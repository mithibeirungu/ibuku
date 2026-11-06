/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        gruvbox: {
          bg: '#fbf1c7', // Gruvbox light 0 (warm parchment)
          'bg-soft': '#f2e5bc', // Gruvbox light 1
          surface: '#f2e5bc',
          'surface-card': '#f2e5bc',
          'surface-light': '#ebdbb2',
          'surface-muted': '#f4ebd0',
          'surface-parchment': '#fffef9',
          border: '#d5c4a1',
          'border-dark': '#bdae93',
          'border-light': '#ebdbb2',
          fg: '#3c3836', // Gruvbox dark 0 (soft charcoal)
          'fg-dark': '#282828',
          'fg-muted': '#7c6f64',
          'fg-faint': '#928374',
          green: '#98971a',
          'green-dark': '#79740e',
          'green-bg': '#e7e5b8',
          yellow: '#d79921',
          'yellow-dark': '#b57614',
          'yellow-bg': '#f5e8be',
          aqua: '#689d6a',
          'aqua-dark': '#427b58',
          'aqua-bg': '#e0ede0',
          red: '#cc241d',
          'red-dark': '#9d0006',
          'red-bg': '#fbe5e4',
          blue: '#458588',
          'blue-dark': '#076678',
          orange: '#d65d0e',
          'orange-dark': '#af3a03'
        }
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
        mono: ['"JetBrains Mono"', '"Fira Code"', 'Consolas', 'monospace'],
        serif: ['"Playfair Display"', '"Cormorant Garamond"', 'Georgia', 'serif']
      },
      boxShadow: {
        'gruvbox': '0 4px 12px -2px rgba(60, 56, 54, 0.08), 0 2px 4px -2px rgba(60, 56, 54, 0.04)',
        'parchment': 'inset 0 0 10px rgba(181, 118, 20, 0.05), 0 2px 8px rgba(60, 56, 54, 0.06)'
      }
    },
  },
  plugins: [],
}

