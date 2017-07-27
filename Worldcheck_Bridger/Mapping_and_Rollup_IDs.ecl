#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib, WorldCheck_Bridger;

export Mapping_and_Rollup_IDs(dataset(Layout_WorldCheck_Premium) in_f):= function

//Standard Layout
	
	Layout_SP := record
		string	Type{xpath('Type')};
		string	Label{xpath('Label')};
		string	Number{xpath('Number')};
		string	Issued_By{xpath('Issued_By')};
		string	Date_Issued{xpath('Date_Issued')};
		string	Date_Expires{xpath('Date_Expired')};
		string	Comments{xpath('Comments')};
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_SP;
		string ssn_info;
		string passport_info;
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

//POPULATE SSNs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing name AKAs//////////
	// Parse the SSN values	
	MyParsedSSN := PARSE(ds_with_new_fields(trim(Social_Security_Number,left,right) != ''),Social_Security_Number,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid SSN values
	// Transform the SSN values
	Layout_temp trfSSNName(MyParsedSSN l) := transform
		self.ssn_info				:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
											,SKIP
											,TRIM(l.CompleteName,left,right));
		self.ID						:= l.uid;
		self.Type 					:= 'SSN'; // Name type of two for the AKA records
		self.Label					:= '';
		self.Number					:= '';
		self.Issued_By				:= '';
		self.Date_Issued			:= '';
		self.Date_Expires			:= '';
		self.Comments				:= '';
		self.passport_info			:= '';
	end;

	// Reformat SSN values
	ds_NormSSNNames := project(MyParsedSSN, trfSSNName(left));
							
	Layout_temp ssnTran(ds_NormSSNNames l):= transform
		self.Number			:= if(regexfind('\\(', l.ssn_info, 0)<>'',
									l.ssn_info[1..stringlib.stringfind(l.ssn_info, '(', 1)-1],
									l.ssn_info);
		self.Issued_By 		:= if(stringlib.stringfind(l.ssn_info, '(', 2)<>0 and stringlib.stringfind(l.ssn_info, ')', 2)<>0,
									l.ssn_info[stringlib.stringfind(l.ssn_info, '(', 2)+1..stringlib.stringfind(l.ssn_info, ')', 2)-1],
								if(stringlib.stringfind(l.ssn_info, '(', 1)<>0 and stringlib.stringfind(l.ssn_info, ')', 1)<>0 and stringlib.stringfind(l.ssn_info, '(', 2)=0,
									l.ssn_info[stringlib.stringfind(l.ssn_info, '(', 1)+1..stringlib.stringfind(l.ssn_info, ')', 1)-1],
									''));
		self 				:= l;
	end;
	
ds_reformSSN 		:= project(ds_NormSSNNames, ssnTran(left));

//POPULATE PASSPORTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

ds_reformPassport 	:= Mapping_Passports(in_f);

//POPULATE PROPRIETARY UIDs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	Layout_temp trfPUIDs(ds_with_new_fields l) := transform
		self.ID						:= l.uid;
		self.Type 					:= 'ProprietaryUID'; // Name type of two for the AKA records
		self.Label					:= '';
		self.Number					:= l.uid;
		self.Issued_By				:= '';
		self.Date_Issued			:= '';
		self.Date_Expires			:= '';
		self.Comments				:= '';
		self.ssn_info			:= '';
		self.passport_info			:= '';
		self						:= l;
	end;

	// Reformat SSN values
	ds_PUIDs := project(ds_with_new_fields, trfPUIDs(left));
							
	Layout_temp puidsTran(ds_PUIDs l):= transform
		self 				:= l;
	end;
	
ds_reformPUIDs		:= project(ds_PUIDs, puidsTran(left));

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Concat SSNs and Passports
concatID := ds_reformSSN + ds_reformPassport + ds_reformPUIDs : persist('~thor_200::persist::worldcheck::all_ids');

	// Rollup SSNs and Passports
	ID_rollup := record
		string ID;
		dataset(Layout_SP) Identification{xpath('Identification')};
		//string ID;
	end;

	ID_rollup t_SP(concatID L) := transform
		self.Identification 	:= row(L, Layout_SP);
		self := L;
	end;

	p_ID := project(concatID, t_SP(left));

	ID_rollup   t_SP_child(p_ID L, p_ID R) := transform
		self.Identification   	:= L.Identification + row({r.Identification[1].Type,
													r.Identification[1].Label,
													r.Identification[1].Number,
													r.Identification[1].Issued_By,
													r.Identification[1].Date_Issued,
													r.Identification[1].Date_Expires,
													r.Identification[1].Comments}
												   ,Layout_SP);
		self              		:= L;
	end;

ID_out := rollup(sort(p_ID,record)
						, t_SP_child(left,right)
						, ID): persist('~thor_200::persist::worldcheck::ids');
						
return id_out;

end;