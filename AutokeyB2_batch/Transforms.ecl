IMPORT Autokey_batch, ut;

EXPORT Transforms := MODULE

	EXPORT AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_add_zip_set(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) :=
		TRANSFORM
			SELF.zip_value := ut.fn_GetZipSet(l.p_city_name, l.st, l.z5,	'', ziplib.CityToZip5(l.st, l.p_city_name), l.zipradius);
			SELF           := l;
		END;
			
	EXPORT AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_parse_companyname(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 
		TRANSFORM
			SELF.comp_name_indic_value := IF(l.company_name = '', '', TRIM(datalib.companyclean(l.company_name)[1..40]));
			SELF.comp_name_sec_value   := IF(l.company_name = '', '', TRIM(datalib.companyclean(l.company_name)[41..80]));
			SELF := l;
		END;
		
	// Used by AutokeyB2_batch.Get_BDIDs_Batch()
	EXPORT AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_convert_for_getting_BDIDs(Autokey_batch.Layouts.rec_Cleaned_Input_Record l) := 
		TRANSFORM
			SELF.acctno       := l.AccountNumber;
			SELF.fein         := l.FEIN;
			SELF.phone10      := l.Phone;
			SELF.company_name := l.CName;
			SELF.prim_range   := l.prange_value;
			SELF.predir       := l.predir_value;
			SELF.prim_name    := l.pname_value;
			SELF.addr_suffix  := l.addr_suffix_value;
			SELF.postdir      := l.postdir_value;
			SELF.sec_range    := l.sec_range_value;
			SELF.p_city_name  := l.City;
			SELF.st           := l.State;
			SELF.z5           := l.Zip;
			SELF              := l;
		END;		
				
				
	// ===========================================================================================================

	// ------------------------------------ Likely unused transforms. ------------------------------------

	// ***** Suppression Transforms. *****		
		
		EXPORT AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_Remove_CityStateZip(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 
			TRANSFORM
				SELF.p_city_name := '';
				SELF.st          := '';
				SELF.z5          := '';
				SELF.zip_value   := [];
				SELF             := l;
			END;	
			
		EXPORT AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_Remove_CityZip(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 
			TRANSFORM
				SELF.p_city_name := '';
				SELF.z5          := '';
				SELF.zip_value   := [];				
				SELF             := l;
			END;				
			
		EXPORT AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_Remove_PrimName(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 
			TRANSFORM
				SELF.prim_name := '';
				SELF           := l;
			END;		

	// ------------------------------------ End likely unused transforms. ------------------------------------

END;  // Transforms module
