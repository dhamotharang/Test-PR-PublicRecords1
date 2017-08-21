import ut;

ut.macAppendStandardizedDate(File_Marriage_OH_In
														,date_of_marriage
														,dDateStandardized);



marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(recordof(dDateStandardized) le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 
 //divorce info
 self.filing_type  := '3';
 
 self.vendor       := 'OH';
 self.source_file  := 'OH DEPARTMENT OF HEALTH';
 self.process_date := marriage_divorce_v2.process_date;
 self.state_origin := 'OH';


 //groom
 self.party1_type            := 'G';
 self.party1_name_format     := 'L';
 self.party1_name        		 := stringlib.stringcleanspaces( if(trim(le.grooms_last_name)='' or trim(le.grooms_first_name)='',
															  'UNKNOWN',
														     trim(le.grooms_last_name)+', '+le.grooms_first_name+' '+le.grooms_middle_initial));	
 
 self.party1_county        := if(trim(le.groom_residence_county)='99','OUT OF STATE',
															if(trim(le.groom_residence_county)='00','UNKNOWN',le.groom_residence_county));
 self.party1_times_married := if(trim(le.times_married_groom)='9','',le.times_married_groom);
 self.party1_age					 := if(trim(le.grooms_age)='00','',le.grooms_age);

//bride
 self.party2_type        := 'B';
 self.party2_name_format := 'L';
 self.party2_name        		 := stringlib.stringcleanspaces( if(trim(le.brides_last_name)='' or trim(le.brides_first_name)='',
															  'UNKNOWN',
														     trim(le.brides_last_name)+', '+le.brides_first_name+' '+le.brides_middle_name));	

  
 self.party2_county        := if(trim(le.bride_residence_county)='99','OUT OF STATE',
															if(trim(le.bride_residence_county)='00','UNKNOWN',le.bride_residence_county));
 self.party2_times_married := if(trim(le.times_married_bride)='9','',le.times_married_bride);
 self.party2_age					 := if(trim(le.brides_age)='00','',le.brides_age);


//marriage info
 self.marriage_dt 					 := le.yyyy+le.mm+le.dd;
 
 self.marriage_filing_number := trim(le.certificate_number);
 self.marriage_docket_volume := trim(le.volume_number);
 
 self.marriage_county        := trim(le.license_issued_county);
 
 

 self := [];


end;

export mapping_oh_marriage := project(dDateStandardized,t_map_to_common(left));