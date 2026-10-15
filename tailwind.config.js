module.exports = {
  future: {
    hoverOnlyWhenSupported: true
  },
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        docuseal: {
          'color-scheme': 'light',
          primary: '#185FA5',
          secondary: '#378ADD',
          accent: '#5BA8E8',
          neutral: '#07101F',
          'base-100': '#F4F7FB',
          'base-200': '#E7EEF6',
          'base-300': '#D3E0EE',
          'base-content': '#07101F',
          '--rounded-btn': '1.9rem',
          '--tab-border': '2px',
          '--tab-radius': '.5rem'
        }
      }
    ]
  }
}
