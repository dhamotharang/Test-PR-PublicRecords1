Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_OH_2006 input) 

										:= transform
	self.Key 							:= 'OH' + hash64(input.last_name,input.first_name,input.address);
	self.Process_Date 					:= '20060327';
	self.Source_State 					:= 'OH';
	self.Lobbyist_Name_Last				:= input.last_name;
	self.Lobbyist_Name_First			:= input.first_name;
	self.Lobbyist_Address_Street_Line	:= input.address;
	self.Lobbyist_Address_City			:= input.city;
	self.Lobbyist_Address_State			:= input.state;
	self.Lobbyist_Address_ZIP			:= input.zip;
	self.Lobbyist_Phone					:= input.phone;
	self.Lobby_Legislative_Year_Start	:= '2006';
	self.Lobby_Legislative_Year_End		:= '2006';
	self 								:= [];
	
end;

export Mapping_OH_2006_As_Common 		:= project(File_Lobbyists_OH_2006,MyTransform(left));