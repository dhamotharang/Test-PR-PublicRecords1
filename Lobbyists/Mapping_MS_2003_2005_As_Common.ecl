MyInitialDS := Lobbyists.File_Lobbyists_MS_2003_2005; 

pattern SingleName := pattern('[^;]+');

MyParsedRecord := record 
	MyInitialDS;
	string SingleClient := trim(matchtext(SingleName),left,right);
end;
	
MyParsedDS := parse(MyInitialDS,Client_List,SingleName,MyParsedRecord,scan,first);

import lib_stringlib;

Layout_Lobbyists_Common MyTransform(MyParsedRecord input) := transform

	self.Key := 'MS' + hash64(input.Year,input.SingleClient,input.Registration_Date);
	self.Process_Date := '20050607';
	self.Source_State := 'MS';
	self.Lobby_Legislative_Year_Start := input.Year;
	self.Lobbyist_Name_Full := input.Name;
	self.Lobbyist_Address_Street_Line := input.Address;
	self.Lobbyist_Address_CSZ_Line := input.City_State_Zip;
	self.Lobbyist_Phone := lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Lobbyist_Fax := lib_stringlib.stringlib.stringfilter(input.Fax,'0123456789');
	AssocNumSplit	:= '^(.*)[(]([0-9]+)';
	self.Association_Name_Full := regexfind(AssocNumSplit,input.SingleClient,1);
	self.Association_State_Id := regexfind(AssocNumSplit,input.SingleClient,2);
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date := if(regexfind(DateFinder,input.Registration_Date),
	                                   intformat((integer)regexfind(DateFinder,input.Registration_Date,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.Registration_Date,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.Registration_Date,2),2,1),
																		 '');
	self := [];
end;

export Mapping_MS_2003_2005_As_Common := project(MyParsedDS,MyTransform(left));