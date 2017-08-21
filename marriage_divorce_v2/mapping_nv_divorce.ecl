import ut;
/*d
	string25 orig_Defendant_Name;
  string1 orig_Divorce_Record_Indicator;
  string1 orig_filler;
  string4 orig_Control_Certificate_Year;
  string7 orig_Control_Certificate_Number;
  string8 orig_Divorce_Date;
  string2 orig_Divorce_County;
  string1 orig_Decree;
  string25 orig_Plantiff_Name;
  string2 vfiller_1;
  string1 orig_Court_Code;
  string9 orig_Temporary_Number;
  string10 orig_County_File_Number;
  string14 orig_filler_2;

*/
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(recordof(marriage_divorce_v2.File_Divorce_NV_In) le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 self.filing_type  					:= '7';
 //self.filing_subtype				:= le.orig_Decree; no table for this
 self.vendor       					:= 'NVDIV';
 self.source_file  					:= 'NV VITAL STATISTICS';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'NV';

 // can be either plantiff or defendant
 self.party1_type 					:= if(le.orig_Divorce_Record_Indicator!='D','P',
												  			if(le.orig_Divorce_Record_Indicator!='P','D',''));
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= if(le.orig_Divorce_Record_Indicator='P' AND le.fixed_name_Plant!='',le.fixed_name_Plant,
																	if(le.orig_Divorce_Record_Indicator='D' AND le.fixed_name_Def!='',le.fixed_name_Def,'UNKNOWN'));	 
	
 // can be either plantiff or defendant
  self.party2_type 					:= if(le.orig_Divorce_Record_Indicator='D','P',
												  			if(le.orig_Divorce_Record_Indicator='P','D',''));
 self.party2_name_format 		:= 'L';
  self.party2_name        		:= if(le.orig_Divorce_Record_Indicator='D' AND le.fixed_name_Plant!='',le.fixed_name_Plant,
																	if(le.orig_Divorce_Record_Indicator='P' AND le.fixed_name_Def!='',le.fixed_name_Def,'UNKNOWN'));	

 //divorce info
 self.divorce_dt        		 := le.orig_Divorce_Date;
 self.divorce_filing_number  := le.orig_Control_Certificate_Number;
 self.divorce_docket_volume  := if(trim(le.orig_County_File_Number)='0000000000','',le.orig_County_File_Number); 
 //self.divorce_county         := get_nv_counties(le.orig_Divorce_County); no county codes match.

 self := [];

 
end;

export mapping_nv_divorce := project(marriage_divorce_v2.File_Divorce_NV_In,t_map_to_common(left));