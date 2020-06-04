
#OPTION('multiplePersistInstances',false);

foreign_terrorists := DATASET('~thor::in::globalwatchlists::state_department_terrorist', 
                              Layout_State_Dept_Foreign_Terrorist_Orgs.layout_foreign_terrorists, 
														   CSV(separator('|'),quote('"'),terminator(['\n', '\r\n'])
															                                             //,heading(1)
																																					       ));
														 
//output(foreign_terrorists, named('foreign_terrorists'));

filter_foreign_terrorists := foreign_terrorists
                                  (Organization <> '' and regexfind('Loading /data_999/sanctions/data/state_department/' + '|' +
																												      'Orignal Filename' + '|' +
																												      'Number of Sheets' + '|' +
																												      'Author' + '|' +
																											      	'Writing Sheet number' + '|' +
																												      'Minrow=0 Maxrow', Organization) = false);

//output(filter_foreign_terrorists, named('filter_terrorist_exclusions'));

Layout_State_Dept_Foreign_Terrorist_Orgs_seq := record
string sequence;
Layout_State_Dept_Foreign_Terrorist_Orgs.layout_foreign_terrorists;
end;

Layout_State_Dept_Foreign_Terrorist_Orgs_seq
                               tr_add_sequence(filter_foreign_terrorists l, integer c) := TRANSFORM

self.sequence := (string) c;
self.Organization := l.Organization;
self.aka := l.aka;									
end;              

add_sequence := PROJECT(filter_foreign_terrorists,tr_add_sequence(left,counter));
//output(add_sequence, named('add_sequence'));

Layout_State_Dept_Foreign_Terrorist_Orgs.layout_names_and_AKAS 
                                       tr_primary_names(add_sequence l ) := TRANSFORM
self.sequence := l.sequence;
self.name := l.organization;
self.name_type := 'Primary';
end;

primary_names := PROJECT(add_sequence,tr_primary_names (left));
//output(primary_names, named('primary_names'));

Layout_State_Dept_Foreign_Terrorist_Orgs.layout_names_and_AKAS 
                                 tr_AKAs_names(add_sequence l ) := TRANSFORM
self.sequence := l.sequence;
self.name :=  StringLib.StringFindReplace(StringLib.StringFindReplace(l.aka,'(',''),')','');
self.name_type := 'AKA';
end;

AKAs_names := PROJECT(add_sequence,tr_AKAs_names (left));
//output(AKAs_names, named('AKAs_names'));

dedup_sort_primary_name := dedup(sort(primary_names,sequence,name),sequence,name);
dedup_sort_AKAs_names := dedup(sort(AKAs_names,sequence,name),sequence,name);

concat_primary_AKAs := dedup_sort_primary_name(name <> '') + dedup_sort_AKAs_names(name <> '');

Patriot_preprocess.layout_patriot_common tr_patriot_common(concat_primary_AKAs l ) := TRANSFORM

self.pty_key := 'SDFTO' + l.sequence;
self.source := 'State Department Foreign Terrorist Organizations';
self.orig_pty_name := l.Name;
self.name_type := l.name_type;
self.entity_flag := 'Y';  
self := [];
end;

patriot_common := PROJECT(concat_primary_AKAs,tr_patriot_common (left));
//output(choosen(patriot_common, all),named('patriot_common_individual'));

EXPORT Mapping_State_Dept_Foreign_Terrorist_Orgs := patriot_common
         : persist('~thor::persist::out::patriot::preprocess::State_Dept_Foreign_Terrorist_Orgs');