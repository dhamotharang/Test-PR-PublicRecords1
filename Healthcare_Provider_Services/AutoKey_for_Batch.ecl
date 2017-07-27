IMPORT AutoKeyI, AutoKeyB2, Ingenix_NatlProf, doxie, NPPES, AMS, BatchServices,Autokey_batch, DEA, Prof_LicenseV2, ABMS;

EXPORT AutoKey_for_Batch(DATASET(Healthcare_Provider_Services.Layouts.autokeyInput) ak_input) := MODULE

		// SEARCH THE PROVIDERS AUTOKEYS
		ak_config_Ing_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export UseAllLookUps := TRUE;
				export boolean noFail := true;
				export skip_set :=Ingenix_NatlProf.Constants.autokey_skip_set_prov;
		END;
			
			//**** GET FAKEIDS - FLAPD SEARCH
		ak_ing_key := Ingenix_NatlProf.Constants.Autokey_qa_name_Prov;
		ak_ing_prov := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_ing_out := Autokey_batch.get_fids(ak_ing_prov, ak_ing_key, ak_config_Ing_data);
		out_ing_rec := dataset([],Healthcare_Provider_Services.Layouts.Layout_Autokeys_Prov);
		typ_str_ing := Ingenix_NatlProf.Constants.autokey_typeStr_prov;
		AutokeyB2.mac_get_payload(ak_ing_out,ak_ing_key,out_ing_rec,out_ing,did,zero,typ_str_ing);

		export ing_autokeys := out_ing;

		// SEARCH THE Sanctions AUTOKEYS
		ak_config_Ing_Sanc_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export UseAllLookUps := TRUE;
				export boolean noFail := true;
				export skip_set :=Ingenix_NatlProf.Constants.autokey_skip_set_sanc;
		END;
			//**** GET FAKEIDS - FLAPD SEARCH
		ak_sanc_key := Ingenix_NatlProf.Constants.autokey_qa_name_sanc;
		ak_in_sanc := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_sanc := Autokey_batch.get_fids(ak_in_sanc, ak_sanc_key, ak_config_Ing_Sanc_data);
		out_sanc_rec := dataset([],Healthcare_Provider_Services.Layouts.Layout_Autokeys_Sanc);
		typ_str_sanc := Ingenix_NatlProf.Constants.autokey_typeStr_sanc;
		AutokeyB2.mac_get_payload(ak_out_sanc,ak_sanc_key,out_sanc_rec,out_sanc,did,zero,typ_str_sanc);
		export sanc_autokeys := out_sanc;
		
		// SEARCH THE AMS AUTOKEYS
		ak_config_ams_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export UseAllLookUps := TRUE;
				export boolean noFail := true;
				export skip_set := AMS._Constants().AUTOKEY_SKIP_SET;
		END;

		//**** GET FAKEIDS - FLAPD SEARCH
		ak_ams_key := AMS._Constants().AUTOKEY_NAME;
		ak_in_ams := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_ams := Autokey_batch.get_fids(ak_in_ams, ak_ams_key, ak_config_ams_data);
		out_ams_rec := dataset([],Healthcare_Provider_Services.Layouts.Layout_Autokeys_ams);
		typ_str_ams := AMS._Constants().TYPE_STR;
		AutokeyB2.mac_get_payload(ak_out_ams,ak_ams_key,out_ams_rec,out_ams,did,bdid,typ_str_ams);
		
		export ams_autokeys := out_ams;
		
		// SEARCH THE NPI AUTOKEYS
		ak_config_npi_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export UseAllLookUps := TRUE;
				export boolean noFail := true;
				export skip_set :=NPPES.Constants().ak_skipSet;
		END;

		//**** GET FAKEIDS - FLAPD SEARCH
		ak_npi_key := NPPES.Constants().str_autokeyname;
		ak_in_npi := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_npi := Autokey_batch.get_fids(ak_in_npi, ak_npi_key, ak_config_npi_data);
		out_npi_rec := dataset([],recordof(NPPES.Key_NPPES_Payload)-fakeid);
		typ_str_npi := NPPES.Constants().ak_typeStr;
		AutokeyB2.mac_get_payload(ak_out_npi,ak_npi_key,out_npi_rec,out_npi,did,bdid,typ_str_npi);
		
		export npi_autokeys := out_npi;
		
		// SEARCH THE DEA AUTOKEYS
		ak_config_dea_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export boolean noFail := true;
				export UseAllLookUps := TRUE;
				export skip_set :=DEA.Constants('').skip_set;
		END;

		//**** GET FAKEIDS - FLAPD SEARCH
		ak_dea_key := DEA.Constants('').ak_QAname;
		ak_in_dea := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_dea := Autokey_batch.get_fids(ak_in_dea, ak_dea_key, ak_config_dea_data);
		out_dea_rec := dataset([],recordof(dea.Key_DEA_Payload)-fakeid);
		typ_str_dea := DEA.Constants('').ak_typestr;
		AutokeyB2.mac_get_payload(ak_out_dea,ak_dea_key,out_dea_rec,out_dea,(unsigned6)did,(unsigned6)bdid,typ_str_dea);
		
		export dea_autokeys := out_dea;
		
		// SEARCH THE Prof Lic AUTOKEYS
		ak_config_pl_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export boolean noFail := true;
				export UseAllLookUps := TRUE;
				export skip_set := Prof_LicenseV2.Constants.skip_set;
		END;

		//**** GET FAKEIDS - FLAPD SEARCH
		ak_pl_key := Prof_LicenseV2.Constants.autokey_qa_name;
		ak_in_pl := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_pl := Autokey_batch.get_fids(ak_in_pl, ak_pl_key, ak_config_pl_data);
		out_pl_rec := dataset([],recordof(Prof_LicenseV2.Key_ProfLic_Payload)-fakeid);
		typ_str_pl := 'BC';
		AutokeyB2.mac_get_payload(ak_out_pl,ak_pl_key,out_pl_rec,out_pl,did,bdid,typ_str_pl);
		
		export pl_autokeys := out_pl;
		
		// SEARCH THE ABMS AUTOKEYS
		ak_config_ABMS_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export boolean noFail := true;
				export UseAllLookUps := TRUE;
				export skip_set := ABMS._Constants().AUTOKEY_SKIP_SET;
		END;

		// **** GET FAKEIDS - FLAPD SEARCH
		ak_abms_key := ABMS._Constants().AUTOKEY_NAME;
		ak_in_abms := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_abms := Autokey_batch.get_fids(ak_in_abms, ak_abms_key, ak_config_abms_data);
		out_abms_rec := dataset([],recordof(ABMS.Key_Autokey_Payload)-fakeid);
		typ_str_abms :=  ABMS._Constants().TYPE_STR;
		AutokeyB2.mac_get_payload(ak_out_abms,ak_abms_key,out_abms_rec,out_abms,did,bdid,typ_str_abms);
		
		export abms_autokeys := out_abms;
		
END;