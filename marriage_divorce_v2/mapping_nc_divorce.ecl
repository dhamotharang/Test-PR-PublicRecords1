import ut;




marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layout_Divorce_NC_In le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 //divorce info
 self.filing_type  					:= '7';
 self.vendor       					:= 'NCDIV';
 self.source_file  					:= 'NC VITAL STATISTICS';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'NC';
 

 self.party1_type				    := 'P';
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.plntf_last_name)='' or trim(le.plntf_first_name)='',
														'UNKNOWN',
														trim(le.plntf_last_name)+', '+le.plntf_first_name+' '+le.plntf_middle_name));	
   
 
 self.party2_type				    := 'D';
 self.party2_name_format		:= 'L';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.dfndnt_last_name)='' or trim(le.dfndnt_first_name)='',
														'UNKNOWN',
														trim(le.dfndnt_last_name)+', '+le.dfndnt_first_name+' '+le.dfndnt_middle_name));	
 
 //divorce info
 self.divorce_dt        		:= (string)ut.Date_MMDDYYYY_i2(le.decree_mmddyyyy);
 self.divorce_filing_number := trim(le.certificate_num);
 self.divorce_county        := stringlib.stringtouppercase(marriage_divorce_v2.get_nc_county(le.decree_cnty));
 self := [];

 
end;

export mapping_nc_divorce := project(marriage_divorce_v2.File_Divorce_NC_In,t_map_to_common(left));// : persist('mar_div_nc_div');