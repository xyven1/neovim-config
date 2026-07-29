(
	(comment) @injection.content
	(#set! injection.language "comment")
)

(
	(shell_command
		(
			(shell_fragment) @injection.content
			(line_continuation)?
		)+
	)

	(#set! injection.language "bash")
)

(
	(run_instruction
		(heredoc_block
			(
				(heredoc_line) @injection.content
				"\n" @injection.content
			)+
		)
	)

  (#set! injection.language "bash")
)
