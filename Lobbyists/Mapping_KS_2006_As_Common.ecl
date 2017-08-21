Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_KS_2006 InputRecord) 
										
										:= transform
	self.Key 							:= 'KS' + hash64(InputRecord.name);
	self.Process_Date 					:= '20060428';
	self.Source_State 					:= 'KS';
	self.Lobbyist_Name_Full 			:= InputRecord.name;
	self.Lobbyist_Address_Street_Line 	:= trim(InputRecord.address1)+' '+trim(InputRecord.address2);
	self.Lobbyist_Address_City			:= InputRecord.City;
	self.Lobbyist_Address_State			:= InputRecord.State;
	self.Lobbyist_Address_Zip			:= InputRecord.Zip;
	self.Lobbyist_Phone					:= InputRecord.Phone;
	self.Lobbyist_Email					:= InputRecord.Email;
	self.Association_Name_Full 			:= InputRecord.Firm;
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
	
end;

export Mapping_KS_2006_As_Common := project(File_Lobbyists_KS_2006,MyTransform(left));