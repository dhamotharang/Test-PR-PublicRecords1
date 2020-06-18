import  Address, _Validate, ut, STD, Corp2_Mapping;

export Cleaned_DL_OH(string processDate, string fileDate) := function

	in_file    := DriversV2.File_DL_OH_Update(fileDate);
	layout_out := DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned;	

	layout_out mapClean(in_file l)  	    := transform
		string73 tempName 				    			:= Address.CleanPerson73(DriversV2.functions.TrimUpper(DriversV2.functions.TrimUpper(l.First_Name)+' '+ DriversV2.functions.TrimUpper(l.Middle_Name)+' '+ 
																																								               DriversV2.functions.TrimUpper(l.Last_Name) +' '+ DriversV2.functions.TrimUpper(l.Suffix)
																																					                     ));
    self.clean_name_prefix        			:= tempName[1..5];
		self.clean_fname         			      := tempName[6..25];
		self.clean_mname        			      := tempName[26..45];
		self.clean_lname          			    := tempName[46..65];
		self.clean_name_suffix	      			:= tempName[66..70];
		self.clean_name_score         			:= tempName[71..73];
		self.process_Date										:= if(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		self.Key_Number       							:= trim(l.Key_Number,left,right);
		self.License_Number       					:= DriversV2.functions.TrimUpper(l.License_Number);
		self.License_Class      						:= DriversV2.functions.TrimUpper(l.License_Class);
		self.Donor_Flag       							:= DriversV2.functions.TrimUpper(l.Donor_Flag);
		self.Hair_Color       							:= DriversV2.functions.TrimUpper(l.Hair_Color);
		self.Eye_Color      								:= DriversV2.functions.TrimUpper(l.Eye_Color);
		self.Weight_L       								:= trim(l.Weight_L,left,right);
		self.Height_Feet       							:= trim(l.Height_Feet,left,right);
		self.Height_Inches       						:= if(length(trim(l.Height_Inches,left,right))=1, '0'+trim(l.Height_Inches,left,right), trim(l.Height_Inches,left,right));
		self.Sex_Gender       							:= DriversV2.functions.TrimUpper(l.Sex_Gender);
		self.Permanent_License_Issue_Date   := DriversV2.functions.ValidateDate(l.Permanent_License_Issue_Date);
		self.Is_Medical_Two_Part_License    := DriversV2.functions.TrimUpper(l.Is_Medical_Two_Part_License);
		self.License_Expiration_Date      	:= DriversV2.functions.ValidateDate(l.License_Expiration_Date);
		self.Deputy_Registrar_Agency        := trim(l.Deputy_Registrar_Agency,left,right);
		self.CDLIS_Flag      							  := DriversV2.functions.TrimUpper(l.CDLIS_Flag);
		self.Is_on_PDPS       						  := DriversV2.functions.TrimUpper(l.Is_on_PDPS);
		self.License_App_Ctrl       				:= DriversV2.functions.TrimUpper(l.License_App_Ctrl);
		self.Is_Temporary      						  := DriversV2.functions.TrimUpper(l.Is_Temporary);
		self.License_App_Transaction_Type   := DriversV2.functions.TrimUpper(l.License_App_Transaction_Type);
		self.Motorcycle_Novice_Date       	:= DriversV2.functions.ValidateDate(l.Motorcycle_Novice_Date);
		self.Restriction_Codes       				:= DriversV2.functions.TrimUpper(l.Restriction_Codes);
		self.Endorsement_Codes       				:= DriversV2.functions.TrimUpper(l.Endorsement_Codes);
		self.Is_Ohio_Resident       				:= DriversV2.functions.TrimUpper(l.Is_Ohio_Resident);
		self.Has_Warrant_Blocks      			  := DriversV2.functions.TrimUpper(l.Has_Warrant_Blocks);
		self.Is_Fraud      									:= DriversV2.functions.TrimUpper(l.Is_Fraud);
		self.TSA_Threat_Assessment_Code     := trim(l.TSA_Threat_Assessment_Code,left,right);
		self.TSA_Notification_Date          := DriversV2.functions.ValidateDate(l.TSA_Notification_Date);
		self.TSA_Expiration_Date            := DriversV2.functions.ValidateDate(l.TSA_Expiration_Date);
		self.Med_Certificate_Self_Cert_Code := trim(l.Med_Certificate_Self_Cert_Code,left,right);
		self.Med_Certificate_Expiration_Date:= DriversV2.functions.ValidateDate(l.Med_Certificate_Expiration_Date);
		self.First_Name       							:= DriversV2.functions.TrimUpper(l.First_Name);
		self.Middle_Name      							:= DriversV2.functions.TrimUpper(l.Middle_Name);
		self.Last_Name       							  := DriversV2.functions.TrimUpper(l.Last_Name);
		self.Suffix       								  := DriversV2.functions.TrimUpper(l.Suffix);
		self.Street_Address       				  := DriversV2.functions.fn_RemoveSpecialChars(l.Street_Address);
		self.City       										:= DriversV2.functions.fn_RemoveSpecialChars(l.City);
		self.State       										:= if(DriversV2.functions.TrimUpper(l.State) in ['XX','X'],'',DriversV2.functions.TrimUpper(l.State));
		self.Zip_Code      								  := if((INTEGER)stringlib.stringfilter(l.Zip_Code,'0123456789')<>0,stringlib.stringfilter(l.Zip_Code,'0123456789'),''); 
		self.County_Number       						:= trim(l.County_Number,left,right);
		self.Birth_Date                 		:= DriversV2.functions.ValidateDate(l.Birth_Date);
		self               								  := l ;  
		self               								  := [] ;
	end;

	Cleaned_OH_File := project(in_file, mapClean(left));	
	return Cleaned_OH_File;
	
end;     