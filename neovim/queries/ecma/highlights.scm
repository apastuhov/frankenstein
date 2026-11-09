; extends

; Receivers are keywords, while ordinary built-in variables stay neutral.
([
  (this)
  (super)
] @keyword
  (#set! priority 110))
