
#OPTION('multiplePersistInstances',false);

BankOfEngland	:= 	DATASET('~thor::in::globalwatchlists::bank_of_england', 
                               	     Layout_Bank_of_England.Layout_sanctionsconlist, CSV(separator(';'),heading(2),terminator(['\n', '\r\n'])));	

//output(BankOfEngland);

Layout_Bank_of_England.Layout_sanctionsconlist tr_Reformat_DOB_Values(BankOfEngland L) := TRANSFORM

get_YYYYMMDD_format := 
				intformat((integer2)regexreplace('.*/.*/([0-9]+)',l.dob,'$1'),4,1)
			+ intformat((integer1)regexreplace('.*/([0-9]+)/.*',l.dob,'$1'),2,1)
			+ intformat((integer1)regexreplace('([0-9]+)/.*/.*',l.dob,'$1'),2,1);
			
get_MM_slash_DD_slash_YYYY_format	:= 	get_YYYYMMDD_format[5..6] + '/' + get_YYYYMMDD_format[7..8] + '/' + get_YYYYMMDD_format[1..4]; 

self.DOB := if(l.dob[1..1] <> '0' and L.DOB <> '', get_MM_slash_DD_slash_YYYY_format,l.dob);
self := l;
end;
		
Reformat_DOB_Values := PROJECT(BankOfEngland,tr_Reformat_DOB_Values(left));

Layout_Bank_of_England.layout_clean_up  tr_clean_up(Reformat_DOB_Values L) := TRANSFORM
self.ent_key := 'BES' + trim(l.Group_ID);
self.source := 'Bank of England Sanctions';
self.lstd_entity := 
               trim( //if(trim(l.Title) <> '', trim(l.Title) + ' ','') +
							      if(trim(l.Name_1) <> '', trim(l.Name_1) + ' ','')
									+	if(trim(l.Name_2) <> '', trim(l.Name_2) + ' ','')
                  +	if(trim(l.Name_3) <> '', trim(l.Name_3) + ' ','')
                  +	if(trim(l.Name_4) <> '', trim(l.Name_4) + ' ','')
                  +	if(trim(l.Name_5) <> '', trim(l.Name_5) + ' ','')
                  +	if(trim(l.Name_6) <> '', trim(l.Name_6) + ' ',''));


self.first_name :=  if(trim(l.Name_1) <> '', trim(l.Name_1) + ' ','')
                  + if(trim(l.Name_2) <> '', trim(l.Name_2) + ' ','')
									+ if(trim(l.Name_3) <> '', trim(l.Name_3) + ' ','')
									+ if(trim(l.Name_4) <> '', trim(l.Name_4) + ' ','')
									+ if(trim(l.Name_5) <> '', trim(l.Name_5) + ' ','');
self.last_name := trim(l.Name_6);
self.title := trim(l.Title);
self.dob := StringLib.StringFindReplace(
                          StringLib.StringFindReplace(
													     StringLib.StringFindReplace(l.dob, '0/0/0', ''), '0/0/', ''), '/0/', '/');

self.Town_of_Birth := if(length(l.Town_of_Birth) > 225, regexreplace('Province',l.Town_of_Birth,'Prov'), 
                             trim(l.Town_of_Birth));
self.Country_of_Birth := trim(l.Country_of_Birth);
self.Nationality := trim(l.Nationality);;
self.Passport_Details := trim(l.Passport_Details);
self.NI_Number := trim(l.NI_Number)[1..125];
self.position := if(length(l.Position) < 120,
                        trim(regexreplace('as well as Ministry',
												 regexreplace(' and ZANU',
												//	 regexreplace(' (ZANU (',
													   regexreplace(', ZANU',
													    regexreplace('. Possibly',
														 //  regexreplace(') and',
												        regexreplace(' and the ',l.Position,' (2) '),
																  // '(2) and'),
																		 '(2) Possibly'),
																		   '(2) ZANU'),
																		   //  ' (2) ZANU ('),
																				   ' (2) ZANU'),
																				  	    '(2) Minister.')),
																		trim(regexreplace(' and ',
																		  regexreplace('as well as Ministry',
																			   regexreplace(' and ZANU',
																				//   regexreplace(' (ZANU (',
																					   regexreplace(', ZANU',
																						   regexreplace('. Possibly',
																							  // regexreplace(') and',
																								   regexreplace(' and the ',l.Position,' (2) '), 
																									  //   '(2) and'),
																											  '(2) Possibly'),
																											   '(2) ZANU'),
																											   // ' (2) ZANU ('),
																											     ' (2) ZANU'),
																											      '(2) Minister.'),
																											       ' & ')));
self.Address_1 := trim(l.Address_1);
self.Address_2 := trim(l.Address_2);
self.Address_3 := trim(l.Address_3);
self.Address_4 := trim(l.Address_4);
self.Address_5 := trim(l.Address_5);
self.Address_6 := trim(l.Address_6);
self.Post_Zip_Code := regexreplace('[(].+[)]', l.Post_Zip_Code, '');
self.Country :=  trim(l.Country);
self.address_addl_info := trim(l.Other_Information);
self.Group_Type := trim(l.Group_Type);
self.alias_type := trim(l.Alias_Type);
self.Regime := trim(l.Regime);
self.Group_ID := trim(l.Group_ID); 
self.lf := '\n';
end;

ds_map_to_old := PROJECT(Reformat_DOB_Values,tr_clean_up(LEFT));

Patriot_preprocess.layout_patriot_common tr_patriot_common(ds_map_to_old l ) := TRANSFORM

position_remarks := if(trim(l.position) <> '','; Position: ' + trim(l.position), '');
dob_remarks := if(trim(StringLib.StringFindReplace(trim(l.dob),'/  /','')) <> '', trim('; Date of Birth: ' + trim(l.dob)), '');
Town_of_Birth_remarks := if(trim(l.Town_of_Birth) <> '', trim('; Town of Birth: ' + trim(l.Town_of_Birth)), '');
Country_of_Birth_remarks := if(trim(l.Country_of_Birth) <> '', trim('; Country of Birth: ' + trim(l.Country_of_Birth)), '');
Nationality_remarks := if(trim(l.Nationality) <> '', trim('; Nationality: ' + trim(l.Nationality)), '');
Passport_Details_remarks := if(trim(l.Passport_Details) <> '', trim('; Passport Details: ' + trim(l.Passport_Details)), '');

NI_Number_remarks := if(l.NI_Number <> '' and regexfind('SSN ',l.NI_Number) = false, trim('; NI Number: ' + trim(l.NI_Number)),
                       if(l.NI_Number <> '' and regexfind('SSN ',l.NI_Number) = true,
                         trim('; NI Number: ' + 
												      StringLib.StringFindReplace(StringLib.StringFindReplace(trim(l.NI_Number)
                                  ,'SSN ...-..-....'   // is this parsing correct?
                                      ,'&%%%%')
                                        ,'....%%%%'
                                          ,'xxxx')),''));  

Regime_remarks := if(l.Regime <> '', trim('; Regime: ' + trim(l.Regime)), '');                                     
address_addl_info_remarks := if(l.address_addl_info <> '', trim('; Other Information: ' + trim(l.address_addl_info)), '');   
Regime_Title := if(l.Title <> '', trim('; Title: ' + trim(l.Title)), ''); 

   concat_remarks :=  
	                   position_remarks +
	                   dob_remarks +
										 Town_of_Birth_remarks +
										 Country_of_Birth_remarks +
										 Nationality_remarks +
										 Passport_Details_remarks +
										 NI_Number_remarks +
										 Regime_remarks +
										 address_addl_info_remarks +
										 Regime_Title;
										 
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
	remarks15 := concat_remarks_clean[1051..1125];
	remarks16 := concat_remarks_clean[1126..1200];
	remarks17 := concat_remarks_clean[1201..1275];
	remarks18 := concat_remarks_clean[1276..1350];
	remarks19 := concat_remarks_clean[1351..1425];
	remarks20 := concat_remarks_clean[1426..];

  addr1 := trim(trim(l.Address_1) + ' '+ trim(l.Address_2));
  addr2 := trim(trim(l.Address_3) + ' ' + trim(l.Address_4));
  addr3 := trim(
	         if(l.Address_5 <> '', trim(l.Address_5) + ' ', '') +
	         if(l.Address_6 <> '', trim(l.Address_6) + ' ', '') +
					 if(l.Post_Zip_Code <> '', trim(l.Post_Zip_Code) + ' ', '') +
					 if(l.Country <> '', trim(l.Country) + ' ', ''));	
	
  addr_1 := map(addr1 <> '' => addr1,
	              addr2 <> '' => addr2, 
								addr3 <> '' => addr3, ''); 
												
  addr_2 := map(addr1 <> '' and addr2 <> '' => addr2,
	              addr1 <> '' and addr2 = '' and addr3 <> '' => addr3,
								addr1 = '' and addr2 <> '' and addr3 <> '' => addr3,
	                      '');
	
  addr_3 := map(addr1 <> '' and  addr2 <> '' and addr3 <> '' => addr3,	'');	


self.pty_key := l.ent_key;
self.source := l.source;
self.orig_pty_name := l.lstd_entity;
self.country := l.Country;
self.name_type := if(regexfind('PRIME',StringLib.StringToUpperCase(l.alias_type))= false, l.alias_type,'');
self.addr_1 := addr_1;
self.addr_2 := addr_2;
self.addr_3 := addr_3;
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
self.remarks_15 := remarks15;
self.remarks_16 := remarks16;
self.remarks_17 := remarks17;
self.remarks_18 := remarks18;
self.remarks_19 := remarks19;
self.remarks_20 := remarks20;	
self.entity_flag := map(l.Group_Type = 'Entity' => 'Y', '');

self := []
end;

patriot_common := PROJECT(ds_map_to_old,tr_patriot_common(left));

EXPORT Mapping_Bank_of_England := patriot_common
                      : persist('~thor::persist::out::patriot::preprocess::Bank_of_England');

