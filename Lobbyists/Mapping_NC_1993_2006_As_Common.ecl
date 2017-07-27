import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_NC_1993_2006 input) := transform

	self.Key := 'NC' + hash64(input.Term,input.Name,input.Principal);
	self.Process_Date := '20050608';
	self.Source_State := 'NC';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Firm_Name_Full	:= input.Firm;
	self.Firm_Address_Street_Line	:= input.Address;
	self.Firm_Address_CSZ_Line	:= input.City_State_Zip;
	self.Firm_Phone	:= lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Association_Name_Full	:= input.Principal;
	self.Association_Address_Street_Line	:= input.Principals_Address;
	self.Association_Address_CSZ_Line	:= input.Principals_City_State_Zip;
	self.Association_Phone	:= lib_stringlib.stringlib.stringfilter(input.Principals_Phone,'0123456789');
	self.Lobby_Legislative_Year_Start := input.Term[1..4];
	self.Lobby_Legislative_Year_End := input.Term[6..9];
	self := [];
end;

export Mapping_NC_1993_2006_As_Common := project(File_Lobbyists_NC_1993_2006,MyTransform(left));
