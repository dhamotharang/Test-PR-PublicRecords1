import ut;

ut.MAC_SF_BuildProcess(BankruptcyV2.Mapping_BK_Main_history,
                       '~thor_data400::base::Bankruptcy::Main_history',bld_bk_main_hi, 2);
				   
ut.MAC_SF_BuildProcess(BankruptcyV2.BK_DID_history,
                       '~thor_data400::base::Bankruptcy::search_history', bld_bk_search_hi,2);
					   
					 
export proc_build_history_base := sequential(bld_bk_main_hi, bld_bk_search_hi);


