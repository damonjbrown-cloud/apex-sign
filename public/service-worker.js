self.addEventListener('install', () => {
  console.log('Apex Sign App installed')
})

self.addEventListener('activate', () => {
  console.log('Apex Sign App activated')
})

self.addEventListener('fetch', (event) => {
  event.respondWith(fetch(event.request))
})
