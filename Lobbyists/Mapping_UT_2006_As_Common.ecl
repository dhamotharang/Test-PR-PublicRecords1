import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_UT_2006 input) 

										:= transform

	self.Key 							:= 'UT' + hash64(input.last_name,input.first_name,input.address1,input.address2);
	self.Process_Date 					:= '20051229';
	self.Source_State 					:= 'UT';
	self.Lobbyist_Name_Last				:= input.last_name;
	self.Lobbyist_Name_First			:= input.first_name;
	
	self.Lobbyist_Address_Street_Line	:= trim(input.address1,left,right) + ' ' +trim(input.address2,left,right) + ' ' +trim(input.address3,left,right);								   
	self.Lobbyist_Address_City			:= trim(input.city);									   
	self.Lobbyist_Address_State			:= trim(input.state);
	self.Lobbyist_Address_Zip			:= lib_stringlib.stringlib.stringfilter(input.zip,'0123456789');
											
	self.Lobby_Legislative_Year_Start 	:= '2005';
	self.Lobby_Legislative_Year_End 	:= '2005';
	
	self 								:= [];
	
end;

export Mapping_UT_2006_As_Common 		:= project(File_Lobbyists_UT_2006,MyTransform(left));