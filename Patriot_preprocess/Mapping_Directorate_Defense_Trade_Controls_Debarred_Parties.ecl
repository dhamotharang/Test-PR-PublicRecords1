
 


Debarred_Parties := DATASET('~thor::in::globalwatchlists::debarred_parties', 
                              Layout_Directorate_Defense_Trade_Controls_Debarred_Parties.layout_Debarred_Parties, 
														   CSV(separator('\t'),quote('"'),terminator(['\n', '\r\n']),heading(1)));	

//output(Debarred_Parties, named('Debarred_Parties'));



Layout_Directorate_Defense_Trade_Controls_Debarred_Parties_seq := record
string sequence;
string primary_name;
string aka_name;
Layout_Directorate_Defense_Trade_Controls_Debarred_Parties.layout_Debarred_Parties;
end;


Layout_Directorate_Defense_Trade_Controls_Debarred_Parties_seq
                               tr_add_sequence(Debarred_Parties l, integer c) := TRANSFORM

position_first_AKA := StringLib.StringFind(
                           StringLib.StringToUpperCase(l.name_info),'(AKA',1);

primary_name := map(position_first_AKA = 0
                     => l.name_info,   
                          trim(l.name_info[1..position_first_AKA - 1],left,right)
													  ); 
aka_names := map(position_first_AKA = 0
                 => '',
									trim(l.name_info[position_first_AKA..],left,right)
									 );
									 
aka_add_tilda := trim(StringLib.StringFindReplace(	
                       StringLib.StringFindReplace(								
				                StringLib.StringFindReplace(
												 StringLib.StringFindReplace(
                         StringLib.StringFindReplace(aka_names,'(AKA',''),'(aka',''),')',''),',','~'),';','~'),left,right);														
							       // ~ will be used for normalizer/parsing. Tilda works better.	
										
self.sequence := (string) c;
self.primary_name :=  primary_name;
self.aka_name := aka_add_tilda;
self.dob := regexreplace('Unknown',
              regexreplace('N/A',l.dob,''),'');
self := l;									
end;              

add_sequence := PROJECT(Debarred_Parties,tr_add_sequence(left,counter));
//output(add_sequence, named('add_sequence'));

//////******** count tilda marks 
layout_add_count_tilda_marks := record
integer count_tilda_marks;
Layout_Directorate_Defense_Trade_Controls_Debarred_Parties_seq;
end;

layout_add_count_tilda_marks  tr_add_count_tilda_marks (add_sequence l ) := TRANSFORM

self.sequence := l.sequence;
self.count_tilda_marks := StringLib.StringFindCount(l.aka_name ,'~');
self := l;
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

self.aka_normalized :=  choose(C, regexreplace(aka_format,l.aka_name,'$1'),
											                 regexreplace(aka_format,l.aka_name,'$3'),
											                 regexreplace(aka_format,l.aka_name,'$5'),
											                 regexreplace(aka_format,l.aka_name,'$7'),
											                 regexreplace(aka_format,l.aka_name,'$9'),
											                 regexreplace(aka_format,l.aka_name,'$11'),
											                 regexreplace(aka_format,l.aka_name,'$13'),
											                 regexreplace(aka_format,l.aka_name,'$15'),
											                 regexreplace(aka_format,l.aka_name,'$17'),
											                 regexreplace(aka_format,l.aka_name,'$19'),
													             regexreplace(aka_format,l.aka_name,'$21'),
													             regexreplace(aka_format,l.aka_name,'$23'),	
													             regexreplace(aka_format,l.aka_name,'$25'),	
													             regexreplace(aka_format,l.aka_name,'$27'),	
													             regexreplace(aka_format,l.aka_name,'$29'),	
													             regexreplace(aka_format,l.aka_name,'$31')	
                          		          );
self :=l;											 
end;

Norm_aka :=
     normalize(ds_normalizer_fire_count,left.normalizer_fire_count,NormIt(left,counter));
//output(Norm_aka);


export layout_names_and_AKAS := record
  string sequence;
  string name;
	string name_type;
	string DOB;
  string registration_info;
  string Date;
end;


Layout_Directorate_Defense_Trade_Controls_Debarred_Parties.layout_names_and_AKAS 
                                              tr_primary_names(Norm_aka l ) := TRANSFORM
self.sequence := l.sequence;
self.name := l.primary_name;
self.name_type := 'Primary';
self := l;
end;

primary_names := PROJECT(Norm_aka,tr_primary_names (left));
//output(primary_names, named('primary_names'));

Layout_Directorate_Defense_Trade_Controls_Debarred_Parties.layout_names_and_AKAS 
                                 tr_AKAs_names(Norm_aka l ) := TRANSFORM
self.sequence := l.sequence;
self.name :=  trim(l.aka_normalized,left,right);
self.name_type := 'AKA';
self := l;
end;

AKAs_names := PROJECT(Norm_aka,tr_AKAs_names (left));
//output(AKAs_names, named('AKAs_names'));

dedup_sort_primary_name := dedup(sort(primary_names,sequence,name),sequence,name);
dedup_sort_AKAs_names := dedup(sort(AKAs_names,sequence,name),sequence,name);

concat_primary_AKAs := dedup_sort_primary_name + dedup_sort_AKAs_names(name <> '');

#OPTION('multiplePersistInstances',false);

Patriot_preprocess.layout_patriot_common tr_patriot_common(concat_primary_AKAs l ) := TRANSFORM

left_pad_with_zeros := map(length((string) l.sequence) = 1 => '00',
                           length((string) l.sequence) = 2 => '0', '');

pty_key := 'DTC' + trim(left_pad_with_zeros,left,right) + (string) l.sequence;

self.pty_key := pty_key;
self.source := 'Defense Trade Controls (DTC)Debarred Parties';
self.orig_pty_name := l.Name;
self.name_type := l.name_type;
self.remarks_1 := map(l.registration_info <> '' and l.date <> ''
                     => l.registration_info + ' ' + 'Effective date: ' + l.date,
										     l.registration_info <> '' 
												  => l.registration_info,
													  l.date <> ''
													  => 'Effective date: ' + l.date,
														    '');
self.remarks_2 := map(l.dob <> ''=> 'DOB: ' + l.dob,'');

entity := 'Inc.|Company|Corporation|Logistics|Supply|Aerospace|Incorporated|Technology|Corp.|Ltd.|Associates|International|Services|LLC'; 
self.entity_flag := map(regexfind(entity,l.Name) = true => 'Y','');	

self := [];
end;
 
patriot_common := PROJECT(concat_primary_AKAs,tr_patriot_common (left));
//output(choosen(sort(patriot_common,pty_key), all),named('patriot_common'));

EXPORT Mapping_Directorate_Defense_Trade_Controls_Debarred_Parties := patriot_common
            : persist('~thor::persist::out::patriot::preprocess::Directorate_Defense_Trade_Controls_Debarred_Parties');