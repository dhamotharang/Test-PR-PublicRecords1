import BatchServices,NCPDP,Autokey_batch,AutokeyB2;
EXPORT NCPDP_AutoKeys(DATASET(NCPDP_Layouts.autokeyInput) ak_input) := MODULE

		// SEARCH THE ContLegalPhys AUTOKEYS
		shared ak_config_ContLegalPhys_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := Healthcare_Services.NCPDP_Constants.USE_ALL_LOOKUPS;
				export noFail := Healthcare_Services.NCPDP_Constants.NO_FAIL;
				export workHard := Healthcare_Services.NCPDP_Constants.WORK_HARD;
				export skip_set := Healthcare_Services.NCPDP_Constants.ContLegalPhys_AUTOKEY_SKIP_SET;
		END;
			
			//**** GET FAKEIDS - FLAPD SEARCH
		shared ak_ContLegalPhys_key := Healthcare_Services.NCPDP_Constants.ContLegalPhys_AutoKey_Name;
		ak_ContLegalPhys_prov := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		shared ak_ContLegalPhys_out := Autokey_batch.get_fids(ak_ContLegalPhys_prov, ak_ContLegalPhys_key, ak_config_ContLegalPhys_data);
		//Detect 203
		export ContLegalPhys_autokeys_203 := exists(ak_ContLegalPhys_out(search_status=203));
		out_ContLegalPhys_rec := dataset([],NCPDP_Layouts.AKLayoutOutput);
		typ_str_ContLegalPhys := Healthcare_Services.NCPDP_Constants.TYPE_STR;
		AutokeyB2.mac_get_payload(ak_ContLegalPhys_out,ak_ContLegalPhys_key,out_ContLegalPhys_rec,out_ContLegalPhys,did,bdid,typ_str_ContLegalPhys);

		export ContLegalPhys_autokeys := out_ContLegalPhys;

		// SEARCH THE ContLegalMail AUTOKEYS
		shared ak_config_ContLegalMail_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := Healthcare_Services.NCPDP_Constants.USE_ALL_LOOKUPS;
				export noFail := Healthcare_Services.NCPDP_Constants.NO_FAIL;
				export workHard := Healthcare_Services.NCPDP_Constants.WORK_HARD;
				export skip_set := Healthcare_Services.NCPDP_Constants.ContLegalMail_AUTOKEY_SKIP_SET;
		END;
			
			//**** GET FAKEIDS - FLAPD SEARCH
		shared ak_ContLegalMail_key := Healthcare_Services.NCPDP_Constants.ContLegalMail_AutoKey_Name;
		ak_ContLegalMail_prov := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		shared ak_ContLegalMail_out := Autokey_batch.get_fids(ak_ContLegalMail_prov, ak_ContLegalMail_key, ak_config_ContLegalMail_data);
		//Detect 203
		export ContLegalMail_autokeys_203 := exists(ak_ContLegalMail_out(search_status=203));
		out_ContLegalMail_rec := dataset([],NCPDP_Layouts.AKLayoutOutput);
		typ_str_ContLegalMail := Healthcare_Services.NCPDP_Constants.TYPE_STR;
		AutokeyB2.mac_get_payload(ak_ContLegalMail_out,ak_ContLegalMail_key,out_ContLegalMail_rec,out_ContLegalMail,did,bdid,typ_str_ContLegalMail);

		export ContLegalMail_autokeys := out_ContLegalMail;

		// SEARCH THE DBAPhys AUTOKEYS
		shared ak_config_DBAPhys_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := Healthcare_Services.NCPDP_Constants.USE_ALL_LOOKUPS;
				export noFail := Healthcare_Services.NCPDP_Constants.NO_FAIL;
				export workHard := Healthcare_Services.NCPDP_Constants.WORK_HARD;
				export skip_set := Healthcare_Services.NCPDP_Constants.DBAPhys_AUTOKEY_SKIP_SET;
		END;
			
			//**** GET FAKEIDS - FLAPD SEARCH
		shared ak_DBAPhys_key := Healthcare_Services.NCPDP_Constants.DBAPhys_AutoKey_Name;
		ak_DBAPhys_prov := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		shared ak_DBAPhys_out := Autokey_batch.get_fids(ak_DBAPhys_prov, ak_DBAPhys_key, ak_config_DBAPhys_data);
		//Detect 203
		export DBAPhys_autokeys_203 := exists(ak_DBAPhys_out(search_status=203));
		out_DBAPhys_rec := dataset([],NCPDP_Layouts.AKLayoutOutputDBA);
		typ_str_DBAPhys := Healthcare_Services.NCPDP_Constants.TYPE_STR;
		AutokeyB2.mac_get_payload(ak_DBAPhys_out,ak_DBAPhys_key,out_DBAPhys_rec,out_DBAPhys,did,bdid,typ_str_DBAPhys);

		export DBAPhys_autokeys := out_DBAPhys;

		// SEARCH THE DBAMail AUTOKEYS
		shared ak_config_DBAMail_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := Healthcare_Services.NCPDP_Constants.USE_ALL_LOOKUPS;
				export noFail := Healthcare_Services.NCPDP_Constants.NO_FAIL;
				export workHard := Healthcare_Services.NCPDP_Constants.WORK_HARD;
				export skip_set := Healthcare_Services.NCPDP_Constants.DBAMail_AUTOKEY_SKIP_SET;
		END;
			
			//**** GET FAKEIDS - FLAPD SEARCH
		shared ak_DBAMail_key := Healthcare_Services.NCPDP_Constants.DBAMail_AutoKey_Name;
		ak_DBAMail_prov := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		shared ak_DBAMail_out := Autokey_batch.get_fids(ak_DBAMail_prov, ak_DBAMail_key, ak_config_DBAMail_data);
		//Detect 203
		export DBAMail_autokeys_203 := exists(ak_DBAMail_out(search_status=203));
		out_DBAMail_rec := dataset([],NCPDP_Layouts.AKLayoutOutputDBA);
		typ_str_DBAMail := Healthcare_Services.NCPDP_Constants.TYPE_STR;
		AutokeyB2.mac_get_payload(ak_DBAMail_out,ak_DBAMail_key,out_DBAMail_rec,out_DBAMail,did,bdid,typ_str_DBAMail);

		export DBAMail_autokeys := out_DBAMail;

end;
