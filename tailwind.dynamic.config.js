const path = require('path')

module.exports = {
  future: {
    hoverOnlyWhenSupported: true
  },
  content: [
    path.resolve(__dirname, 'app/javascript/template_builder/dynamic_area.vue'),
    path.resolve(__dirname, 'app/javascript/template_builder/dynamic_section.vue')
  ],
  theme: {
    extend: {
      colors: {
        'base-100': '#F4F7FB',
        'base-200': '#E7EEF6',
        'base-300': '#D3E0EE',
        'base-content': '#07101F'
      }
    }
  }
}
