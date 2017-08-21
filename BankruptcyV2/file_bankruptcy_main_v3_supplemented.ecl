export file_bankruptcy_main_v3_supplemented :=
			dataset('~thor_data400::base::bankruptcy::main_v3',bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp ,flat);
					//	(court_code+case_number not in bankruptcyv2.Suppress.court_code_caseno); //has additional v3 Banko fields used for supplemental key(s)
