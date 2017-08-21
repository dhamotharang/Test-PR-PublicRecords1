import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_CO_2005 input) := transform

	self.Key := 'CO' + hash64(input.lobbyist_last_name,input.lobbyist_first_name,input.lobbyist_address_1);
	self.Process_Date := '20051128';
	self.Source_State := 'CO';
	self.Lobbyist_Name_Last	:= if(input.lobbyist_first_name = '', '', input.lobbyist_last_name);      
	self.Lobbyist_Name_First := if(input.lobbyist_first_name = '', '', input.lobbyist_first_name); 
	self.Lobbyist_Name_Middle	:= if(input.lobbyist_first_name = '', '', input.lobbyist_middle_name); 
	self.Lobbyist_Address_Street_Line	:= if(input.lobbyist_first_name = '', '', 
																			 trim(input.lobbyist_address_1,left,right) + ' ' +
																			 trim(input.lobbyist_address_2,left,right));
	self.Lobbyist_Address_City	:= if(input.lobbyist_first_name = '', '', input.lobbyist_city);
	self.Lobbyist_Address_State	:= if(input.lobbyist_first_name = '', '', input.lobbyist_state);
	self.Lobbyist_Address_Zip	:= if(input.lobbyist_first_name = '', '', lib_stringlib.stringlib.stringfilter(input.lobbyist_zip,'0123456789'));
	self.Lobbyist_Phone	:= if(input.lobbyist_first_name = '', '', lib_stringlib.stringlib.stringfilter(input.lobbyist_phone,'0123456789'));
	self.Firm_Name_Full := if(input.lobbyist_first_name = '', input.lobbyist_last_name, '');
	self.Firm_Address_Street_Line := if(input.lobbyist_first_name = '',  
																	 trim(input.lobbyist_address_1,left,right) + ' ' +
																	 trim(input.lobbyist_address_2,left,right),'');
	self.Firm_Address_City := if(input.lobbyist_first_name = '', input.lobbyist_city,'');
	self.Firm_Address_State := if(input.lobbyist_first_name = '', input.lobbyist_state,''); 
	self.Firm_Address_Zip := if(input.lobbyist_first_name = '', lib_stringlib.stringlib.stringfilter(input.lobbyist_zip,'0123456789'),'');
	self.Firm_Phone := if(input.lobbyist_first_name = '', lib_stringlib.stringlib.stringfilter(input.lobbyist_phone,'0123456789'),'');
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_CO_2005_As_Common := project(File_Lobbyists_CO_2005,MyTransform(left));