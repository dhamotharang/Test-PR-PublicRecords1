export Lookup_TX_Statewide := module


//Looup Layouts
	export layout_adn := 
		record
		string adn_cod;
		string adn_val;
		end;
		
	export layout_agency := 
		record
		string agy_idn;
		string ori_txt;
		string atr_txt;
		end;
		
	export layout_cdn := 
		record
		string cdn_cod;
		string cdn_val;
		end;
		
	export layout_coc := 
		record
		string coc_cod;
		string coc_val;
		end;

	export layout_cpn := 
		record
		string cpn_cod;
		string cpn_val;
		string cpn_act_cod;
		string cpn_lng_txt;
		string cpn_app_cod;
		end;

	export layout_dda := 
		record
		string dda_cod;
		string dda_val;
		string dda_act_cod;
		string dda_lng_txt;
		string dda_app_cod;
		end;
		
	export layout_fcd := 
		record
		string fcd_cod;
		string fcd_val;
		string fcd_act_cod;
		string fcd_lng_txt;
		string fcd_app_cod;
		end;

	export layout_fpo := 
		record
		string fpo_cod;
		string fpo_val;
		string fpo_act_cod;
		string fpo_lng_txt;
		string fpo_app_cod;
		end;

	export layout_goc := 
		record
		string goc_cod;
		string goc_val;
		end;
		
	export layout_off := 
		record
		string ofc_idn;
		string off_cod;
		string stu_cod;
		string cit_cod;
		string lda_cod;
		string lit_val;
		string beg_dte;
		string end_dte;
		end;
		
	export layout_paf := 
		record
		string paf_cod;
		string paf_val;
		string paf_act_cod;
		string paf_lng_txt;
		string paf_app_cod;
		end;
		
	export layout_ssn := 
		record
		string ssn_cod;
		string ssn_val;
		end;

//Lookup Files
	export adn := dataset('~thor_data400::in::crim_court::tx::statewide::adn_cod.txt', layout_adn,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export agency := dataset('~thor_data400::in::crim_court::tx::statewide::agency.txt', layout_agency,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export cdn := dataset('~thor_data400::in::crim_court::tx::statewide::cdn_cod.txt', layout_cdn,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export coc := dataset('~thor_data400::in::crim_court::tx::statewide::coc_cod.txt', layout_coc,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export cpn := dataset('~thor_data400::in::crim_court::tx::statewide::cpn_cod.txt', layout_cpn,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export dda := dataset('~thor_data400::in::crim_court::tx::statewide::dda_cod.txt', layout_dda,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
					
	export fcd := dataset('~thor_data400::in::crim_court::tx::statewide::fcd_cod.txt', layout_fcd,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));	
						
	export fpo := dataset('~thor_data400::in::crim_court::tx::statewide::fpo_cod.txt', layout_fpo,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export goc := dataset('~thor_data400::in::crim_court::tx::statewide::goc_cod.txt', layout_goc,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
												
	export off := dataset('~thor_data400::in::crim_court::tx::statewide::off_code.txt', layout_off,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
	export paf := dataset('~thor_data400::in::crim_court::tx::statewide::paf_cod.txt', layout_paf,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n'])));
						
end;