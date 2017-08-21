import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_CA_2005 input) := transform

	self.Key := 'CA' + hash64(input.surname,input.givenname,input.employer,input.address_1);
	self.Process_Date := '20051121';
	self.Source_State := 'CA';
	self.Lobbyist_Name_Last	:= input.Surname;
	self.Lobbyist_Name_First	:= input.Givenname;
	self.Lobbyist_Address_Street_Line	:= trim(input.Address_1,left,right) + ' ' +
																			 trim(input.Address_2,left,right);
	self.Lobbyist_Address_City	:= input.City;
	self.Lobbyist_Address_State	:= input.State;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Association_Name_Full	:= input.Employer;
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_CA_2005_As_Common := project(File_Lobbyists_CA_2005,MyTransform(left));