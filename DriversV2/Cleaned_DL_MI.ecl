import  Address, ut, std, lib_stringlib,_Validate;

export Cleaned_DL_MI(string processDate, string filedate) := function
	
  TrimUpper(STRING s):= FUNCTION
	 	 RETURN std.str.touppercase(std.str.cleanspaces(s));
  END;
	in_file    := DriversV2.File_DL_MI_Update(filedate)(TrimUpper(Code)<>'D');	//Per Vendor Code='D' are Deleted Records,Filtering out!! 
	layout_out := DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned;	
	
	layout_out    mapClean(in_file l)  	:= transform
		string73 tempName 				    		:= Address.CleanPerson73(TrimUpper(TrimUpper(l.First_Name)+' '+ TrimUpper(l.Middle_Name)+' '+ 
																																				 TrimUpper(l.Last_Name) +' '+ TrimUpper(l.Name_Suffix)
																																				 ));
    self.clean_name_prefix        		:= tempName[1..5];
		self.clean_fname         			    := tempName[6..25];
		self.clean_mname        			    := tempName[26..45];
		self.clean_lname          			  := tempName[46..65];
		self.clean_name_suffix	      	  := tempName[66..70];
		self.clean_name_score         		:= tempName[71..73];
		self.process_Date									:= if(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		self.Code           			        := TrimUpper(l.Code);	
		self.Customer_DLN_PID       			:= TrimUpper(l.Customer_DLN_PID);
		self.Street_Address        			  := TrimUpper(l.Street_Address);
   	self.City        			            := TrimUpper(l.City);
   	self.State        								:= TrimUpper(l.State);
    self.Zipcode        			 				:= lib_stringlib.stringlib.stringfilter(l.ZipCode[1..5],'0123456789');
   	self.Date_of_Birth        			 	:= DriversV2.functions.ValidateDate(l.Date_of_Birth);
		self.Gender       						    := TrimUpper(l.Gender);	 	
   	self.County        			 					:= TrimUpper(l.County);
   	self.DLN_PID_Indicator        	  := TrimUpper(l.DLN_PID_Indicator);
   	self.Mailing_Street_address       := TrimUpper(l.Mailing_Street_address);
   	self.Mailing_City        			 		:= TrimUpper(l.Mailing_City);
   	self.Mailing_State        			 	:= TrimUpper(l.Mailing_State);
   	self.Mailing_Zipcode        			:= lib_stringlib.stringlib.stringfilter(l.Mailing_Zipcode[1..5],'0123456789');
		self                        			:= l;	
	end;
	
	Cleaned_MI_File := project(in_file,  mapClean(left));
	return Cleaned_MI_File;
	
end;
