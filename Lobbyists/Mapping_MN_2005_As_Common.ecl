import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_MN_2005 InputRecord) := transform
  self.Key := 'MN' + hash64(InputRecord.Lobbyist_Name_Last,
	                          InputRecord.Lobbyist_Name_First,
														InputRecord.Lobbyist_Name_Middle,
														InputRecord.Association_Name_Full);
	self.Process_Date := '20050519';
	self.Source_State := 'MN';
	self.Lobbyist_Name_Last := InputRecord.Lobbyist_Name_Last;
	self.Lobbyist_Name_First := InputRecord.Lobbyist_Name_First;
	self.Lobbyist_Name_Middle := InputRecord.Lobbyist_Name_Middle;
	Street_1_Is_Apt_Num := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1]) = '#' or
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..4]) = 'BOX ' or
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..3]) = 'APT' or
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..3]) = 'C/O' or
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..4]) = 'STE ' or
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..5]) = 'SUITE';
  Street_1_Is_Company := stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..6]) <> 'PO BOX' and
	                       stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..8]) <> 'P.O. BOX' and
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..5]) <> 'ROOM ' and
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..12]) <> 'SECOND FLOOR' and
												 stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1[1..11]) <> 'FIFTH FLOOR' and
												 (InputRecord.Lobbyist_Address_Street_1[1] < '0' or
												  InputRecord.Lobbyist_Address_Street_1[1] > '9') and
												 (not Street_1_Is_Apt_Num);
	self.Lobbyist_Address_Street_Line := if(Street_1_Is_Company,
	                                        InputRecord.Lobbyist_Address_Street_2,
																					if(Street_1_Is_Apt_Num,
																					   trim(trim(InputRecord.Lobbyist_Address_Street_2,left,right) + ' ' +
																						      trim(InputRecord.Lobbyist_Address_Street_1,left,right),left,right),
																						 trim(trim(InputRecord.Lobbyist_Address_Street_1,left,right) + ' ' +
																						      trim(InputRecord.Lobbyist_Address_Street_2,left,right),left,right)));
	self.Lobbyist_Address_City := InputRecord.Lobbyist_Address_City;
	self.Lobbyist_Address_State := InputRecord.Lobbyist_Address_State;
	self.Lobbyist_Address_ZIP := lib_stringlib.StringLib.stringfilter(InputRecord.Lobbyist_Address_ZIP,'0123456789');
	self.Lobbyist_Phone := lib_stringlib.StringLib.stringfilter(InputRecord.Lobbyist_Phone,'0123456789');
	self.Lobbyist_Email := InputRecord.Lobbyist_Email;
	self.Firm_Name_Full := if(Street_1_Is_Company,
	                          InputRecord.Lobbyist_Address_Street_1,
														'');
	self.Firm_Address_Street_Line := if(Street_1_Is_Company,
	                                    InputRecord.Lobbyist_Address_Street_2,
																			'');
	self.Firm_Address_City := if(Street_1_Is_Company,
	                             InputRecord.Lobbyist_Address_City,
															 '');
	self.Firm_Address_State := if(Street_1_Is_Company,
	                              InputRecord.Lobbyist_Address_State,
																'');
	self.Firm_Address_ZIP := if(Street_1_Is_Company,
	                            lib_stringlib.StringLib.stringfilter(InputRecord.Lobbyist_Address_ZIP,'0123456789'),
															'');
	self.Firm_Phone := if(Street_1_Is_Company,
	                      lib_stringlib.StringLib.stringfilter(InputRecord.Lobbyist_Phone,'0123456789'),
												'');
	self.Association_Name_Full := InputRecord.Association_Name_Full;
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date := if(regexfind(DateFinder,InputRecord.Lobby_Received_Date),
	                                   intformat((integer)regexfind(DateFinder,InputRecord.Lobby_Received_Date,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,InputRecord.Lobby_Received_Date,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,InputRecord.Lobby_Received_Date,2),2,1),
																		 '');
	self.Lobby_Legislative_Year_Start := if(regexfind(DateFinder,InputRecord.Lobby_Received_Date),
	                                        regexfind(DateFinder,InputRecord.Lobby_Received_Date,3),
																					'');
	self := [];
end;

export Mapping_MN_2005_As_Common := project(File_Lobbyists_MN_2005,MyTransform(left));