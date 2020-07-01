import std;

export OH_as_DL (dataset(DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned) in_file):=function

	DriversV2.Layout_DL_Extended intof(DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned l) := transform 

		self.orig_state 			    		    := 'OH';
		self.source_code	                := 'AD';
		self.dt_first_seen    				    := (unsigned8)l.process_date div 100;
		self.dt_last_seen     				    := (unsigned8)l.process_date div 100;
		self.dt_vendor_first_reported     := (unsigned8)l.process_date div 100;
		self.dt_vendor_last_reported	    := (unsigned8)l.process_date div 100;
		self.dateReceived		  				    := (integer)l.process_date;	
		self.name											    := DriversV2.functions.TrimUpper(DriversV2.functions.TrimUpper(l.First_Name)+' '+ DriversV2.functions.TrimUpper(l.Middle_Name)+' '+ 
																																			 DriversV2.functions.TrimUpper(l.Last_Name)+' '+ DriversV2.functions.TrimUpper(l.Suffix) );
		self.RawFullName							    := DriversV2.functions.TrimUpper(DriversV2.functions.TrimUpper(l.First_Name)+' '+ DriversV2.functions.TrimUpper(l.Middle_Name)+' '+ 
																																			 DriversV2.functions.TrimUpper(l.Last_Name)+' '+ DriversV2.functions.TrimUpper(l.Suffix) );																							 
		self.DLCP_Key         				    := l.Key_Number;
		self.dl_key_number    				    := l.Key_Number;
		self.dl_number        				    := l.License_Number;
		self.title 											  := l.clean_name_prefix;
		self.fname 											  := l.clean_fname;		                             
		self.mname 											  := l.clean_mname;		                             
		self.lname 											  := l.clean_lname;		                             
		self.name_suffix 									:= l.clean_name_suffix;		                             
		self.cleaning_score 							:= l.clean_name_score;
		self.hair_color       				    := l.hair_color;
		self.eye_color        				    := l.eye_color;
		self.weight           				    := l.Weight_l;
		self.height           				    := l.Height_Feet + l.Height_Inches;																								 
		self.addr1										    := l.Street_Address;
		self.city 										    := l.City;
		self.state										    := l.State;
		self.zip 										    	:= l.Zip_Code;		
		self.dob 											    := (unsigned4)(l.Birth_Date);
		self.sex_flag									    := l.Sex_Gender;
		self.Attention_flag               := l.Donor_flag;
		Self.license_class   							:= trim(l.license_class,left,right); 
		self.OrigLicenseClass   					:= trim(l.license_class,left,right);
    self.moxie_license_type 			    := trim(l.license_class,left,right);//keeping the old mapping 
		self.restrictions     				    := l.Restriction_Codes;
		self.restrictions_delimited 	    := if(trim(l.Restriction_Codes,all)<>'', 
																						trim(l.Restriction_Codes[1..2],right) +
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[3..4]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[5..6]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[7..8]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[9..10]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[11..12]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[13..14]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[15..16]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[17..18]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[19..20]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[21..22]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[23..24]) + 
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[25..26]) +
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[27..28]) +
																						DriversV2.functions.f2CharCodeAndComma(l.Restriction_Codes[29..30]),
																						'');
		self.expiration_date		          := (unsigned4)(l.License_Expiration_Date);
		self.orig_expiration_date         := (unsigned4)(l.License_Expiration_Date);
		self.lic_issue_date 	            := (unsigned4)l.Permanent_License_Issue_Date;		
		self.orig_issue_date              := (unsigned4)l.Permanent_License_Issue_Date;	
		self.lic_endorsement              := l.Endorsement_Codes;	
		self.orig_County							    := l.County_Number ;
		self                    					:= l;
		self                          		:= [];
	end;
	
	oh_as_dl_mapper := project(in_file,intof(left));
	
	return oh_as_dl_mapper; 

end;