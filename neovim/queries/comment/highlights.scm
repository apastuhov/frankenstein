; extends

; Highlight TODO and FIXME labels without coloring the rest of the comment.

((tag
  (name) @comment.todo)
  (#any-of? @comment.todo "TODO" "FIXME")
  (#set! priority 150))

("text" @comment.todo
  (#any-of? @comment.todo "TODO" "FIXME")
  (#set! priority 150))
