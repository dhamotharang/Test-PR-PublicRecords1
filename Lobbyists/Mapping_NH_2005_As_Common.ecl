import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_NH_2005 input) := transform

	self.Key := 'NH' + hash64(input.Name,input.Firm_Name,input.Date_Registered);
	self.Process_Date := '20050525';
	self.Source_State := 'NH';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Lobbyist_Address_Street_Line	:= input.Address;
	self.Lobbyist_Address_City	:= input.City;
	self.Lobbyist_Address_State	:= input.State;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	self.Association_Name_Full	:= input.Firm_Name;
	self.Association_Address_Street_Line	:= input.Firm_Address;
	self.Association_Address_City	:= input.Firm_City;
	self.Association_Address_State	:= input.Firm_State;
	self.Association_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Firm_Zip,'0123456789');
	
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date := if(regexfind(DateFinder,input.Date_Registered),
	                                   intformat((integer)regexfind(DateFinder,input.Date_Registered,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.Date_Registered,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.Date_Registered,2),2,1),
																		 '');
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_NH_2005_As_Common := project(File_Lobbyists_NH_2005,MyTransform(left));