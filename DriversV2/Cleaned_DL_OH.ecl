import  Address, _Validate, ut, STD, Corp2_Mapping;

export Cleaned_DL_OH(string processDate, string fileDate) := function

	in_file    := DriversV2.File_DL_OH_Update(fileDate);
	layout_out := DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned;	
	
	//Cleaning '*' ,'{' from StreetAddrs & city  Ex:"268 LORA *" or "LAKEWOOD{" -- will return "268 LORA" ,"LAKEWOOD"
	fn_RemoveSpecialChars(string s, string replacement='') := function				
		stripInvalids := regexreplace('\\x2A|\\x7B|',s,replacement);		
		return stripInvalids;
	end;
	
	TrimUpper(STRING s):= FUNCTION
	 RETURN std.str.touppercase(std.str.cleanspaces(s));
  END;
	
	ValidateDate(STRING d)		 := function
		return Corp2_Mapping.fValidateDate(trim(d,left,right),'MMDDCCYY').GeneralDate;
	end;	
	
	layout_out mapClean(in_file l)  	    := transform
		string73 tempName 				    			:= Address.CleanPerson73(TrimUpper(TrimUpper(l.First_Name)+' '+ TrimUpper(l.Middle_Name)+' '+ 
																												                   TrimUpper(l.Last_Name) +' '+ TrimUpper(l.Suffix)
																																					 )
																																 );
    self.clean_name_prefix        			:= tempName[1..5];
		self.clean_fname         			      := tempName[6..25];
		self.clean_mname        			      := tempName[26..45];
		self.clean_lname          			    := tempName[46..65];
		self.clean_name_suffix	      			:= tempName[66..70];
		self.clean_name_score         			:= tempName[71..73];
		self.process_Date										:= if(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		self.Key_Number       							:= trim(l.Key_Number,left,right);
		self.License_Number       					:= TrimUpper(l.License_Number);
		self.License_Class      						:= TrimUpper(l.License_Class);
		self.Donor_Flag       							:= TrimUpper(l.Donor_Flag);
		self.Hair_Color       							:= TrimUpper(l.Hair_Color);
		self.Eye_Color      								:= TrimUpper(l.Eye_Color);
		self.Weight_L       								:= trim(l.Weight_L,left,right);
		self.Height_Feet       							:= trim(l.Height_Feet,left,right);
		self.Height_Inches       						:= if(length(trim(l.Height_Inches,left,right))=1, '0'+trim(l.Height_Inches,left,right), trim(l.Height_Inches,left,right));
		self.Sex_Gender       							:= TrimUpper(l.Sex_Gender);
		self.Permanent_License_Issue_Date   := ValidateDate(l.Permanent_License_Issue_Date);
		self.Is_Medical_Two_Part_License    := TrimUpper(l.Is_Medical_Two_Part_License);
		self.License_Expiration_Date      	:= ValidateDate(l.License_Expiration_Date);
		self.Deputy_Registrar_Agency        := trim(l.Deputy_Registrar_Agency,left,right);
		self.CDLIS_Flag      							  := TrimUpper(l.CDLIS_Flag);
		self.Is_on_PDPS       						  := TrimUpper(l.Is_on_PDPS);
		self.License_App_Ctrl       				:= TrimUpper(l.License_App_Ctrl);
		self.Is_Temporary      						  := TrimUpper(l.Is_Temporary);
		self.License_App_Transaction_Type   := TrimUpper(l.License_App_Transaction_Type);
		self.Motorcycle_Novice_Date       	:= ValidateDate(l.Motorcycle_Novice_Date);
		self.Restriction_Codes       				:= TrimUpper(l.Restriction_Codes);
		self.Endorsement_Codes       				:= TrimUpper(l.Endorsement_Codes);
		self.Is_Ohio_Resident       				:= TrimUpper(l.Is_Ohio_Resident);
		self.Has_Warrant_Blocks      			  := TrimUpper(l.Has_Warrant_Blocks);
		self.Is_Fraud      									:= TrimUpper(l.Is_Fraud);
		self.TSA_Threat_Assessment_Code     := trim(l.TSA_Threat_Assessment_Code,left,right);
		self.TSA_Notification_Date          := ValidateDate(l.TSA_Notification_Date);
		self.TSA_Expiration_Date            := ValidateDate(l.TSA_Expiration_Date);
		self.Med_Certificate_Self_Cert_Code := trim(l.Med_Certificate_Self_Cert_Code,left,right);
		self.Med_Certificate_Expiration_Date:= ValidateDate(l.Med_Certificate_Expiration_Date);
		self.First_Name       							:= TrimUpper(l.First_Name);
		self.Middle_Name      							:= TrimUpper(l.Middle_Name);
		self.Last_Name       							  := TrimUpper(l.Last_Name);
		self.Suffix       								  := TrimUpper(l.Suffix);
		self.Street_Address       				  := fn_RemoveSpecialChars(TrimUpper(l.Street_Address));
		self.City       										:= fn_RemoveSpecialChars(TrimUpper(l.City));
		self.State       										:= if(TrimUpper(l.State) in ['XX','X'],'',TrimUpper(l.State));
		self.Zip_Code      								  := if((INTEGER)stringlib.stringfilter(l.Zip_Code,'0123456789')<>0,stringlib.stringfilter(l.Zip_Code,'0123456789'),''); 
		self.County_Number       						:= trim(l.County_Number,left,right);
		self.Birth_Date                 		:= ValidateDate(l.Birth_Date);
		self               								  := l ;  
		self               								  := [] ;
	end;

	Cleaned_OH_File := project(in_file, mapClean(left));	
	return Cleaned_OH_File;
	
end;     