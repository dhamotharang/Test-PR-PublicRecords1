import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_TX_1997_2000 input) := transform

	self.Key := 'TX' + '1998' + hash64(input.Lob_Name,input.Concern);
	self.Process_Date := '20050718';
	self.Source_State := 'TX';
	self.Lobbyist_Name_Full	:= input.Lob_Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.lob_busad1,left,right) + ' ' +
																			 trim(input.lob_busad2,left,right) + ' ' + 
																			 if(trim(input.lob_busad_ste,left,right) <> '', 'Suite' + ' ' + input.lob_busad_ste, '');																			 
	self.Lobbyist_Address_City	:= input.lob_busad_cty;
	self.Lobbyist_Address_State	:= input.lob_busad_st;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.lob_busad_zip,'0123456789');
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.lob_bus_phone,'0123456789');
	self.Association_Name_Full	:= input.concern;
	self.Association_Address_Street_Line	:= trim(input.conadd1,left,right) + ' ' +
																		       trim(input.conadd2,left,right) + ' ' +
																					 if(trim(input.consuite,left,right) <> '', 'Suite' + ' ' + input.consuite, ''); 
	self.Association_Address_City	:= input.concity;
	self.Association_Address_State	:= input.constate;
	self.Association_Address_Zip := lib_stringlib.stringlib.stringfilter(input.conzip,'0123456789');
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Termination_Date :=  if(regexfind(DateFinder,input.termdate),
	                                   intformat((integer)regexfind(DateFinder,input.termdate,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.termdate,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.termdate,2),2,1),
																		 '');               
	self.Lobby_Legislative_Year_Start := '1998';
	self.Lobby_Legislative_Year_End := '1998';
	self := [];
end;

export Mapping_TX_1998_As_Common := project(File_Lobbyists_TX_1998,MyTransform(left));