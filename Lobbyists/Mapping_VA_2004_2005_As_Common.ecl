Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_VA_2004_2005 InputRecord) := transform
	self.Key := 'VA' + hash64(InputRecord.Lobbyist_Name,InputRecord.Client_Name);
	self.Process_Date := '20050427';
	self.Source_State := 'VA';
	self.Lobbyist_Name_Full := InputRecord.Lobbyist_Name;
	Address1IsAddress := InputRecord.Lobbyist_Address_1_Employer[1..4] = 'P.O.' or
	                                     (InputRecord.Lobbyist_Address_1_Employer[1] >= '0' and
										  InputRecord.Lobbyist_Address_1_Employer[1] <= '9');
	self.Lobbyist_Address_Street_Line := if(Address1IsAddress,
										 trim(InputRecord.Lobbyist_Address_1_Employer,left,right) +
										 if(InputRecord.Lobbyist_Address_3 <> '',
										    ' ' + trim(InputRecord.Lobbyist_Address_2,left,right) +
												if(InputRecord.Lobbyist_Address_4 <> '',
												   ' ' + trim(InputRecord.Lobbyist_Address_3,left,right),
													 ''),
												''),
										 trim(InputRecord.Lobbyist_Address_2,left,right) +
										 if(InputRecord.Lobbyist_Address_4 <> '',
										    ' ' + trim(InputRecord.Lobbyist_Address_3,left,right),
												''));
	self.Lobbyist_Address_CSZ_Line := if(InputRecord.Lobbyist_Address_4 <> '',
	                                     InputRecord.Lobbyist_Address_4,
																			 if(InputRecord.Lobbyist_Address_3 <> '',
																			    InputRecord.Lobbyist_Address_3,
																					InputRecord.Lobbyist_Address_2));
	self.Firm_Name_Full := if(Address1IsAddress,'',InputRecord.Lobbyist_Address_1_Employer);
	self.Firm_Address_Street_Line := if(Address1IsAddress,
	                                    '',
																			trim(InputRecord.Lobbyist_Address_2,left,right) +
										                  if(InputRecord.Lobbyist_Address_4 <> '',
										                     ' ' + trim(InputRecord.Lobbyist_Address_3,left,right),
												                 ''));
	self.Firm_Address_CSZ_Line := if(Address1IsAddress,
	                                 '',
																	 if(InputRecord.Lobbyist_Address_4 <> '',
																	    InputRecord.Lobbyist_Address_4,
																			InputRecord.Lobbyist_Address_3));
	self.Association_Name_Full := InputRecord.Client_Name;
	self.Association_Address_Street_Line := trim(InputRecord.Client_Address_1,left,right) +
	                                     if(InputRecord.Client_Address_3 <> '',
																			    ' ' + trim(InputRecord.Client_Address_2,left,right),
																					'');
	self.Association_Address_CSZ_Line := if(InputRecord.Client_Address_3 <> '',
	                                        InputRecord.Client_Address_3,
																					InputRecord.Client_Address_2);
	self.Lobby_Registration_Date := if(InputRecord.Registration_Date <> '',
	                                   '20' +
	                                   InputRecord.Registration_Date[7..8] +
	                                   InputRecord.Registration_Date[1..2] +
									   InputRecord.Registration_Date[4..5],
									   '');
	self.Lobby_Subject := InputRecord.Subject;
	self.Lobbyist_Phone := InputRecord.Lobbyist_Phone[2..4] +
	                       InputRecord.Lobbyist_Phone[6..8] +
						             InputRecord.Lobbyist_Phone[10..];
	self.Firm_Phone := if(Address1IsAddress,
	                      '',
												InputRecord.Lobbyist_Phone[2..4] +
	                      InputRecord.Lobbyist_Phone[6..8] +
						            InputRecord.Lobbyist_Phone[10..]);
  self.Lobby_Legislative_Year_Start := '2004';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_VA_2004_2005_As_Common := project(File_Lobbyists_VA_2004_2005,MyTransform(left));