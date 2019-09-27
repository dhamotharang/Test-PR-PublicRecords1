
#OPTION('multiplePersistInstances',false);

terrorist_exclusions := DATASET('~thor::in::globalwatchlists::state_department_terrorist_exclusion', 
                              Layout_State_Dept_Terrorist_Exclusions.layout_Terrorist_Exclusions, 
														   CSV(separator('|'),quote('"'),terminator(['\n', '\r\n'])
															                                             //,heading(1)
																								                                      ));
																								 
//output(terrorist_exclusions, named('terrorist_exclusions'));

filter_terrorist_exclusions := terrorist_exclusions
                                  (Organization <> '' and regexfind('Loading /data_999/sanctions/data/state_department/' + '|' +
																												      'Orignal Filename' + '|' +
																												      'Number of Sheets' + '|' +
																												      'Author' + '|' +
																											      	'Writing Sheet number' + '|' +
																												      'Minrow=0 Maxrow', Organization) = false);

//output(filter_terrorist_exclusions, named('filter_terrorist_exclusions'));


Layout_State_Dept_Terrorist_Exclusions_seq := record
string sequence;
Layout_State_Dept_Terrorist_Exclusions.layout_Terrorist_Exclusions;
string remarks_1;
end;


Layout_State_Dept_Terrorist_Exclusions_seq
                               tr_add_sequence(filter_terrorist_exclusions l, integer c) := TRANSFORM

Organization := map(regexfind('Pakistan and Afghanistan offices',l.Organization) 
                        => regexreplace('(.*)(~)(.*)(~)',
												         regexreplace('\\)',regexreplace('\\(',l.Organization,'~'),'~')
																							     ,'$1'), l.Organization);			
																									 
remarks := map(regexfind('Pakistan and Afghanistan offices',l.Organization) 
                        => regexreplace('(.*)(~)(.*)(~)',
												         regexreplace('\\)',regexreplace('\\(',l.Organization,'~'),'~')
																							     ,'$3'), '');		
																									 
self.sequence := (string) c;
//self.Organization := l.Organization;
self.Organization := Organization;
self.aka := StringLib.StringFindReplace(
               StringLib.StringFindReplace(l.aka,'a.k.a.','~'),'f.k.a.','~');
									// ~ will be used for normalizer/parsing. 
self.remarks_1 := remarks; 

end;              // Tilda works better than pipe for in regex for parsing.

add_sequence := PROJECT(filter_terrorist_exclusions,tr_add_sequence(left,counter));
//output(choosen(add_sequence,all), named('add_sequence'));

//////******** count tilda marks 
layout_add_count_tilda_marks := record
integer count_tilda_marks;
Layout_State_Dept_Terrorist_Exclusions_seq;
end;

layout_add_count_tilda_marks  tr_add_count_tilda_marks (add_sequence l ) := TRANSFORM

aka_slim := map(StringLib.StringFindCount(l.aka ,'~') < 15
                         => l.aka,
												    l.aka[1..StringLib.StringFind(l.aka,'~',16)-1]);

self.sequence := l.sequence;
self.count_tilda_marks := StringLib.StringFindCount(aka_slim ,'~');
self.aka := aka_slim;
self.organization := l.organization;
self.remarks_1 := l.remarks_1;
end;

ds_count_tilda_marks  := PROJECT(add_sequence,tr_add_count_tilda_marks (left));

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
self :=l;															 
															 
end;

Norm_aka :=
     normalize(ds_normalizer_fire_count,left.normalizer_fire_count,NormIt(left,counter));
//output(Norm_aka);

Layout_State_Dept_Terrorist_Exclusions.layout_names_and_AKAS 
                                       tr_primary_names(Norm_aka l ) := TRANSFORM
self.sequence := l.sequence;
//self.name := l.organization; 
self.name := regexreplace('"',l.organization,'');
self.name_type := 'Primary';
self.remarks_1 := l.remarks_1;
end;

primary_names := PROJECT(Norm_aka,tr_primary_names (left));
//output(choosen(primary_names,all), named('primary_names'));

Layout_State_Dept_Terrorist_Exclusions.layout_names_and_AKAS 
                                 tr_AKAs_names(Norm_aka l ) := TRANSFORM
self.sequence := l.sequence;
self.name :=  trim(regexreplace(',|;',l.aka_normalized,''),left,right);
self.name_type := 'AKA';
self.remarks_1 := l.remarks_1;
end;

AKAs_names := PROJECT(Norm_aka,tr_AKAs_names (left));
//output(AKAs_names, named('AKAs_names'));

dedup_sort_primary_name := dedup(sort(primary_names,sequence,name),sequence,name);
dedup_sort_AKAs_names := dedup(sort(AKAs_names,sequence,name),sequence,name);

concat_primary_AKAs := dedup_sort_primary_name + dedup_sort_AKAs_names(name <> '');

Patriot_preprocess.layout_patriot_common tr_patriot_common(concat_primary_AKAs l ) := TRANSFORM


left_pad_with_zeros := map(length((string)l.sequence) = 1 => '00',
                           length((string)l.sequence) = 2 => '0', '');

pty_key := 'SDTE' + trim(left_pad_with_zeros,left,right) + (string)l.sequence;

//self.pty_key := 'SDTE' + l.sequence;
self.pty_key := pty_key;
self.source := 'State Department Terrorist Exclusions';
self.orig_pty_name := l.Name;
self.name_type := l.name_type;
self.entity_flag := 'Y';  
self.remarks_1 := l.remarks_1;
self := [];
end;

patriot_common := PROJECT(concat_primary_AKAs,tr_patriot_common (left));
//output(choosen(patriot_common, all),named('patriot_common_individual'));

EXPORT Mapping_State_Dept_Terrorist_Exclusions := patriot_common
         : persist('~thor::persist::out::patriot::preprocess::State_Dept_Terrorist_Exclusions');