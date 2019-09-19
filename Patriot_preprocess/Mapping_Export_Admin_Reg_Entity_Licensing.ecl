
#OPTION('multiplePersistInstances',false);

ds_denied_entity := DATASET('~thor::in::globalwatchlists::denied_entity', 
                                	   Layout_Export_Admin_Reg_Entity_Licensing.layout_denied_entity,CSV(separator('|'),heading(1),TERMINATOR(['\n', '\r\n'])));
	
//output(ds_denied_entity,named('ds_denied_entity'));
	
Layout_Export_Admin_Reg_Entity_Licensing.layout_add_ent_key 
                       tr_add_ent_key(ds_denied_entity l, integer c ) := TRANSFORM
											 

left_pad_with_zeros := map(length((string) c) = 1 => '00',
                           length((string) c) = 2 => '0', '');

pty_key := 'DEL' + trim(left_pad_with_zeros,left,right) + (string) c;											 
											 
self.Ent_Key := pty_key;
self := l;
end;

add_ent_key := PROJECT(ds_denied_entity,tr_add_ent_key (left,counter));


/////***** normalize entities ********

//******* separate entities and addresses 

layout_entities_and_address := record
string entities_only;
string entity_names_no_parse;
string address;
Layout_Export_Admin_Reg_Entity_Licensing.layout_add_ent_key;

end;

layout_entities_and_address  tr_entities_only (add_ent_key l ) := TRANSFORM

pre_clean_entities_1 := trim(StringLib.StringFindReplace(l.entities,'f.k.a.','~a.k.a.'),left,right);


pre_clean_entities_2 :=  Map(
                            regexfind('(.*)(\\(a.k.a., China Academy of Engineering Physics \\(CAEP\\) s 902 Institute\\))(.*)(.*)(>)(.*)',pre_clean_entities_1)
					                  => regexreplace('(.*)(\\(a.k.a., China Academy of Engineering Physics \\(CAEP\\) s 902 Institute\\))(.*)(.*)(>)(.*)',pre_clean_entities_1,'$1$3$4~$2$5$6'),
         
				                    regexfind('(.*)(\\(a.k.a., Planning Department No 1\\))(.*)(>)(.*)',pre_clean_entities_1)
					                  => regexreplace('(.*)(\\(a.k.a., Planning Department No 1\\))(.*)(>)(.*)',pre_clean_entities_1,'$1$3~$2$4$5'),
          
				                    regexfind('(.*)(\\(a.k.a., 35th Research Institute\\))(.*)',pre_clean_entities_1)
					                  => regexreplace('(.*)(\\(a.k.a., 35th Research Institute\\))(.*)',pre_clean_entities_1,'$1~$2$3'),
														
														pre_clean_entities_1);          


//entities_only := map(StringLib.StringFind(l.entities, '>', 1) > 0
entities_only := map(StringLib.StringFind(pre_clean_entities_2, '>', 1) > 0
                        => pre_clean_entities_2[1..StringLib.StringFind(pre_clean_entities_2, '>', 1)-1],pre_clean_entities_2);

entity_names_parse := map(StringLib.StringFind(entities_only, '~', 16) > 0
                        => entities_only[1..StringLib.StringFind(entities_only, '~', 16)-1],
												    entities_only);
												
entity_names_no_parse := map(StringLib.StringFind(entities_only, '~', 16) > 0
															=> entities_only[StringLib.StringFind(entities_only, '~', 16)..], '');												
												
self.entities_only := entity_names_parse;
self.entity_names_no_parse := entity_names_no_parse;	
self.address := map(StringLib.StringFind(l.entities, '>', 1) > 0
                    => trim(l.entities[StringLib.StringFind(l.entities, '>', 1)+1..]),'');										
self := l;										
end;

ds_entities_and_addresses := PROJECT(add_ent_key,tr_entities_only (left));

//output(choosen(ds_entities_and_addresses,all), named('ent_and_add')); 

//////******** count tilda marks 
layout_add_count_tilda_marks := record
integer count_tilda_marks;
layout_entities_and_address;
end;

layout_add_count_tilda_marks  tr_add_count_tilda_marks (ds_entities_and_addresses l ) := TRANSFORM

self.count_tilda_marks := StringLib.StringFindCount(l.entities_only ,'~');
self := l;
end;

ds_count_tilda_marks  := PROJECT(ds_entities_and_addresses,tr_add_count_tilda_marks (left));

//output(ds_count_tilda_marks);

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
string entities_format;
string entity;
string name_type;
layout_add_normalizer_fire_count;
end;

OutRec NormIt(ds_normalizer_fire_count L, integer C) := TRANSFORM

// limit: output(regexreplace('(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)(~)(.*)',
                   //   'n1~n2~n3~n4~n5~n6~n7~n8~n9~n10~n11~12~13~14~15~16','$31'));	
									 
entities_format := trim(map(l.normalizer_fire_count = 1 => '(.*)', 
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
self.entities_format := entities_format;

self.entity :=  choose(C, regexreplace(entities_format,l.entities_only,'$1'),
											    regexreplace(entities_format,l.entities_only,'$3'),
											    regexreplace(entities_format,l.entities_only,'$5'),
											    regexreplace(entities_format,l.entities_only,'$7'),
											    regexreplace(entities_format,l.entities_only,'$9'),
											    regexreplace(entities_format,l.entities_only,'$11'),
											    regexreplace(entities_format,l.entities_only,'$13'),
											    regexreplace(entities_format,l.entities_only,'$15'),
											    regexreplace(entities_format,l.entities_only,'$17'),
											    regexreplace(entities_format,l.entities_only,'$19'),
													regexreplace(entities_format,l.entities_only,'$21'),
													regexreplace(entities_format,l.entities_only,'$23'),	
													regexreplace(entities_format,l.entities_only,'$25'),	
													regexreplace(entities_format,l.entities_only,'$27'),	
													regexreplace(entities_format,l.entities_only,'$29'),	
													regexreplace(entities_format,l.entities_only,'$31')	
                          		 );
															 
self.name_type := choose(C,'',
											    'AKA',
											    'AKA',
											    'AKA',
											    'AKA',
											    'AKA',
											    'AKA',
											    'AKA',
											    'AKA',
											    'AKA',
													'AKA',
													'AKA',	
													'AKA',	
													'AKA',	
													'AKA',	
													'AKA');
															 
end;

Norm_entites :=
     normalize(ds_normalizer_fire_count,left.normalizer_fire_count,NormIt(left,counter));
//output(Norm_entites);

Layout_Export_Admin_Reg_Entity_Licensing.layout_set_name_type  tr_set_name_type(Norm_entites l ) := TRANSFORM

self.Entity := trim(regexreplace('a.k.a',regexreplace('a.k.a.',regexreplace('aka',l.Entity,''),''),''));
                                
self.name_type := l.name_type; 
self.Ent_Key := l.Ent_Key;
self.Country := l.country;
self.Address :=   
       StringLib.StringFindReplace(
			  StringLib.StringFindReplace(
        StringLib.StringFindReplace(
         StringLib.StringFindReplace(
          StringLib.StringFindReplace(l.Address,
                         'Avenue','Ave'),
                            ', ',','),
                             'P.O.', 'PO'),
                              '; and ', ';'),
                                '; ', ';');
																
self.License_Requirement := l.License_Requirement;
self.License_Review_Policy := l.License_Review_Policy;
self.Federal_Register_Citation := l.Federal_Register_Citation;
end;

set_name_type  := PROJECT(Norm_entites,tr_set_name_type (left));
//output(set_name_type);

Filter_empty_entities := set_name_type(Entity <> '');
// output(set_name_type(Entity = ''));
// output(count(set_name_type(Entity = '')));

// output(Filter_empty_entities(regexfind('Hassan Matni Import Export Co.',Entity)));                                                                                                                                                                                                                                                                                                                              
// output(Filter_empty_entities(regexfind('Katrangi Electronics',Entity)));                                                                                                                                                                                                                                                                                                                                        
// output(Filter_empty_entities(regexfind('UM Airlines', Entity)));  
// output(Filter_empty_entities(regexfind('-Fu Jirui', Entity))); 

Patriot_preprocess.layout_patriot_common tr_patriot_common(Filter_empty_entities l) := TRANSFORM

  addr_1 := trim(l.Address,left,right)[1..50];
  addr_2 := trim(l.Address,left,right)[51..100];
  addr_3 := trim(l.Address,left,right)[101..150];
  addr_4 := trim(l.Address,left,right)[151..200];
  addr_5 := trim(l.Address,left,right)[201..250];
	
	
	remarks_1 := if(trim(l.Country,left,right) <> '', 'Country: ' + trim(StringLib.StringFindReplace(l.Country,'Syr Ia','Syria')), '');
  remarks_2 := if(trim(l.License_Requirement,left,right) <> '', '; Licence Requirement: ' + trim(l.License_Requirement), '');
                                            
  remarks_3 := if(trim(l.License_Review_Policy,left,right) <> '', '; License Review Policy: ' + trim(l.License_Review_Policy), '');
                                           
  remarks_4 := if(trim(l.Federal_Register_Citation,left,right) <> '','; Federal Register Citation: ' +
                                                                       trim(l.Federal_Register_Citation), '');
  concat_remarks := remarks_1 + 
	                  remarks_2 + 
										remarks_3 + 
										remarks_4 ;
	
 	remarks1 := concat_remarks[1..75];
  remarks2 := concat_remarks[76..150];
  remarks3 := concat_remarks[151..225];
  remarks4 := concat_remarks[226..300];
  remarks5 := concat_remarks[301..375];
  remarks6 := concat_remarks[376..450];
  remarks7 := concat_remarks[451..525];
	remarks8 := concat_remarks[526..600];
  remarks9 := concat_remarks[601..675];
	remarks10 := concat_remarks[676..750];
	remarks11 := concat_remarks[751..825];	
	remarks12 := concat_remarks[826..900];
	remarks13 := concat_remarks[901..975];
	remarks14 := concat_remarks[976..1050];
	
	// clean_Entity := 
           // map(regexfind('(, )(.*)',l.Entity) 
					      // => regexreplace('(, )(.*)', l.Entity,'$2'),
									  // regexfind('(-)(.*)',l.Entity) 
					           // => regexreplace('(-)(.*)', l.Entity,'$2'),
										      // regexfind('(\\()(.*)',l.Entity) 
					                 // => regexreplace('(\\()(.*)', l.Entity,'$2'),	
	                                // l.Entity);	
	
	
  entity_string1 := 'Company|Computer|IT solutions|Construction|Ltd|Technol|offices|Foundation|Material|Testing|Laboratory|International|LLC|Airline|Electronics|Research|Factory|Canada|Instruments|America|Inc|Enterprise|Corporation|tech|Tech|Solutions|Group|Corporation|China|Academy|';                                                                                                                                                                                                                                                                                                            
	
	entity_string2 := 'Automation|Control|Equipment|Institute|Radio|Automat|Nuclear|Energy|Facility|Engineering|Beijing|University|Aeronautics|Astronautics|Comput|North|East|South|West|';                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                  
  entity_string3 := 'Planning Department No 1|Corporacion|Nacional|Telecommunicaciones|Trading|Action|Global|Co.|Limited|Elecomponents|Industries|Product|Industry|System|Tehran|Complex|Industrial|Air|Sky|Limited|Aviation|Nigeria|System|';                                                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                 
  entity_string4 := '&|Logistic|Holding|Import|Export|Service|GMBH|Motors|Property|Satellite|People|Institut|GSKB|Academ|MSDB|NPP|Kompaniya|Center|NPO|Instrument|Electron|Transport|APEX|Nation|Scien|';                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                       
  entity_string5 := 'dustriels|ky One FZE|MEC|Leasing|One Net|Zener Marine|Zener Lebanon|Plant|LLP|Resources|OAO|Video|Logic|Solution|UVZ|UCB|Transsphere|Transoil|Oil|TTSN|OAO|OJSC|Surgutneftegas|OJSC|Specelkom|VP|OOO|STGH|SM Way Oy|SGM|SADAF|Russian|Cargo|Power|Rosneft|Otkrytoe Aktsionernoe|Olkerboy Oy|Obshchestvo|';
  
	entity_string6 := 'Shanghai|Bureau|Space|HWA|GBNTT|Electric|Department|CJSC|Zest|JSC|Uralvagonzavod|FZE|HWA|the following nine aliases|Sanatorium Nizhnyaya Oreanda|ZTE Parsian|ZAO Vankorneft|YuzhnoKirinskoye Field|Port|Merchant|Film|Unimont|Novy Svet Winery|Novokuibyshevsk Refinery|Nova SPB|Noun Nasreddine|Noor Muhammad Market|Maples SA|MaksiTekhGrup|Magnetar|MPEG|MCES|Indian Rare Earths|Universal|Engineer Idris|Chelyabinsk70|CETC|Aerostar Asset Management FZC|Refinery';
  
	
	concat_entity := entity_string1 + entity_string2 + entity_string3 + entity_string4 + entity_string5 + entity_string6;  
	
	
  self.pty_key := l.Ent_Key;
  self.source := 'US Bureau of Industry and Security - Denied Entity List';
 // self.orig_pty_name := trim(StringLib.StringFindReplace(l.Entity,'People s','People\'s'),left,right);
  self.orig_pty_name := map(l.Entity[1..2] in ['(,',' ,',' -'] => trim(l.Entity[3..],left,right),
	                          l.Entity[1..1] in [',','-','('] => trim(l.Entity[2..],left,right),	                     
	                               trim(l.Entity,left,right));
	
  self.orig_vessel_name := '';
  self.country := trim(StringLib.StringFindReplace(l.Country,'Syr Ia','Syria'),left,right);
  self.name_type := trim(l.name_type,left,right);	
  self.addr_1 := addr_1;
	self.addr_2 := addr_2;
	self.addr_3 := addr_3;
	self.addr_4 := addr_4;
	self.addr_5 := addr_5;		
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
	self.entity_flag := map(regexfind(concat_entity,l.Entity,nocase) = true => 'Y','');		

	self := [];	
end;

patriot_common := PROJECT(Filter_empty_entities,tr_patriot_common(left));

EXPORT Mapping_Export_Admin_Reg_Entity_Licensing := patriot_common
          : persist('~thor::persist::out::patriot::preprocess::Export_Admin_Reg_Entity_Licensing');
