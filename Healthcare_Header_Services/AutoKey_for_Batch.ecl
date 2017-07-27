IMPORT AutoKeyI, AutoKeyB2, doxie, BatchServices,Autokey_batch,NPPES, Enclarity,AutokeyB2_batch, Ingenix_NatlProf;

EXPORT AutoKey_for_Batch(DATASET(Healthcare_Header_Services.Layouts.autokeyInput) ak_input) := MODULE
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
		// SEARCH THE Enclarity SelectFile AUTOKEYS
		ak_config_SelectFile_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export boolean workHard := true;
				export boolean noFail := true;
				export UseAllLookUps := TRUE;
				export skip_set := Enclarity.Autokey_constants().Autokey_indiv_constants.ak_skipSet;
		END;

		// **** GET FAKEIDS - FLAPD SEARCH
		ak_SelectFile_key := Enclarity.Autokey_constants().Autokey_indiv_constants.str_autokeyname;
		ak_in_SelectFile := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out_SelectFile := Autokey_batch.get_fids(ak_in_SelectFile, ak_SelectFile_key, ak_config_SelectFile_data);
		out_SelectFile_rec := dataset([],Enclarity.Layouts.autokey_common);
		typ_str_SelectFile :=  Enclarity.Autokey_constants().Autokey_indiv_constants.ak_typeStr;
		AutokeyB2.mac_get_payload(ak_out_SelectFile,ak_SelectFile_key,out_SelectFile_rec,out_SelectFile,did,bdid,typ_str_SelectFile);
		
		export SelectFile_autokeys := out_SelectFile;
		
		//The below is a special autokey for re-Enty code only. Do not use unless you have a providerid that is actually the fakeid from the Enclarity Business file
		ak_SelectFileBus_key := Enclarity.Autokey_constants().Autokey_indiv_constants.str_autokeyname;
		ak_out_SelectFileBus := PROJECT(ak_input,transform(AutokeyB2_batch.Layouts.rec_output_IDs_batch,self.acctno:=left.acctno;self.search_status:=0;self.matchCode:='L';self.id:=left.providerid;self.isDID:=true;self:=[]));
		out_SelectFileBus_rec := dataset([],Enclarity.Layouts.autokey_common);
		typ_str_SelectFileBus :=  Enclarity.Autokey_constants().Autokey_indiv_constants.ak_typeStr;
		AutokeyB2.mac_get_payload(ak_out_SelectFileBus,ak_SelectFileBus_key,out_SelectFileBus_rec,out_SelectFileBus,did,bdid,typ_str_SelectFileBus);
		
		export SelectFileBus_autokeys := out_SelectFileBus;

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
		out_sanc_rec := dataset([],Healthcare_Header_Services.Layouts.Layout_Autokeys_Sanc);
		typ_str_sanc := Ingenix_NatlProf.Constants.autokey_typeStr_sanc;
		AutokeyB2.mac_get_payload(ak_out_sanc,ak_sanc_key,out_sanc_rec,out_sanc,did,zero,typ_str_sanc);
		export sanc_autokeys := out_sanc;

END;