import ut;


marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.Layout_Divorce_KY_In le) := transform
 
 string2 v_mm := case(le.date_of_divorce_mddccyy[1],
                     '1'=>'0'+le.date_of_divorce_mddccyy[1],
					 '2'=>'0'+le.date_of_divorce_mddccyy[1],
					 '3'=>'0'+le.date_of_divorce_mddccyy[1],
					 '4'=>'0'+le.date_of_divorce_mddccyy[1],
					 '5'=>'0'+le.date_of_divorce_mddccyy[1],
					 '6'=>'0'+le.date_of_divorce_mddccyy[1],
					 '7'=>'0'+le.date_of_divorce_mddccyy[1],
					 '8'=>'0'+le.date_of_divorce_mddccyy[1],
					 '9'=>'0'+le.date_of_divorce_mddccyy[1],
					 '0'=>'10',
					 '&'=>'12',
					 '-'=>'11',
					 '00'
					);
					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 
 
 //divorce info
 self.filing_type  := '7';
 self.filing_subtype := if(le.type_of_decree='1','ABSOLUTE',
                        if(le.type_of_decree='2','LIMITED',
												if(le.type_of_decree='3','ANNULEMENT',
												if(le.type_of_decree='X','UNKNOWN',
						''))));
 
 self.vendor       := 'KYDIV';
 self.source_file  := 'DEPT FOR PUBLIC HEALTH';
 self.process_date := marriage_divorce_v2.process_date;
 self.state_origin := 'KY';


 //husband
 self.party1_type        := 'H';
 self.party1_name_format := 'L';
 self.party1_name        := stringlib.stringcleanspaces( if(trim(le.husband_last_name)='' or trim(le.husband_first_name)='',
														'UNKNOWN',
														trim(le.husband_last_name)+', '+le.husband_first_name+' '+le.husband_middle_initial));	
 
 self.party1_age         := if(le.husband_age<>'99',le.husband_age,'');

 self.party1_county        := stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.husband_place_of_residence));
 self.party1_race := case(le.husband_race,'1'=>'WHITE','2'=>'NEGRO','3'=>'OTHER','9'=>'UNKNOWN','');
 self.party1_times_married := le.husband_number_this_marriage;

//wife
 self.party2_type        		:= 'W';
 self.party2_name_format 		:= 'L';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.wife_maiden_name)='' or trim(le.wife_first_name)='',
														'UNKNOWN',
														trim(le.wife_maiden_name)+', '+le.wife_first_name+' '+le.wife_middle_initial));	
 self.party2_age         		:= if(le.wife_age<>'99',le.wife_age,'');

 self.party2_county        	:= stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.wife_place_of_residence));
 self.party2_race          	:= case(le.wife_race,'1'=>'WHITE','2'=>'NEGRO','3'=>'OTHER','9'=>'UNKNOWN','');
 self.party2_times_married 	:= le.wife_number_this_marriage;
 
//marriage info
 self.number_of_children   	:= le.number_of_children;
 self.marriage_dt     			:= le.year_of_marriage+le.month_of_marriage;
 self.marriage_county 			:= stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.place_of_marriage));

//divorce info
 self.divorce_filing_dt 		:= le.year_of_registration;
 self.divorce_dt        		:= (string)ut.Date_MMDDYYYY_i2(v_mm+le.date_of_divorce_mddccyy[2..7]);
 self.divorce_docket_volume := le.volume_number;
 self.divorce_filing_number := le.certificate_number;
 self.divorce_county        := stringlib.stringtouppercase(marriage_divorce_v2.get_ky_county(le.county_of_occurrence));

 self := [];

end;

export mapping_ky_divorce := project(marriage_divorce_v2.File_Divorce_KY_In,t_map_to_common(left));// : persist('mar_div_ky_div');