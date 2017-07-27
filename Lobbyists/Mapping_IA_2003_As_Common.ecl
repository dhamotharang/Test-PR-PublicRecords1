Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_IA_2003 InputRecord) := transform
  self.Key := 'IA' + hash64(InputRecord.Association_Name_Full,InputRecord.Lobbyist_Name_Full);
	self.Process_Date := '20050505';
	self.Source_State := 'IA';
  self.Association_Name_Full := InputRecord.Association_Name_Full;
	self.Association_Contact_Name_Full := InputRecord.Association_Contact_Name_Full;
	self.Association_Address_Street_Line := InputRecord.Association_Address_Street_Line;
	self.Association_Address_CSZ_Line := InputRecord.Association_Address_CSZ_Line;
	self.Lobbyist_Name_Full := InputRecord.Lobbyist_Name_Full;
	self.Lobby_Status := if(trim(InputRecord.Lobby_Status,left,right) = 'added',
	                        'ACTIVE',
													if(trim(InputRecord.Lobby_Status,left,right) = 'deleted',
													   'TERMINATED',
														 ''));
	self.Lobby_Registration_Date := if(trim(InputRecord.Lobby_Status,left,right) = 'added',
	                                   if(InputRecord.Status_Date_1 <> '',
																		    InputRecord.Status_Date_1[7..10] +
																				InputRecord.Status_Date_1[1..2] +
																				InputRecord.Status_Date_1[4..5],
																				''),
																		 '');
	self.Lobby_Termination_Date := if(trim(InputRecord.Lobby_Status,left,right) = 'deleted',
	                                  if(InputRecord.Status_Date_1 <> '',
										  							   InputRecord.Status_Date_1[7..10] +
																			 InputRecord.Status_Date_1[1..2] +
																			 InputRecord.Status_Date_1[4..5],
																				''),
																		 '');
	self.Lobby_Legislative_Year_Start := '2003';
	self.Lobby_Legislative_Year_End := '2003';
	self := [];
end;

export Mapping_IA_2003_As_Common := project(File_Lobbyists_IA_2003,MyTransform(left));