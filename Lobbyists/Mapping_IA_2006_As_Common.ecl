Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_IA_2006 InputRecord) := transform
	self.Key 							:= 'IA' + hash64(InputRecord.Lobbyist_ID,InputRecord.Client_ID);
	self.Process_Date 					:= '20060323';
	self.Source_State 					:= 'IA';
	
	Lobbyist_Is_Person 					:= trim(InputRecord.Firm_Name) = '';
	self.Lobbyist_State_ID 				:= InputRecord.Lobbyist_ID;
	self.Lobbyist_Name_Full 			:= if(Lobbyist_Is_Person,trim(InputRecord.Lobbyist_Name),'');
	self.Lobbyist_Address_Street_Line	:= if(Lobbyist_Is_Person,trim(InputRecord.Firm_Address),'');
	self.Lobbyist_Address_CSZ_Line 		:= if(Lobbyist_Is_Person,trim(InputRecord.Firm_City_State_zip),'');
	
	self.Firm_Name_Full					:= if(Lobbyist_Is_Person,'',trim(InputRecord.Firm_Name));
	self.Firm_Address_Street_Line 		:= if(Lobbyist_Is_Person,'',trim(InputRecord.Firm_Address));
	self.Firm_Address_CSZ_Line 			:= if(Lobbyist_Is_Person,'',trim(InputRecord.Firm_City_State_zip));
	self.Association_State_ID 			:= InputRecord.Client_ID;
	self.Association_Name_Full 			:= trim(InputRecord.Client_Name_Full);
	self.Lobby_Registration_Date 		:= if(InputRecord.Lobbyist_Reg_Date <> '',
										InputRecord.Lobbyist_Reg_Date[7..10] +
										InputRecord.Lobbyist_Reg_Date[1..2] +
										InputRecord.Lobbyist_Reg_Date[4..5],
    					                '');
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
	
end;

export Mapping_IA_2006_As_Common 		:= project(File_Lobbyists_IA_2006,MyTransform(left));