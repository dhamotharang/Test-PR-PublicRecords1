import DriversV2, Address, ut, lib_stringlib;

export Cleaned_DL_NV(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_NV_Raw_Update(fileDate);

	layout_out := driversV2.Layout_DL_NV_In.Cleaned;
	
	string8 reformatDate(string10 pDateIn)	:=	StringLib.StringFilterOut(pDateIn, '-');	

	layout_out mapClean(in_file l) := transform
		string		fullName						:=	trim(	trim(l.LST_NAME,left,right) + ', ' + 
																						trim(l.FST_NAME,left,right) + 
																						trim(l.MID_NAME,left,right),left,right);
																					
		string73 	tempName 						:=	Address.CleanPersonLFM73(fullName);
											
		self.clean_name_prefix				:= tempName[1..5];
		self.clean_name_first					:= tempName[6..25];
		self.clean_name_middle				:= tempName[26..45];
		self.clean_name_last					:= tempName[46..65];
		self.clean_name_suffix				:= tempName[66..70];
		self.clean_name_score					:= tempName[71..73];
		self.clean_m_prim_range				:= '';
		self.clean_m_predir						:= '';
		self.clean_m_prim_name				:= '';
		self.clean_m_addr_suffix			:= '';
		self.clean_m_postdir					:= '';
		self.clean_m_unit_desig				:= '';
		self.clean_m_sec_range				:= '';
		self.clean_m_p_city_name			:= '';
		self.clean_m_v_city_name			:= '';
		self.clean_m_st			   				:= '';
		self.clean_m_zip							:= '';
		self.clean_m_zip4						 	:= '';
		self.clean_m_cart				  		:= '';
		self.clean_m_cr_sort_sz				:= '';
		self.clean_m_lot							:= '';
		self.clean_m_lot_order				:= '';
		self.clean_m_dpbc							:= '';
		self.clean_m_chk_digit				:= '';
		self.clean_m_record_type			:= '';
		self.clean_m_ace_fips_st			:= '';
		self.clean_m_fipscounty				:= '';
		self.clean_m_geo_lat					:= '';
		self.clean_m_geo_long					:= '';
		self.clean_m_msa							:= '';
		self.clean_m_geo_blk					:= '';
		self.clean_m_geo_match				:= '';
		self.clean_m_err_stat					:= '';		
		
		self.clean_p_prim_range				:= '';
		self.clean_p_predir						:= '';
		self.clean_p_prim_name				:= '';
		self.clean_p_addr_suffix			:= '';
		self.clean_p_postdir					:= '';
		self.clean_p_unit_desig				:= '';
		self.clean_p_sec_range				:= '';
		self.clean_p_p_city_name			:= '';
		self.clean_p_v_city_name			:= '';
		self.clean_p_st			   				:= '';
		self.clean_p_zip							:= '';
		self.clean_p_zip4							:= '';
		self.clean_p_cart							:= '';
		self.clean_p_cr_sort_sz				:= '';
		self.clean_p_lot							:= '';
		self.clean_p_lot_order				:= '';
		self.clean_p_dpbc							:= '';
		self.clean_p_chk_digit				:= '';
		self.clean_p_record_type			:= '';
		self.clean_p_ace_fips_st			:= '';
		self.clean_p_fipscounty				:= '';
		self.clean_p_geo_lat					:= '';
		self.clean_p_geo_long					:= '';
		self.clean_p_msa							:= '';
		self.clean_p_geo_blk					:= '';
		self.clean_p_geo_match				:= '';
		self.clean_p_err_stat					:= '';					
		self.append_process_date			:= lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.dt_first_seen						:= (unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;
		self.dt_last_seen							:= (unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;
		self.dt_vendor_first_reported	:= (unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;
		self.dt_vendor_last_reported	:= (unsigned8)lib_stringlib.stringlib.stringfilter(processDate,'0123456789') div 100;	
		self.DOB											:= reformatDate(l.DOB);
		self.EFF_DT										:= reformatDate(l.EFF_DT);
		self                       		:= l;		
	end;

	Cleaned_NV_File := project(in_file, mapClean(left));
	
	return Cleaned_NV_File;
end;
