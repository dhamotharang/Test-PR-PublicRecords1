import ut, std;

EXPORT functions := module

	export create_midex_rpt_nbr(string in_batch, string in_incident_num, string in_party_num) := function
					v_incident_number := ut.rmv_ld_zeros(in_incident_num);
					v_party_number 		:= ut.rmv_ld_zeros(in_party_num);
					cln_party_number 	:= if(trim(v_party_number) = '0','',v_party_number);
					midex_rpt_nbr 		:= std.str.CleanSpaces(trim(in_batch)+'-'	+ v_incident_number +'-' + cln_party_number);
	return midex_rpt_nbr ;
	end;





end;