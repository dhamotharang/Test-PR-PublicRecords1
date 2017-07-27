Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_ME_2005 input) := transform

	self.Key := 'ME' + hash64(input.Name,input.Year,input.Employer);
	self.Process_Date := '20050509';
	self.Source_State := 'ME';
	self.Lobby_Legislative_Year_Start := input.Year;
	self.Lobby_Legislative_Year_End := input.Year;
	lobbyistiscompany := func_is_company (input.Name);
	self.Lobbyist_Name_Full := if (lobbyistiscompany, '', input.Name);
	self.Firm_Name_Full := if (lobbyistiscompany, input.Name, '');
	self.Association_Name_Full := input.Employer;
	self.Lobby_Status := input.Status;
	self := [];
end;

export Mapping_ME_2005_As_Common := project(File_Lobbyists_ME_2005,MyTransform(left));
	