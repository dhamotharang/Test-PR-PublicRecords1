import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_TX_2001_2005 input) := transform

	self.Key := 'TX' + '2001' + hash64(input.lobby_name,input.concername);
	self.Process_Date := '20050718';
	self.Source_State := 'TX';
	self.Lobbyist_Name_Full	:= input.Lobby_Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.address1,left,right) + ' ' +
																			 trim(input.address2,left,right);
	self.Lobbyist_Address_City	:= input.city;
	self.Lobbyist_Address_State	:= input.state;
	self.Lobbyist_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.zipcode,'0123456789');
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.lobphone,'0123456789');
	self.Association_Name_Full	:= input.concername;
	self.Association_Address_Street_Line	:= trim(input.ec_addr1,left,right) + ' ' +
																		       trim(input.ec_addr2,left,right);
	self.Association_Address_City	:= input.ec_city;
	self.Association_Address_State	:= input.ec_stcd;
	self.Association_Address_Zip := lib_stringlib.stringlib.stringfilter(input.ec_zip4,'0123456789');
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date := if(regexfind(DateFinder,input.lobstart),
	                                   intformat((integer)regexfind(DateFinder,input.lobstart,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.lobstart,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.lobstart,2),2,1),
																		 ''); 
	self.Lobby_Termination_Date :=  if(regexfind(DateFinder,input.lobterm),
	                                   intformat((integer)regexfind(DateFinder,input.lobterm,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.lobterm,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.lobterm,2),2,1),
																		 '');               
	self := [];
end;

export Mapping_TX_2001_As_Common := project(File_Lobbyists_TX_2001,MyTransform(left));