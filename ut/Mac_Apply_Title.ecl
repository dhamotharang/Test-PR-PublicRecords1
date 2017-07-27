import risk_indicators,ut,header;
export Mac_apply_title(infile,title_field, fname_field, mname_field, outfile) := macro
import header;
	header.Mac_apply_title(infile,title_field, fname_field, mname_field, outfile2)
	outfile:=outfile2:DEPRECATED('Use header.Mac_apply_title instead');
endmacro;