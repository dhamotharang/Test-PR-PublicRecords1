import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_WV_2005 input) := transform

	self.Key := 'WV' + hash64(input.Name,input.Address1,input.Address2);
	self.Process_Date := '20050516';
	self.Source_State := 'WV';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.Address1,left,right) + ' ' +
																			 trim(input.Address2,left,right);
	self.Lobbyist_Address_City	:= input.City;
	self.Lobbyist_Address_State	:= input.State;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_WV_2005_As_Common := project(File_Lobbyists_WV_2005,MyTransform(left));