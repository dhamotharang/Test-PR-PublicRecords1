
#OPTION('multiplePersistInstances',false);

import Address;

dsInterpolMostWantedINT		:= 	DATASET('~thor::in::globalwatchlists::innovative_systems::int', 
                                	   Patriot_preprocess.Layout_Interpol_Most_Wanted.Interpol_Most_Wanted_Red_Notice, Thor);	

dsInterpolMostWanted		:= 	DATASET('~thor::in::globalwatchlists::interpol_most_wanted', 
                                	   Patriot_preprocess.Layout_Interpol_Most_Wanted.layout_Interpol_Most_Wanted_Full, CSV(separator('|'),terminator(['\n', '\r\n'])));	

//output(dsInterpolMostWantedINT,named('dsInterpolMostWantedINT'));

//output(dsInterpolMostWanted,named('dsInterpolMostWanted'));

//**** process interpol most wanted int

Layout_Interpol_Most_Wanted.layout_Reformat_INT_Red_Notice_out0  tr_Reformat_INT_Red_Notice_out0(dsInterpolMostWantedINT l) := TRANSFORM
				 
a := trim(l.Original_Primary_Name)[1..StringLib.StringFind(trim(l.Original_Primary_Name),' ', StringLib.StringFindCount(trim(l.Original_Primary_Name), ' '))-1];	
	
v_first_last_stop := if(StringLib.StringFind(l.Original_Primary_Name,'(',1) > 0 and
                         StringLib.StringFind(l.Original_Primary_Name,'ALIAS',1) = 0 and 
                           regexfind('[0-9]',l.Original_Primary_Name) = false ,
                            StringLib.StringFind(a,' ', StringLib.StringFindCount(trim(a), ' ') ) , 0);
  
self.last_update_date := ''; //+ '${INTERPOL_MOST_WANTED_RED_NOTICE}'; fix
self.pty_key := trim(l.Application_Code) + (string)(integer) regexreplace('^92',l.Serial_Number,'');  
self.Interpol_ID := '';
self.source := 'Interpol Most Wanted - Red Notice';	
self.FamilyName := if(trim(l.Cleaned_Last_Name) <> '', trim(l.Cleaned_Last_Name), 
                      if(v_first_last_stop > 0, l.Original_Primary_Name[v_first_last_stop + 1..v_first_last_stop + 1 + 50] ,''));
self.Forename := if(trim(l.Cleaned_First_Name) <> '' , trim(l.Cleaned_First_Name), 
                      if(v_first_last_stop > 0 , l.Original_Primary_Name[1..v_first_last_stop - 1],''));
self.Name_Type := '';

end_postion_primary_name := StringLib.StringFind(StringLib.StringToUpperCase(trim(l.Original_Primary_Name)),'(ALIAS',1)-1;  

self.Original_Primary_Name := if(StringLib.StringFind(StringLib.StringToUpperCase(trim(l.Original_Primary_Name)),'(ALIAS', 1) > 0,
                                trim(StringLib.StringToUpperCase(trim(l.Original_Primary_Name))[1..end_postion_primary_name]),
                                     StringLib.StringToUpperCase(trim(l.Original_Primary_Name)));        

self.Original_Country := StringLib.StringToUpperCase(trim(l.Original_Country_01));
self.Original_Languages := if(l.Original_Language_01 <> '', trim(l.Original_Language_01) + ', ', '') +
													 if(l.Original_Language_02 <> '', trim(l.Original_Language_02) + ', ', '') +
													 if(l.Original_Language_03 <> '', trim(l.Original_Language_03) + ', ', '') +
													 if(l.Original_Language_04 <> '', trim(l.Original_Language_04) + ', ', '') +
													 if(l.Original_Language_05 <> '', trim(l.Original_Language_05) + ', ', '') +
													 if(l.Original_Language_06 <> '', trim(l.Original_Language_06) + ', ', '') +
													 if(l.Original_Language_07 <> '', trim(l.Original_Language_07) + ', ', '') +
													 if(l.Original_Language_08 <> '', trim(l.Original_Language_08) + ', ', '') +
													 if(l.Original_Language_09 <> '', trim(l.Original_Language_09) + ', ', '') +
													 if(l.Original_Language_10 <> '', trim(l.Original_Language_10) , '') ;
 
self.Original_DOB := trim(l.Original_DOB_01);
 
self.Original_POBs :=  if(l.Original_POB_01 <> '', trim(l.Original_POB_01) + ', ', '') +
												if(l.Original_POB_02 <> '', trim(l.Original_POB_02) + ', ', '') +
												if(l.original_POB_03 <> '', trim(l.Original_POB_03) + ', ', '') +
												if(l.Original_POB_04 <> '', trim(l.Original_POB_04) + ', ', '') +
												if(l.Original_POB_05 <> '', trim(l.Original_POB_05) + ', ', '') +
												if(l.Original_POB_06 <> '', trim(l.Original_POB_06) + ', ', '') +
												if(l.Original_POB_07 <> '', trim(l.Original_POB_07) + ', ', '') +
												if(l.Original_POB_08 <> '', trim(l.Original_POB_08) + ', ', '') +
												if(l.Original_POB_09 <> '', trim(l.Original_POB_09) + ', ', '') +
												if(l.Original_POB_10 <> '', trim(l.Original_POB_10) , '') ; 


self.Original_Linked_With := if(l.Original_Linked_With_01 <> '', trim(l.Original_Linked_With_01) + ', ' , '') +
													   if(l.Original_Linked_With_02 <> '', trim(l.Original_Linked_With_02) + ', ', '') +
													   if(l.Original_Linked_With_03 <> '', trim(l.Original_Linked_With_03) + ', ', '') +
													   if(l.Original_Linked_With_04 <> '', trim(l.Original_Linked_With_04) + ', ', '') +
													   if(l.Original_Linked_With_05 <> '', trim(l.Original_Linked_With_05) + ', ', '') +
													   if(l.Original_Linked_With_06 <> '', trim(l.Original_Linked_With_06) + ', ', '') +
													   if(l.Original_Linked_With_07 <> '', trim(l.Original_Linked_With_07) + ', ', '') +
													   if(l.Original_Linked_With_08 <> '', trim(l.Original_Linked_With_08) + ', ', '') +
													   if(l.Original_Linked_With_09 <> '', trim(l.Original_Linked_With_09) + ', ', '') +
													   if(l.Original_Linked_With_10 <> '', trim(l.Original_Linked_With_10) , '') ;

self.Original_Nationality_01 := l.Original_Country_01;
self.Original_Nationality_02 := l.Original_Country_02;
self.Original_Nationality_03 := l.Original_Country_03;
self.Original_Nationality_04 := l.Original_Country_04;
self.Original_Nationality_05 := l.Original_Country_05;
self.Original_Nationality_06 := l.Original_Country_06;
self.Original_Nationality_07 := l.Original_Country_07;
self.Original_Nationality_08 := l.Original_Country_08;
self.Original_Nationality_09 := l.Original_Country_09;
self.Original_Nationality_10 := l.Original_Country_10; 
self := l;
self := [];
end;

ds_Reformat_INT_Red_Notice_out0 := PROJECT(dsInterpolMostWantedINT,tr_Reformat_INT_Red_Notice_out0(LEFT));

Layout_Interpol_Most_Wanted.layout_Reformat_INT_Red_Notice_out1  tr_Reformat_INT_Red_Notice_out1(dsInterpolMostWantedINT l) := TRANSFORM

self.last_update_date := ''; //'${INTERPOL_MOST_WANTED_RED_NOTICE}'; fix
self.pty_key := trim(l.Application_Code) + (string)(integer) regexreplace('^92',l.Serial_Number,'');  
self.Interpol_ID := '';
self.source := 'Interpol Most Wanted - Red Notice';

v_FamilyName := StringLib.StringFindReplace(trim(l.Original_Primary_Name[StringLib.StringFind(l.Original_Primary_Name,'(ALIAS',1)+6..50]),')','');
v_Forename := l.Original_Primary_Name[1..StringLib.StringFind(l.original_Primary_Name,' ',1)];  

self.FamilyName := v_FamilyName;
self.Forename := v_Forename; 
self.Name_Type := 'AKA';
self.Original_Primary_Name := if(StringLib.StringFind(l.original_Primary_Name,'(ALIAS',1) > 0,
                                 v_Forename + v_FamilyName, '');    
self.Original_Country := StringLib.StringToUpperCase(trim(l.Original_Country_01));
self.Original_Languages := if(l.Original_Language_01 <> '', trim(l.Original_Language_01) + ', ', '') +
													 if(l.Original_Language_02 <> '', trim(l.Original_Language_02) + ', ', '') +
													 if(l.Original_Language_03 <> '', trim(l.Original_Language_03) + ', ', '') +
													 if(l.Original_Language_04 <> '', trim(l.Original_Language_04) + ', ', '') +
													 if(l.Original_Language_05 <> '', trim(l.Original_Language_05) + ', ', '') +
													 if(l.Original_Language_06 <> '', trim(l.Original_Language_06) + ', ', '') +
													 if(l.Original_Language_07 <> '', trim(l.Original_Language_07) + ', ', '') +
													 if(l.Original_Language_08 <> '', trim(l.Original_Language_08) + ', ', '') +
													 if(l.Original_Language_09 <> '', trim(l.Original_Language_09) + ', ', '') +
													 if(l.Original_Language_10 <> '', trim(l.Original_Language_10) , '') ;
 
self.Original_DOB := trim(l.Original_DOB_01);
 
self.Original_POBs :=  if(l.Original_POB_01 <> '', trim(l.Original_POB_01) + ', ', '') +
												if(l.Original_POB_02 <> '', trim(l.Original_POB_02) + ', ', '') +
												if(l.original_POB_03 <> '', trim(l.Original_POB_03) + ', ', '') +
												if(l.Original_POB_04 <> '', trim(l.Original_POB_04) + ', ', '') +
												if(l.Original_POB_05 <> '', trim(l.Original_POB_05) + ', ', '') +
												if(l.Original_POB_06 <> '', trim(l.Original_POB_06) + ', ', '') +
												if(l.Original_POB_07 <> '', trim(l.Original_POB_07) + ', ', '') +
												if(l.Original_POB_08 <> '', trim(l.Original_POB_08) + ', ', '') +
												if(l.Original_POB_09 <> '', trim(l.Original_POB_09) + ', ', '') +
												if(l.Original_POB_10 <> '', trim(l.Original_POB_10) , '') ; 


self.Original_Linked_With := if(l.Original_Linked_With_01 <> '', trim(l.Original_Linked_With_01) + ', ' , '') +
													   if(l.Original_Linked_With_02 <> '', trim(l.Original_Linked_With_02) + ', ', '') +
													   if(l.Original_Linked_With_03 <> '', trim(l.Original_Linked_With_03) + ', ', '') +
													   if(l.Original_Linked_With_04 <> '', trim(l.Original_Linked_With_04) + ', ', '') +
													   if(l.Original_Linked_With_05 <> '', trim(l.Original_Linked_With_05) + ', ', '') +
													   if(l.Original_Linked_With_06 <> '', trim(l.Original_Linked_With_06) + ', ', '') +
													   if(l.Original_Linked_With_07 <> '', trim(l.Original_Linked_With_07) + ', ', '') +
													   if(l.Original_Linked_With_08 <> '', trim(l.Original_Linked_With_08) + ', ', '') +
													   if(l.Original_Linked_With_09 <> '', trim(l.Original_Linked_With_09) + ', ', '') +
													   if(l.Original_Linked_With_10 <> '', trim(l.Original_Linked_With_10) , '') ;

self.Original_Nationality_01 := l.Original_Country_01;
self.Original_Nationality_02 := l.Original_Country_02;
self.Original_Nationality_03 := l.Original_Country_03;
self.Original_Nationality_04 := l.Original_Country_04;
self.Original_Nationality_05 := l.Original_Country_05;
self.Original_Nationality_06 := l.Original_Country_06;
self.Original_Nationality_07 := l.Original_Country_07;
self.Original_Nationality_08 := l.Original_Country_08;
self.Original_Nationality_09 := l.Original_Country_09;
self.Original_Nationality_10 := l.Original_Country_10; 
self := l;
self := [];
end;


ds_Reformat_INT_Red_Notice_out1 := PROJECT(dsInterpolMostWantedINT,tr_Reformat_INT_Red_Notice_out1(LEFT));
//output(ds_Reformat_INT_Red_Notice_out1, named('ds_Reformat_INT_Red_Notice_out1'));


//******Filter by Expression
////!is_blank(string_lrtrim(Original_Primary_Name))

concat := ds_Reformat_INT_Red_Notice_out0 + ds_Reformat_INT_Red_Notice_out1;
ds_Filter_by_Expression := concat(Original_Primary_Name <> '');


////////////////////////////////////////////////////////////////////////////////////////////////

//*****Process interpol_most_wanted 

Filter_Header_and_Bad_Records := dsInterpolMostWanted(
                            FamilyName <> 'LastName' and FamilyName <> '' and Forename <> '');  

Sort_Interpol_Most_Wanted := sort(Filter_Header_and_Bad_Records,
                      Forename, FamilyName, Sex, DateofBirth, BirthPlace, Language, Nationality, Offenses, WarrantBy_1, Height, Weight, Hair, Eyes, PhotoName);
  

Dedup_Sorted := dedup(Sort_Interpol_Most_Wanted,
                       Forename, FamilyName, Sex, DateofBirth, BirthPlace, Language, Nationality, Offenses, WarrantBy_1, Height, Weight, Hair, Eyes, PhotoName);

Layout_Interpol_Most_Wanted.layout_Parse_Individual_Citations_out0  tr_Parse_Individual_Citations_out0(Dedup_Sorted l) := TRANSFORM

v_pob_slash_count := length(StringLib.StringFilter(l.BirthPlace,'/'));
v_language_comma_count := length(StringLib.StringFilter(l.Language,','));
v_nationality_comma_count := length(StringLib.StringFilter(l.Nationality,','));

pob_right_pad_with_slash :=  if (v_pob_slash_count = 0, '/////////',
	                                  if (v_pob_slash_count = 1, '////////',
	                                   if (v_pob_slash_count = 2,'///////',
										                  if (v_pob_slash_count = 3,'//////',
											                 if (v_pob_slash_count = 4,'/////',
												                if (v_pob_slash_count = 5,'////',
												  	             if (v_pob_slash_count = 6,'///',
									                        if (v_pob_slash_count = 7,'//',
														  	           if (v_pob_slash_count = 8,'/','')
																	          ))))))));
																						
language_right_pad_with_comma := if (v_language_comma_count = 0, ',,,,,,,,,',
	                                  if (v_language_comma_count = 1, ',,,,,,,,',
	                                   if (v_language_comma_count = 2,',,,,,,,',
										                  if (v_language_comma_count = 3,',,,,,,',
											                 if (v_language_comma_count = 4,',,,,,',
												                if (v_language_comma_count = 5,',,,,',
												  	             if (v_language_comma_count = 6,',,,',
									                        if (v_language_comma_count = 7,',,',
														  	           if (v_language_comma_count = 8,',','')
																	          ))))))));
																						
nationality_right_pad_with_comma := if (v_nationality_comma_count = 0, ',,,,,,,,,',
	                                   if (v_nationality_comma_count = 1, ',,,,,,,,',
	                                    if (v_nationality_comma_count = 2,',,,,,,,',
										                   if (v_nationality_comma_count = 3,',,,,,,',
											                  if (v_nationality_comma_count = 4,',,,,,',
												                 if (v_nationality_comma_count = 5,',,,,',
												  	              if (v_nationality_comma_count = 6,',,,',
									                         if (v_nationality_comma_count = 7,',,',
														  	            if (v_nationality_comma_count = 8,',','')
																	           ))))))));																						

self.FamilyName := if(StringLib.StringFind(l.FamilyName,'(ALIAS', 1) > 0 , trim(l.FamilyName[1..StringLib.StringFind(l.FamilyName,'(ALIAS',1)-1]),l.FamilyName);
self.Name_Type := '';  
self.BirthPlace_Parsed := trim(trim(StringLib.StringFindReplace(StringLib.StringFindReplace(l.BirthPlace,'Former Yugoslav Republic of','Former Yugoslav Rep. of'),'"','')) + pob_right_pad_with_slash);
self.Language_Parsed :=   trim(trim(StringLib.StringFindReplace(l.Language,'"','')) + language_right_pad_with_comma);
self.Nationality_Parsed := trim(trim(StringLib.StringFindReplace(l.Nationality,'"','')) + nationality_right_pad_with_comma);
self := l;
self := [];
end;	

ds_Parse_Individual_Citations_out0 := PROJECT(Dedup_Sorted,tr_Parse_Individual_Citations_out0(LEFT));


Layout_Interpol_Most_Wanted.layout_Parse_Individual_Citations_out1  tr_Parse_Individual_Citations_out1(Dedup_Sorted l) := TRANSFORM

v_pob_slash_count := length(StringLib.StringFilter(l.BirthPlace,'/'));
v_language_comma_count := length(StringLib.StringFilter(l.Language,','));
v_nationality_comma_count := length(StringLib.StringFilter(l.Nationality,','));

pob_right_pad_with_slash :=  if (v_pob_slash_count = 0, '/////////',
	                                  if (v_pob_slash_count = 1, '////////',
	                                   if (v_pob_slash_count = 2,'///////',
										                  if (v_pob_slash_count = 3,'//////',
											                 if (v_pob_slash_count = 4,'/////',
												                if (v_pob_slash_count = 5,'////',
												  	             if (v_pob_slash_count = 6,'///',
									                        if (v_pob_slash_count = 7,'//',
														  	           if (v_pob_slash_count = 8,'/','')
																	          ))))))));
																						
language_right_pad_with_comma := if (v_language_comma_count = 0, ',,,,,,,,,',
	                                  if (v_language_comma_count = 1, ',,,,,,,,',
	                                   if (v_language_comma_count = 2,',,,,,,,',
										                  if (v_language_comma_count = 3,',,,,,,',
											                 if (v_language_comma_count = 4,',,,,,',
												                if (v_language_comma_count = 5,',,,,',
												  	             if (v_language_comma_count = 6,',,,',
									                        if (v_language_comma_count = 7,',,',
														  	           if (v_language_comma_count = 8,',','')
																	          ))))))));
																						
nationality_right_pad_with_comma := if (v_nationality_comma_count = 0, ',,,,,,,,,',
	                                   if (v_nationality_comma_count = 1, ',,,,,,,,',
	                                    if (v_nationality_comma_count = 2,',,,,,,,',
										                   if (v_nationality_comma_count = 3,',,,,,,',
											                  if (v_nationality_comma_count = 4,',,,,,',
												                 if (v_nationality_comma_count = 5,',,,,',
												  	              if (v_nationality_comma_count = 6,',,,',
									                         if (v_nationality_comma_count = 7,',,',
														  	            if (v_nationality_comma_count = 8,',','')
																	           ))))))));																						

self.FamilyName := if(StringLib.StringFind(l.FamilyName,'(ALIAS', 1) > 0, StringLib.StringFindReplace(trim(l.FamilyName[StringLib.StringFind(l.FamilyName,'(ALIAS',1)+6..50]),')','') , '');
self.Name_Type := 'AKA';  
self.BirthPlace_Parsed := trim(trim(StringLib.StringFindReplace(StringLib.StringFindReplace(l.BirthPlace,'Former Yugoslav Republic of','Former Yugoslav Rep. of'),'"','')) + pob_right_pad_with_slash);
self.Language_Parsed :=   trim(trim(StringLib.StringFindReplace(l.Language,'"','')) + language_right_pad_with_comma);
self.Nationality_Parsed := trim(trim(StringLib.StringFindReplace(l.Nationality,'"','')) + nationality_right_pad_with_comma);
self := l;
self := [];
end;	

ds_Parse_Individual_Citations_out1 := PROJECT(Dedup_Sorted,tr_Parse_Individual_Citations_out1(LEFT));

//output(ds_Parse_Individual_Citations_out1, named('ds_Parse_Individual_Citations_out1'));

//******Gather Orig with Aliases

ds_Gather_Orig_with_Aliases :=  ds_Parse_Individual_Citations_out0 + ds_Parse_Individual_Citations_out1;
//output(ds_Gather_Orig_with_Aliases, named('ds_Gather_Orig_with_Aliases'));

//*****Filter Null Names

ds_Filter_Null_Names := ds_Gather_Orig_with_Aliases(trim(FamilyName) <> '');
//output(ds_Filter_Null_Names, named('ds_Filter_Null_Names'));

ds_Sort_IMW := sort(ds_Filter_Null_Names,ID,FamilyName, Forename, Offenses);
//output(choosen(ds_Sort_IMW,500),named('ds_Sort_IMW'));

layout_Parse_Individual_Citations_out0_with_rollup_offenses := record
Layout_Interpol_Most_Wanted.layout_Parse_Individual_Citations_out0;
string offenses_rolluped;
end;

layout_Parse_Individual_Citations_out0_with_rollup_offenses tr_initialize_offenses_rolluped(ds_Sort_IMW L) := TRANSFORM
self.offenses_rolluped := '';
self := l;
end;
		
ds_initialize_offenses_rolluped := PROJECT(ds_Sort_IMW,tr_initialize_offenses_rolluped(LEFT));
//output(ds_initialize_offenses_rolluped, named('ds_initialize_offenses_rolluped'));

ds_sort_initialize_offenses_rolluped := sort(ds_initialize_offenses_rolluped,id,familyname,offenses);
//output(ds_initialize_offenses_rolluped,named('ds_sort_initialize_offenses_rolluped'));

layout_Parse_Individual_Citations_out0_with_rollup_offenses tr_rollup_offenses(ds_sort_initialize_offenses_rolluped
                                                                   L,ds_sort_initialize_offenses_rolluped R) := TRANSFORM
self.id := l.id;
self.familyname := l.familyname;
self.offenses := r.offenses;
self.offenses_rolluped := map(l.offenses <> r.offenses and trim(l.offenses_rolluped) = '' =>
                               l.offenses + ', ' +  r.offenses,
															  l.offenses <> r.offenses and trim(l.offenses_rolluped) <> '' =>			
                                  trim(l.offenses_rolluped) + ', ' + trim(r.offenses),
																	  l.offenses = r.offenses and trim(l.offenses_rolluped) <> '' =>	
																		  trim(l.offenses_rolluped),
																			  l.offenses);  // take care of .offenses = r.offenses and trim(l.offenses_rolluped) = ''

self := r;
END;

ds_rollup_offense := ROLLUP(ds_sort_initialize_offenses_rolluped,
                       LEFT.id = RIGHT.id 
					              and	LEFT.familyname = RIGHT.familyname,
                          tr_rollup_offenses(LEFT,RIGHT));
				 
//output(ds_rollup_offense,named('ds_rollup_offense'));		


//Layout_Interpol_Most_Wanted.layout_Parse_Individual_Citations_out0 tr_set_offenses_to_rollup_offense(ds_rollup_offense l) := TRANSFORM				 
Layout_Interpol_Most_Wanted.layout_Rollup tr_set_offenses_to_rollup_offense(ds_rollup_offense l) := TRANSFORM			 
self.offenses := if(l.offenses_rolluped <> '',l.offenses_rolluped, l.offenses); 
self := l;
end;

ds_set_offenses_to_rollup_offense := PROJECT(ds_rollup_offense,tr_set_offenses_to_rollup_offense(LEFT));

// Preprocess before call to tr_Reformat_Interpol_Data to assign sequence number to distinct ids
//
distinct_ids := TABLE(ds_rollup_offense,{id, count_1 := count(group)},id);
//output(distinct_ids,named('distinct_ids'));

Layout_id_and_id_with_sequence := record
string ID;
integer pty_count;
end;

Layout_id_and_id_with_sequence tr_add_sequence_to_distinct_ids(distinct_ids l, integer c ) := TRANSFORM
self.id := l.id;
self.pty_count := c;
end;

ds_add_sequence_to_distinct_ids := PROJECT(distinct_ids,tr_add_sequence_to_distinct_ids(left,counter));
//output(ds_add_sequence_to_distinct_ids,named('ds_add_sequence_to_distinct_ids'));	
	
ds_attached_seq_ds_rollup_offense := join(ds_rollup_offense,ds_add_sequence_to_distinct_ids,
																		  left.id = right.id);
		
//output(ds_attached_seq_ds_rollup_offense,named('ds_attached_seq_ds_rollup_offense'));

Layout_Interpol_Most_Wanted.layout_Reformat_Interpol_Data 
                          tr_Reformat_Interpol_Data(ds_attached_seq_ds_rollup_offense l) := TRANSFORM
self.last_update_date := ''; //:: '${INTERPOL_DATE}'; need to fix
self.pty_key := 'IMW' +  (string) l.pty_count;  
self.Interpol_ID := if(StringLib.StringFind(l.ID,'/',1) > 0 , l.ID[9..10] , l.ID);
self.source := 'Interpol Most Wanted';
self.FamilyName := trim(StringLib.StringFindReplace(StringLib.StringFindReplace(regexreplace('[0-9][0-9][0-9][0-9]',l.FamilyName,''),'(',''),')',''));
self.Forename := StringLib.StringFindReplace(trim(StringLib.StringFindReplace(StringLib.StringFindReplace(regexreplace('[0-9][0-9][0-9][0-9]',l.Forename,''),'(',''),')','')),'  ',' ');
self.Original_Primary_Name := StringLib.StringToUpperCase(StringLib.StringFindReplace(
                                     trim(StringLib.StringFindReplace(StringLib.StringFindReplace(regexreplace('[0-9][0-9][0-9][0-9]',l.Forename,''),'(',''),')',''))
                                                                          ,'  ',' ')
                                      + ' '
                           + trim(StringLib.StringFindReplace(StringLib.StringFindReplace(regexreplace('[0-9][0-9][0-9][0-9]',l.FamilyName,''),'(',''),')','')) 
													    ) ;
self.Original_Country := StringLib.StringToUpperCase(trim(l.Nationality));
self.Original_Languages := trim(l.Language);
self.Original_DOB := trim(l.DateofBirth[1..StringLib.StringFind(l.DateofBirth,'(',1)-1]);
self.Original_POBs := trim(l.BirthPlace);
self.Original_Crimes := trim(l.Offenses);
self.Original_Gender := trim(l.Sex[1..1]);  
self.Original_Warrant_Issued_By := if(StringLib.StringFind(l.WarrantBy_1,',',1) <> 0 , 
                                      trim(l.WarrantBy_1)[1..StringLib.StringFind(l.WarrantBy_1,',',1)],
                                              l.WarrantBy_1);
self.Original_Photo_File := trim(l.PhotoName);
self.Original_Height := trim(l.Height);
self.Original_Weight := trim(l.Weight);
self.Original_Hair := trim(l.Hair);
self.Original_Eyes := trim(l.Eyes)[1..25];
self := l;
self := [];
end;

ds_Reformat_Interpol_Data := PROJECT(ds_attached_seq_ds_rollup_offense,tr_Reformat_Interpol_Data(left));
//output(ds_Reformat_Interpol_Data,named('ds_Reformat_Interpol_Data'));	
														 

//******Filter by Expression-1
//string_lrtrim(FamilyName) != "FERNANDO"

ds_Filter_by_Expression_1 := ds_Reformat_Interpol_Data(trim(FamilyName) <> 'FERNANDO');

//******Reformat Unmatched Records

concat_Filter_by_Expression := ds_Filter_by_Expression + ds_Filter_by_Expression_1;

Layout_Interpol_Most_Wanted.layout_Reformat_Unmatched_Records 
                          tr_Reformat_Unmatched_Records(concat_Filter_by_Expression l) := TRANSFORM

temp_name := Map( trim(l.FamilyName) + ', ' + trim(l.Forename) <> '' and  
              StringLib.StringFind(trim(l.FamilyName) + ', ' + trim(l.Forename),'(',1) > 0 and 
                length(StringLib.StringFilter(trim(l.FamilyName) + ', ' + trim(l.Forename),'1234567890')) > 0 							  
								 => StringLib.StringFilterOut(StringLib.StringFindReplace(StringLib.StringFindReplace(trim(l.FamilyName) + ', ' + trim(l.Forename),'(',''),')',''),'1234567890'),
								    
										trim(l.FamilyName)  + ', ' +  trim(l.Forename) <> ''
										    => trim(l.FamilyName) + trim(l.Forename),
												   
													 trim(l.Original_Primary_Name) <> '' and 
                                StringLib.StringFind(l.Original_Primary_Name,'(',1) > 0 and
                                  length(StringLib.StringFilter(l.Original_Primary_Name,'1234567890')) > 0 
																	  => StringLib.StringFilterOut(StringLib.StringFindReplace(StringLib.StringFindReplace(l.Original_Primary_Name,'(',''),')',''),'1234567890'),
																
																       trim(l.Original_Primary_Name) <> '' 
							                             => l.Original_Primary_Name ,'');
	
  remarks_1 := if(trim(l.Original_DOB) <> '' and trim(l.Original_DOB) <> '00000000' , '; Date of Birth: ' + trim(l.Original_DOB), '') +
               if(l.Original_POBs <> '' , '; Place/s of Birth: ' + trim(l.Original_POBs), '');             
  remarks_2 := if(l.Original_Gender <> '', '; Gender: ' + if(l.Original_Gender = 'F' ,'FEMALE' ,'MALE'),'');
  remarks_3 := StringLib.StringFindReplace(
              if(l.Original_Hair <> '', '; Hair: ' + trim(l.Original_Hair), '') +
              if(l.Original_Eyes <> '', '; Eyes: ' + trim(l.Original_Eyes), '') +
              if(l.Original_Height <> '', '; Height: ' + trim(l.Original_Height), '') +
              if(l.Original_Weight <> '' ,'; Weight: ' + trim(l.Original_Weight), ''),'^; ','');
  remarks_4 := if(l.Original_Languages <> '', '; Languages: ' + trim(l.Original_Languages), '');
  remarks_5 := if(trim(l.Original_Crimes) <> '', '; Crimes: ' + trim(l.Original_Crimes), '');
  remarks_6 := if(l.Original_Warrant_Issued_By <> '', '; Warrant Issued By: ' + trim(l.Original_Warrant_Issued_By), '');
  remarks_7 := if(trim(l.Interpol_ID) <> '' , '; Interpol ID: ' + l.Interpol_ID,  '');
  remarks_8 := if(l.Original_Linked_With <> '', '; Linked With: ' + 
                                                                trim(StringLib.StringFindReplace(StringLib.StringFindReplace(l.Original_Linked_With
                                                                                      ,'/Public/Data/Children/Missing/Notices/Data/..../[0-9]*/'
                                                                                      ,'Missing Children ')
                                                                           ,'/Public/Data/Wanted/Notices/Data/..../[0-9]*/'
                                                                             ,'')
                                                                           ), ''); 
  concat_remarks :=  
	                   remarks_1 +
	                   remarks_2 +
										 remarks_3 +										 
										 remarks_4 +
										 remarks_5 +
										 remarks_6 +
										 remarks_7 +
										 remarks_8;
										 
	concat_remarks_clean := regexreplace(', ;',concat_remarks[3..],';'); 
  
 	remarks1 := concat_remarks_clean[1..75];
  remarks2 := concat_remarks_clean[76..150];
  remarks3 := concat_remarks_clean[151..225];
  remarks4 := concat_remarks_clean[226..300];
  remarks5 := concat_remarks_clean[301..375];
  remarks6 := concat_remarks_clean[376..450];
  remarks7 := concat_remarks_clean[451..525];
	remarks8 := concat_remarks_clean[526..600]; 
	remarks9 := concat_remarks_clean[601..675];
	remarks10 := concat_remarks_clean[676..750];
	remarks11 := concat_remarks_clean[751..825];	
	remarks12 := concat_remarks_clean[826..900];
	remarks13 := concat_remarks_clean[901..975];
	remarks14 := concat_remarks_clean[976..1050]; 
								 
  self.pty_key := if(trim(l.pty_key) <> '', trim(l.pty_key),'');
  self.source :=  if(trim(l.source) <> '' , trim(l.source), '');           
	self.orig_pty_name := if(trim(l.Original_Primary_Name) <> '' , trim(l.Original_Primary_Name),'');				
  
	self.orig_vessel_name := '';
  self.country := if(trim(l.Original_Country) <> '', trim(l.Original_Country), '');
  self.name_type := trim(l.Name_Type);
  self.addr_1 := if(trim(l.Original_Country) <> '', trim(l.Original_Country), '');
  self.remarks_1 := remarks1;          
  self.remarks_2 := remarks2; 
  self.remarks_3 := remarks3;
  self.remarks_4 := remarks4;
  self.remarks_5 := remarks5;
  self.remarks_6 := remarks6;
  self.remarks_7 := remarks7;
  self.remarks_8 := remarks8;
	self.remarks_9 := remarks9;
  self.remarks_10 := remarks10;
  self.remarks_11 := remarks11;
  self.remarks_12 := remarks12;
  self.remarks_13 := remarks13;
	self.remarks_14 := remarks14;
	self := l; 
	self := []; 
end; 


ds_Reformat_Unmatched_Records := PROJECT(concat_Filter_by_Expression,tr_Reformat_Unmatched_Records(left));
//output(ds_Reformat_Unmatched_Records,named('ds_Reformat_Unmatched_Records'));	

ds_Filter_by_Expression_1a := ds_Reformat_Interpol_Data(trim(FamilyName) = 'FERNANDO');

Layout_Interpol_Most_Wanted.layout_Reformat_Unmatched_Records 
                          tr_Reformat_Unmatched_Records_1(ds_Filter_by_Expression_1a l) := TRANSFORM

 temp_name := trim(
                Map(trim(l.FamilyName) + ', ' + trim(l.Forename) <> '' and 
                 StringLib.StringFind(trim(l.FamilyName) + ', ' + trim(l.Forename),'(',1) > 0 and
                  length(StringLib.StringFilter(trim(l.FamilyName) + ', ' + trim(l.Forename),'1234567890')) > 0 
									   => StringLib.StringFilterOut(StringLib.StringFindReplace(StringLib.StringFindReplace(trim(l.FamilyName) + ', ' + trim(l.Forename)
										                                                                                                    ,'(','')
                                                                                                                          ,')','')
                                                                                                                          ,'1234567890'),
								        trim(l.FamilyName) + ', ' + trim(l.Forename) <> ''
												   => trim(l.FamilyName) + ', ' + trim(l.Forename) ,                                                                                                               
                               trim(l.Original_Primary_Name) <> '' and 
                                StringLib.StringFind(l.Original_Primary_Name,'(',1) > 0 and
                                  length(StringLib.StringFilter(l.Original_Primary_Name,'1234567890')) > 0 
																	   => StringLib.StringFilterOut(StringLib.StringFindReplace(StringLib.StringFindReplace(l.Original_Primary_Name,'(',''),')',''),'1234567890') ,
																					trim(l.Original_Primary_Name) <> '' 
																					  => l.Original_Primary_Name , ''));	
																						
																						
  remarks_1 := if(trim(l.Original_DOB) <> '' and trim(l.Original_DOB) <> '00000000' , '; Date of Birth: ' + trim(l.Original_DOB), '') +
               if(l.Original_POBs <> '' , '; Place/s of Birth: ' + trim(l.Original_POBs), '');             
  remarks_2 := if(l.Original_Gender <> '', '; Gender: ' + if(l.Original_Gender = 'F' ,'FEMALE' ,'MALE'),'');
  remarks_3 := StringLib.StringFindReplace(
              if(l.Original_Hair <> '', '; Hair: ' + trim(l.Original_Hair), '') +
              if(l.Original_Eyes <> '', '; Eyes: ' + trim(l.Original_Eyes), '') +
              if(l.Original_Height <> '', '; Height: ' + trim(l.Original_Height), '') +
              if(l.Original_Weight <> '' ,'; Weight: ' + trim(l.Original_Weight), ''),'^; ','');
  remarks_4 := if(l.Original_Languages <> '', '; Languages: ' + trim(l.Original_Languages), '');
  remarks_5 := if(trim(l.Original_Crimes) <> '', '; Crimes: ' + trim(l.Original_Crimes), '');
  remarks_6 := if(l.Original_Warrant_Issued_By <> '', '; Warrant Issued By: ' + trim(l.Original_Warrant_Issued_By), '');
  remarks_7 := if(trim(l.Interpol_ID) <> '' , '; Interpol ID: ' + l.Interpol_ID,  '');
  remarks_8 := if(l.Original_Linked_With <> '', '; Linked With: ' + 
                                                                trim(StringLib.StringFindReplace(StringLib.StringFindReplace(l.Original_Linked_With
                                                                                      ,'/Public/Data/Children/Missing/Notices/Data/..../[0-9]*/'
                                                                                      ,'Missing Children ')
                                                                           ,'/Public/Data/Wanted/Notices/Data/..../[0-9]*/'
                                                                             ,'')
                                                                           ), ''); 
  concat_remarks :=  
	                   remarks_1 +
	                   remarks_2 +
										 remarks_3 +										 
										 remarks_4 +
										 remarks_5 +
										 remarks_6 +
										 remarks_7 +
										 remarks_8;
										 
	concat_remarks_clean := regexreplace(', ;',concat_remarks[3..],';'); 
  
 	remarks1 := concat_remarks_clean[1..75];
  remarks2 := concat_remarks_clean[76..150];
  remarks3 := concat_remarks_clean[151..225];
  remarks4 := concat_remarks_clean[226..300];
  remarks5 := concat_remarks_clean[301..375];
  remarks6 := concat_remarks_clean[376..450];
  remarks7 := concat_remarks_clean[451..525];
	remarks8 := concat_remarks_clean[526..600]; 
	remarks9 := concat_remarks_clean[601..675];
	remarks10 := concat_remarks_clean[676..750];
	remarks11 := concat_remarks_clean[751..825];	
	remarks12 := concat_remarks_clean[826..900];
	remarks13 := concat_remarks_clean[901..975];
	remarks14 := concat_remarks_clean[976..1050]; 
																																																                                                                                                     
  self.pty_key := if(trim(l.pty_key) <> '', trim(l.pty_key) ,'');
  self.source :=  if(trim(l.source) <> '', trim(l.source), '');
  self.orig_pty_name :=
       if(trim(l.Original_Primary_Name) <> '', trim(l.Original_Primary_Name), '');
  self.orig_vessel_name := '';
  self.country := if(trim(l.Original_Country) <> '', trim(l.Original_Country), '');
  self.name_type := trim(l.Name_Type);
  self.addr_1 := if(trim(l.Original_Country) <> '', trim(l.Original_Country), '');
  self.remarks_1 := remarks1;          
  self.remarks_2 := remarks2; 
  self.remarks_3 := remarks3;
  self.remarks_4 := remarks4;
  self.remarks_5 := remarks5;
  self.remarks_6 := remarks6;
  self.remarks_7 := remarks7;
  self.remarks_8 := remarks8;
	self.remarks_9 := remarks9;
  self.remarks_10 := remarks10;
  self.remarks_11 := remarks11;
  self.remarks_12 := remarks12;
  self.remarks_13 := remarks13;
	self.remarks_14 := remarks14;
	self := []; 
end;

ds_Reformat_Unmatched_Records_1 := PROJECT(ds_Filter_by_Expression_1a,tr_Reformat_Unmatched_Records(left));
//output(ds_Reformat_Unmatched_Records_1,named('ds_Reformat_Unmatched_Records_1'));	

//******Gather
Gather := ds_Reformat_Unmatched_Records + ds_Reformat_Unmatched_Records_1;
//output(Gather);

Patriot_preprocess.layout_patriot_common tr_patriot_common(Gather l) := TRANSFORM 
 self := l;
 self := [];
 end;

patriot_common := PROJECT(Gather,tr_patriot_common(left));

EXPORT Mapping_Interpol_Most_Wanted := patriot_common
          : persist('~thor::persist::out::patriot::preprocess::Interpol_Most_Wanted');
