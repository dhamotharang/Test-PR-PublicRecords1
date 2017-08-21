import ut, corrections, codes, hygenics_crim;

df := hygenics_crim.allcourtoffenses;

hygenics_crim.layout_CourtOffenses into_cof(df L, codes.File_Codes_V3_In R) := transform
	self.court_off_lev_mapped := R.long_desc;
	self.arr_off_lev_mapped := '';
	self := L;
end;

df2 := join(df,codes.File_Codes_V3_In,right.file_name='COURT_OFFENSES' and 
			right.field_name = 'COURT_OFF_LEV' and 
			right.field_name2 = left.vendor and 
			right.code = left.court_off_lev,
			into_cof(LEFT,RIGHT),lookup,left outer);
			
hygenics_crim.layout_CourtOffenses into_aof(df2 L, codes.File_Codes_V3_In R) := transform
	self.arr_off_lev_mapped := R.long_desc;
	self := L;
end;

df3 := join(df2,codes.File_Codes_V3_In,right.file_name='COURT_OFFENSES' and 
			right.field_name = 'ARR_OFF_LEV' and 
			right.field_name2 = left.vendor and 
			right.code = left.arr_off_lev,
			into_aof(LEFT,RIGHT),lookup,left outer);

ut.MAC_SF_BuildProcess(df3,'~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,aout,2)

export proc_build_DOC_court_offenses := aout;