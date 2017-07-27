MyInitialDS := Lobbyists.File_Lobbyists_AR_2005; 

pattern SingleName := pattern('[ ]{5,}[^ ]+([ ]{1,4}[^ ]+)*');

MyLFMParsedRecord := record	
MyInitialDS;
string	SingleLobbyFirmMember := trim(matchtext(SingleName),left,right);
	end;
	
MyLFMParsedDS := parse(MyInitialDS,Lobby_Firm_Members[19..],SingleName,MyLFMParsedRecord,
	scan,first);
	
MyClientParsedRecord := record 
MyLFMParsedDS;
	string SingleClient := trim(matchtext(SingleName),left,right);
	end;
		
MyClientParsedDS := parse(MyLFMParsedDS,Clients_Name[9..],SingleName,MyClientParsedRecord,
	scan,first);

Layout_Lobbyists_Common MyTransform(MyClientParsedRecord input) := transform

	self.Key := 'AR' + hash64(input.Lobbyist_Name,input.SingleClient);
	self.Process_Date := '20050428';
	self.Source_State := 'AR';
	lobbyistiscompany := func_is_company (input.lobbyist_name);
	self.Lobbyist_Name_Full := if (lobbyistiscompany, '', input.Lobbyist_Name);
	self.Firm_Name_Full := if (lobbyistiscompany, input.Lobbyist_Name, '');
	self.Firm_Address_Street_Line := if (lobbyistiscompany, input.Lobbyist_Address_1, ''); 
	self.Firm_Address_CSZ_Line := if (lobbyistiscompany, input.Lobbyist_Address_2, '');
	self.Lobbyist_Address_Street_Line := if (lobbyistiscompany, '', input.Lobbyist_Address_1);
  self.Lobbyist_Address_CSZ_Line := if (lobbyistiscompany, '', input.Lobbyist_Address_2);
	self.Lobby_Status := input.Lobbyist_Status;
	self.Lobbyist_Phone := if (lobbyistiscompany, '', input.Lobbyist_Phone[2..4]+
																										input.Lobbyist_Phone[7..9]+
																										input.Lobbyist_Phone[11..]);																			
	self.Firm_Phone := if (lobbyistiscompany, input.Lobbyist_Phone[2..4]+
                                            input.Lobbyist_Phone[7..9]+
																						input.Lobbyist_Phone[11..], '');
	self.Association_Name_Full := input.SingleClient;
		self := [];
	end;
	
	export Mapping_AR_As_Common := project(MyClientParsedDS,MyTransform(left));
	
	