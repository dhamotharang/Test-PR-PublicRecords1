Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_IA_2001 InputRecord) := transform
  self.Key := 'IA' + hash64(InputRecord.Association_Name_Full,InputRecord.Lobbyist_Name_First,InputRecord.Lobbyist_Name_Last);
	self.Process_Date := '20050506';
	self.Source_State := 'IA';
	self.Lobbyist_Name_Last := InputRecord.Lobbyist_Name_Last;
	self.Lobbyist_Name_First := InputRecord.Lobbyist_Name_First;
	self.Association_Name_Full := InputRecord.Association_Name_Full;
	self.Lobby_Legislative_Year_Start := '2001';
	self.Lobby_Legislative_Year_End := '2001';
	self := [];
end;

export Mapping_IA_2001_As_Common := project(File_Lobbyists_IA_2001,MyTransform(left));