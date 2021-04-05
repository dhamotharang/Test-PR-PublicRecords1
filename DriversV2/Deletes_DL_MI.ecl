import lib_stringlib, ut, std, _Validate;
EXPORT Deletes_DL_MI (string processDate, string fileDate) := function

  TrimUpper(STRING s):= FUNCTION
	 	 RETURN std.str.touppercase(std.str.cleanspaces(s));
  END;
	
  in_file    := DriversV2.File_DL_MI_Update(filedate)(TrimUpper(code)='D');	//Per Vendor Code='D' are Deleted Records,Processing them separately!! 
	
	DriversV2.Layouts_DL_MI_In.Layout_MI_TempDel  mapClean(in_file  l) := transform
	 	self.process_Date									:= if(_Validate.Date.fIsValid(processDate),processDate,ut.now());	
		self.Code           			        := TrimUpper(l.Code);	
		self.Customer_DLN_PID       			:= TrimUpper(l.Customer_DLN_PID);
  	self.Last_Name                    := TrimUpper(l.Last_Name);
   	self.First_Name                   := TrimUpper(l.First_Name);
   	self.Middle_Name                  := TrimUpper(l.Middle_Name);
    self.Name_Suffix                  := TrimUpper(l.Name_Suffix);
		self.Street_Address        			  := TrimUpper(l.Street_Address);
   	self.City        			            := TrimUpper(l.City);
   	self.State        								:= TrimUpper(l.State);
    self.Zipcode        			 				:= lib_stringlib.stringlib.stringfilter(l.ZipCode[1..5],'0123456789');
   	self.Date_of_Birth        			 	:= DriversV2.functions.ValidateDate(l.Date_of_Birth);
		self.Gender       						    := DriversV2.functions.TrimUpper(l.Gender);	 	
   	self.County        			 					:= TrimUpper(l.County);
   	self.DLN_PID_Indicator        	  := TrimUpper(l.DLN_PID_Indicator);
   	self.Mailing_Street_address       := TrimUpper(l.Mailing_Street_address);
   	self.Mailing_City        			 		:= TrimUpper(l.Mailing_City);
   	self.Mailing_State        			 	:= TrimUpper(l.Mailing_State);
   	self.Mailing_Zipcode        			:= lib_stringlib.stringlib.stringfilter(l.Mailing_Zipcode[1..5],'0123456789');
		self                        			:= l;	
	end;
  Cleaned_MI_File := project(in_file, mapClean(left));
	
	DriversV2.Layouts_DL_MI_In.Layout_MI_TempDel trfNormAddr(Cleaned_MI_File l, integer c) := transform
		self.Street_Address   := choose(c, l.Street_Address, l.Mailing_Street_address);
		self.City             := choose(c, l.City, l.Mailing_City);
		self.State     				:= choose(c, l.State, l.Mailing_State);
		self.ZipCode       		:= choose(c, l.Zipcode, l.Mailing_Zipcode);
		self           				:= l;
	end;

	norm_file := normalize( Cleaned_MI_File, 
												  if(TrimUpper(left.Street_Address)<>'' and TrimUpper(left.Mailing_Street_address) <> '' and
												     TrimUpper(left.Street_Address) <>  TrimUpper(left.Mailing_Street_address)and 
														 trim(left.Street_Address + left.City + left.State,all) <> '',2,1)
												  ,trfNormAddr(left,counter)
											   );
												 
								 	
	// Transform to the DL Deletes Layout
	DriversV2.Layout_DL_Deletes 	mapDeletes(DriversV2.Layouts_DL_MI_In.Layout_MI_TempDel l) := transform
		self.orig_state        := 'MI';
		self.dl_number         := TrimUpper(l.Customer_DLN_PID);
		self.fileDate          := fileDate;
		self.processDate       := l.process_Date;
		self.name              := TrimUpper(TrimUpper(l.First_Name)+' '+ TrimUpper(l.Middle_Name)+' '+ 
																			  TrimUpper(l.Last_Name) +' '+ TrimUpper(l.Name_Suffix));
		self.addr1             := TrimUpper(l.Street_Address);
		self.city							 := TrimUpper(l.City);
		self.state						 := TrimUpper(l.State);
		self.zip							 := l.ZipCode;
		self.dob               := (UNSIGNED4)l.Date_of_Birth;
		self                   := l;		
	end;

	MI_File := project(norm_file, mapDeletes(left));
				
	return MI_File;
end;		