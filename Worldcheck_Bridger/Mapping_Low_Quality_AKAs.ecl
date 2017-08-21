#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib;

export Mapping_Low_Quality_AKAs(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Standard Layout	
	Layout_Aliases := record
		string Type{xpath('Type')};
		string Category{xpath('Category')};
		unicode First_Name{xpath('First_Name')};
		unicode Middle_Name{xpath('Middle_Name')};
		unicode Last_Name{xpath('Last_Name')};
		unicode Generation{xpath('Generation')};
		unicode Full_Name{xpath('Full_Name')};
		unicode Comments{xpath('Comments')};
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_Aliases;
		unicode name_alias;
		string e_i_ind;
		//string ID;
	end;

	//Input Files
	//in_f 				:= File_WorldCheck_Premium_In;
	in_file_2			:= distribute(in_f, random());
	ds_with_new_fields 	:= in_file_2;

	// Shared parsing pieces for AKAs and alternate spellings
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
	end;

	Invalid_Names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];

//POPULATE AKAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing name AKAs//////////
	// Parse the AKA name values	
	MyParsedAKAds := PARSE(ds_with_new_fields(trim(Low_Quality_Aliases,left,right) != ''),Low_Quality_Aliases,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid AKA name values
	// Transform the AKA name values
	Layout_temp trfAkaName(MyParsedAKADS l) := transform
		self.name_alias		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,(unicode)TRIM(l.CompleteName,left,right));
		self.Type 			:= 'AKA'; // Name type of two for the AKA records
		self.Category		:= 'WEAK';
		self.First_Name		:= U'';
		self.Middle_Name	:= U'';
		self.Last_Name		:= U'';
		self.Generation		:= U'';
		self.Full_Name		:= U'';
		self.Comments		:= U'';
		self.ID				:= l.uid;
		self.e_i_ind		:= l.e_i_ind;
	end;

	// Reformat AKA name values
	ds_NormAKAName := project(MyParsedAKADS, trfAKAName(left));
	
	Layout_temp2 := record
		Layout_temp;
		string string_alias;
	end;
	
	Layout_temp2 trfAkaNames(ds_NormAKAName l) := transform
		self.string_alias := (string)l.name_alias;
		self := l;
	end;
	
	ds_NormAKANames := project(ds_NormAKAName, trfAkaNames(left));
							
	Layout_temp akaTran(ds_NormAKANames l):= transform
		self.First_Name		:= if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)<>'',
									(unicode)trim(l.name_alias[stringlib.stringfind(l.string_alias, ',', 1)+1..length(l.string_alias)], left, right),
									(unicode)'');
		self.Last_Name 		:= if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)<>'',
									(unicode)trim(l.name_alias[1..stringlib.stringfind(l.string_alias, ',', 1)-1], left, right),
									if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)='',
									(unicode)l.name_alias,
									(unicode)''));
		self.Full_Name		:= if(l.e_i_ind <> 'E',
									(unicode)'',
									(unicode)l.name_alias);
		self := l;
	end;
	
ds_reformAKAs := project(ds_NormAKANames, akaTran(left)) : persist('~thor_200::persist::worldcheck::weak_akas');

return ds_reformAKAs;

end;