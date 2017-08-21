Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_ID_2006 InputRecord) := transform
	self.Key := 'ID' + hash64(InputRecord.Lobbyist_Name_Last,InputRecord.Lobbyist_Name_First,InputRecord.Lobbyist_Name_Middle,InputRecord.Lobbyist_Name_Suffix);
	self.Process_Date 						:= '20060323';
	self.Source_State 						:= 'ID';
	self.Lobby_Legislative_Year_Start 		:= InputRecord.Lobby_Legislative_Year;
	self.Lobby_Legislative_Year_End 		:= InputRecord.Lobby_Legislative_Year;
	
	Lobbyist_Is_Person 						:= InputRecord.Lobbyist_Name_First <> '';
	
	self.Lobbyist_Name_Last 				:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Name_Last,'');
	self.Lobbyist_Name_First 				:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Name_First,'');   
	self.Lobbyist_Name_Middle 				:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Name_Middle,''); 
	self.Lobbyist_Name_Suffix 				:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Name_Suffix,'');
	
	self.Firm_Name_Full 					:= if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Name_Last);
	self.Lobbyist_Address_Street_Line 		:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Address_Mailing,'');
	self.Lobbyist_Address_City 				:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Address_City,'');
	self.Lobbyist_Address_State 			:= if(Lobbyist_Is_Person,InputRecord.Lobbyist_Address_State,'');
	LobbyistPaddedZip 						:= intformat((integer)InputRecord.Lobbyist_Address_Zip,if(length(InputRecord.Lobbyist_Address_Zip)<=5,5,9),1);
	self.Lobbyist_Address_ZIP 				:= if(Lobbyist_Is_Person,LobbyistPaddedZip,'');
	self.Firm_Address_Street_Line 			:= if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Address_Mailing);
	self.Firm_Address_City 					:= if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Address_City);
	self.Firm_Address_State 				:= if(Lobbyist_Is_Person,'',InputRecord.Lobbyist_Address_State);
	self.Firm_Address_ZIP 					:= if(Lobbyist_Is_Person,'',LobbyistPaddedZip);
	self.Association_Name_Full 				:= InputRecord.Employer_Name;
	self.Association_Address_Street_Line 	:= InputRecord.Employer_Address_Mailing;
	self.Association_Address_City 			:= InputRecord.Employer_Address_City;
	self.Association_Address_State 			:= InputRecord.Employer_Address_State;
	AssociationPaddedZip 					:= intformat((integer)InputRecord.Employer_Address_Zip,if(length(InputRecord.Employer_Address_Zip)<=5,5,9),1);
	self.Association_Address_Zip 			:= AssociationPaddedZip;
	self.Lobby_Legislative_Code 			:= 'TODO';
	self 									:= [];
end;

export Mapping_ID_2006_As_Common 			:= project(File_Lobbyists_ID_2006, MyTransform(left));
