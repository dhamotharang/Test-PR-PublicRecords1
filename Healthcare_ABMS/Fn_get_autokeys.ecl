import ABMS,BatchServices,Autokey_batch,AutokeyB2,AutokeyB2_batch,Healthcare_Shared;
EXPORT Fn_get_autokeys(DATASET(Healthcare_Shared.Layouts.autokeyInput) ak_input) := MODULE
//ABMS SECTION -> SEARCH THE ABMS AUTOKEYS
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
end;
