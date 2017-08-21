import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_CA_2006 input) := transform

	self.Key 							:= 'CA' + hash64(input.last_name,input.first_name,input.employer,input.address1);
	self.Process_Date 					:= '20060914';
	self.Source_State 					:= 'CA';
	self.Lobbyist_Name_Last				:= input.last_name;
	self.Lobbyist_Name_First			:= input.first_name;
	self.Lobbyist_Address_Street_Line	:= trim(input.address1,left,right) + ' ' +
										   trim(input.address2,left,right);
	self.Lobbyist_Address_City			:= input.city;
	self.Lobbyist_Address_State			:= input.state;
	self.Lobbyist_Address_Zip			:= lib_stringlib.stringlib.stringfilter(input.zip,'0123456789');
	self.Lobbyist_Phone					:= lib_stringlib.stringlib.stringfilter(input.phone,'0123456789');
	self.Association_Name_Full			:= input.employer;
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
end;

export Mapping_CA_2006_As_Common := project(File_Lobbyists_CA_2006,MyTransform(left));