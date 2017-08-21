IMPORT ut, Emdeon, tools;

EXPORT Files(STRING pversion = '', BOOLEAN pUseProd = FALSE) := MODULE

	 /* One file received, but contains three different record types, each with its own layout - will need to be split into three input files */
	EXPORT orig_file						:= DATASET(Emdeon.Filenames(pversion,pUseProd).orig_lInputTemplate, Emdeon.layouts.raw.Orig_file, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
	EXPORT orig_consol_file			:= DATASET(Emdeon.Filenames(pversion,pUseProd).orig_lConsolTemplate, Emdeon.layouts.raw.Orig_file, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
	EXPORT orig_consol_history	:= DATASET(Emdeon.Filenames(pversion,pUseProd).orig_lInputHistTemplate, Emdeon.layouts.raw.Orig_file, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__, opt);
	EXPORT raw_file							:= DATASET(Emdeon.Filenames(pversion,pUseProd).raw_lInputTemplate, Emdeon.layouts.raw.Orig_file, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
	
   /* Input File Versions */
  EXPORT claims_input  			:= DATASET(Emdeon.Filenames(pversion,pUseProd).claims_lInputTemplate, Emdeon.layouts.consolidated.c_record, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
  EXPORT splits_input  			:= DATASET(Emdeon.Filenames(pversion,pUseProd).splits_lInputTemplate, Emdeon.layouts.consolidated.s_record, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
  EXPORT detail_input 			:= DATASET(Emdeon.Filenames(pversion,pUseProd).detail_lInputTemplate, Emdeon.layouts.consolidated.d_record, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
	// EXPORT claims_history   	:= DATASET(Filenames(pversion,pUseProd).claims_lInputHistTemplate, layouts.input.c_record, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
	// EXPORT splits_history 		:= DATASET(Filenames(pversion,pUseProd).splits_lInputHistTemplate, layouts.input.s_record, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);
	// EXPORT detail_history  		:= DATASET(Filenames(pversion,pUseProd).detail_lInputHistTemplate, layouts.input.d_record, CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),__compressed__);

	 /* Base File Versions */
   tools.mac_FilesBase(Emdeon.Filenames(pversion,pUseProd).claims_base, Emdeon.layouts.base.c_record, claims_base);
   tools.mac_FilesBase(Emdeon.Filenames(pversion,pUseProd).splits_base, Emdeon.layouts.base.s_record, splits_base);
   tools.mac_FilesBase(Emdeon.Filenames(pversion,pUseProd).detail_base, Emdeon.layouts.base.d_record, detail_base);

END;
