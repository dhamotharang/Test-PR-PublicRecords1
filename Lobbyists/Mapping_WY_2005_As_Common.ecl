MyInitialDS := Lobbyists.File_Lobbyists_WY_2005; 

pattern SingleClient := pattern('[^,]+');

MyParsedRecord := record 
	MyInitialDS;
	string CompleteName := trim(matchtext(SingleClient),left,right);
end;
	
MyParsedDS := parse(MyInitialDS,Clients,SingleClient,MyParsedRecord,scan,first);
	
MyParsedRecord MyRollup(MyParsedRecord l, MyParsedRecord r) := transform
	self.CompleteName := l.CompleteName + ', ' + r.CompleteName;
	self := l;
end;

MyRolledDS := rollup(MyParsedDS, right.CompleteName = 'Inc' or
																 right.CompleteName = 'Inc.' or
																 right.CompleteName = 'INC' or
                                 right.CompleteName = 'LLP' or
																 right.CompleteName = 'LLC' or
																 right.CompleteName = 'LTD' or
																 right.CompleteName = 'Ltd.' or
																 right.CompleteName = 'Ltd' or
																 right.CompleteName = 'LP' or
																 right.CompleteName = 'L.P.' or
																 right.CompleteName = 'LC' or
													       right.CompleteName = 'PC' or
													       right.CompleteName = 'Cheyenne' or
													       right.CompleteName = 'WY 82001' or
													       right.CompleteName = '(307) 635-8761' or
													       right.CompleteName = '(307) 637-7556' or
													       right.CompleteName = 'Organization' or
													       right.CompleteName = 'Consulting' or
													       right.CompleteName = 'West Haven' or                                                                                                              
 													       right.CompleteName = 'CT 06516' or
 													       right.CompleteName = 'Inc. by its service corporation' or                                                                     
 													       right.CompleteName = 'Inc. and other subsidiaries of its present company', 
							 
MyRollup(left,right));

import lib_stringlib;

Layout_Lobbyists_Common MyTransform(MyRolledDS input) := transform
	self.Key := 'WY' + hash64(input.Name,input.CompleteName);
	self.Process_Date := '20050627';
	self.Source_State := 'WY';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Lobbyist_Address_Street_Line	:= input.Address;
	self.Lobbyist_Address_CSZ_Line	:= input.City_State_Zip;
	self.Lobbyist_Phone	:= lib_stringlib.stringlib.stringfilter(input.Telephone,'0123456789');
	self.Association_Name_Full := input.CompleteName;
	self.Lobby_Registration_Date := input.Year_Registered;
	self := [];
end;

Export Mapping_WY_2005_As_Common := project(MyRolledDS,MyTransform(left));









																
