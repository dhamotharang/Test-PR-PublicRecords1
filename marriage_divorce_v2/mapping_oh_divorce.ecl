import ut,address;

ut.macAppendStandardizedDate(File_Divorce_OH_In
														,date_of_decree
														,dDateStandardized);



marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(recordof(dDateStandardized) le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 
 //divorce info
 self.filing_type  := '7';
 self.filing_subtype := if(le.divorce_code='1','',
                        if(le.divorce_code='2','ANNULEMENT',
												if(le.divorce_code='3','DISSOLUTION',
												'')));
 
 self.vendor       := 'OH';
 self.source_file  := 'OH DEPARTMENT OF HEALTH';
 self.process_date := marriage_divorce_v2.process_date;
 self.state_origin := 'OH';


 //husband
 self.party1_type            := 'H';
 self.party1_name_format     := 'L';
 self.party1_name        		 := stringlib.stringcleanspaces( if(trim(le.husband_last_name)='' or trim(le.husband_first_name)='',
															  'UNKNOWN',
														     trim(le.husband_last_name)+', '+le.husband_first_name+' '+le.husband_middle_name));	
 //BUG 152269. husband_year_birth is 4 bytes long and it is 9999 when not present.
 //self.party1_dob 				   := if(le.husband_year_of_birth <>'--',le.husband_year_of_birth,'');
 self.party1_dob 				   	 := if(le.husband_year_of_birth <>'9999',le.husband_year_of_birth,'');
 self.party1_county        	 := le.husband_county;
 self.party1_times_married 	 := le.husband_times_married;

//wife
 //husband
 self.party2_type        := 'W';
 //Based on Terri's review comment
 self.party2_name_format := 'F';
 self.party2_name        := stringlib.stringcleanspaces( if(trim(le.Wife_first_name)='',
														'UNKNOWN',
														le.Wife_first_name+' '+le.wife_middle_name));	
 
 //BUG 152269. wife_year_birth is 4 bytes long and it is 9999 when not present.
 //self.party2_dob 				   := if(le.Wife_year_of_birth <>'--',le.Wife_year_of_birth,'');
 self.party2_dob 				   := if(le.Wife_year_of_birth <>'9999',le.Wife_year_of_birth,'');
 self.party2_county        := le.wife_county;
 self.party2_times_married := le.wife_times_married;


 self.number_of_children   	:= if(trim(le.number_of_minor_children)='9','',le.number_of_minor_children);

//divorce info
 self.divorce_dt        	:= le.yyyy+le.mm+le.dd;
 self.divorce_docket_volume := le.volume_number;
 self.divorce_filing_number := le.certificate_number;
 self.divorce_county        := le.county_decree;
 self.grounds_for_divorce   :=if(le.grounds_for_divorce='1','WILLFUL ABSENCE',
															if(le.grounds_for_divorce='2','ADULTERY',
															if(le.grounds_for_divorce='3','IMPRISONMENT',
															if(le.grounds_for_divorce='4','EXTRME CRUELTY',
															if(le.grounds_for_divorce='5','GROSS NEGLECT/EXTREME CRUETLY',
															if(le.grounds_for_divorce='6','GROSS NEGLECT OF DUTY',
															if(le.grounds_for_divorce='7','WILLFUL ABSENCE AND GROSS NEGLECT',
															if(le.grounds_for_divorce='8','DIVOUTST/FRAUDCNTRCT/IMPOTENCY/UNDERAGE',
															if(le.grounds_for_divorce='9','UNKNOWN GROUNDS',
															'')))))))));
 
 self.marriage_duration     :=if(le.marriage_duration='00','',
                              if(le.marriage_duration='99','LT1',
							  (string)(integer)le.marriage_duration));
 
 //this is a special case, OH Divorce data doesn't provide the wife's last name
 // self.pname_party2 := if(self.party2_name<>'' and self.party2_name<>'UNKNOWN',
                       // address.cleanpersonLFM73(le.husband_last_name+', '+self.party2_name),
					  // '');
 tmp_pname_party2 := if(self.party2_name<>'' and self.party2_name<>'UNKNOWN',
                       address.cleanpersonFML73(self.party2_name+' '+le.husband_last_name),
					             '');
 self.pname_party2 := if(tmp_pname_party2='',
                         '',
												 tmp_pname_party2[1..65]+'     '+tmp_pname_party2[71..]);  //Note _ i don't know why it takes 6 spaces instead of 5.
 self := [];


end;

export mapping_oh_divorce := project(dDateStandardized,t_map_to_common(left));