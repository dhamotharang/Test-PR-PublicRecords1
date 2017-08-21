import ut,address;

pattern letter := pattern('[A-Z]');
pattern number := pattern('[1-9][0-9]*');
pattern anychr := pattern('[A-Z0-9]');
pattern ws := ' '+;
pattern word := repeat(letter,2,any);

pattern primdir := (('N' or 'S' or 'E' or 'W') opt('.')) or 'NORTH' or 'SOUTH' or 'EAST' or 'WEST';
pattern secdir := 'NE' or 'SE' or 'SW' or 'NW' or 'N.E.' or 'S.E.' or 'S.W.' or 'N.W.' or 'NORTHEAST' or 'SOUTHEAST' or 'NORTHWEST' or 'SOUTHWEST' or 'N E' or 'S E' or 'S W' or 'N W';
pattern strdir := primdir or secdir;
pattern poststrtype := (('ST' or 'RD' or ('AV' opt('E')) or 'CT' or ('DR' opt('V')) or 'PL' or 'LN' or 'BLVD' or 'CIR' or 'TERR') opt('.')) or 'WAY' or 'ROAD' or 'CIRCLE' or 'TERRACE' or 'LOOP' or 'STREET' or 'AVENUE' or 'COURT' or 'DRIVE' or 'PLACE' or 'PARKWAY' or 'LANE' or 'HIGHWAY' or 'FREEWAY' or 'EXPRESSWAY' or 'PATH' or 'PASS' or 'TRAIL' or 'PLAZA' or 'SQUARE' or 'PIKE' or 'TURNPIKE' or 'RUN' or 'ROW' or 'CURVE' or 'BOULEVARD' or 'TRACE' or 'PARK';
pattern prestrtype := ('AVENUE' or ('AV' opt('E') opt('.')) or 'PASEO' or 'CALLE' or 'VIA' or 'AVENIDA' or ('AVDA' opt('.')) or 'CAMINO' or 'PLACITA' or 'RUE');
pattern highwaytype := opt('OLD' ws) (('US' ws 'HIGHWAY') or ('US' ws 'HWY') or ('STATE' ws 'HIGHWAY') or ('STATE' ws 'HWY') or 'HWY' or ('STATE' ws 'ROUTE') or ('STATE' ws 'ROAD') or ('COUNTY' ws 'ROAD') or 'HIGHWAY' or ('COUNTY' ws 'RD') or ('CO' ws 'RD'));
pattern poststrname := (((opt(('L' or 'D' or 'O') '\'') word) or 'MT.' or 'ST.') repeat(ws ((opt(('L' or 'D' or 'O') '\'') word) or 'MT.' or 'ST.'))) or (number ('ST' | 'ND' | 'RD' | 'TH')) or letter or (word ws letter opt('.') ws word) or (number ws 'MILE') or ('"' letter '"');
pattern prestrname := (word repeat(ws word)) or letter or (word ws letter opt('.') ws word) or ('"' letter '"');
pattern highwaynum := number opt(opt('-') letter);
pattern notypestr := 'BROADWAY';
pattern predir := strdir;
pattern strname := (poststrname ws poststrtype) or (prestrtype ws prestrname) or (highwaytype ws highwaynum) or notypestr;
pattern postdir := strdir;
pattern unittype := (('APT' or 'STE' or 'FL' or 'BLDG' or 'TRLR' or 'SP') opt('.')) or 'UNIT' or 'SPACE' or 'LOT' or 'BOX' or 'SUITE';
pattern unitnum := repeat(anychr,1,any) opt('-' repeat(anychr,1,any));
pattern housenum := number opt(('-' number) or (opt('-') letter) or (('-' or ws) '1/2'));
pattern roadway := (opt(predir ws) strname opt(opt(',') ws postdir)) or (predir ws number ws postdir);
pattern subunit := (((unittype ws opt('#' opt(ws))) or ('#' opt(ws))) unitnum) or 'LOWR' or 'UPPR' or 'FRNT' or 'REAR' or 'BSMT';
pattern boxnum := pattern('[1-9A-Z]') repeat(anychr);

pattern straddr := housenum ws roadway opt((',' or (opt(',') ws)) subunit);
pattern pobox := (('PO' ws 'BOX') or 'BOX' or ('P' ws 'O' ws 'BOX') or ('POST' ws 'OFFICE' ws 'BOX') or ('P.O.' ws 'BOX') or ('P.' ws 'O.' ws 'BOX') or 'POB' or 'P.O.B.') ws boxnum;

pattern city := opt(primdir ws) opt('FT' opt('.') ws) opt('MT' opt('.') ws) opt('ST' opt('.') ws) opt(('L' or 'O' or 'D') '\'') word repeat(('-' or ws) opt(('L' or 'O' or 'D') '\'') word);
pattern state := 'AK' | 'HI' | 'WA' | 'OR' | 'CA' | 'MT' | 'ID' | 'NV' | 'WY' | 'AZ' |
                 'CO' | 'UT' | 'NM' | 'ND' | 'SD' | 'NE' | 'OK' | 'TX' | 'MN' | 'WI' |
								 'IA' | 'IL' | 'MO' | 'IN' | 'AR' | 'LA' | 'MI' | 'OH' | 'KY' | 'TN' |
								 'AL' | 'MS' | 'FL' | 'GA' | 'SC' | 'NC' | 'VA' | 'WV' | 'MD' | 'DC' |
								 'ME' | 'VT' | 'NH' | 'RI' | 'CT' | 'MA' | 'NY' | 'PA' | 'NJ' | 'DE' | 'KS';
pattern zip := pattern('[0-9]{5}') opt(opt('-') pattern('[0-9]{4}'));

pattern addressrule := straddr or pobox;
pattern cszrule := city ((opt(',') ws) or ',') state ((opt(',') ws) or ',') zip;

pattern completerule := addressrule ((opt(',') ws) or ',') cszrule;

Layout_WholeLobbyistAddress := record
  Joined_Lobbyists;
	string Lobbyist_Address_Whole_Delivery := matchtext(addressrule);
	string Lobbyist_Address_Whole_CSZLine := matchtext(cszrule);
end;

RecordsWithSplitLobbyistAddress := parse(Joined_Lobbyists,Lobbyist_Address_Whole,completerule,Layout_WholeLobbyistAddress,noscan,best,not matched,nocase);

Layout_WholeFirmAddress := record
  RecordsWithSplitLobbyistAddress;
	string Firm_Address_Whole_Delivery := matchtext(addressrule);
	string Firm_Address_Whole_CSZLine := matchtext(cszrule);
end;

RecordsWithSplitFirmAddress := parse(RecordsWithSplitLobbyistAddress,Firm_Address_Whole,completerule,Layout_WholeFirmAddress,noscan,best,not matched,nocase);

Layout_WholeAssociationAddress := record
  RecordsWithSplitFirmAddress;
	string Association_Address_Whole_Delivery := matchtext(addressrule);
	string Association_Address_Whole_CSZLine := matchtext(cszrule);
end;

RecordsWithSplitAssociationAddress := parse(RecordsWithSplitFirmAddress,Association_Address_Whole,completerule,Layout_WholeAssociationAddress,noscan,best,not matched,nocase);

Layout_Lobbyists_Common CleanLobbyists(Layout_WholeAssociationAddress InputRecord) := transform
	string73 tempLobbyistName := stringlib.StringToUpperCase(if(trim(InputRecord.Lobbyist_Name_Full,left,right) <> '',
	                                address.CleanPerson73(trim(InputRecord.Lobbyist_Name_Full,left,right)),
																	if(trim(trim(InputRecord.Lobbyist_Name_First,left,right) + ' ' +
																	        trim(InputRecord.Lobbyist_Name_Middle,left,right) + ' ' +
																					trim(InputRecord.Lobbyist_Name_Last,left,right) + ' ' +
																					trim(InputRecord.Lobbyist_Name_Suffix,left,right),left,right) <> '',
																	   address.CleanPerson73(trim(trim(InputRecord.Lobbyist_Name_First,left,right) + ' ' +
																	                                                 trim(InputRecord.Lobbyist_Name_Middle,left,right) + ' ' +
																					                                         trim(InputRecord.Lobbyist_Name_Last,left,right) + ' ' +
																					                                         trim(InputRecord.Lobbyist_Name_Suffix,left,right),left,right)),
																		 '')));
	string182 tempLobbyistAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Lobbyist_Address_CSZ_Line <> '',
																						address.CleanAddress182(trim(InputRecord.Lobbyist_Address_Street_Line,left,right),
	                                                                                     trim(InputRecord.Lobbyist_Address_CSZ_Line,left,right)),
																						if(InputRecord.Lobbyist_Address_Street_Line <> '' or
																						   InputRecord.Lobbyist_Address_City <> '' or
																							 InputRecord.Lobbyist_Address_State <> '' or
																							 InputRecord.Lobbyist_Address_ZIP <> '',
																							 address.CleanAddress182(trim(InputRecord.Lobbyist_Address_Street_Line,left,right),
																							                                            trim(trim(InputRecord.Lobbyist_Address_City,left,right) + ', ' +
																																													     trim(InputRecord.Lobbyist_Address_State,left,right) + ' ' +
																																															 trim(InputRecord.Lobbyist_Address_ZIP,left,right),left,right)),
																							 if(InputRecord.Lobbyist_Address_Whole_Delivery <> '' or
																							    InputRecord.Lobbyist_Address_Whole_CSZLine <> '',
																									address.CleanAddress182(trim(InputRecord.Lobbyist_Address_Whole_Delivery,left,right),
																									                                           trim(InputRecord.Lobbyist_Address_Whole_CSZLine,left,right)),
																									''))));
	string182 tempFirmAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Firm_Address_CSZ_Line <> '',
																				address.CleanAddress182(trim(InputRecord.Firm_Address_Street_Line,left,right),
	                                                                                 trim(InputRecord.Firm_Address_CSZ_Line,left,right)),
																				if(InputRecord.Firm_Address_Street_Line <> '' or
																				   InputRecord.Firm_Address_City <> '' or
																					 InputRecord.Firm_Address_State <> '' or
																					 InputRecord.Firm_Address_ZIP <> '',
																					 address.CleanAddress182(trim(InputRecord.Firm_Address_Street_Line,left,right),
																					                                            trim(trim(InputRecord.Firm_Address_City,left,right) + ', ' +
																																											     trim(InputRecord.Firm_Address_State,left,right) + ' ' +
																																													 trim(InputRecord.Firm_Address_ZIP,left,right),left,right)),
																					 if(InputRecord.Firm_Address_Whole_Delivery <> '' or
																					    InputRecord.Firm_Address_Whole_CSZLine <> '',
																							address.CleanAddress182(trim(InputRecord.Firm_Address_Whole_Delivery,left,right),
																							                                           trim(InputRecord.Firm_Address_Whole_CSZLine,left,right)),
																							''))));
	string182 tempAssociationAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Association_Address_CSZ_Line <> '',
															        				 address.CleanAddress182(trim(InputRecord.Association_Address_Street_Line,left,right),
	                                                                                        trim(InputRecord.Association_Address_CSZ_Line,left,right)),
																				       if(InputRecord.Association_Address_Street_Line <> '' or
																				          InputRecord.Association_Address_City <> '' or
																					        InputRecord.Association_Address_State <> '' or
																					        InputRecord.Association_Address_ZIP <> '',
																					        address.CleanAddress182(trim(InputRecord.Association_Address_Street_Line,left,right),
																					                                                   trim(trim(InputRecord.Association_Address_City,left,right) + ', ' +
																																											            trim(InputRecord.Association_Address_State,left,right) + ' ' +
																																													        trim(InputRecord.Association_Address_ZIP,left,right),left,right)),
																							    if(InputRecord.Association_Address_Whole_Delivery <> '' or
																							       InputRecord.Association_Address_Whole_CSZLine <> '',
																									   address.CleanAddress182(trim(InputRecord.Association_Address_Whole_Delivery,left,right),
																									                                              trim(InputRecord.Association_Address_Whole_CSZLine,left,right)),
																									   ''))));
	string73 tempAssociationContactName := stringlib.StringToUpperCase(if(trim(InputRecord.Association_Contact_Name_Full,left,right) <> '',
	                                          address.CleanPerson73(trim(InputRecord.Association_Contact_Name_Full)),
																						if(trim(trim(InputRecord.Association_Contact_Name_First,left,right) + ' ' +
																						        trim(InputRecord.Association_Contact_Name_Last,left,right),left,right) <> '',
																						   address.CleanPerson73(trim(trim(InputRecord.Association_Contact_Name_First,left,right) + ' ' +
																						                                                 trim(InputRecord.Association_Contact_Name_Last,left,right),left,right)),
																							 '')));
	self.Lobbyist_Name_Clean_title			:= tempLobbyistName[1..5];
	self.Lobbyist_Name_Clean_fname			:= tempLobbyistName[6..25];
	self.Lobbyist_Name_Clean_mname			:= tempLobbyistName[26..45];
	self.Lobbyist_Name_Clean_lname			:= tempLobbyistName[46..65];
	self.Lobbyist_Name_Clean_name_suffix	:= tempLobbyistName[66..70];
	self.Lobbyist_Name_Clean_cleaning_score	:= tempLobbyistName[71..73];
	self.Lobbyist_Address_Clean_prim_range  := tempLobbyistAddressReturn[1..10];
	self.Lobbyist_Address_Clean_predir 	    := tempLobbyistAddressReturn[11..12];
	self.Lobbyist_Address_Clean_prim_name 	:= tempLobbyistAddressReturn[13..40];
	self.Lobbyist_Address_Clean_addr_suffix := tempLobbyistAddressReturn[41..44];
	self.Lobbyist_Address_Clean_postdir 	:= tempLobbyistAddressReturn[45..46];
	self.Lobbyist_Address_Clean_unit_desig 	:= tempLobbyistAddressReturn[47..56];
	self.Lobbyist_Address_Clean_sec_range 	:= tempLobbyistAddressReturn[57..64];
	self.Lobbyist_Address_Clean_p_city_name	:= tempLobbyistAddressReturn[65..89];
	self.Lobbyist_Address_Clean_v_city_name	:= tempLobbyistAddressReturn[90..114];
	self.Lobbyist_Address_Clean_st 			:= tempLobbyistAddressReturn[115..116];
	self.Lobbyist_Address_Clean_zip 		:= tempLobbyistAddressReturn[117..121];
	self.Lobbyist_Address_Clean_zip4 		:= tempLobbyistAddressReturn[122..125];
	self.Lobbyist_Address_Clean_cart 		:= tempLobbyistAddressReturn[126..129];
	self.Lobbyist_Address_Clean_cr_sort_sz 	:= tempLobbyistAddressReturn[130];
	self.Lobbyist_Address_Clean_lot 		:= tempLobbyistAddressReturn[131..134];
	self.Lobbyist_Address_Clean_lot_order 	:= tempLobbyistAddressReturn[135];
	self.Lobbyist_Address_Clean_dpbc 		:= tempLobbyistAddressReturn[136..137];
	self.Lobbyist_Address_Clean_chk_digit 	:= tempLobbyistAddressReturn[138];
	self.Lobbyist_Address_Clean_record_type	:= tempLobbyistAddressReturn[139..140];
	self.Lobbyist_Address_Clean_ace_fips_st	:= tempLobbyistAddressReturn[141..142];
	self.Lobbyist_Address_Clean_fipscounty 	:= tempLobbyistAddressReturn[143..145];
	self.Lobbyist_Address_Clean_geo_lat 	:= tempLobbyistAddressReturn[146..155];
	self.Lobbyist_Address_Clean_geo_long 	:= tempLobbyistAddressReturn[156..166];
	self.Lobbyist_Address_Clean_msa 		:= tempLobbyistAddressReturn[167..170];
	self.Lobbyist_Address_Clean_geo_match 	:= tempLobbyistAddressReturn[178];
	self.Lobbyist_Address_Clean_err_stat 	:= tempLobbyistAddressReturn[179..182];
	self.Firm_Address_Clean_prim_range  := tempFirmAddressReturn[1..10];
	self.Firm_Address_Clean_predir 	    := tempFirmAddressReturn[11..12];
	self.Firm_Address_Clean_prim_name 	:= tempFirmAddressReturn[13..40];
	self.Firm_Address_Clean_addr_suffix := tempFirmAddressReturn[41..44];
	self.Firm_Address_Clean_postdir 	:= tempFirmAddressReturn[45..46];
	self.Firm_Address_Clean_unit_desig 	:= tempFirmAddressReturn[47..56];
	self.Firm_Address_Clean_sec_range 	:= tempFirmAddressReturn[57..64];
	self.Firm_Address_Clean_p_city_name	:= tempFirmAddressReturn[65..89];
	self.Firm_Address_Clean_v_city_name	:= tempFirmAddressReturn[90..114];
	self.Firm_Address_Clean_st 			:= tempFirmAddressReturn[115..116];
	self.Firm_Address_Clean_zip 		:= tempFirmAddressReturn[117..121];
	self.Firm_Address_Clean_zip4 		:= tempFirmAddressReturn[122..125];
	self.Firm_Address_Clean_cart 		:= tempFirmAddressReturn[126..129];
	self.Firm_Address_Clean_cr_sort_sz 	:= tempFirmAddressReturn[130];
	self.Firm_Address_Clean_lot 		:= tempFirmAddressReturn[131..134];
	self.Firm_Address_Clean_lot_order 	:= tempFirmAddressReturn[135];
	self.Firm_Address_Clean_dpbc 		:= tempFirmAddressReturn[136..137];
	self.Firm_Address_Clean_chk_digit 	:= tempFirmAddressReturn[138];
	self.Firm_Address_Clean_record_type	:= tempFirmAddressReturn[139..140];
	self.Firm_Address_Clean_ace_fips_st	:= tempFirmAddressReturn[141..142];
	self.Firm_Address_Clean_fipscounty 	:= tempFirmAddressReturn[143..145];
	self.Firm_Address_Clean_geo_lat 	:= tempFirmAddressReturn[146..155];
	self.Firm_Address_Clean_geo_long 	:= tempFirmAddressReturn[156..166];
	self.Firm_Address_Clean_msa 		:= tempFirmAddressReturn[167..170];
	self.Firm_Address_Clean_geo_match 	:= tempFirmAddressReturn[178];
	self.Firm_Address_Clean_err_stat 	:= tempFirmAddressReturn[179..182];
	self.Association_Address_Clean_prim_range   := tempAssociationAddressReturn[1..10];
	self.Association_Address_Clean_predir 	    := tempAssociationAddressReturn[11..12];
	self.Association_Address_Clean_prim_name 	:= tempAssociationAddressReturn[13..40];
	self.Association_Address_Clean_addr_suffix  := tempAssociationAddressReturn[41..44];
	self.Association_Address_Clean_postdir 		:= tempAssociationAddressReturn[45..46];
	self.Association_Address_Clean_unit_desig 	:= tempAssociationAddressReturn[47..56];
	self.Association_Address_Clean_sec_range 	:= tempAssociationAddressReturn[57..64];
	self.Association_Address_Clean_p_city_name	:= tempAssociationAddressReturn[65..89];
	self.Association_Address_Clean_v_city_name	:= tempAssociationAddressReturn[90..114];
	self.Association_Address_Clean_st 			:= tempAssociationAddressReturn[115..116];
	self.Association_Address_Clean_zip 			:= tempAssociationAddressReturn[117..121];
	self.Association_Address_Clean_zip4 		:= tempAssociationAddressReturn[122..125];
	self.Association_Address_Clean_cart 		:= tempAssociationAddressReturn[126..129];
	self.Association_Address_Clean_cr_sort_sz 	:= tempAssociationAddressReturn[130];
	self.Association_Address_Clean_lot 			:= tempAssociationAddressReturn[131..134];
	self.Association_Address_Clean_lot_order 	:= tempAssociationAddressReturn[135];
	self.Association_Address_Clean_dpbc 		:= tempAssociationAddressReturn[136..137];
	self.Association_Address_Clean_chk_digit 	:= tempAssociationAddressReturn[138];
	self.Association_Address_Clean_record_type	:= tempAssociationAddressReturn[139..140];
	self.Association_Address_Clean_ace_fips_st	:= tempAssociationAddressReturn[141..142];
	self.Association_Address_Clean_fipscounty 	:= tempAssociationAddressReturn[143..145];
	self.Association_Address_Clean_geo_lat 		:= tempAssociationAddressReturn[146..155];
	self.Association_Address_Clean_geo_long 	:= tempAssociationAddressReturn[156..166];
	self.Association_Address_Clean_msa 			:= tempAssociationAddressReturn[167..170];
	self.Association_Address_Clean_geo_match 	:= tempAssociationAddressReturn[178];
	self.Association_Address_Clean_err_stat 	:= tempAssociationAddressReturn[179..182];
	self.Association_Contact_Name_Clean_title			:= tempAssociationContactName[1..5];
	self.Association_Contact_Name_Clean_fname			:= tempAssociationContactName[6..25];
	self.Association_Contact_Name_Clean_mname			:= tempAssociationContactName[26..45];
	self.Association_Contact_Name_Clean_lname			:= tempAssociationContactName[46..65];
	self.Association_Contact_Name_Clean_name_suffix		:= tempAssociationContactName[66..70];
	self.Association_Contact_Name_Clean_cleaning_score	:= tempAssociationContactName[71..73];
  self.Key := stringlib.StringToUpperCase(InputRecord.Key);
	self.Process_Date := stringlib.StringToUpperCase(InputRecord.Process_Date);
	self.Source_State := stringlib.StringToUpperCase(InputRecord.Source_State);
	self.Lobbyist_Name_Full := stringlib.StringToUpperCase(InputRecord.Lobbyist_Name_Full);
	self.Lobbyist_Name_Last := stringlib.StringToUpperCase(InputRecord.Lobbyist_Name_Last);
	self.Lobbyist_Name_First := stringlib.StringToUpperCase(InputRecord.Lobbyist_Name_First);
	self.Lobbyist_Name_Middle := stringlib.StringToUpperCase(InputRecord.Lobbyist_Name_Middle);
	self.Lobbyist_Name_Suffix := stringlib.StringToUpperCase(InputRecord.Lobbyist_Name_Suffix);
	self.Lobbyist_Address_Whole := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Whole);
	self.Lobbyist_Address_Street_Line := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_Line);
	self.Lobbyist_Address_CSZ_Line := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_CSZ_Line);
	self.Lobbyist_Address_City := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_City);
	self.Lobbyist_Address_State := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_State);
	self.Lobbyist_Address_ZIP := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_ZIP);
	self.Lobbyist_Phone := stringlib.StringToUpperCase(InputRecord.Lobbyist_Phone);
	self.Lobbyist_Fax := stringlib.StringToUpperCase(InputRecord.Lobbyist_Fax);
	self.Lobbyist_Email := stringlib.StringToUpperCase(InputRecord.Lobbyist_Email);
	self.Lobbyist_Type := stringlib.StringToUpperCase(InputRecord.Lobbyist_Type);
	self.Lobbyist_State_ID := stringlib.StringToUpperCase(InputRecord.Lobbyist_State_ID);
	self.Firm_Name_Full := stringlib.StringToUpperCase(InputRecord.Firm_Name_Full);
	self.Firm_Address_Whole := stringlib.StringToUpperCase(InputRecord.Firm_Address_Whole);
	self.Firm_Address_Street_Line := stringlib.StringToUpperCase(InputRecord.Firm_Address_Street_Line);
	self.Firm_Address_CSZ_Line := stringlib.StringToUpperCase(InputRecord.Firm_Address_CSZ_Line);
	self.Firm_Address_City := stringlib.StringToUpperCase(InputRecord.Firm_Address_City);
	self.Firm_Address_State := stringlib.StringToUpperCase(InputRecord.Firm_Address_State);
	self.Firm_Address_ZIP := stringlib.StringToUpperCase(InputRecord.Firm_Address_ZIP);
	self.Firm_Phone := stringlib.StringToUpperCase(InputRecord.Firm_Phone);
	self.Association_Name_Full := stringlib.StringToUpperCase(InputRecord.Association_Name_Full);
	self.Association_Address_Whole := stringlib.StringToUpperCase(InputRecord.Association_Address_Whole);
	self.Association_Address_Street_Line := stringlib.StringToUpperCase(InputRecord.Association_Address_Street_Line);
	self.Association_Address_CSZ_Line := stringlib.StringToUpperCase(InputRecord.Association_Address_CSZ_Line);
	self.Association_Address_City := stringlib.StringToUpperCase(InputRecord.Association_Address_City);
	self.Association_Address_State := stringlib.StringToUpperCase(InputRecord.Association_Address_State);
	self.Association_Address_ZIP := stringlib.StringToUpperCase(InputRecord.Association_Address_ZIP);
	self.Association_Phone := stringlib.StringToUpperCase(InputRecord.Association_Phone);
	self.Association_State_ID := stringlib.StringToUpperCase(InputRecord.Association_State_ID);
	self.Association_Contact_Name_Full := stringlib.StringToUpperCase(InputRecord.Association_Contact_Name_Full);
	self.Association_Contact_Name_Last := stringlib.StringToUpperCase(InputRecord.Association_Contact_Name_Last);
	self.Association_Contact_Name_First := stringlib.StringToUpperCase(InputRecord.Association_Contact_Name_First);
	self.Lobby_Subject := stringlib.StringToUpperCase(InputRecord.Lobby_Subject);
	self.Lobby_Costs_Fees := stringlib.StringToUpperCase(InputRecord.Lobby_Costs_Fees);
	self.Lobby_Costs_Expenses := stringlib.StringToUpperCase(InputRecord.Lobby_Costs_Expenses);
	self.Lobby_Costs_Expenses_Client := stringlib.StringToUpperCase(InputRecord.Lobby_Costs_Expenses_Client);
	self.Lobby_Costs_Total := stringlib.StringToUpperCase(InputRecord.Lobby_Costs_Total);
	self.Lobby_Status := stringlib.StringToUpperCase(InputRecord.Lobby_Status);
	self.Lobby_Legislative_Year_Start := stringlib.StringToUpperCase(InputRecord.Lobby_Legislative_Year_Start);
	self.Lobby_Legislative_Year_End := stringlib.StringToUpperCase(InputRecord.Lobby_Legislative_Year_End);
	self.Lobby_Registration_Date := stringlib.StringToUpperCase(InputRecord.Lobby_Registration_Date);
	self.Lobby_Termination_Date := stringlib.StringToUpperCase(InputRecord.Lobby_Termination_Date);
	self.Lobby_Legislative_Code := stringlib.StringToUpperCase(InputRecord.Lobby_Legislative_Code);
end;
clean_lobbyists := project(nofold(RecordsWithSplitAssociationAddress),CleanLobbyists(left));

ut.mac_suppress_by_phonetype(clean_lobbyists, Lobbyist_Phone, Lobbyist_Address_State, clean_lobbyists_WA_suppressed, false, DID_field);

export Cleaned_Lobbyists := clean_lobbyists_WA_suppressed :
	persist('~thor_data200::persist::lobbyists::cleaned_lobbyists');