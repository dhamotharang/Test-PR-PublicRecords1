import std;

export MI_as_DL(dataset(DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned) pFile_MI_Input) := function
	
	DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned_Ext trfNormAddr(pFile_MI_Input l, integer c) := transform
		self.addr_type        := choose(c,'R','M');
		self.Street_Address   := choose(c, l.Street_Address, l.Mailing_Street_address);
		self.City             := choose(c, l.City, l.Mailing_City);
		self.State     				:= choose(c, l.State, l.Mailing_State);
		self.ZipCode       		:= choose(c, l.Zipcode, l.Mailing_Zipcode);
		self           				:= l;
	end;

	norm_file := normalize( pFile_MI_Input,
												  if(DriversV2.functions.TrimUpper(left.Street_Address)<>'' and DriversV2.functions.TrimUpper(left.Mailing_Street_address) <> '' and
												     DriversV2.functions.TrimUpper(left.Street_Address) <>  DriversV2.functions.TrimUpper(left.Mailing_Street_address)and 
														 trim(left.Street_Address + left.City + left.State,all) <> '',2,1)
												  ,trfNormAddr(left,counter)
											   );
												 
DriversV2.Layout_DL_Extended tMI_To_Common(DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned_Ext l):= transform
	  self.orig_state 							    := 'MI';
		self.source_code	                := 'AD';
		self.dt_first_seen    				    := (unsigned8)l.process_date div 100;
		self.dt_last_seen     				    := (unsigned8)l.process_date div 100;
		self.dt_vendor_first_reported     := (unsigned8)l.process_date div 100;
		self.dt_vendor_last_reported	    := (unsigned8)l.process_date div 100;
		self.dateReceived		  				    := (integer)l.process_date;
		self.name											    := std.str.cleanspaces(trim(l.First_Name)+' '+ trim(l.Middle_Name)+' '+trim(l.Last_Name)+' '+ trim(l.Name_Suffix) );
		self.RawFullName							    := std.str.cleanspaces(trim(l.First_Name)+' '+ trim(l.Middle_Name)+' '+trim(l.Last_Name)+' '+ trim(l.Name_Suffix) );																						 
		self.dl_number        				    := l.Customer_DLN_PID;
		self.title 											  := l.clean_name_prefix;
		self.fname 											  := l.clean_fname;		                             
		self.mname 											  := l.clean_mname;		                             
		self.lname 											  := l.clean_lname;		                             
		self.name_suffix 									:= l.clean_name_suffix;		                             
		self.cleaning_score 							:= l.clean_name_score;	
		self.OrigLicenseClass					    := l.DLN_PID_Indicator;
	  //If no DL number, assume it's an ID
	  self.license_type 						    := if(l.Customer_DLN_PID<>'','D','I');
	  self.moxie_license_type 			    := if(l.Customer_DLN_PID<>'','D','I');
		self.addr1										    := l.Street_Address;
		self.city 										    := l.City;
		self.state										    := l.State;
		self.zip 										    	:= l.ZipCode;		
		self.addr_type                    := l.addr_type;		
		self.dob 											    := (unsigned4)(l.Date_of_Birth);
		self.sex_flag									    := l.Gender;
		self.orig_County							    := l.County ;
		self                    					:= l;
		self                          		:= [];
	end;

MI_as_DL_mapper := project(norm_file, tMI_To_Common(left));

return MI_as_DL_mapper;

end;