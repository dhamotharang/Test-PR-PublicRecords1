#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib;

//Standard Layout	
	Layout_Aliases := record
		string Type{xpath('Type')};
		string Category{xpath('Category')};
		unicode First_Name{xpath('First_Name')};
		unicode Middle_Name{xpath('Middle_Name')};
		unicode Last_Name{xpath('Last_Name')};
		unicode Generation{xpath('Generation')};
		unicode Full_Name{xpath('Full_Name')};
		string Comments{xpath('Comments')};
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_Aliases;
		unicode name_alias;
		string e_i_ind;
		//string ID;
	end;

//Input Files
in_f				:= Worldcheck_bridger.File_WorldCheck_Native_Character;
in_file_2			:= distribute(in_f, random());
ds_with_new_fields 	:= in_file_2;

	// Shared parsing pieces for AKAs and alternate spellings
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		unicode CompleteName := TRIM(MATCHUNICODE(SingleName),left,right);
	end;

	Invalid_Names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];

//POPULATE AKAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing name AKAs//////////
	// Parse the AKA name values	
	MyParsedAKAds := PARSE(ds_with_new_fields(length(trim(Native_Character_Names,left,right))>1),(unicode)Native_Character_Names,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid AKA name values
	// Transform the AKA name values
	Layout_temp trfAkaName(MyParsedAKADS l) := transform
		self.name_alias		:= IF(length(l.CompleteName) < 1
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			:= 'AKA'; // Name type of two for the AKA records
		self.Category		:= '';
		self.First_Name		:= (unicode)'';
		self.Middle_Name	:= (unicode)'';
		self.Last_Name		:= (unicode)'';
		self.Generation		:= (unicode)'';
		self.Full_Name		:= (unicode)'';
		self.Comments		:= '';
		self.e_i_ind		:= '';
		self.ID				:= l.uid;
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
		
		language_filter		:= trim(l.string_alias[stringlib.stringfind(l.string_alias, '{', 1)+1..stringlib.stringfind(l.string_alias, '}', 1)-1], left, right);
		
		self.First_Name		:= if(regexfind(',', l.string_alias, 0)<>'' and regexfind('\\{', l.string_alias, 0)<>'',
									trim(l.name_alias[stringlib.stringfind(l.string_alias, ',', 1)+1..stringlib.stringfind(l.string_alias, '{', 1)-1], left, right),
									if(regexfind(',', l.string_alias, 0)<>'',
									trim(l.name_alias[stringlib.stringfind(l.string_alias, ',', 1)+1..length(l.string_alias)], left, right),
									(unicode)''));
		self.Last_Name 		:= if(regexfind(',', l.string_alias, 0)<>'',
									trim(l.name_alias[1..stringlib.stringfind(l.string_alias, ',', 1)-1], left, right),
									(unicode)'');
		self.Full_Name		:= if(regexfind(',', l.string_alias, 0)='' and regexfind('\\{', l.string_alias, 0)<>'',
									trim(l.name_alias[1..stringlib.stringfind(l.string_alias, '{', 1)-1], left, right),
									(unicode)'');
		self.Comments		:= if(language_filter<>'',
									'Language: {'+language_filter+'}',
									'');
		self 				:= l;
	end;
	
ds_reformAKAs := project(ds_NormAKANames, akaTran(left)) : persist('~thor_200::persist::worldcheck::native_character');

export Mapping_Native_Character := ds_reformAKAs;