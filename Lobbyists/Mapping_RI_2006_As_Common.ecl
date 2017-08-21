import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_RI_2006 input) := transform

	self.Key 							:= 'RI' + hash64(input.lobbyist_name,input.lobbyist_id);
	self.Process_Date 					:= '20060329';
	self.Source_State 					:= 'RI';
	self.Association_Name_Full			:= input.entity_name;
	self.Lobbyist_Name_Full				:= input.lobbyist_name;
	self.Firm_Name_Full					:= input.lobby_firm_name;
	self.Lobbyist_Type					:= input.relationship_type;
	self.Lobbyist_State_ID				:= input.lobbyist_id;
	self.Lobbyist_Address_Street_Line	:= input.street_address;
	self.Lobbyist_Phone					:= lib_stringlib.stringlib.stringfilter(input.lobbyist_phone,'0123456789');
	self.Lobbyist_Address_CSZ_Line		:= input.city_state;
	
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self := [];
end;

export Mapping_RI_2006_As_Common 		:= project(File_Lobbyists_RI_2006,MyTransform(left));