import Address, lib_stringlib, ut, std, _Validate;
EXPORT Deletes_DL_MI (string processDate, string fileDate) := function

	//Per Vendor [Code='D'] are Deleted Records,Processing them separately!! 
  in_file    := DriversV2.File_DL_MI_Update(filedate)(DriversV2.functions.TrimUpper(code)='D');	
	layout_out := DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned;	
	
	layout_out    mapClean_deletes(in_file l)  	:= transform
		string73 tempName 				    		:= Address.CleanPerson73(DriversV2.functions.TrimUpper(DriversV2.functions.TrimUpper(l.First_Name)+' '+ DriversV2.functions.TrimUpper(l.Middle_Name)+' '+ 
																															 DriversV2.functions.TrimUpper(l.Last_Name) +' '+ DriversV2.functions.TrimUpper(l.Name_Suffix) )
																															 );
    self.clean_name_prefix        		:= tempName[1..5];
		self.clean_fname         			    := tempName[6..25];
		self.clean_mname        			    := tempName[26..45];
		self.clean_lname          			  := tempName[46..65];
		self.clean_name_suffix	      	  := tempName[66..70];
		self.clean_name_score         		:= tempName[71..73];
		self.process_Date									:= if(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		self.Code           			        := DriversV2.functions.TrimUpper(l.Code);	
		self.Customer_DLN_PID       			:= DriversV2.functions.TrimUpper(l.Customer_DLN_PID);
		self.Street_Address        			  := DriversV2.functions.TrimUpper(l.Street_Address);
   	self.City        			            := DriversV2.functions.TrimUpper(l.City);
   	self.State        								:= DriversV2.functions.TrimUpper(l.State);
    self.Zipcode        			 				:= lib_stringlib.stringlib.stringfilter(l.ZipCode[1..5],'0123456789');
   	self.Date_of_Birth        			 	:= DriversV2.functions.ValidateDate(l.Date_of_Birth);
		self.Gender       						    := DriversV2.functions.TrimUpper(l.Gender);	 	
   	self.County        			 					:= DriversV2.functions.TrimUpper(l.County);
   	self.DLN_PID_Indicator        	  := DriversV2.functions.TrimUpper(l.DLN_PID_Indicator);
   	self.Mailing_Street_address       := DriversV2.functions.TrimUpper(l.Mailing_Street_address);
   	self.Mailing_City        			 		:= DriversV2.functions.TrimUpper(l.Mailing_City);
   	self.Mailing_State        			 	:= DriversV2.functions.TrimUpper(l.Mailing_State);
   	self.Mailing_Zipcode        			:= lib_stringlib.stringlib.stringfilter(l.Mailing_Zipcode[1..5],'0123456789');
		self                        			:= l;	
	end;
	
	Cleaned_MI_Deletes := project(in_file,  mapClean_deletes(left));
	
	DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned_Ext trfNormAddr(layout_out l, integer c) := transform
		self.Street_Address   := choose(c, l.Street_Address, l.Mailing_Street_address);
		self.City             := choose(c, l.City, l.Mailing_City);
		self.State     				:= choose(c, l.State, l.Mailing_State);
		self.ZipCode       		:= choose(c, l.Zipcode, l.Mailing_Zipcode);
		self.addr_type        := choose(c,'R','M');
		self           				:= l;
	end;

	norm_file := normalize( Cleaned_MI_Deletes, 
												  if(DriversV2.functions.TrimUpper(left.Street_Address)<>'' and DriversV2.functions.TrimUpper(left.Mailing_Street_address) <> '' and
												     DriversV2.functions.TrimUpper(left.Street_Address) <>  DriversV2.functions.TrimUpper(left.Mailing_Street_address)and 
														 trim(left.Street_Address + left.City + left.State,all) <> '',2,1)
												  ,trfNormAddr(left,counter)
											   );
												 
								 	
	// Transform to the "DL Deletes" Layout!
	DriversV2.Layout_DL_Deletes 	mapDeletes(DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned_Ext l) := transform
		self.orig_state        := 'MI';
		self.dl_number         := l.Customer_DLN_PID;
		self.fileDate          := fileDate;
		self.processDate       := l.process_Date;
		self.name              := std.str.cleanspaces(trim(l.clean_fname) +' '+ trim(l.clean_mname) +' '+ trim(l.clean_lname)+' '+ trim(l.clean_name_suffix));
		self.addr1             := l.Street_Address;
		self.city							 := l.City;
		self.state						 := l.State;
		self.zip							 := l.ZipCode;
		self.dob               := (UNSIGNED4)l.Date_of_Birth;
		self                   := l;		
	end;

	MI_Deletes := project(norm_file, mapDeletes(left));
				
	return MI_Deletes;
end;		