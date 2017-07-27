import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_RI_2005 input) := transform

	self.Key := 'RI' + hash64(input.Lobbyist_Name,input.Lobbyist_ID);
	self.Process_Date := '20050512';
	self.Source_State := 'RI';
	self.Association_Name_Full	:= input.Entity_Name;
	self.Lobbyist_Name_Full	:= input.Lobbyist_Name;
	self.Firm_Name_Full	:= input.Lobby_Firm_Name;
	self.Lobbyist_Type	:= input.Relationship_Type;
	self.Lobbyist_State_ID	:= input.Lobbyist_ID;
	self.Lobbyist_Address_Street_Line	:= input.Street_Address;
	self.Lobbyist_Address_CSZ_Line	:= input.City_State;
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.Lobbyist_Phone,'0123456789');
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_RI_2005_As_Common := project(File_Lobbyists_RI_2005,MyTransform(left));
	