import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_WV_2006 input) 

										:= transform

	self.Key 							:= 'WV' + hash64(input.Name,input.Address1,input.Address2);
	self.Process_Date 					:= '20060328';
	self.Source_State 					:= 'WV';
	self.Lobbyist_Name_Full				:= input.name;
	self.Lobbyist_Address_Street_Line	:= trim(input.address1,left,right) + ' ' +
										   trim(input.address2,left,right);
	self.Lobbyist_Address_City			:= input.city;
	self.Lobbyist_Address_State			:= input.state;
	self.Lobbyist_Address_Zip			:= lib_stringlib.stringlib.stringfilter(input.zip,'0123456789');
	self.Lobbyist_Phone					:= lib_stringlib.stringlib.stringfilter(input.phone,'0123456789');
	self.Lobbyist_Email					:= trim(input.email,left,right);
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
	
end;

export Mapping_WV_2006_As_Common 		:= project(File_Lobbyists_WV_2006,MyTransform(left));