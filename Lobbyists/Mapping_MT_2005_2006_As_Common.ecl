import lib_stringlib;

MyLayout := Layout_Lobbyists_MT_2000_2006;

MyLayout MyIteration(MyLayout L, MyLayout R) := transform
	IsLobbyistLine := (trim(R.text_131,left,right) = '');
	self.lobbyist_name := if(IsLobbyistLine,R.Lobbyist_Name,L.Lobbyist_Name);
	self.lobbyist_address := if(IsLobbyistLine,R.Lobbyist_Address,L.Lobbyist_Address);
	self.lobbyist_phone := if(IsLobbyistLine,R.Lobbyist_Phone,L.Lobbyist_Phone);
	self := R;
	end;
	
MyReproducedData := iterate(File_Lobbyists_MT_2005_2006,MyIteration(left,right));

MyNewData := MyReproducedData(trim(text_131,left,right) <> '');

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_MT_2000_2006 input) := transform
	self.Key := 'MT' + hash64(input.Lobbyist_Name,input.Entity_Name);
	self.Process_Date := '20050718';
	self.Source_State := 'MT';
	self.Lobbyist_Name_Full	:= input.Lobbyist_Name;
	self.Lobbyist_Address_Whole := input.Lobbyist_Address;
	self.Lobbyist_Phone := lib_stringlib.stringlib.stringfilter(input.Lobbyist_Phone,'0123456789');
	self.Association_Name_Full	:= input.Entity_Name;
	self.Association_Address_Street_Line	:= input.Entity_Address_1;
	self.Association_Address_CSZ_Line	:= input.Entity_CSZ;
	self.Association_Phone	:= lib_stringlib.stringlib.stringfilter(input.Work_Phone,'0123456789');
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	self.Lobby_Registration_Date := if(regexfind(DateFinder,input.Date_Authorized),
	                                   intformat((integer)regexfind(DateFinder,input.Date_Authorized,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.Date_Authorized,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.Date_Authorized,2),2,1),
																		 '');
	self.Lobby_Termination_Date := if(regexfind(DateFinder,input.Date_Terminated),
	                                   intformat((integer)regexfind(DateFinder,input.Date_Terminated,3),4,1) +
																		 intformat((integer)regexfind(DateFinder,input.Date_Terminated,1),2,1) +
																		 intformat((integer)regexfind(DateFinder,input.Date_Terminated,2),2,1),
																		 '');
  self := [];
end;

export Mapping_MT_2005_2006_As_Common := project(MyNewData,MyTransform(left));
