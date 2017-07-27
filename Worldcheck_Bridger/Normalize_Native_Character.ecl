#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib;

//Standard Layout	
	Layout_Aliases := record
		string Type;
		string Category;
		string First_Name;
		string Middle_Name;
		string Last_Name;
		string Generation;
		string Full_Name;
		string Comments;
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_Aliases;
		string255 name_alias;
		string e_i_ind;
		//string ID;
	end;

//Input Files
in_f				:= File_WorldCheck_Native_Character;
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
	MyParsedAKAds := PARSE(ds_with_new_fields(trim(Native_Character_Names,left,right) != ''),Native_Character_Names,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid AKA name values
	// Transform the AKA name values
	Layout_temp trfAkaName(MyParsedAKADS l) := transform
		self.name_alias		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			:= 'AKA'; // Name type of two for the AKA records
		self.Category		:= '';
		self.First_Name		:= '';
		self.Middle_Name	:= '';
		self.Last_Name		:= '';
		self.Generation		:= '';
		self.Full_Name		:= '';
		self.Comments		:= '';
		self.e_i_ind		:= '';
		self.ID				:= l.uid;
	end;

	// Normalize the AKA name values
	ds_NormAKANames := NORMALIZE(MyParsedAKADS
                            ,1
							,trfAKAName(left));
							
	Layout_temp akaTran(ds_NormAKANames l):= transform
		
		language_filter		:= trim(l.name_alias[stringlib.stringfind(l.name_alias, '{', 1)+1..stringlib.stringfind(l.name_alias, '}', 1)-1], left, right);
		
		self.First_Name		:= regexreplace('\\{\\}', regexreplace(language_filter, if(regexfind(',', l.name_alias, 0)<>'',
									trim(l.name_alias[stringlib.stringfind(l.name_alias, ',', 1)+1..length(l.name_alias)], left, right),
									''), ''), '');
		self.Last_Name 		:= regexreplace('\\{\\}', regexreplace(language_filter, if(regexfind(',', l.name_alias, 0)<>'',
									trim(l.name_alias[1..stringlib.stringfind(l.name_alias, ',', 1)-1], left, right),
									''), ''), '');
		self.Full_Name		:= regexreplace('\\{\\}', regexreplace(language_filter, if(regexfind(',', l.name_alias, 0)<>'',
									'',
									l.name_alias), ''), '');
		self.Comments		:= if(language_filter<>'',
									'Language: {'+language_filter+'}',
									'');
		self 				:= l;
	end;
	
ds_reformAKAs := project(ds_NormAKANames, akaTran(left)) : persist('~thor_200::persist::worldcheck::normalized_native_character');

export Normalize_Native_Character := ds_reformAKAs;