MyInitialDS := Lobbyists.File_Lobbyists_DC_2005; 

pattern SingleLobbyist := pattern('[^,]+');

MyParsedRecord := record 
	MyInitialDS;
	string CompleteName := trim(matchtext(SingleLobbyist),left,right);
end;
	
MyParsedDS := parse(MyInitialDS,Lobbyist_Name,SingleLobbyist,MyParsedRecord,scan,first);
	
MyParsedRecord MyRollup(MyParsedRecord l, MyParsedRecord r) := transform
	self.CompleteName := l.CompleteName + ', ' + r.CompleteName;
	self := l;
end;
 
MyRolledDS := rollup(MyParsedDS, right.CompleteName = 'Jr' or
                                 right.CompleteName = 'PC' or
																 right.CompleteName = 'PL' or
																 right.CompleteName = 'Esq' or
																 right.CompleteName = 'Esquire' or
																 right.CompleteName = 'PLLC' or
																 right.CompleteName = 'Phelps & Phil' or
																 right.CompleteName = 'Phelps & Phillips' or
																 right.CompleteName = 'Luchs' or
																 right.CompleteName = 'DeLorme & Nicola Whiteman' or      
																 right.CompleteName = 'Lawrence' or
																 right.CompleteName = 'Ronald' or
																 right.CompleteName = 'Bernard' or
																 right.CompleteName = 'Douglass' or
																 right.CompleteName = 'Frank' or
																 right.CompleteName = 'Robert' or
																 right.CompleteName = 'James' or
																 right.CompleteName = 'Jim' or
																 right.CompleteName = 'Douglass' or
																 right.CompleteName = 'Richard A' or
																 right.CompleteName = 'Richard',										       																 
MyRollup(left,right));

import lib_stringlib;

Layout_Lobbyists_Common MyTransform(MyParsedRecord input) := transform

	self.Key := 'DC' + hash64(input.Registrant_Date,input.CompleteName);
	self.Process_Date := '20050614';
	self.Source_State := 'DC';
	lobbyistiscompany := func_is_company (input.CompleteName);
	self.Lobbyist_Name_Full	:= if(input.CompleteName = input.Compensating_Registrant or 
	                              input.CompleteName = input.Registrant_Name, '', input.CompleteName);
  self.Lobbyist_Address_Street_Line := if (lobbyistiscompany, '', input.Permanent_Address);
	self.Lobbyist_Address_CSZ_Line := if (lobbyistiscompany, '', input.City_State_Zip);
	self.Lobbyist_State_ID	:= input.Lobbyist_ID;
	self.Firm_Name_Full	:= if(input.Registrant_Name = input.Compensating_Registrant, '', input.Registrant_Name);
	self.Firm_Address_Street_Line	:=	if (lobbyistiscompany, input.Permanent_Address, '');
	self.Firm_Address_CSZ_Line	:= if (lobbyistiscompany, input.City_State_Zip, '');
	self.Association_Name_Full	:= input.Compensating_Registrant;
	self.Association_Address_Street_Line	:=	input.Comp_Address;
	self.Association_Address_CSZ_Line	:=	input.Comp_City_State_Zip;
	self.Lobby_Subject	:= input.Nature_Of_Lobbying;
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date := if(regexfind(DateFinder,input.Registrant_Date),
	                                   intformat((integer)regexfind(DateFinder,input.Registrant_Date,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.Registrant_Date,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.Registrant_Date,2),2,1),
																		 '');
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_DC_2005_As_Common := project(MyRolledDS,MyTransform(left));