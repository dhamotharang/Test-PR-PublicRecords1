import lib_stringlib;

PLayout := record
	unsigned seq_num := 0;
	unsigned group_num := 0;
	Lobbyists.Layout_Lobbyists_OK_2005;
end;

PLayout  AddSequenceTrf(Lobbyists.File_Lobbyists_OK_2005 l, INTEGER c) := transform
	self.seq_num   := c;
	self.group_num := 0;
	self := l;
end;

pout := project(Lobbyists.File_Lobbyists_OK_2005, AddSequenceTrf(LEFT, COUNTER));

PLayout SeqIterationTrf(PLayout L, PLayout R) := transform
	IsLineEmpty    := (trim(L.Lobbyist_Name_And_Address + L.Firm_Name_And_Address + L.Clients ,left,right) = '');
	self.group_num := if(IsLineEmpty,R.seq_num,L.group_num);
	self := R;
end;
	
MyRecordGroups := iterate(pout,SeqIterationTrf(left,right));

//output(MyRecordGroups);

MyLobbyistFormat := record
  MyRecordGroups.seq_num;
	MYRecordGroups.group_num;
	MyRecordGroups.Lobbyist_Name_And_Address;
end;

LobbyistNameAddrPhoneTable := table(MyRecordGroups,MyLobbyistFormat);

FilterLobbyistTable := LobbyistNameAddrPhoneTable(Lobbyist_Name_And_Address <> '');

//output(FilterLobbyistTable);

MyFirmFormat := record
	MyRecordGroups.seq_num;
  MYRecordGroups.group_num;
	MyRecordGroups.Firm_Name_And_Address;
end;

FirmTable := table(MyRecordGroups,MyFirmFormat);

FilterFirmTable := FirmTable(Firm_Name_And_Address <> '');

//output(FilterFirmTable);

MyClientsFormat := record
  MyRecordGroups.seq_num;
  MyRecordGroups.group_num;
	MyRecordGroups.Clients;
end;

ClientsTable := table(MyRecordGroups,MyClientsFormat);

FilterClientsTable := ClientsTable(Clients <> '');

//output(FilterClientsTable);

Layout_Lobbyist := record
  MyRecordGroups.group_num;
	string Lobbyist_name;
	string Lobbyist_Address1;
	string Lobbyist_Address2;
	string Lobbyist_Phone;
end;

Layout_Lobbyist LobbyTransform(MyLobbyistFormat l) := transform
	self.group_num         := l.group_num;
	self.Lobbyist_name     := if((l.seq_num-l.group_num) = 0,l.Lobbyist_Name_And_Address,'');
	self.Lobbyist_Address1 := if((l.seq_num-l.group_num) = 1,l.Lobbyist_Name_And_Address,'');
	self.Lobbyist_Address2 := if((l.seq_num-l.group_num) = 2,l.Lobbyist_Name_And_Address,'');
	self.Lobbyist_Phone    := if((l.seq_num-l.group_num) = 3,l.Lobbyist_Name_And_Address,'');
end;
	
LobbyistGroupRecs := project(FilterLobbyistTable,LobbyTransform(left));

//output(LobbyistGroupRecs);

Layout_Lobbyist LobbyRollup(Layout_Lobbyist l, Layout_Lobbyist r) := transform
	self.group_num         := l.group_num;
	self.Lobbyist_name     := if(l.Lobbyist_name = '',r.Lobbyist_name,l.Lobbyist_name);
	self.Lobbyist_Address1 := if(l.Lobbyist_Address1  = '',r.Lobbyist_Address1,l.Lobbyist_Address1);
	self.Lobbyist_Address2 := if(l.Lobbyist_Address2  = '',r.Lobbyist_Address2,l.Lobbyist_Address2);
	self.Lobbyist_Phone    := if(l.Lobbyist_Phone     = '',r.Lobbyist_Phone,l.Lobbyist_Phone);
end;

Lobbyist_recs_rollup := rollup(LobbyistGroupRecs, LobbyRollup(Left, Right), group_num);
//output(Lobbyist_recs_rollup);

Layout_Firm := record
  MyRecordGroups.group_num;
	string Firm_name;
	string Firm_Address1;
	string Firm_Address2;
	string Firm_Phone;
end;

Layout_Firm FirmTransform(MyFirmFormat l) := transform
	self.group_num     := l.group_num;
	self.Firm_name     := if((l.seq_num-l.group_num) = 0,l.Firm_Name_And_Address,'');
	self.Firm_Address1 := if((l.seq_num-l.group_num) = 1,l.Firm_Name_And_Address,'');
	self.Firm_Address2 := if((l.seq_num-l.group_num) = 2,l.Firm_Name_And_Address,'');
	self.Firm_Phone    := if((l.seq_num-l.group_num) = 3,l.Firm_Name_And_Address,'');
end;
	
FirmGroupRecs := project(FilterFirmTable,FirmTransform(left));

//output(FirmGroupRecs);

Layout_Firm FirmRollup(Layout_Firm l, Layout_Firm r) := transform
	self.group_num     := l.group_num;
	self.Firm_name     := if(l.Firm_name      = '',r.Firm_name,l.Firm_name);
	self.Firm_Address1 := if(l.Firm_Address1  = '',r.Firm_Address1,l.Firm_Address1);
	self.Firm_Address2 := if(l.Firm_Address2  = '',r.Firm_Address2,l.Firm_Address2);
	self.Firm_Phone    := if(l.Firm_Phone     = '',r.Firm_Phone,l.Firm_Phone);
end;

Firm_recs_rollup := rollup(FirmGroupRecs, FirmRollup(Left, Right), group_num);
//output(Firm_recs_rollup);

Layout_Join_Lobbyist_Firm := record
  Layout_Lobbyist;
	string Firm_name;
	string Firm_Address1;
	string Firm_Address2;
	string Firm_Phone;
end;

Layout_Join_Lobbyist_Firm LobbyFirmJoinTrf(Layout_Lobbyist l, Layout_Firm r) := transform
	self.Firm_name  := r.Firm_name;
	self.Firm_Address1 := r.Firm_Address1;
	self.Firm_Address2 := r.Firm_Address2;
	self.Firm_Phone := r.Firm_Phone;
	self := l;
end;

ds_with_lobbyist_firm := join(Lobbyist_recs_rollup,Firm_recs_rollup,left.group_num = right.group_num, LobbyFirmJoinTrf(left,right),left outer);

//output(ds_with_lobbyist_firm);

Layout_Join_Lobby_Firm_Clients := record
  Layout_Join_Lobbyist_Firm;
	string Clients;	
end;

Layout_Join_Lobby_Firm_Clients LobbyFirmClientsJoinTrf(Layout_Join_Lobbyist_Firm l, MyClientsFormat r) := transform
	self.Clients  := r.Clients;
	self := l;
end;

ds_with_lobby_firm_Clients := join(ds_with_lobbyist_firm,FilterClientsTable,left.group_num = right.group_num, LobbyFirmClientsJoinTrf(left,right),left outer);

//output(ds_with_lobby_firm_Clients);

Layout_Lobbyists_Common MyTransform(Layout_Join_Lobby_Firm_Clients input) := transform
	self.Key          := 'OK' + hash64(input.Lobbyist_Name + input.Clients);
	self.Process_Date := '20050328';
	self.Source_State := 'OK';
	self.Lobbyist_Name_Full    := stringlib.StringToUpperCase(input.Lobbyist_Name);
	self.Lobbyist_Address_Street_Line := stringlib.StringToUpperCase(input.Lobbyist_Address1);
	self.Lobbyist_Address_CSZ_Line    := stringlib.StringToUpperCase(input.Lobbyist_Address2);
	self.Lobbyist_Phone        := lib_stringlib.stringlib.stringfilter(input.Lobbyist_Phone[1..3]+
																																		 input.Lobbyist_Phone[5..7]+
																																		 input.Lobbyist_Phone[9..], '0123456789');
	self.Firm_Name_Full        := stringlib.StringToUpperCase(input.Firm_Name);
	self.Firm_Address_Street_Line     := stringlib.StringToUpperCase(input.Firm_Address1);
	self.Firm_Address_CSZ_Line        := stringlib.StringToUpperCase(input.Firm_Address2);
	self.Firm_Phone     := lib_stringlib.stringlib.stringfilter(input.Firm_Phone[1..3]+
																															input.Firm_Phone[5..7]+
																															input.Firm_Phone[9..], '0123456789');
	self.Association_Name_Full     := stringlib.StringToUpperCase(input.Clients);

	self.Lobby_Legislative_Year_Start  := '2005';
	self.Lobby_Legislative_Year_End    := '2005';
	self := [];
end;	
	
export Mapping_OK_2005_As_Common := project(ds_with_lobby_firm_Clients,MyTransform(left));