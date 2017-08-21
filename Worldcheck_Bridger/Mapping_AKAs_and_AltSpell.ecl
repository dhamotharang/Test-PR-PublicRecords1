#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib, std;

export Mapping_AKAs_and_AltSpell(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Standard Layout	
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_Aliases;
		unicode name_alias;
		string e_i_ind;
		//string ID;
	end;

//Input Files
	//in_f 				:= File_WorldCheck_In;
	in_file_2			:= distribute(in_f);
	ds_with_new_fields 	:= in_file_2;

	// Shared parsing pieces for AKAs and alternate spellings
	pattern SingleName := pattern(U'[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		unicode CompleteName := TRIM(MATCHUNICODE(SingleName),left,right);
	end;

	Invalid_Names := [U'',U',',U'NONE',U'N/A',U'NOT AVAILABLE',U'UNAVAILABLE',U'UNKNOWN',U'NONE REPORTED'];

//POPULATE AKAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing name AKAs//////////
	// Parse the AKA name values	
	MyParsedAKAds := PARSE(ds_with_new_fields(trim(Std.uni.touppercase(Aliases),left,right) != ''),Aliases,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid AKA name values
	// Transform the AKA name values
	Layout_temp trfAkaName(MyParsedAKADS l) := transform
		self.name_alias		:= IF(Std.Uni.ToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			  := 'AKA'; // Name type of two for the AKA records
		self.Category		  := '';
		self.First_Name		:= U'';
		self.Middle_Name	:= U'';
		self.Last_Name		:= U'';
		self.Generation		:= U'';
		self.Full_Name		:= U'';
		self.Comments		  := U'';
		self.ID				    := l.uid;
		self.e_i_ind		  := l.e_i_ind;
	end;

	// Reformat AKA name values
	ds_NormAKAName := project(MyParsedAKADS, trfAKAName(left));
	
	Layout_temp2 := record
		Layout_temp;
		unicode string_alias;
	end;
	
	Layout_temp2 trfAkaNames(ds_NormAKAName l) := transform
		self.string_alias := if(regexfind(U'DBA |NKA |FKA ', Std.Uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									l.name_alias[5..],
									l.name_alias);
		
//Bug #86882 -From World Checks Aliases field, filter out the terms fka, nka, and dba from the AKA name and set 
//the AKAs Type tag to the respective value. For dba add the alias text to the AKAs Comments tag
		self.Type 			:= map(regexfind(U'FKA ',std.Uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4]) => 'FKA',
														 regexfind(U'NKA ',std.Uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4]) => 'NKA',
														 regexfind(U'DBA ',std.Uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4]) => 'AKA', l.type);
		self.comments		:= if(regexfind(U'DBA ',std.Uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4]),(string)l.name_alias, l.comments);
		self := l;
	end;
	
	ds_NormAKANames := project(ds_NormAKAName, trfAkaNames(left));
							
	Layout_temp akaTran(ds_NormAKANames l):= transform
		unicode name_alias 	:= if(regexfind(U'^(DBA |NKA |FKA )', trim(l.name_alias, left, right), nocase),
									l.name_alias[5..],
									l.name_alias);
		
		self.First_Name		:= if(l.e_i_ind <> 'E' and regexfind(U',', l.string_alias, 0)<>'',
									trim(name_alias[Std.uni.find(l.string_alias, ',', 1)+1..length(l.string_alias)], left, right),
									U'');
		self.Last_Name 		:= if(l.e_i_ind <> 'E' and regexfind(U',', l.string_alias, 0)<>'',
									trim(name_alias[1..Std.uni.find(l.string_alias, ',', 1)-1], left, right),
									if(l.e_i_ind <> 'E' and regexfind(U',', l.string_alias, 0)='',
									name_alias,
									U''));
		self.Full_Name		:= if(l.e_i_ind <> 'E',
									U'',
									name_alias);
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
		self.name_alias		:= IF(Std.uni.ToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			:= 'AKA'; // Name type of two for the AKA records
		self.Category		:= '';
		self.First_Name		:= U'';
		self.Middle_Name	:= U'';
		self.Last_Name		:= U'';
		self.Generation		:= U'';
		self.Full_Name		:= U'';
		self.Comments		:= U'';
		self.ID				:= l.uid;
		self.e_i_ind		:= l.e_i_ind;
	end;

	// Normalize the Alternative Spelling values
	ds_NormASpell := NORMALIZE(MyParsedASpellds
                            ,1
							,trfASpell(left));
	
	Layout_temp2 trfAkaNames2(ds_NormASpell l) := transform
		self.string_alias := if(regexfind(U'DBA |NKA |FKA ', Std.Uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									l.name_alias[5..],
									l.name_alias);
		self := l;
	end;
	
	ds_NormASpells := project(ds_NormASpell, trfAkaNames2(left));
							
	Layout_temp aSpellTran(ds_NormASpells l):= transform
		
		unicode name_alias 	:= if(regexfind(U'DBA |NKA |FKA ', std.uni.ToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									l.name_alias[5..],
									l.name_alias);
		
		self.Type			:= if(regexfind(U'NKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									'NKA',
								if(regexfind(U'FKA ', stringlib.StringToUpperCase((string)trim(l.name_alias, left, right))[1..4], 0)<>'',
									'FKA',
									l.type));
		
		self.First_Name		:= if(l.e_i_ind <> 'E' and regexfind(U',', l.string_alias, 0)<>'',
									trim(name_alias[Std.Uni.find(l.string_alias, ',', 1)+1..length(l.string_alias)], left, right),
									U'');
									
		self.Last_Name 		:= if(l.e_i_ind <> 'E' and regexfind(U',', l.string_alias, 0)<>'',
									trim(name_alias[1..Std.Uni.find(l.string_alias, U',', 1)-1], left, right),
									if(l.e_i_ind <> 'E' and regexfind(U',', l.string_alias, 0)='',
									l.name_alias,
									U''));
									
		self.Full_Name		:= if(l.e_i_ind <> 'E',
									U'',
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
aka_counts := out_count((integer)count_>254);

	count_layout := RECORD
		concatAKA;
		integer count_;
	end;

	count_layout join_aka(concatAKA l, aka_counts r):= transform
	  self.count_ := (integer)r.count_;
		self := l;
	end;

	counts_added 		:= join(concatAKA
															,aka_counts
															,left.id = right.id
															,join_AKA(left,right)
															,full outer);

//Filter by aka counts////////////////////////////////////////////////////////////////////////////////////////
	ds_max_akas		:= counts_added((integer)count_ > 254);

	//rgxPunct := u'!|@|#|$|%|-|\'|~';
	rgxPunct := u'!|@|#|$|%|~';				// restore hyphens and apostrophes

	counts_added removePunct(ds_max_akas l):= transform
		self.first_name 	:= if(l.e_i_ind not in [''],
														regexreplace(rgxPunct, l.first_name,''),
														l.first_name);
		self.middle_name 	:= if(l.e_i_ind not in [''],
														regexreplace(rgxPunct, l.middle_name,''),
														l.middle_name);
		self.last_name 		:= if(l.e_i_ind not in [''],
														regexreplace(rgxPunct, l.last_name,''),
														l.last_name);
		self.full_name 		:= if(l.e_i_ind not in [''],
														regexreplace(rgxPunct, l.full_name,''),
														l.full_name);
		self.name_alias 	:= if(l.e_i_ind not in [''],
														regexreplace(rgxPunct, l.name_alias,''),
														l.name_alias);
		self							:= l;
	end;


	ds_max_akas_fixed := dedup(sort(project(ds_max_akas, removePunct(left)), record), record);
	
	ds_ok_akas				:= counts_added((integer)count_ <= 254);

	all_akas1	:= ds_max_akas_fixed + ds_ok_akas;
	
	Layout_temp4 := record	
		all_akas1;
		unicode orig_name_alias;
		unicode orig_full_name;
	end;
	
	Layout_temp4 RemovingSpaceafterSlash(all_akas1 l):= transform
		self.orig_name_alias		:= l.name_alias;
		self.orig_full_name			:= l.full_name;	
		self.name_alias 				:= STD.Uni.CleanAccents(STD.Uni.ToUpperCase(regexreplace(u'/ ', l.full_name, u'/')));
		self.full_name 					:= STD.Uni.CleanAccents(STD.Uni.ToUpperCase(regexreplace(u'/ ', l.name_alias, u'/')));
		self										:= l;
	end;
	
 	
  all_akas1 trOriginalNames_id_60101(Layout_temp4 l) := TRANSFORM
			self.name_alias  	:= l.orig_name_alias;	
			self.full_name 		:= l.orig_full_name;		
			self 							:= l;
 	END;
	
	//all_akas := project(akas_for_id_60101(orig_full_name not in ['AQI - ZARQAWI', 'Jahbet al- Nusrah', 'Jama\'at al-Tawhid wa\'al-Jihad', 'Al Qaida in Iraq']), trOriginalNames_id_60101(left)) + all_akas1(id <> '60101');	
	
	all_akas := all_akas1;
	
	
//Reformat to old layout////////////////////////////////////////////////////////////////////////////////////
	concatAKA oldReform(all_akas l):=transform
		self := l;
	end;

fixed_akas := project(all_akas, oldReform(left)):persist('~thor_200::persist::worldcheck::normalize_akas_altspell_fixed');


return fixed_akas;

end;