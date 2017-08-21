import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_CO_2006 input) := transform

	self.Key 								:= 'CO' + hash64(input.lobbyist_last_name,input.lobbyist_first_name,input.lobbyist_address_1,input.lobbyist_address_2);
	self.Process_Date 						:= '20060417';
	self.Source_State 						:= 'CO';
	self.Lobbyist_Name_Last					:= if(input.lobbyist_first_name = '', '', input.lobbyist_last_name);      
	self.Lobbyist_Name_First 				:= if(input.lobbyist_first_name = '', '', input.lobbyist_first_name); 
	self.Lobbyist_Address_Street_Line		:= if(input.lobbyist_first_name = '', '', 
											   trim(input.lobbyist_address_1,left,right) + ' ' +
											   trim(input.lobbyist_address_2,left,right));
	self.Lobbyist_Address_City				:= if(input.lobbyist_first_name = '', '', input.lobbyist_city);
	self.Lobbyist_Address_State				:= if(input.lobbyist_first_name = '', '', input.lobbyist_state);
	self.Lobbyist_Address_Zip				:= if(input.lobbyist_first_name = '', '', lib_stringlib.stringlib.stringfilter(input.lobbyist_zip,'0123456789'));
	
	self.Firm_Name_Full 					:= if(input.lobbyist_first_name = '', input.lobbyist_last_name, '');
	self.Firm_Address_Street_Line 			:= if(input.lobbyist_first_name = '',  
											   trim(input.lobbyist_address_1,left,right) + ' ' +
											   trim(input.lobbyist_address_2,left,right),'');
	self.Firm_Address_City 					:= if(input.lobbyist_first_name = '', input.lobbyist_city,'');
	self.Firm_Address_State 				:= if(input.lobbyist_first_name = '', input.lobbyist_state,''); 
	self.Firm_Address_Zip 					:= if(input.lobbyist_first_name = '', lib_stringlib.stringlib.stringfilter(input.lobbyist_zip,'0123456789'),'');

	self.Association_Name_Full				:= input.employer_name;
	self.Association_Address_Street_Line	:= trim(input.employer_address_1,left,right) + ' ' +
											   trim(input.employer_address_2,left,right);
	self.Association_Address_City			:= input.employer_city;	
	self.Association_Address_State			:= input.employer_state;
	self.Association_Address_ZIP			:= input.employer_zip;
	
	self.Lobby_Legislative_Year_Start 		:= '2006';
	self.Lobby_Legislative_Year_End 		:= '2006';
	self 									:= [];
	
end;

export Mapping_CO_2006_As_Common 			:= project(File_Lobbyists_CO_2006,MyTransform(left));