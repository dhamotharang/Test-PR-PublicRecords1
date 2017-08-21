import DriversV2, Address, ut, lib_stringlib;

export Cleaned_DL_LA(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_LA_Raw_Update(fileDate);

	layout_out := DriversV2.Layout_DL_LA_In.Cleaned;
	
	string8 reformatDate(string10 pDateIn)	:=	StringLib.StringFilterOut(pDateIn, '-');	
	
	// process each restriction code
	string CharCodeAndComma(string pRestrictionCode) :=	if(trim(pRestrictionCode,right)<>'',
																														',' + trim(pRestrictionCode,right),
																														''
																												 );

	layout_out mapClean(in_file l) := transform
		string73 	tempName 						:=	Address.CleanPersonLFM73(l.Name);
											
		self.clean_name_prefix				:= 	tempName[1..5];
		self.clean_name_first					:= 	tempName[6..25];
		self.clean_name_middle				:= 	tempName[26..45];
		self.clean_name_last					:= 	tempName[46..65];
		self.clean_name_suffix				:= 	tempName[66..70];
		self.clean_name_score					:= 	tempName[71..73];
		self.clean_prim_range					:= 	'';
		self.clean_predir							:= 	'';
		self.clean_prim_name					:= 	'';
		self.clean_addr_suffix				:= 	'';
		self.clean_postdir						:= 	'';
		self.clean_unit_desig					:= 	'';
		self.clean_sec_range					:= 	'';
		self.clean_p_city_name				:= 	'';
		self.clean_v_city_name				:= 	'';
		self.clean_st			   					:= 	'';
		self.clean_zip								:= 	'';
		self.clean_zip4						 		:= 	'';
		self.clean_cart				  			:= 	'';
		self.clean_cr_sort_sz					:= 	'';
		self.clean_lot								:= 	'';
		self.clean_lot_order					:= 	'';
		self.clean_dpbc								:= 	'';
		self.clean_chk_digit					:= 	'';
		self.clean_record_type				:= 	'';
		self.clean_ace_fips_st				:= 	'';
		self.clean_fipscounty					:= 	'';
		self.clean_geo_lat						:= 	'';
		self.clean_geo_long						:= 	'';
		self.clean_msa								:= 	'';
		self.clean_geo_blk						:= 	'';
		self.clean_geo_match					:= 	'';
		self.clean_err_stat						:= 	'';	
		self.append_process_date			:= 	lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.dt_first_seen						:= 	(unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;
		self.dt_last_seen							:= 	(unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;
		self.dt_vendor_first_reported	:= 	(unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;
		self.dt_vendor_last_reported	:= 	(unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;	
		self                       		:= 	l;		
	end;

	Cleaned_LA_File := project(in_file, mapClean(left));
	
	return Cleaned_LA_File;
end;
