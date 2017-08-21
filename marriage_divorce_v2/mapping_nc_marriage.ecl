import ut;




marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layout_Marriage_NC_In le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 self.filing_type  					:= '3';
 self.vendor       					:= 'NCMAR';
 self.source_file  					:= 'NC VITAL STATISTICS';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'NC';
 
 
 //husband
 self.party1_type        		:= 'G';
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.groom_last_name)='' or trim(le.groom_first_name)='',
														'UNKNOWN',
 													  trim(le.groom_last_name)+', '+le.groom_first_name+' '+le.groom_middle_name));	
 
 //wife
 self.party2_type        		:= 'B';
 self.party2_name_format 		:= 'L';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.bride_last_name)='' or trim(le.bride_first_name)='',
														'UNKNOWN',
 													  trim(le.bride_last_name)+', '+le.bride_first_name+' '+le.bride_middle_name));	
 
 //marriage info
 self.marriage_dt        		:= (string)ut.Date_MMDDYYYY_i2(le.marr_mmddyyyy);
 self.marriage_filing_number := trim(le.certificate_num);
 self.marriage_county        := stringlib.stringtouppercase(marriage_divorce_v2.get_nc_county(le.county_code));

 self := [];

 
end;

export mapping_nc_marriage := project(marriage_divorce_v2.File_Marriage_NC_In,t_map_to_common(left));// : persist('mar_div_nc_mar');