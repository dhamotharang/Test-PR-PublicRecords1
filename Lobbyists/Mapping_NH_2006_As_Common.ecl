import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_NH_2006 input) := transform

	self.Key 								:= 'NH' + hash64(input.Name,input.Firm_Name,input.Date_Registered);
	self.Process_Date 						:= '20060406';
	self.Source_State 						:= 'NH';
	self.Lobbyist_Name_Full					:= input.name;
	self.Lobbyist_Address_Street_Line		:= input.address;
	self.Lobbyist_Address_CSZ_Line			:= input.city_state_zip;
	self.Association_Name_Full				:= input.firm_name;
	self.Association_Address_Street_Line	:= input.firm_address;
	self.Association_Address_CSZ_Line		:= input.firm_city_state_zip;

	DateFinder 								:= '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date 			:= if(regexfind(DateFinder,input.Date_Registered),
											intformat((integer)regexfind(DateFinder,input.Date_Registered,3),4,1) +
											intformat((integer)regexfind(DateFinder,input.Date_Registered,1),2,1) +
											intformat((integer)regexfind(DateFinder,input.Date_Registered,2),2,1),
											'');
											
	self.Lobby_Legislative_Year_Start 		:= '2006';
	self.Lobby_Legislative_Year_End 		:= '2006';
	self 									:= [];
	
end;

export Mapping_NH_2006_As_Common := project(File_Lobbyists_NH_2006,MyTransform(left));