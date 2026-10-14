// Single source of per-signer colors, indexed by submitter order.
// 0 Buyer blue, 1 Co-buyer green, 2 Dealer orange, then distinct colors.
// Field fills, borders, chips, and event marks all follow this list.
// lib/signer_colors.rb parses these object literals; keep one entry per line.

export const signerColors = [
  { dot: 'bg-blue-500', bg: 'bg-blue-100', border: 'border-blue-500/80', outline: 'outline-blue-500', edge: 'border-blue-100', event: 'bg-blue-200' },
  { dot: 'bg-green-500', bg: 'bg-green-100', border: 'border-green-500/80', outline: 'outline-green-500', edge: 'border-green-100', event: 'bg-green-200' },
  { dot: 'bg-orange-500', bg: 'bg-orange-100', border: 'border-orange-500/80', outline: 'outline-orange-500', edge: 'border-orange-100', event: 'bg-orange-200' },
  { dot: 'bg-red-500', bg: 'bg-red-100', border: 'border-red-500/80', outline: 'outline-red-500', edge: 'border-red-100', event: 'bg-red-200' },
  { dot: 'bg-yellow-300', bg: 'bg-yellow-100', border: 'border-yellow-300/80', outline: 'outline-yellow-300', edge: 'border-yellow-100', event: 'bg-yellow-200' },
  { dot: 'bg-purple-600', bg: 'bg-purple-100', border: 'border-purple-600/80', outline: 'outline-purple-600', edge: 'border-purple-100', event: 'bg-purple-200' },
  { dot: 'bg-pink-500', bg: 'bg-pink-100', border: 'border-pink-500/80', outline: 'outline-pink-500', edge: 'border-pink-100', event: 'bg-pink-200' },
  { dot: 'bg-cyan-500', bg: 'bg-cyan-100', border: 'border-cyan-500/80', outline: 'outline-cyan-500', edge: 'border-cyan-100', event: 'bg-cyan-200' },
  { dot: 'bg-lime-500', bg: 'bg-lime-100', border: 'border-lime-500/80', outline: 'outline-lime-500', edge: 'border-lime-100', event: 'bg-lime-200' },
  { dot: 'bg-indigo-500', bg: 'bg-indigo-100', border: 'border-indigo-500/80', outline: 'outline-indigo-500', edge: 'border-indigo-100', event: 'bg-indigo-200' }
]

export const signerDotClasses = signerColors.map((color) => color.dot)
export const signerBgClasses = signerColors.map((color) => color.bg)
export const signerBorderClasses = signerColors.map((color) => color.border)

export function signerColor (index) {
  const parsed = Number(index)
  const safeIndex = Number.isFinite(parsed) && parsed >= 0 ? parsed : 0

  return signerColors[safeIndex % signerColors.length]
}
