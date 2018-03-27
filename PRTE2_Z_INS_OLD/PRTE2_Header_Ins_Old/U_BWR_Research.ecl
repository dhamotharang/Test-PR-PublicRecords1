IMPORT PRTE2_Header_Ins;
IMPORT prte;

// These two trying to view Boca data are hitting a layout error.
	// ds := prte_csv.ge_header_base.dheader_file_on_lz;
	// ds := PRTE.Get_Header_Base.Boca_Only;
	
	ds := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS;
	OUTPUT(ds);