import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_OR_2005 input) := transform

	self.Key := 'OR' + hash64(input.Lob_Last_Name,input.Lob_First_Name,input.Entity_Name);
	self.Process_Date := '20050512';
	self.Source_State := 'OR';
	self.Lobbyist_Name_Last	:= input.Lob_Last_Name;
	self.Lobbyist_Name_first	:= input.Lob_First_Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.Lob_Address_1,left,right) + ' ' +
																			 trim(input.Lob_Address_2,left,right);
	self.Lobbyist_Address_City	:= input.Lob_City;
	self.Lobbyist_Address_State	:= input.Lob_State;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Lob_Zip,'0123456789');
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.Lob_Phone,'0123456789');
	self.Association_Name_Full	:= input.Entity_Name;
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_OR_2005_As_Common := project(File_Lobbyists_OR_2005,MyTransform(left));