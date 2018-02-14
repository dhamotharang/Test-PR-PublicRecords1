import tools, STD;
export Key(string pversion = '',boolean pUseProd = false) := module

	layout_diags := RECORD
   string7 diag_cd;
   string1 icd_version;
   string1 type_of_code;
   string8 effective_dt;
   string8 termination_dt;
   integer8 total_code_cnt;
   decimal16_2 total_paid_amt;
   string60 desc_short;
   string100 desc_med;
   string300 desc_long;
	END;

	shared ref_diags_9_and_10 := DATASET('~thor::base::qa::std_icd_diag_codes_reference_data', {layout_diags, UNSIGNED8 __fpos {virtual(fileposition)}}, THOR, OPT);
	export REF_ICD_10_DIAGS_FILTERED := ref_diags_9_and_10(icd_version<>'9' AND type_of_code = '1' AND termination_dt > (string)Std.Date.Today());

	shared ref_icd10_base				:= REF_ICD_10_DIAGS_FILTERED;

	tools.mac_FilesIndex('ref_icd10_base,{diag_cd},{diag_cd, desc_short}'	,Keyname(pversion,pUseProd).ref_icd10_diag_code,ref_icd10_key);
end;
