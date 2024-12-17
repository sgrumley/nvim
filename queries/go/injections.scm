;; extends
; json
(
  (short_var_declaration
    left: (expression_list (identifier) @_var)
    right: (expression_list
             (raw_string_literal
               (raw_string_literal_content) @injection.content)))
  (#match? @injection.content "^\\{")
  (#set! injection.language "json")
  (#set! injection.combined)
)

; sql
(
  (short_var_declaration
    left: (expression_list (identifier) @_var)
    right: (expression_list
             (raw_string_literal
               (raw_string_literal_content) @injection.content)))
  (#set! injection.language "sql")
  (#set! injection.combined)
)

; eg. from code
; json := `{"name": "name", "age": 13}`
; sql := `{SELECT * FROM users WHERE id="id"}`

	   ;(short_var_declaration ; [22, 1] - [22, 43]
	   ;  left: (expression_list ; [22, 1] - [22, 4]
	   ;    (identifier)) ; [22, 1] - [22, 4]
	   ;  right: (expression_list ; [22, 8] - [22, 43]
	   ;    (raw_string_literal ; [22, 8] - [22, 43]
	   ;      (raw_string_literal_content)))) ; [22, 9] - [22, 42]

