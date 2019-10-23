import tools;
export Keyname(string		pversion			= '',   boolean pUseProd = false) := module

	export ref_icd10_lFileTemplate	    							:= '~thor400_data::key::std_icd_diag_codes::@version@::'	;
	
	export ref_icd10_ldiag_code															:= ref_icd10_lFileTemplate + 'diag_code';
	export ref_icd10_diag_code																:= tools.mod_FilenamesBuild(ref_icd10_ldiag_code	,pversion);
	export ref_icd10_diag_code_dAll_filenames	:= ref_icd10_diag_code.dAll_filenames;
	
	export ref_icd10	:= ref_icd10_diag_code.dAll_filenames;

end;
