//hd := header.file_headers;
export isPreGLB(hd) := MACRO

	header.fn_IsPreGLB((unsigned3)hd.dt_nonglb_last_seen, (unsigned3)hd.dt_first_seen, (string2)hd.src)

ENDMACRO;