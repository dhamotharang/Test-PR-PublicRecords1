Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_IA_2002 InputRecord) := transform
  self.Key := 'IA' + hash64(InputRecord.Lobbyist_State_ID,InputRecord.Association_State_ID);
	self.Process_Date := '20050506';
	self.Source_State := 'IA';
  self.Association_Name_Full := InputRecord.Association_Name_Full;
	self.Association_Contact_Name_Full := InputRecord.Association_Contact_Name_Full;
	self.Lobbyist_Name_First := InputRecord.Lobbyist_Name_First;
	self.Lobbyist_Name_Last := InputRecord.Lobbyist_Name_Last;
	Address1IsAddress := InputRecord.Lobbyist_Address_Street_1_Or_Firm[1..4] = 'P.O.' or
	                     (InputRecord.Lobbyist_Address_Street_1_Or_Firm[1] >= '0' and
										    InputRecord.Lobbyist_Address_Street_1_Or_Firm[1] <= '9');
	self.Lobbyist_Address_Street_Line := if(Address1IsAddress,
	                                        trim(InputRecord.Lobbyist_Address_Street_1_Or_Firm,left,right) + ' ',
																					'') +
																			 trim(InputRecord.Lobbyist_Address_Street_2,left,right);
	self.Lobbyist_Address_CSZ_Line := InputRecord.Lobbyist_Address_CSZ_Line;
	self.Firm_Name_Full := if(Address1IsAddress,
	                          '',
														InputRecord.Lobbyist_Address_Street_1_Or_Firm);
	self.Firm_Address_Street_Line := if(Address1IsAddress,
	                                    '',
																			InputRecord.Lobbyist_Address_Street_2);
	self.Firm_Address_CSZ_Line := if(Address1IsAddress,
	                                 '',
																	 InputRecord.Lobbyist_Address_CSZ_Line);
	CleanedPhone := InputRecord.Lobbyist_Phone[2..4] +
	                InputRecord.Lobbyist_Phone[6..8] +
									InputRecord.Lobbyist_Phone[10..13];
	self.Lobbyist_Phone := CleanedPhone;
	self.Firm_Phone := if(Address1IsAddress,
	                      '',
												CleanedPhone);
	self.Lobbyist_State_ID := InputRecord.Lobbyist_State_ID;
	self.Association_State_ID := InputRecord.Association_State_ID;
	self.Lobby_Status := if(trim(InputRecord.Lobby_Status,left,right) = 'added',
	                        'ACTIVE',
													if(trim(InputRecord.Lobby_Status,left,right) = 'deleted',
													   'TERMINATED',
														 ''));
	self.Lobby_Registration_Date := if(trim(InputRecord.Lobby_Status,left,right) = 'added',
	                                   if(InputRecord.Status_Date <> '',
																		    InputRecord.Status_Date[7..10] +
																				InputRecord.Status_Date[1..2] +
																				InputRecord.Status_Date[4..5],
																				''),
																		 '');
	self.Lobby_Termination_Date := if(trim(InputRecord.Lobby_Status,left,right) = 'deleted',
	                                  if(InputRecord.Status_Date <> '',
										  							   InputRecord.Status_Date[7..10] +
																			 InputRecord.Status_Date[1..2] +
																			 InputRecord.Status_Date[4..5],
																				''),
																		 '');
  self.Lobby_Legislative_Year_Start := '2002';
	self.Lobby_Legislative_Year_End := '2002';
	self := [];
end;

export Mapping_IA_2002_As_Common := project(File_Lobbyists_IA_2002,MyTransform(left));