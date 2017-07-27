Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_OH_2005 input) := transform

	self.Key := 'OH' + hash64(input.Name,input.Address);
	self.Process_Date := '20050523';
	self.Source_State := 'OH';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Lobbyist_Address_Street_Line	:= input.Address;
	self.Lobbyist_Address_CSZ_Line	:= input.City_State_Zip;
	self.Lobbyist_Phone	:= input.Telephone[1..3]+
                         input.Telephone[5..7]+
												 input.Telephone[9..];
	self.Lobby_Legislative_Year_Start	:= '2005';
	self.Lobby_Legislative_Year_End	:= '2005';
	self := [];
end;

export Mapping_OH_2005_As_Common := project(File_Lobbyists_OH_2005,MyTransform(left));