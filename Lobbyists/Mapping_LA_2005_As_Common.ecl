import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_LA_2005 input) := transform

	self.Key := 'LA' + hash64(input.Last_Name, input.First_Name, input.Address_1);
	self.Process_Date := '20051122';
	self.Source_State := 'LA';
	self.Lobbyist_Name_Last	:= input.Last_Name;
	self.Lobbyist_Name_First	:= input.First_Name;
	self.Lobbyist_Name_Middle	:= input.Middle_Name;
	self.Lobbyist_Name_Suffix	:= input.Suffix;
	self.Lobbyist_Address_Street_Line	:= trim(input.Address_1,left,right) + ' ' +
																			 trim(input.Address_2,left,right);
	self.Lobbyist_Address_City :=	input.City;											 
	self.Lobbyist_Address_State :=	input.State;											 
	self.Lobbyist_Address_Zip := lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	self.Lobby_Status := if(trim(input.Active,left,right) = 'Y', 'ACTIVE',
	                     if(trim(input.Active,left,right) = 'N', 'INACTIVE', ''));
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_LA_2005_As_Common := project(File_Lobbyists_LA_2005,MyTransform(left));
						