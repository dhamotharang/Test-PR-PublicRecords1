import ut;

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layouts_FL_Divorce_In.Layout_Divorce_FL_In le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
//divorce filing info
  self.filing_type  := '7';
 
 self.filing_subtype := le.type_of_report;
 
 
 self.vendor       					:= 'FLDIV';
 self.source_file  					:= 'FLORIDA DEPT OF HEALTH';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'FL';

//husband 
 self.party1_type        		:= 'H';
 self.party1_name_format 		:= 'L';
 self.party1_name           := stringlib.stringcleanspaces(trim(le.husb_name_last)+', '+le.husb_name_first+' '+le.husb_name_middle+' '+le.husb_name_suffix);	
 
 
 
 self.party1_csz				 		:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(trim(le.husb_res_state_code)));
//wife
 self.party2_type        		:= 'W';
 self.party2_name_format 		:= 'L';
 self.party2_name           := stringlib.stringcleanspaces(trim(le.wife_name_last)+', '+le.wife_name_first+' '+le.wife_name_middle+' '+le.wife_maiden_surname);	
 
 
 
 self.party2_csz         		:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(trim(le.wife_res_state_code)));

 //marriage info bug #132685
 self.number_of_children 		:= if ( le.living_child_under18 <> '9',le.living_child_under18,'');
 self.marriage_dt     			:= if(trim(le.date_of_marriage_year,LEFT,RIGHT)+trim(le.date_of_marriage_month,LEFT,RIGHT)+trim(le.date_of_marriage_day,LEFT,RIGHT) != '88888888',trim(le.date_of_marriage_year,LEFT,RIGHT)+trim(le.date_of_marriage_month,LEFT,RIGHT)+trim(le.date_of_marriage_day,LEFT,RIGHT),'');
 self.place_of_marriage 		:= stringlib.stringtouppercase(marriage_divorce_v2.get_fl_states(le.marr_state_code));

 //divorce info
 self.divorce_filing_dt 		:= trim(le.date_filed_recYY,LEFT,RIGHT)+trim(le.date_filed_recMM,LEFT,RIGHT)+trim(le.date_filed_recDD,LEFT,RIGHT);
 self.divorce_dt        		:= if(trim(le.date_of_final_judgmentYY,LEFT,RIGHT)+trim(le.date_of_final_judgmentMM,LEFT,RIGHT)+trim(le.date_of_final_judgmentDD,LEFT,RIGHT) != '888888888',trim(le.date_of_final_judgmentYY,LEFT,RIGHT)+trim(le.date_of_final_judgmentMM,LEFT,RIGHT)+trim(le.date_of_final_judgmentDD,LEFT,RIGHT),'');
 self.divorce_filing_number := trim(le.certnumber);
 self.divorce_county        := le.county_issuing_report;
 self.divorce_docket_volume := trim(le.docket_vol_page);

 self := [];

 
end;

export mapping_fl_new_divorce := project(marriage_divorce_v2.File_FL_Divorce_In,t_map_to_common(left));// : persist('mar_div_fl_div');