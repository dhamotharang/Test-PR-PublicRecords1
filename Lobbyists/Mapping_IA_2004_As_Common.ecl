Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_IA_2004 InputRecord) := transform
	self.Key := 'IA' + hash64(InputRecord.Lobbyist_ID,InputRecord.Client_ID);
	self.Process_Date := '20050505';
	self.Source_State := 'IA';
	self.Lobbyist_State_ID := InputRecord.Lobbyist_ID;
	self.Lobbyist_Name_Full := InputRecord.Lobbyist_Name_Full;
	Address1IsAddress := InputRecord.Lobbyist_Address_Street_1_Or_Firm[1..4] = 'P.O.' or
	                     (InputRecord.Lobbyist_Address_Street_1_Or_Firm[1] >= '0' and
										    InputRecord.Lobbyist_Address_Street_1_Or_Firm[1] <= '9');
	self.Lobbyist_Address_Street_Line := trim(if(Address1IsAddress,
	                                             trim(InputRecord.Lobbyist_Address_Street_1_Or_Firm,left,right) + ' ',
																							 '') +
																						trim(InputRecord.Lobbyist_Address_Street_2,left,right));
	self.Lobbyist_Address_CSZ_Line := InputRecord.Lobbyist_Address_CSZ_Line;
	self.Firm_Name_Full := if(Address1IsAddress,'',InputRecord.Lobbyist_Address_Street_1_Or_Firm);
	self.Firm_Address_Street_Line := if(Address1IsAddress,
	                                    '',
																			InputRecord.Lobbyist_Address_Street_2);
	self.Firm_Address_CSZ_Line := if(Address1IsAddress,
	                                 '',
																	 InputRecord.Lobbyist_Address_CSZ_Line);
	self.Lobbyist_Phone := InputRecord.Lobbyist_Phone;
	self.Firm_Phone := if(Address1IsAddress,
	                      '',
												InputRecord.Lobbyist_Phone);
	self.Association_State_ID := InputRecord.Client_ID;
	self.Association_Name_Full := InputRecord.Client_Name_Full;
	self.Lobby_Registration_Date := if(InputRecord.Lobby_Registration_Date <> '',
	                                   InputRecord.Lobby_Registration_Date[7..10] +
	                                   InputRecord.Lobby_Registration_Date[1..2] +
									                   InputRecord.Lobby_Registration_Date[4..5],
									                   '');
  self.Lobby_Legislative_Year_Start := '2004';
	self.Lobby_Legislative_Year_End := '2004';
	self := [];
end;

export Mapping_IA_2004_As_Common := project(File_Lobbyists_IA_2004,MyTransform(left));