export mac_filterStateOverlap(inf, outf) := macro
	outf := inf(file_state not in uccd.set_DirectStates or isDirect);
endmacro;