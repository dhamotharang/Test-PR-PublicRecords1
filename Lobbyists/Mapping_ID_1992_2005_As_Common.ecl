Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_ID_1992_2005 InputRecord) := transform
  self.Key := 'ID' + hash64(InputRecord.Lobbyist_Name_Last_Or_Full,InputRecord.Lobbyist_Name_First,InputRecord.Lobbyist_Name_Middle,InputRecord.Lobbyist_Name_Suffix,
	                          InputRecord.Employer_Name_Last_Or_Full,InputRecord.Employer_Name_First);
	self.Process_Date := '20050504';
	self.Source_State := 'ID';
  self.Lobby_Legislative_Year_Start := InputRecord.Lobby_Legislative_Year;
	self.Lobby_Legislative_Year_End := InputRecord.Lobby_Legislative_Year;
	Lobbyist_Is_Person := InputRecord.Lobbyist_Name_First <> '';
	self.Lobbyist_Name_Last := if(Lobbyist_Is_Person,InputRecord.Lobbyist_Name_Last_Or_Full,'');
	self.Lobbyist_Name_First := InputRecord.Lobbyist_Name_First;
	self.Lobbyist_Name_Middle := InputRecord.Lobbyist_Name_Middle;
	self.Lobbyist_Name_Suffix := InputRecord.Lobbyist_Name_Suffix;
	self.Firm_Name_Full := if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Name_Last_Or_Full);
	self.Lobbyist_Address_Street_Line := if(Lobbyist_Is_Person,InputRecord.Lobbyist_Address_Mailing,'');
	self.Lobbyist_Address_City := if(Lobbyist_Is_Person,InputRecord.Lobbyist_Address_City,'');
	self.Lobbyist_Address_State := if(Lobbyist_Is_Person,InputRecord.Lobbyist_Address_State,'');
	LobbyistPaddedZip := if(length(InputRecord.Lobbyist_Address_ZIP)<=5,
							intformat((integer)InputRecord.Lobbyist_Address_ZIP,5,1),
							intformat((integer)InputRecord.Lobbyist_Address_ZIP,9,1)
						   );		// getting around a compiler bug in Prod (constant expression required)
	self.Lobbyist_Address_ZIP := if(Lobbyist_Is_Person,LobbyistPaddedZip,'');
	self.Firm_Address_Street_Line := if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Address_Mailing);
	self.Firm_Address_City := if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Address_City);
	self.Firm_Address_State := if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Address_State);
	self.Firm_Address_ZIP := if(Lobbyist_Is_Person,'',LobbyistPaddedZip);
	Employer_Is_Person := InputRecord.Employer_Name_First <> '';
	self.Association_Name_Full := if(Employer_Is_Person,'',InputRecord.Employer_Name_Last_Or_Full);
	self.Association_Contact_Name_Last := if(Employer_Is_Person,InputRecord.Employer_Name_Last_Or_Full,'');
	self.Association_Contact_Name_First := InputRecord.Employer_Name_First;
	self.Association_Address_Street_Line := InputRecord.Employer_Address_Mailing;
	self.Association_Address_City := InputRecord.Employer_Address_City;
	self.Association_Address_State := InputRecord.Employer_Address_State;
	AssociationPaddedZip := if(length(InputRecord.Employer_Address_ZIP)<=5,
							intformat((integer)InputRecord.Employer_Address_ZIP,5,1),
							intformat((integer)InputRecord.Employer_Address_ZIP,9,1)
						   );		// getting around a compiler bug in Prod (constant expression required)
	self.Association_Address_ZIP := AssociationPaddedZip;
	self.Lobby_Legislative_Code := 'TODO';
	self := [];
end;

export Mapping_ID_1992_2005_As_Common := project(File_Lobbyists_ID_1992_2005,MyTransform(left));
