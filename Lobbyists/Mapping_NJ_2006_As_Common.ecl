Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_NJ_2006 input) 

										:= transform
	self.Key 							:= 'NJ' + hash64(input.last_name,input.first_name,input.company);
	self.Process_Date 					:= '20060323';
	self.Source_State 					:= 'NJ';
	self.Lobbyist_Name_Last				:= input.last_name;
	self.Lobbyist_Name_First			:= input.first_name;
	self.Lobbyist_Name_Middle			:= input.middle_initial;
	self.Lobbyist_Address_Street_Line	:= trim(input.addr1,left,right) + ' ' +
										   trim(input.addr2,left,right) + ' ' +
										   trim(input.addr3,left,right);								   
	self.Lobbyist_Address_City			:= input.city;
	self.Lobbyist_Address_State			:= input.state;
	self.Lobbyist_Address_ZIP			:= input.zip;
	self.Association_Name_Full			:= input.company;
	self 								:= [];
	
end;

export Mapping_NJ_2006_As_Common 		:= project(File_Lobbyists_NJ_2006,MyTransform(left));