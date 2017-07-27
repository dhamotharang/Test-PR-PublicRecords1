import Lib_AddrClean;

Layout_Lobbyists_Common CleanLobbyists(Layout_Lobbyists_Common InputRecord) := transform
	string73 tempLobbyistName := stringlib.StringToUpperCase(if(trim(InputRecord.Lobbyist_Name_Full,left,right) <> '',
	                                lib_AddrClean.AddrCleanLib.CleanPerson73(trim(InputRecord.Lobbyist_Name_Full,left,right)),
																	if(trim(trim(InputRecord.Lobbyist_Name_First,left,right) + ' ' +
																	        trim(InputRecord.Lobbyist_Name_Middle,left,right) + ' ' +
																					trim(InputRecord.Lobbyist_Name_Last,left,right) + ' ' +
																					trim(InputRecord.Lobbyist_Name_Suffix,left,right),left,right) <> '',
																	   lib_AddrClean.AddrCleanLib.CleanPerson73(trim(trim(InputRecord.Lobbyist_Name_First,left,right) + ' ' +
																	                                                 trim(InputRecord.Lobbyist_Name_Middle,left,right) + ' ' +
																					                                         trim(InputRecord.Lobbyist_Name_Last,left,right) + ' ' +
																					                                         trim(InputRecord.Lobbyist_Name_Suffix,left,right),left,right)),
																		 '')));
	string182 tempLobbyistAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Lobbyist_Address_CSZ_Line <> '',
																						lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.Lobbyist_Address_Street_Line,left,right),
	                                                                                     trim(InputRecord.Lobbyist_Address_CSZ_Line,left,right)),
																						if(InputRecord.Lobbyist_Address_Street_Line <> '' or
																						   InputRecord.Lobbyist_Address_City <> '' or
																							 InputRecord.Lobbyist_Address_State <> '' or
																							 InputRecord.Lobbyist_Address_ZIP <> '',
																							 lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.Lobbyist_Address_Street_Line,left,right),
																							                                            trim(trim(InputRecord.Lobbyist_Address_City,left,right) + ', ' +
																																													     trim(InputRecord.Lobbyist_Address_State,left,right) + ' ' +
																																															 trim(InputRecord.Lobbyist_Address_ZIP,left,right),left,right)),
																							 '')));
	string182 tempFirmAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Firm_Address_CSZ_Line <> '',
																				lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.Firm_Address_Street_Line,left,right),
	                                                                                 trim(InputRecord.Firm_Address_CSZ_Line,left,right)),
																				if(InputRecord.Firm_Address_Street_Line <> '' or
																				   InputRecord.Firm_Address_City <> '' or
																					 InputRecord.Firm_Address_State <> '' or
																					 InputRecord.Firm_Address_ZIP <> '',
																					 lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.Firm_Address_Street_Line,left,right),
																					                                            trim(trim(InputRecord.Firm_Address_City,left,right) + ', ' +
																																											     trim(InputRecord.Firm_Address_State,left,right) + ' ' +
																																													 trim(InputRecord.Firm_Address_ZIP,left,right),left,right)),
																					 '')));
	string182 tempAssociationAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Association_Address_CSZ_Line <> '',
															        				 lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.Association_Address_Street_Line,left,right),
	                                                                                        trim(InputRecord.Association_Address_CSZ_Line,left,right)),
																				       if(InputRecord.Association_Address_Street_Line <> '' or
																				          InputRecord.Association_Address_City <> '' or
																					        InputRecord.Association_Address_State <> '' or
																					        InputRecord.Association_Address_ZIP <> '',
																					        lib_AddrClean.AddrCleanLib.CleanAddress182(trim(InputRecord.Association_Address_Street_Line,left,right),
																					                                                   trim(trim(InputRecord.Association_Address_City,left,right) + ', ' +
																																											            trim(InputRecord.Association_Address_State,left,right) + ' ' +
																																													        trim(InputRecord.Association_Address_ZIP,left,right),left,right)),
																					        '')));
	string73 tempAssociationContactName := stringlib.StringToUpperCase(if(trim(InputRecord.Association_Contact_Name_Full,left,right) <> '',
	                                          lib_AddrClean.AddrCleanLib.CleanPerson73(trim(InputRecord.Association_Contact_Name_Full)),
																						if(trim(trim(InputRecord.Association_Contact_Name_First,left,right) + ' ' +
																						        trim(InputRecord.Association_Contact_Name_Last,left,right),left,right) <> '',
																						   lib_AddrClean.AddrCleanLib.CleanPerson73(trim(trim(InputRecord.Association_Contact_Name_First,left,right) + ' ' +
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
	self.Firm_Address_Street_Line := stringlib.StringToUpperCase(InputRecord.Firm_Address_Street_Line);
	self.Firm_Address_CSZ_Line := stringlib.StringToUpperCase(InputRecord.Firm_Address_CSZ_Line);
	self.Firm_Address_City := stringlib.StringToUpperCase(InputRecord.Firm_Address_City);
	self.Firm_Address_State := stringlib.StringToUpperCase(InputRecord.Firm_Address_State);
	self.Firm_Address_ZIP := stringlib.StringToUpperCase(InputRecord.Firm_Address_ZIP);
	self.Firm_Phone := stringlib.StringToUpperCase(InputRecord.Firm_Phone);
	self.Association_Name_Full := stringlib.StringToUpperCase(InputRecord.Association_Name_Full);
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

export Cleaned_Lobbyists := project(Joined_Lobbyists,CleanLobbyists(left));