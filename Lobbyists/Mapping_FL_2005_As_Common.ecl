import lib_stringlib;

PLayout := record
	unsigned seq_num := 0;
	unsigned group_num := 0;
	Lobbyists.Layout_Lobbyists_FL_2005_Combined;
end;

PLayout  AddSequenceTrf(Lobbyists.Layout_Lobbyists_FL_2005_Combined l, INTEGER c) := transform
	self.seq_num   := c;
	self.group_num := 0;
	self := l;
end;

pout := project(Lobbyists.File_Lobbyists_FL_2005, AddSequenceTrf(LEFT, COUNTER));


PLayout SeqIterationTrf(PLayout L, PLayout R) := transform
	IsLineOne      := if(R.myRecordString[1] = '1',True,False);
	self.group_num := if(IsLineOne,R.seq_num,L.group_num);
	self := R;
end;
	
MyRecordGroups := iterate(pout,SeqIterationTrf(left,right));


Lobbysit_Recs := MyRecordGroups(myRecordString[1] = '1');


Association_Recs := MyRecordGroups(myRecordString[1] <> '1');

Layout_Lobbyist := record
	unsigned group_num := 0;
	Lobbyists.Layout_Lobbyists_FL_2005_Rec1;
end;

Layout_Lobbyist LobbyistTrf(PLayout l) := transform
  self.Record_Type    := l.myRecordString[1];
	self.Lobbyist_Name  := l.myRecordString[2..36];
	self.Lobbyist_Address_1 := l.myRecordString[37..71];
	self.Lobbyist_Address_2 := l.myRecordString[72..106];
	self.Lobbyist_Address_3 := l.myRecordString[107..141];
	self.Lobbyist_City := l.myRecordString[142..161];
	self.Lobbyist_State := l.myRecordString[162..163];
	self.Lobbyist_Zip := l.myRecordString[164..173];
	self.Lobbyist_Phone := l.myRecordString[174..185];
	self := l;
end;

FormattedLobbyistRecs := project(Lobbysit_Recs,LobbyistTrf(left));

Layout_Association := record
	unsigned group_num := 0;
	Lobbyists.Layout_Lobbyists_FL_2005_Rec2;
end;

Layout_Association AssociationTrf(PLayout l) := transform
	self.Record_Type := l.myRecordString[1];
	self.Principal_Name := l.myRecordString[2..71];
	self.Principal_Address_1 := l.myRecordString[72..106];
	self.Principal_Address_2 := l.myRecordString[107..141];
	self.Principal_Address_3 := l.myRecordString[142..176];
	self.Principal_City := l.myRecordString[177..196];
	self.Principal_State := l.myRecordString[197..198];
	self.Principal_Zip := l.myRecordString[199..208];
	self.Lobbyist_Withdraw_Date := l.myRecordString[209..218];
	self.Lobbyist_Period_1_Ind := l.myRecordString[219];
	self.Lobbyist_Period_2_Ind := l.myRecordString[220];
  self := l;
end;

FormattedAssociationRecs := project(Association_Recs,AssociationTrf(left));


Layout_Join_Lobbyist_Assoc := record	
  Layout_Lobbyist;
	string	Principal_Name;
	string	Principal_Address_1;
	string	Principal_Address_2;
	string	Principal_Address_3;
	string	Principal_City;
	string	Principal_State;
	string	Principal_Zip;
	string	Lobbyist_Withdraw_Date;
	string	Lobbyist_Period_1_Ind;
	string	Lobbyist_Period_2_Ind;
end;

Layout_Join_Lobbyist_Assoc LobbyAssocJoinTrf(Layout_Lobbyist l, Layout_Association r) := transform
	self.Principal_Name  := r.Principal_Name;
	self.Principal_Address_1 := r.Principal_Address_1;
	self.Principal_Address_2 := r.Principal_Address_2;
	self.Principal_Address_3 := r.Principal_Address_3;
	self.Principal_City := r.Principal_City;
	self.Principal_State := r.Principal_State;
	self.Principal_Zip := r.Principal_Zip;
	self.Lobbyist_Withdraw_Date := r.Lobbyist_Withdraw_Date;
	self.Lobbyist_Period_1_Ind := r.Lobbyist_Period_1_Ind;
	self.Lobbyist_Period_2_Ind := r.Lobbyist_Period_2_Ind;
	self := l;
end;

ds_with_lobbyist_Assoc := join(FormattedLobbyistRecs,FormattedAssociationRecs,left.group_num = right.group_num, LobbyAssocJoinTrf(left,right),left outer);


Layout_Lobbyists_Common MyTransform(Layout_Join_Lobbyist_Assoc input) := transform
	self.Key	:= 'FL' + hash64(input.Lobbyist_Name + input.Principal_Name);
	self.Process_Date := '20051003';
	self.Source_State := 'FL';
	self.Lobbyist_Name_Full := input.Lobbyist_Name;
	self.Lobbyist_Address_Street_Line := trim(input.Lobbyist_Address_1,left,right) + ' ' +
																			 trim(input.Lobbyist_Address_2,left,right) + ' ' +
																			 trim(input.Lobbyist_Address_3,left,right);
	self.Lobbyist_Address_City	:= input.Lobbyist_City;
	self.Lobbyist_Address_State	:= input.Lobbyist_State;
	self.Lobbyist_Address_Zip	:=	lib_stringlib.stringlib.stringfilter (input.Lobbyist_Zip,'0123456789');
	self.Lobbyist_Phone :=	lib_stringlib.stringlib.stringfilter (input.Lobbyist_Phone,'0123456789');
	self.Association_Name_Full := input.Principal_Name;
	self.Association_Address_Street_Line := trim(input.Principal_Address_1,left,right) + ' ' +
																					trim(input.Principal_Address_2,left,right) + ' ' +
																					trim(input.Principal_Address_3,left,right); 
	self.Association_Address_City	:= input.Principal_City;
	self.Association_Address_State	:= input.Principal_State;
	self.Association_Address_Zip	:= lib_stringlib.stringlib.stringfilter (input.Principal_Zip,'0123456789');
	self.Lobby_Legislative_Year_Start  := '2005';
	self.Lobby_Legislative_Year_End    := '2005';
	self := [];
end;	
	
export Mapping_FL_2005_As_Common := project(ds_with_lobbyist_Assoc,MyTransform(left));