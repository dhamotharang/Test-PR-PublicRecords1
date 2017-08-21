import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_MI_2006 InputRecord) 
										
										:= transform
	self.Key 							:= 'MI' + hash64(InputRecord.lobby_last_name,InputRecord.lobby_first_name);
	self.Process_Date 					:= '20060323';
	self.Source_State 					:= 'MI';
	
	self.Lobbyist_State_ID				:= InputRecord.lobby_id;
	self.Lobbyist_Type					:= InputRecord.lobby_type;
	self.Lobbyist_Name_Last				:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_last_name); 
	self.Lobbyist_Name_First			:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_first_name);
	self.Lobbyist_Name_Middle			:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_middle_name); 
	self.Lobbyist_Address_Street_Line 	:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', trim(InputRecord.lobby_address));
	self.Lobbyist_Address_City			:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_city);
	self.Lobbyist_Address_State			:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_state); 
	self.Lobbyist_Address_Zip			:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_zip);
	self.Lobbyist_Phone					:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', '', InputRecord.lobby_phone); 
	
	self.Firm_Name_Full 				:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', InputRecord.lobby_last_name, '');
	self.Firm_Address_Street_Line 		:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', trim(InputRecord.lobby_address),'');
	self.Firm_Address_City 				:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', InputRecord.lobby_city,'');
	self.Firm_Address_State 			:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', InputRecord.lobby_state,''); 
	self.Firm_Address_Zip 				:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', lib_stringlib.stringlib.stringfilter(InputRecord.lobby_zip,'0123456789'),'');
	self.Firm_Phone						:= if(InputRecord.lobby_first_name = '' or InputRecord.lobby_first_name = 'CITY', InputRecord.lobby_phone, '');
	
	self.Association_Name_Full			:= InputRecord.lobby_signatory;
	
	DateFinder 							:= '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date		:= if(regexfind(DateFinder,InputRecord.lobby_active_date),
										intformat((integer)regexfind(DateFinder,InputRecord.lobby_active_date,3),4,1) +
										intformat((integer)regexfind(DateFinder,InputRecord.lobby_active_date,1),2,1) +
										intformat((integer)regexfind(DateFinder,InputRecord.lobby_active_date,2),2,1),
										'');

	self.Lobby_Termination_Date			:= if(regexfind(DateFinder,InputRecord.lobby_termination_date),
										intformat((integer)regexfind(DateFinder,InputRecord.lobby_termination_date,3),4,1) +
										intformat((integer)regexfind(DateFinder,InputRecord.lobby_termination_date,1),2,1) +
										intformat((integer)regexfind(DateFinder,InputRecord.lobby_termination_date,2),2,1),
										'');
										
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
	
end;

export Mapping_MI_2006_As_Common := project(File_Lobbyists_MI_2006,MyTransform(left));