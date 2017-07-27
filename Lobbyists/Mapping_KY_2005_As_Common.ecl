import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_KY_2005 input) := transform

	self.Key := 'KY' + hash64(input.Last_Name,input.First_Name,input.Company_or_Organization);
	self.Process_Date := '20050607';
	self.Source_State := 'KY';
	self.Lobbyist_Name_Last	:= input.Last_Name;
	self.Lobbyist_Name_First	:= input.First_Name;
	self.Association_Name_Full	:= input.Company_or_Organization;
	self.Lobbyist_Address_Street_Line	:= input.Street_Address;
	self.Lobbyist_Address_City	:= input.City;
	self.Lobbyist_Address_State	:= input.State;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Zip_Code,'0123456789');
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_KY_2005_As_Common := project(File_Lobbyists_KY_2005,MyTransform(left));