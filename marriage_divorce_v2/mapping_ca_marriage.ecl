import ut;




marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Marriage_CA_In le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;

 //divorce info
 self.filing_type  					:= '3';
 self.vendor       					:= 'CAMAR';
 self.source_file  					:= 'CA VITAL STATISTICS';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'CA';
 
 //husband
 self.party1_type			      := 'G';
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.groom_last_name)='' or trim(le.groom_first_name)='',
														'UNKNOWN',
														trim(le.groom_last_name)+', '+le.groom_first_name+' '+le.groom_middle_initial));	
self.party1_age							:=le.groom_age;
   
//wife 
 self.party2_type			      := 'B';
 self.party2_name_format		:= 'L';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.bride_last_name)='' or trim(le.bride_first_name)='',
														'UNKNOWN',
														trim(le.bride_last_name)+', '+le.bride_first_name+' '+le.bride_middle_initial));	
 self.party2_age						:=le.bride_age;
 //marriage info
 
 self.marriage_dt        		 := '19'+le.marriage_dt;
 self.marriage_filing_number := trim(le.local_registrar_number);
 self.marriage_docket_volume := le.state_file_number;
 
 self.marriage_county        := stringlib.stringtouppercase(marriage_divorce_v2.get_ca_county(le.marriage_county));
 
 
 
 self := [];

 
end;

export mapping_ca_marriage := project(marriage_divorce_v2.File_Marriage_CA_In,t_map_to_common(left)) : persist('mar_div_ca_mar');