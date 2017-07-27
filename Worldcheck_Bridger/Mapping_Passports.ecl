#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import worldcheck_bridger;

export Mapping_passports(dataset(Layout_WorldCheck_Premium) in_f):= function

//Standard Layout
	
	Layout_SP := record
		string	IdentificationType{xpath('Type')};
		string	Label{xpath('Label')};
		string	IDNumber{xpath('Number')};
		string	Issued_By{xpath('Issued_by')};
		string	Date_Issued{xpath('Date_Issued')};
		string	Date_Expires{xpath('Date_Expired')};
		string	IdentificationComments{xpath('Comments')};
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_SP;
		string ssn_info;
		string passport_info;
		//string ID;
	end;
	
	//Input Files
	//in_f 				:= File_WorldCheck_In;
	in_file_2			:= distribute(in_f, random());
	ds_with_new_fields 	:= in_file_2;

	// Shared parsing pieces for SSNs
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
	end;

	Invalid_Names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];

////////// Begin parsing and normalizing Passports/////////
	// Parse the Passport values	
	MyParsedPassport := PARSE(ds_with_new_fields(trim(Passports,left,right) != ''),Passports,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid Passport values
	// Transform the Passport values
	Layout_temp trfPassportName(MyParsedPassport l) := transform
		self.Passport_info			:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
											,SKIP
											,TRIM(l.CompleteName,left,right));
		self.ID						:= l.uid;
		self.IdentificationType 	:= 'Passport'; // Name type of two for the AKA records
		self.Label					:= '';
		self.IDNumber				:= '';
		self.Issued_By				:= '';
		self.Date_Issued			:= '';
		self.Date_Expires			:= '';
		self.IdentificationComments	:= '';
		self.ssn_info				:= '';
	end;

	// Reformat Passport values
	ds_NormPassportNames := project(MyParsedPassport, trfPassportName(left));
							
	Layout_temp PassportTran(ds_NormPassportNames l):= transform
		self.IDNumber		:= if(regexfind('\\(', l.Passport_info, 0)<>'',
									l.Passport_info[1..stringlib.stringfind(l.Passport_info, '(', 1)-1],
									l.Passport_info);
		self.Issued_By 		:= if(stringlib.stringfind(l.Passport_info, '(', 2)<>0 and stringlib.stringfind(l.Passport_info, ')', 2)<>0,
									l.Passport_info[stringlib.stringfind(l.Passport_info, '(', 2)+1..stringlib.stringfind(l.Passport_info, ')', 2)-1],
								if(stringlib.stringfind(l.Passport_info, '(', 1)<>0 and stringlib.stringfind(l.Passport_info, ')', 1)<>0 and stringlib.stringfind(l.Passport_info, '(', 2)=0,
									l.Passport_info[stringlib.stringfind(l.Passport_info, '(', 1)+1..stringlib.stringfind(l.Passport_info, ')', 1)-1],
									''));
		self := l;
	end;
	
ds_reformPassport := project(ds_NormPassportNames, PassportTran(left)) : persist('~thor_200::persist::worldcheck::passports');

return ds_reformPassport;

end;