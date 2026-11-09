; extends

; TypeScript exposes optional chaining as an anonymous token.
("?." @operator
  (#set! priority 110))

; Type composition uses operators, rather than decorative delimiters.
(union_type
  "|" @operator
  (#set! priority 110))

(intersection_type
  "&" @operator
  (#set! priority 110))
