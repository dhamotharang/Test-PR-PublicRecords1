import lib_stringlib;

PLayout := record
	unsigned seq_num := 0;
	unsigned group_num := 0;	
	Lobbyists.Layout_Lobbyists_AL_2005;
end;

PLayout  AddSequenceTrf(Lobbyists.Layout_Lobbyists_AL_2005 l, INTEGER c) := transform
	self.seq_num   := c;
	self.group_num := 0;
	self := l;
end;

pout := project(Lobbyists.File_Lobbyists_AL_2005, AddSequenceTrf(LEFT, COUNTER));


PLayout SeqIterationTrf(PLayout L, PLayout R) := transform
	IsNewRecord      := if(L.lobbyist_name_address_phone + L.association = '',True,False);
	self.group_num := if(IsNewRecord,R.seq_num,L.group_num);
	self := R;
end;
	
MyRecordGroups := iterate(pout,SeqIterationTrf(left,right));


Lobbyists_Recs := MyRecordGroups(lobbyist_name_address_phone + association <> '');
//output(Lobbyists_Recs);


Lay_Lobby_Name_Address_Phone := record
	Lobbyists_Recs.seq_num;
	Lobbyists_Recs.group_num;
	Lobbyists_Recs.lobbyist_name_address_phone;
end;

ds_NameAddressPhone := table(Lobbyists_Recs,Lay_Lobby_Name_Address_Phone);
Filtered_NameAddressPhone := ds_NameAddressPhone(lobbyist_name_address_phone <> '');
//output(Filtered_NameAddressPhone);

Lay_Lobby_Association := record
	Lobbyists_Recs.group_num;
	Lobbyists_Recs.association;
end;

ds_Association := table(Lobbyists_Recs,Lay_Lobby_Association);
Filtered_Association := ds_Association(association <> '');
//output(Filtered_Association);

GroupedSet := group(Filtered_NameAddressPhone,group_num);

//output(GroupedSet);

Layout_Lobbyist := record
  MyRecordGroups.group_num;
	string Lobbyist_name;
	string Lobbyist_Address1;
	string Lobbyist_Address2;
	string Lobbyist_Address3;
	string Lobbyist_Phone;
end;

Layout_Lobbyist LobbyTransform(Lay_Lobby_Name_Address_Phone l) := transform
	self.group_num         := l.group_num;
	self.Lobbyist_name     := if((l.seq_num-l.group_num) = 0,l.lobbyist_name_address_phone,'');
	self.Lobbyist_Address1 := if((l.seq_num-l.group_num) = 1,l.lobbyist_name_address_phone,'');
	self.Lobbyist_Address2 := if((l.seq_num-l.group_num) = 2,l.lobbyist_name_address_phone,'');
	self.Lobbyist_Address3 := if((l.seq_num-l.group_num) = 3,l.lobbyist_name_address_phone,'');
	self.Lobbyist_Phone    := if((l.seq_num-l.group_num) = 4,l.lobbyist_name_address_phone,'');
end;
	
LobbyistGroupRecs := project(Filtered_NameAddressPhone,LobbyTransform(left));

//output(LobbyistGroupRecs);

Layout_Lobbyist LobbyRollup(Layout_Lobbyist l, Layout_Lobbyist r) := transform
	self.group_num         := l.group_num;
	self.Lobbyist_name     := if(l.Lobbyist_name = '',r.Lobbyist_name,l.Lobbyist_name);
	self.Lobbyist_Address1 := if(l.Lobbyist_Address1  = '',r.Lobbyist_Address1,l.Lobbyist_Address1);
	self.Lobbyist_Address2 := if(l.Lobbyist_Address2  = '',r.Lobbyist_Address2,l.Lobbyist_Address2);
	self.Lobbyist_Address3 := if(l.Lobbyist_Address3  = '',r.Lobbyist_Address3,l.Lobbyist_Address3);
	self.Lobbyist_Phone    := if(l.Lobbyist_Phone     = '',r.Lobbyist_Phone,l.Lobbyist_Phone);
end;

Lobbyist_recs_rollup := rollup(LobbyistGroupRecs, LobbyRollup(Left, Right), group_num);
//output(Lobbyist_recs_rollup);

Layout_Lobbyist LobbyTrf(Layout_Lobbyist l) := transform
	self.group_num         := l.group_num;
	self.Lobbyist_Address2 := if(l.Lobbyist_Phone  = '','',l.Lobbyist_Address2);
	self.Lobbyist_Address3 := if(l.Lobbyist_Phone  = '',l.Lobbyist_Address2,l.Lobbyist_Address3);
	self.Lobbyist_Phone    := if(l.Lobbyist_Phone  = '',l.Lobbyist_Address3,l.Lobbyist_Phone);
	self := l;
end;

ds_fixAddrPhoneRecs := project(Lobbyist_recs_rollup,LobbyTrf(left));
//output(ds_fixAddrPhoneRecs);

Layout_Join_Lobbyist := record
  Layout_Lobbyist;
	Lobbyists_Recs.association;	
end;

Layout_Join_Lobbyist LobbyJoinTrf(Layout_Lobbyist l, Lay_Lobby_Association r) := transform
	self.Association := r.Association;
	self := l;
end;

ds_with_lobbyist_Association := join(ds_fixAddrPhoneRecs,Filtered_Association,left.group_num = right.group_num, LobbyJoinTrf(left,right),left outer);
//output(ds_with_lobbyist_Association);

Layout_Lobbyists_Common MyTransform(Layout_Join_Lobbyist input) := transform
	self.Key	:= 'AL' + hash64(input.Lobbyist_Name + input.Association);
	self.Process_Date := '20051205';
	self.Source_State := 'AL';
	self.Lobbyist_Name_Full := input.Lobbyist_Name;
	self.Lobbyist_Address_Street_Line := trim(input.Lobbyist_Address1,left,right) + ' ' +
																			 trim(input.Lobbyist_Address2,left,right); 
	self.Lobbyist_Address_CSZ_Line	:= input.Lobbyist_Address3;
	self.Lobbyist_Phone :=	lib_stringlib.stringlib.stringfilter(input.Lobbyist_Phone,'0123456789');
	self.Association_Name_Full := input.Association;
	self.Lobby_Legislative_Year_Start  := '2005';
	self.Lobby_Legislative_Year_End    := '2005';
	self := [];
end;	
	
export Mapping_AL_2005_As_Common := project(ds_with_lobbyist_association,MyTransform(left));