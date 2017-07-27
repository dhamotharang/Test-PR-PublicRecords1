Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_NY_2001_2002 input) := transform
	
	self.Key := 'NY' + hash64(input.Lobbyist,input.Year,input.Client);
	self.Process_Date := '20050523';
	self.Source_State := 'NY';
	self.Lobby_Legislative_Year_Start := input.Year;
	lobbyistiscompany := func_is_company (input.Lobbyist);
	self.Lobbyist_Name_Full := if (lobbyistiscompany, '', input.Lobbyist);
	self.Firm_Name_Full := if (lobbyistiscompany, input.Lobbyist, '');
	self.Association_Name_Full := input.Client;
	self := [];
end;

export Mapping_NY_2001_2002_As_Common := project(File_Lobbyists_NY_2001_2002,MyTransform(left));