Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_GA_2006 input) := transform

	self.Key 							:= 'GA' + hash64(input.last_name,input.first_name,input.association);
	self.Process_Date 					:= '20060323';
	self.Source_State 					:= 'GA';
	self.Lobbyist_Name_Last				:= input.last_name;
	self.Lobbyist_Name_First			:= input.first_name;
	self.Lobbyist_Name_Middle			:= input.middle_name;
	self.Lobbyist_Name_Suffix			:= input.suffix;
	self.Lobbyist_Address_Street_Line	:= trim(input.address1,left,right) + ' ' +
										   trim(input.address2,left,right);
	self.Lobbyist_Address_City			:= input.city;
	self.Lobbyist_Address_State			:= input.state;
	self.Lobbyist_Address_Zip			:= input.zip;
	self.Lobbyist_Phone					:= if (length(input.phone)=10, input.phone, 
										(input.phone[2..4]+
										input.phone[6..8]+
										input.Phone[10..]));
	self.Association_Name_Full			:= input.association;
	DateFinder 							:= '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date 		:= if(regexfind(DateFinder,input.date_registered),
										intformat((integer)regexfind(DateFinder,input.date_registered,3),4,1) +
										intformat((integer)regexfind(DateFinder,input.date_registered,1),2,1) +
										intformat((integer)regexfind(DateFinder,input.date_registered,2),2,1),
										'');
	self.Lobby_Legislative_Year_Start 	:= '2006';
	self.Lobby_Legislative_Year_End 	:= '2006';
	self 								:= [];
	
end;

export Mapping_GA_2006_As_Common 		:= project(File_Lobbyists_GA_2006,MyTransform(left));