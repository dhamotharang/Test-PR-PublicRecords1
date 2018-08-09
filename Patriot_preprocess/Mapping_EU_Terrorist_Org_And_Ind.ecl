
#OPTION('multiplePersistInstances',false);

individuals := DATASET('~thor::in::globalwatchlists::eu_terrorist_list::persons', 
                              layout_EU_terrorist_org_and_ind.layout_individual, 
														   CSV(separator('|'),quote('"'),terminator(['\n', '\r\n']),heading(1)));	
//output(individual, named('individual'));

groups := DATASET('~thor::in::globalwatchlists::eu_terrorist_list::groups', 
                              layout_EU_terrorist_org_and_ind.layout_groups, 
														   CSV(separator('|'),quote('"'),terminator(['\n', '\r\n']),heading(1)
																				 ));	
//output(groups, named('groups'));


// process individuals
filter_individual := individuals(first_name + last_name <> '');

layout_EU_terrorist_org_and_ind.layout_individual_slim tr_individual_slim(filter_individual l) := TRANSFORM
self.aka := StringLib.StringFindReplace(l.aka,'|','~'); // ~ will be used for normalizer/parsing. 
self := l;                                             // Tilda works better than pipe for in regex for parsing.
end;
		
individual_slim := PROJECT(filter_individual,tr_individual_slim(left));
//output(individual_slim, named('individual_slim'));


//////******** count tilda marks 
layout_add_count_tilda_marks := record
integer count_tilda_marks;
layout_EU_terrorist_org_and_ind.layout_individual_slim;
end;

layout_add_count_tilda_marks  tr_add_count_tilda_marks (individual_slim l ) := TRANSFORM

self.count_tilda_marks := StringLib.StringFindCount(l.aka ,'~');
self := l;
end;

ds_count_tilda_marks  := PROJECT(individual_slim,tr_add_count_tilda_marks (left));

////////******** add normalizer fire count 
layout_add_normalizer_fire_count  := record
integer normalizer_fire_count;
layout_add_count_tilda_marks;
end;

layout_add_normalizer_fire_count  tr_add_normalizer_fire_count (ds_count_tilda_marks l ) := TRANSFORM

self.normalizer_fire_count := l.count_tilda_marks + 1;
self := l;
end;

ds_normalizer_fire_count  := PROJECT(ds_count_tilda_marks,tr_add_normalizer_fire_count (left));
//output(ds_normalizer_fire_count);

OutRec := record
string aka_format;
string aka_normalized;
layout_add_normalizer_fire_count;
end;

OutRec NormIt(ds_normalizer_fire_count L, integer C) := TRANSFORM
								 
aka_format := trim(map(l.normalizer_fire_count = 1 => '(.*)', 
                        l.normalizer_fire_count = 2 => '(.*)(~)(.*)',
												 l.normalizer_fire_count = 3 => '(.*)(~)(.*)(~)(.*)',
												  l.normalizer_fire_count = 4 => '(.*)(~)(.*)(~)(.*)(~)(.*)',
													 l.normalizer_fire_count = 5 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
													  l.normalizer_fire_count = 6 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
														 l.normalizer_fire_count = 7 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
														  l.normalizer_fire_count = 8 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
															 l.normalizer_fire_count = 9 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
															  l.normalizer_fire_count = 10 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																 l.normalizer_fire_count = 11 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																  l.normalizer_fire_count = 12 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																   l.normalizer_fire_count = 13 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																    l.normalizer_fire_count = 14 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																     l.normalizer_fire_count = 15=> '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
/*l.normalizer_fire_count = 16 => */  '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)'));
	
self :=l;
self.aka_format := aka_format;

self.aka_normalized :=  choose(C, regexreplace(aka_format,l.aka,'$1'),
											    regexreplace(aka_format,l.aka,'$3'),
											    regexreplace(aka_format,l.aka,'$5'),
											    regexreplace(aka_format,l.aka,'$7'),
											    regexreplace(aka_format,l.aka,'$9'),
											    regexreplace(aka_format,l.aka,'$11'),
											    regexreplace(aka_format,l.aka,'$13'),
											    regexreplace(aka_format,l.aka,'$15'),
											    regexreplace(aka_format,l.aka,'$17'),
											    regexreplace(aka_format,l.aka,'$19'),
													regexreplace(aka_format,l.aka,'$21'),
													regexreplace(aka_format,l.aka,'$23'),	
													regexreplace(aka_format,l.aka,'$25'),	
													regexreplace(aka_format,l.aka,'$27'),	
													regexreplace(aka_format,l.aka,'$29'),	
													regexreplace(aka_format,l.aka,'$31')	
                          		 );
end;

Norm_aka :=
     normalize(ds_normalizer_fire_count,left.normalizer_fire_count,NormIt(left,counter));
//output(Norm_aka);

layout_EU_terrorist_org_and_ind.layout_names_and_AKAS  tr_primary_names(Norm_aka l ) := TRANSFORM
self.name := trim(l.Last_Name,left,right) + ', ' + trim(l.First_Name,left,right);
self.name_type := 'Primary';
self := l;
end;

primary_names := PROJECT(Norm_aka,tr_primary_names (left));
//output(primary_names, named('primary_names'));

layout_EU_terrorist_org_and_ind.layout_names_and_AKAS  tr_AKAs_names(Norm_aka l ) := TRANSFORM
self.name := trim(l.aka_normalized,left,right);
self.name_type := 'AKA';
self := l;
end;

AKAs_names := PROJECT(Norm_aka,tr_AKAs_names (left));
//output(AKAs_names, named('AKAs_names'));

dedup_sort_primary_name := dedup(sort(primary_names,Individual_ID,name),Individual_ID,name);
dedup_sort_AKAs_names := dedup(sort(AKAs_names,Individual_ID,name),Individual_ID,name);

concat_primary_AKAs := dedup_sort_primary_name + dedup_sort_AKAs_names(name <> '');

Patriot_preprocess.layout_patriot_common tr_patriot_common(concat_primary_AKAs l ) := TRANSFORM

remarks_1 := map(l.Date_of_Birth <> '' => 'Date of Birth: ' + l.Date_of_Birth, '');
remarks_2 := map(l.Alt_DoB_1 <> '' => 'Alternate Date/s of Birth: ' + l.Alt_DoB_1, '') +
                  map(l.Alt_DoB_2 <> '' => 'Alternate Date/s of Birth: ' + l.Alt_DoB_2, '');
remarks_4 := map(l.Citizenship <> '' => 'Citizenship: ' + l.Citizenship, '');
remarks_3 := map(l.Born_In <> '' => 'Born In: ' + l.Born_In, '');
remarks_5 := map(l.ETA_Membership <> '' and l.Other_Membership <> ''
                       => 'Membership: ETA ' + l.ETA_Membership + l.Other_Membership,
											   l.ETA_Membership <> '' and l.Other_Membership = ''
												   => 'Membership: ETA ' + l.ETA_Membership,
													   l.ETA_Membership = '' and l.Other_Membership <> ''
														   => 'Membership: ' + l.Other_Membership,''); 
remarks_6 := map(l.ID_Card <> '' => 'Identity Card: ' + l.ID_Card, '');
remarks_7 := map(l.Passport <> '' => 'Passport: ' + l.Passport, '');

concat_remarks := map(remarks_1 <> '' => remarks_1 + '~', '') +
									map(remarks_2 <> '' => remarks_2 + '~', '') +
									map(remarks_3 <> '' => remarks_3 + '~', '') +
									map(remarks_4 <> '' => remarks_4 + '~', '') +
									map(remarks_5 <> '' => remarks_5 + '~', '') +
									map(remarks_6 <> '' => remarks_6 + '~', '') +
									map(remarks_7 <> '' => remarks_7 + '~', '') ;
									
clean_concat_remarks := concat_remarks[1..length(concat_remarks)-1];									
									
format_1 := '(.*)';
format_2 := '(.*)(~)(.*)';
format_3 := '(.*)(~)(.*)(~)(.*)';
format_4 := '(.*)(~)(.*)(~)(.*)(~)(.*)';
format_5 := '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)';
format_6 := '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)';
format_7 := '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)';		

self.pty_key := 'EUI' + l.Individual_ID;
self.source := 'European Union Designated Terrorist Individuals';
self.orig_pty_name := l.Name;
self.orig_vessel_name := '';
self.name_type := l.name_type;

self.remarks_1 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$1'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,'$1'),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,'$1'),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,'$1'),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,'$1'),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,'$1'),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,'$1'),'');

self.remarks_2 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$3'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,'$3'),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,'$3'),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,'$3'),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,'$3'),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,'$3'),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,''),'');
											
self.remarks_3 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$5'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,'$5'),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,'$5'),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,'$5'),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,'$5'),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,''),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,''),'');									

self.remarks_4 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$7'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,'$7'),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,'$7'),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,'$7'),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,''),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,''),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,''),'');	
											
self.remarks_5 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$9'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,'$9'),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,'$9'),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,''),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,''),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,''),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,''),'');	
											
self.remarks_6 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$11'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,'$11'),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,''),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,''),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,''),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,''),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,''),'');											

self.remarks_7 := map(regexfind(format_7,clean_concat_remarks) => regexreplace(format_7,clean_concat_remarks,'$13'),
								      regexfind(format_6,clean_concat_remarks) => regexreplace(format_6,clean_concat_remarks,''),
								      regexfind(format_5,clean_concat_remarks) => regexreplace(format_5,clean_concat_remarks,''),
								      regexfind(format_4,clean_concat_remarks) => regexreplace(format_4,clean_concat_remarks,''),
								      regexfind(format_3,clean_concat_remarks) => regexreplace(format_3,clean_concat_remarks,''),
								      regexfind(format_2,clean_concat_remarks) => regexreplace(format_2,clean_concat_remarks,''),
								      regexfind(format_1,clean_concat_remarks) => regexreplace(format_1,clean_concat_remarks,''),'');

self.remarks_8 := map(l.Subject_to_Common_Pos_2001_931_CFSP <> '' 
                       => 'Subject of Article 4 of Common Position 2001/931/CFSP only.','');
self.remarks_9 := map(l.name = 'Joma, in charge of the Communist Party of the Philippines including NPA'
                         => 'Comment: ' + l.Name , '');
self := [];
end;

patriot_common_individual := PROJECT(concat_primary_AKAs,tr_patriot_common (left));
//output(patriot_common_individual, named('patriot_common_individual'));

// process groups  
filter_groups := groups(unparsed_data <> '');
//output(filter_groups, named('filter_groups'));


layout_EU_terrorist_org_and_ind.layout_concat_all_names  tr_concat_all_names(filter_groups l) := TRANSFORM

 clean_parsed_data := 
                 StringLib.StringFindReplace(
                       StringLib.StringFindReplace(
                        StringLib.StringFindReplace(
											  StringLib.StringFindReplace( 
												 StringLib.StringFindReplace(
                          StringLib.StringFindReplace(l.unparsed_data,
											                               '(a.k.a.','~'),
																										   'a.k.a.','~'),
																										     '--','~'),
																										       '(','~'),
																											        ')',''),	
																												       ',','')
																														     ; 
clean_groupname :=  '~' + 
                    StringLib.StringFindReplace(
                       StringLib.StringFindReplace(
                        StringLib.StringFindReplace(
											  StringLib.StringFindReplace( 
												 StringLib.StringFindReplace(
                          StringLib.StringFindReplace(l.groupname,
											                               '(a.k.a.','~'),
																										   'a.k.a.','~'),
																										     '--','~'),
																										       '(','~'),
																											        ')',''),	
																												       ',','')
																														     ; 

clean_unparsed_names := '~' + 
                         StringLib.StringFindReplace(
                       StringLib.StringFindReplace(
                        StringLib.StringFindReplace(
											  StringLib.StringFindReplace( 
												 StringLib.StringFindReplace(
                          StringLib.StringFindReplace(l.unparsed_names,
											                               '(a.k.a.','~'),
																										   'a.k.a.','~'),
																										     '--','~'),
																										       '(','~'),
																											        ')',''),	
																												       ',','')
																														     ; 
concat_clean :=   clean_parsed_data 
                    + clean_groupname
						          + clean_unparsed_names;

self.concat_all_names := concat_clean; 
self := l;                                             
end;
	
concat_all_names := PROJECT(filter_groups,tr_concat_all_names (left));

//////******** count tilda marks 
layout_add_count_tilda_marks1 := record
integer count_tilda_marks;
layout_EU_terrorist_org_and_ind.layout_concat_all_names;
end;

layout_add_count_tilda_marks1  tr_add_count_tilda_marks1 (concat_all_names l ) := TRANSFORM

concat_all_names_slim := map(StringLib.StringFindCount(l.concat_all_names ,'~') < 15
                         => l.concat_all_names,
												    l.concat_all_names[1..StringLib.StringFind(l.concat_all_names,'~',16)-1]);

self.count_tilda_marks := StringLib.StringFindCount(concat_all_names_slim ,'~');;
self.concat_all_names := concat_all_names_slim;
self := l;
end;

ds_count_tilda_marks1  := PROJECT(concat_all_names,tr_add_count_tilda_marks1 (left));

//////******** add normalizer fire count 
layout_add_normalizer_fire_count1  := record
integer normalizer_fire_count;
layout_add_count_tilda_marks1;
end;

layout_add_normalizer_fire_count1  tr_add_normalizer_fire_count1 (ds_count_tilda_marks1 l ) := TRANSFORM
self.normalizer_fire_count := l.count_tilda_marks + 1;
self := l;
end;

ds_normalizer_fire_count1  := PROJECT(ds_count_tilda_marks1,tr_add_normalizer_fire_count1 (left));
//output(ds_normalizer_fire_count1);

OutRec1 := record
string name_format;
string name_normalized;
layout_add_normalizer_fire_count1;
end;

OutRec1 NormIt1(ds_normalizer_fire_count1 L, integer C) := TRANSFORM
								 
 name_format := trim(map(l.normalizer_fire_count = 1 => '(.*)', 
                        l.normalizer_fire_count = 2 => '(.*)(~)(.*)',
												 l.normalizer_fire_count = 3 => '(.*)(~)(.*)(~)(.*)',
												  l.normalizer_fire_count = 4 => '(.*)(~)(.*)(~)(.*)(~)(.*)',
													 l.normalizer_fire_count = 5 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
													  l.normalizer_fire_count = 6 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
														 l.normalizer_fire_count = 7 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
														  l.normalizer_fire_count = 8 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
															 l.normalizer_fire_count = 9 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
															  l.normalizer_fire_count = 10 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																 l.normalizer_fire_count = 11 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																  l.normalizer_fire_count = 12 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																   l.normalizer_fire_count = 13 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																    l.normalizer_fire_count = 14 => '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
																     l.normalizer_fire_count = 15=> '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
/*l.normalizer_fire_count = 16 => */   '(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)'));
	
self :=l;
self.name_format := name_format;

self.name_normalized :=  choose(C, regexreplace(name_format,l.concat_all_names,'$1'),
											    regexreplace(name_format,l.concat_all_names,'$3'),
											    regexreplace(name_format,l.concat_all_names,'$5'),
											    regexreplace(name_format,l.concat_all_names,'$7'),
											    regexreplace(name_format,l.concat_all_names,'$9'),
											    regexreplace(name_format,l.concat_all_names,'$11'),
											    regexreplace(name_format,l.concat_all_names,'$13'),
											    regexreplace(name_format,l.concat_all_names,'$15'),
											    regexreplace(name_format,l.concat_all_names,'$17'),
											    regexreplace(name_format,l.concat_all_names,'$19'),
													regexreplace(name_format,l.concat_all_names,'$21'),
													regexreplace(name_format,l.concat_all_names,'$23'),	
													regexreplace(name_format,l.concat_all_names,'$25'),	
													regexreplace(name_format,l.concat_all_names,'$27'),	
													regexreplace(name_format,l.concat_all_names,'$29'),	
													regexreplace(name_format,l.concat_all_names,'$31')	
                          		 );
end;

Norm_names :=
     normalize(ds_normalizer_fire_count1,left.normalizer_fire_count,NormIt1(left,counter));
//output(Norm_names);

Patriot_preprocess.layout_patriot_common tr_patriot_common1(Norm_names l ) := TRANSFORM

self.pty_key := 'EUG' + l.RecordNo;
self.source := 'European Union Designated Terrorist Groups';
self.orig_pty_name := trim(map(regexfind('([0-9]+)(. )(.*)',l.name_normalized) 
                           => regexreplace('([0-9]+)(. )(.*)',l.name_normalized,'$3'),
													      l.name_normalized),left,right);
self.orig_vessel_name := '';
self.name_type := map(regexfind('([0-9]+)(. )(.*)',l.name_normalized) 
                         => 'Primary', 'AKA');
self.entity_flag := 'Y';										 
self := [];
end;

patriot_common_groups := PROJECT(Norm_names,tr_patriot_common1 (left));
//output(patriot_common_groups, named('patriot_common_groups'));

dedup_sort_patriot_common_groups := dedup(sort(patriot_common_groups,pty_key,orig_pty_name),pty_key,orig_pty_name);
//output(dedup_sort_patriot_common_groups, named('dedup_sort_patriot_common_groups'));

concat_indv_and_groups := patriot_common_individual + dedup_sort_patriot_common_groups;
//output(choosen(concat_indv_and_groups,all), named('concat_indv_and_groups'));

EXPORT Mapping_EU_Terrorist_Org_And_Ind := concat_indv_and_groups
          : persist('~thor::persist::out::patriot::preprocess::EU_Terrorist_Org_And_Ind');