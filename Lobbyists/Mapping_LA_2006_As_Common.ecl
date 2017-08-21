import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_LA_2006 input) := transform

	self.Key 							:= 'LA' + hash64(input.Last_Name, input.First_Name, input.Address_1);
	self.Process_Date 					:= '20060428';
	self.Source_State 					:= 'LA';
	self.Lobbyist_Name_Last				:= input.Last_Name;
	self.Lobbyist_Name_First			:= input.First_Name;
	self.Lobbyist_Name_Middle			:= input.Middle_Name;
	self.Lobbyist_Name_Suffix			:= input.Suffix;
	self.Lobbyist_Address_Street_Line	:= trim(input.Address_1,left,right) + ' ' +
									       trim(input.Address_2,left,right);
	
	self.Lobbyist_Address_City 			:=	input.City;											 
	self.Lobbyist_Address_State 		:=	input.State;											 
	self.Lobbyist_Address_Zip 			:= lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	
	self.Lobbyist_Phone					:= if (length(input.phone)>10, 
										(input.phone[2..4]+input.phone[6..8]+input.Phone[10..]),
										(input.phone[1..3]+input.phone[5..7]+input.Phone[9..]));
										
	self.Lobbyist_Fax					:= if (length(input.fax)>10, 
										(input.fax[2..4]+input.fax[6..8]+input.fax[10..]),
										(input.fax[1..3]+input.fax[5..7]+input.fax[9..]));
										
	self.Lobby_Status 					:= if(trim(input.legis_active,left,right) = 'Y', 'ACTIVE',
										if(trim(input.legis_active,left,right) = 'N', 'INACTIVE', ''));
	
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	
	self := [];
end;

export Mapping_LA_2006_As_Common 		:= project(File_Lobbyists_LA_2006,MyTransform(left));
						