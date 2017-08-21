Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_SD_2006 input) := transform

	self.Key 								:= 'SD' + hash64(input.Lobbyist_Name,input.Employer_Name);
	self.Process_Date 						:= '20060414';
	self.Source_State 						:= 'SD';
	self.Lobbyist_Name_Full 				:= input.Lobbyist_Name;
	self.Lobbyist_Address_Street_Line		:= input.Lobbyist_Address;
	self.Lobbyist_Address_CSZ_Line			:= input.Lobbyist_City_State_Zip;
	self.Association_Name_Full 				:= input.Employer_Name;
	self.Association_Address_Street_Line	:= input.Employer_Address;
	self.Association_Address_CSZ_Line		:= input.Employer_City_State_Zip;
	self.Lobby_Legislative_Year_Start 		:= '2006';
	self.Lobby_Legislative_Year_End 		:= '2006';
	self 									:= [];
	
end;

export Mapping_SD_2006_As_Common := project(File_Lobbyists_SD_2006,MyTransform(left));