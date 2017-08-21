MyInitialDS := File_Lobbyists_HI_2005_2006;

pattern Lobbyist := pattern('[^\240]+');

MyParsedRecord := record
  MyInitialDS;
  string Client_Single := trim(matchtext(Lobbyist),left,right);
end;

MyParsedDS := parse(MyInitialDS,Clients,Lobbyist,MyParsedRecord,scan,first);

Layout_Lobbyists_Common MyTransform(MyParsedRecord InputRecord) := transform
  CleanedAssociationName := regexreplace(',$',InputRecord.Client_Single,'');
  self.Key := 'HI' + hash64(InputRecord.Name,CleanedAssociationName);
	self.Source_State := 'HI';
	self.Process_Date := '20050504';
  self.Lobbyist_Name_Full := InputRecord.Name;
	self.Association_Name_Full := CleanedAssociationName;
	self.Lobby_Legislative_Year_Start := if(InputRecord.Year_Registered <> '',InputRecord.Year_Registered[1..4],'');
	self.Lobby_Legislative_Year_End   := if(InputRecord.Year_Registered <> '',InputRecord.Year_Registered[6..9],'');
	self := [];
end;

export Mapping_HI_2005_2006_As_Common := project(nofold(MyParsedDS),MyTransform(left));