import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_OR_2006 input) := transform

	self.Key 							:= 'OR' + hash64(input.Last_Name,input.First_Name,input.Entity_Name);
	self.Process_Date 					:= '20050512';
	self.Source_State 					:= 'OR';
	self.Lobbyist_Name_Last				:= input.Last_Name;
	self.Lobbyist_Name_first			:= input.First_Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.Address1,left,right) + ' ' +
										   trim(input.Address2,left,right);
	self.Lobbyist_Address_City			:= input.City;
	self.Lobbyist_Address_State			:= input.State;
	self.Lobbyist_Address_Zip			:= lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	self.Lobbyist_Phone					:= lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Association_Name_Full			:= input.Entity_Name;
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
	
end;

export Mapping_OR_2006_As_Common := project(File_Lobbyists_OR_2006,MyTransform(left));