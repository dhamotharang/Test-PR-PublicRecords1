import marriage_divorce_v2;

export keys := module

	export main(boolean isFCRA = false)			:= marriage_divorce_v2.key_mar_div_id_main(isFCRA);
	export search(boolean isFCRA = false)		:= marriage_divorce_v2.key_mar_div_id_search(isFCRA);
	export did(boolean isFCRA = false) 			:= marriage_divorce_v2.key_mar_div_did(isFCRA);
	export fnum			:= marriage_divorce_v2.key_mar_div_filing_nbr;
	// export k_payload 	:= marriage_divorce_v2.key_mar_div_payload;

end;