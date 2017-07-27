MyInitialDS := Lobbyists.File_Lobbyists_NV_2005; 

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
                                 right.CompleteName = 'LLP' or
																 right.CompleteName = 'LLC' or
																 right.CompleteName = 'LTD' or
																 right.CompleteName = 'LP' or
													       right.CompleteName = 'The' or
													       right.CompleteName = 'Ltd' or
													       right.CompleteName = 'NV' or
													       right.CompleteName = 'Dev Srvcs' or
													       right.CompleteName = 'Contracts Div' or
													       right.CompleteName = 'Armstrong' or
													       right.CompleteName = 'et al' or
													       right.CompleteName = 'Redevl Agency' or
													       right.CompleteName = 'LV Chapter' or
													       right.CompleteName = 'LLC/Las Vegas' or
													       right.CompleteName = 'NV Chapter' or
													       right.CompleteName = 'Alc' or
													       right.CompleteName = 'Drug & Gamb' or
													       right.CompleteName = 'Center' or
													       right.CompleteName = 'LLC/Reno 1' or
													       right.CompleteName = 'LLC/Reno 2' or
													       right.CompleteName = 'Youth' or
													       right.CompleteName = '& Family' or
													       right.CompleteName = 'Corp' or
													       right.CompleteName = 'Susich' or
													       right.CompleteName = 'Owen & Tackes' or
													       right.CompleteName = 'Interior & Res Design' or
													       right.CompleteName = 'A Mutual Co' or
													       right.CompleteName = 'Unlimited',
													       
																 
  MyRollup(left,right));

	
Layout_Lobbyists_Common MyTransform(MyParsedRecord input) := transform

	self.Key := 'NV' + hash64(input.Name,input.Address,input.CompleteName);
	self.Process_Date := '20050526';
	self.Source_State := 'NV';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Lobbyist_Address_Street_Line	:= input.Address;
	self.Lobbyist_Address_CSZ_Line	:= input.City_State_Zip;
	self.Lobby_Legislative_Year_Start	:= '2005';
	self.Lobby_Legislative_Year_End	:= '2005';
	self.Association_Name_Full	:= input.CompleteName;
	self := [];
end;

export Mapping_NV_2005_As_Common := project(MyRolledDS,MyTransform(left));