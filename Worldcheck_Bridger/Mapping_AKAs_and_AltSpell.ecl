#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib;

export Mapping_AKAs_and_AltSpell(dataset(Layout_WorldCheck_Premium) in_f):= function

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
	//in_f 				:= File_WorldCheck_In;
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
	MyParsedAKAds := PARSE(ds_with_new_fields(trim(stringlib.stringtouppercase(Aliases),left,right) != ''),Aliases,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid AKA name values
	// Transform the AKA name values
	Layout_temp trfAkaName(MyParsedAKADS l) := transform
		self.name_alias		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,(unicode)TRIM(l.CompleteName,left,right));
		self.Type 			  := 'AKA'; // Name type of two for the AKA records
		self.Category		  := '';
		self.First_Name		:= (unicode)'';
		self.Middle_Name	:= (unicode)'';
		self.Last_Name		:= (unicode)'';
		self.Generation		:= (unicode)'';
		self.Full_Name		:= (unicode)'';
		self.Comments		  := '';
		self.ID				    := l.uid;
		self.e_i_ind		  := l.e_i_ind;
	end;

	// Reformat AKA name values
	ds_NormAKAName := project(MyParsedAKADS, trfAKAName(left));
	
	Layout_temp2 := record
		Layout_temp;
		string string_alias;
	end;
	
	Layout_temp2 trfAkaNames(ds_NormAKAName l) := transform
		self.string_alias := if(regexfind('DBA |NKA |FKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									(string)l.name_alias[5..],
									(string)l.name_alias);
		
//Bug #86882 -From World Checks Aliases field, filter out the terms fka, nka, and dba from the AKA name and set 
//the AKAs Type tag to the respective value. For dba add the alias text to the AKAs Comments tag
		self.Type 			:= map(regexfind('FKA ',stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4]) => 'FKA',
														 regexfind('NKA ',stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4]) => 'NKA',
														 regexfind('DBA ',stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4]) => 'AKA', l.type);
		self.comments		:= if(regexfind('DBA ',stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4]),(string)l.name_alias, l.comments);
		self := l;
	end;
	
	ds_NormAKANames := project(ds_NormAKAName, trfAkaNames(left));
							
	Layout_temp akaTran(ds_NormAKANames l):= transform
		string name_alias 	:= if(regexfind('DBA |NKA |FKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									(string)l.name_alias[5..],
									(string)l.name_alias);
		
		self.First_Name		:= if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)<>'',
									trim(name_alias[stringlib.stringfind(l.string_alias, ',', 1)+1..length(l.string_alias)], left, right),
									(unicode)'');
		self.Last_Name 		:= if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)<>'',
									(unicode)trim(name_alias[1..stringlib.stringfind(l.string_alias, ',', 1)-1], left, right),
									if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)='',
									(unicode)name_alias,
									(unicode)''));
		self.Full_Name		:= if(l.e_i_ind <> 'E',
									(unicode)'',
									(unicode)name_alias);
		self := l;
	end;
	
ds_reformAKAs := project(ds_NormAKANames, akaTran(left)): persist('~thor_200::persist::worldcheck::normalize_akas');

//POPULATE ALTERNATIVE SPELLINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing Alternative Spellings//////////
	// Parse the Alternative Spelling values	
	MyParsedASpellds := PARSE(ds_with_new_fields(trim(Alternate_Spelling,left,right) != ''),Alternate_Spelling,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid Alternative Spelling values
	// Transform the Alternative Spelling values
	Layout_temp trfASpell(MyParsedASpellds l) := transform
		self.name_alias		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,(unicode)TRIM(l.CompleteName,left,right));
		self.Type 			:= 'AKA'; // Name type of two for the AKA records
		self.Category		:= '';
		self.First_Name		:= (unicode)'';
		self.Middle_Name	:= (unicode)'';
		self.Last_Name		:= (unicode)'';
		self.Generation		:= (unicode)'';
		self.Full_Name		:= (unicode)'';
		self.Comments		:= '';
		self.ID				:= l.uid;
		self.e_i_ind		:= l.e_i_ind;
	end;

	// Normalize the Alternative Spelling values
	ds_NormASpell := NORMALIZE(MyParsedASpellds
                            ,1
							,trfASpell(left));
	
	Layout_temp2 trfAkaNames2(ds_NormASpell l) := transform
		self.string_alias := if(regexfind('DBA |NKA |FKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									(string)l.name_alias[5..],
									(string)l.name_alias);
		self := l;
	end;
	
	ds_NormASpells := project(ds_NormASpell, trfAkaNames2(left));
							
	Layout_temp aSpellTran(ds_NormASpells l):= transform
		
		string name_alias 	:= if(regexfind('DBA |NKA |FKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									(string)l.name_alias[5..],
									(string)l.name_alias);
		
		self.Type			:= if(regexfind('NKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									'NKA',
								if(regexfind('FKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									'FKA',
									l.type));
		
		self.First_Name		:= if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)<>'',
									trim(name_alias[stringlib.stringfind(l.string_alias, ',', 1)+1..length(l.string_alias)], left, right),
									(unicode)'');
									
		self.Last_Name 		:= if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)<>'',
									(unicode)trim(name_alias[1..stringlib.stringfind(l.string_alias, ',', 1)-1], left, right),
									if(l.e_i_ind <> 'E' and regexfind(',', l.string_alias, 0)='',
									l.name_alias,
									(unicode)''));
									
		self.Full_Name		:= if(l.e_i_ind <> 'E',
									(unicode)'',
									name_alias);
		self := l;
	end;
	
ds_reformASpell := project(ds_NormASpells, aSpellTran(left)): persist('~thor_200::persist::worldcheck::normalize_akas_altspell');

//////////////////////////////////////////////////////////////////////////////////////////////////////

//Concat AKAs and Alternative Spellings
concatAKA := ds_reformAKAs + ds_reformASpell;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Bugzilla #138281////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Count number of aliases by id///////////////////////////////////////////////////////////////////////////////
	rec := record
	 concatAKA.id;
	 count_ := count(group);
	end;

	out_count  := table(concatAKA,
								rec,
								concatAKA.id):persist('~thor_200::persist::worldcheck::normalize_akas_altspell_count');

//Append alias counts to aka persist file/////////////////////////////////////////////////////////////////////
aka_count := out_count((integer)count_>254);

	count_layout := RECORD
		concatAKA;
		integer count_;
	end;

	count_layout join_aka(concatAKA l, aka_count r):= transform
	  self.count_ := (integer)r.count_;
		self := l;
	end;

	counts_added 		:= join(concatAKA
															,aka_count
															,left.id = right.id
															,join_AKA(left,right)
															,full outer);

//Filter by aka counts////////////////////////////////////////////////////////////////////////////////////////
	ds_max_akas		:= counts_added((integer)count_ > 254);

	counts_added removePunct(ds_max_akas l):= transform
		self.first_name 	:= if(l.e_i_ind not in [''],
														regexreplace(u'!|@|#|$|%|-|\'|~', l.first_name,''),
														l.first_name);
		self.middle_name 	:= if(l.e_i_ind not in [''],
														regexreplace(u'!|@|#|$|%|-|\'|~', l.middle_name,''),
														l.middle_name);
		self.last_name 		:= if(l.e_i_ind not in [''],
														regexreplace(u'!|@|#|$|%|-|\'|~', l.last_name,''),
														l.last_name);
		self.full_name 		:= if(l.e_i_ind not in [''],
														regexreplace(u'!|@|#|$|%|-|\'|~', l.full_name,''),
														l.full_name);
		self.name_alias 	:= if(l.e_i_ind not in [''],
														regexreplace(u'!|@|#|$|%|-|\'|~', l.name_alias,''),
														l.name_alias);
		self							:= l;
	end;


	ds_max_akas_fixed1 := dedup(sort(project(ds_max_akas, removePunct(left)), record), record);

	Layout_temp3 := record	
		count_layout;
		unicode orig_First_Name;
		unicode orig_Middle_Name;
		unicode orig_Last_Name;
		unicode orig_Full_Name;
		unicode orig_name_alias;
	end;
	
	Layout_temp3 removeAbbrv(ds_max_akas_fixed1 l):= transform
		self.orig_First_Name		:= l.First_Name;
		self.orig_Middle_Name		:= l.Middle_Name;	
		self.orig_Last_Name			:= l.Last_Name;
		self.orig_Full_Name			:= l.Full_Name;
		self.orig_name_alias		:= l.name_alias;
		self.First_Name 				:= trim(regexreplace(u'^(DR.)', l.first_name, '', NOCASE), left, right);
		self.Middle_Name 				:= trim(regexreplace(u'^(DR.)', l.middle_name, '', NOCASE), left, right);
		self.Last_Name 					:= trim(regexreplace(u'^(DR.)', l.last_name, '', NOCASE), left, right);		
		self.Full_Name 					:= trim(regexreplace(u'^(DR.)', l.full_name, '', NOCASE), left, right);
		self.name_alias	 				:= trim(regexreplace(u'^(DR.)', l.name_alias, '', NOCASE), left, right);
		self										:= l;
	end;
	
 	ds_max_akas_fixed2 := dedup(sort(project(ds_max_akas_fixed1, removeAbbrv(left)), record), record, EXCEPT orig_First_Name, orig_Middle_Name, orig_Last_Name, orig_Full_Name, orig_name_alias);
	
	counts_added trOriginalNames(ds_max_akas_fixed2 l) := TRANSFORM
			self.First_Name  	:= l.orig_First_Name;	
			self.Middle_Name 	:= l.orig_Middle_Name;		
			self.Last_Name 	 	:= l.orig_Last_Name;	
			self.Full_Name 	 	:= l.orig_Full_Name;
			self.name_alias	 	:= l.orig_name_alias;
   		self 							:= l;
 	END;
	
	ds_max_akas_fixed := project(ds_max_akas_fixed2, trOriginalNames(left));
	
	ds_ok_akas				:= counts_added((integer)count_ <= 254);

	all_akas1	:= ds_max_akas_fixed + ds_ok_akas;
	
	all_akas1 RemovingSpaceafterSlash(all_akas1 l) := transform
   		self.name_alias := regexreplace(u'/ ', l.full_name , u'/');
			self.full_name 	:= regexreplace(u'/ ', l.name_alias , u'/');
   		self := l;
   	end;
   	
  akas_for_id_60101 := dedup(sort(project(all_akas1(id = '60101'), RemovingSpaceafterSlash(left)), record), record);
	
	all_akas := akas_for_id_60101 + all_akas1(id <> '60101');	
	
//Reformat to old layout////////////////////////////////////////////////////////////////////////////////////
	concatAKA oldReform(all_akas l):=transform
		self := l;
	end;

fixed_akas := project(all_akas, oldReform(left)):persist('~thor_200::persist::worldcheck::normalize_akas_altspell_fixed');

return fixed_akas;

end;