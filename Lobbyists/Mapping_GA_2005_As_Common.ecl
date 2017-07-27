Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_GA_2005 input) := transform

	self.Key := 'GA' + hash64(input.Last_Name,input.First_Name,input.Association);
	self.Process_Date := '20050518';
	self.Source_State := 'GA';
	self.Lobbyist_Name_Last	:= input.Last_Name;
	self.Lobbyist_Name_First	:= input.First_Name;
	self.Lobbyist_Name_Middle	:= input.Middle_Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.Address1,left,right) + ' ' +
																			 trim(input.Address2,left,right);
	self.Lobbyist_Address_City	:= input.City;
	self.Lobbyist_Address_State	:= input.State;
	self.Lobbyist_Address_Zip	:= input.Zip;
	self.Lobbyist_Phone	:= input.Phone[1..3]+
                         input.Phone[5..7]+
												 input.Phone[9..];
	self.Association_Name_Full	:= input.Association;
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

export Mapping_GA_2005_As_Common := project(File_Lobbyists_GA_2005,MyTransform(left));