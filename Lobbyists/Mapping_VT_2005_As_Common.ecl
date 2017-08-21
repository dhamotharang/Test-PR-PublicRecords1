import lib_stringlib;

PLayout := record
	unsigned seq_num := 0;
	unsigned group_num := 0;
	Lobbyists.Layout_Lobbyists_VT_2005;
end;

PLayout  AddSequenceTrf(Lobbyists.File_Lobbyists_VT_2005 l, INTEGER c) := transform
	self.seq_num   := c;
	self.group_num := 0;
	self := l;
end;

pout := project(Lobbyists.File_Lobbyists_VT_2005, AddSequenceTrf(LEFT, COUNTER));

PLayout SeqIterationTrf(PLayout L, PLayout R) := transform
	IsLineEmpty    := (trim(L.Lobbyists_Employer_Name_And_Address + L.Lobbyists_Employer_Phone + L.Lobbyist_Name ,left,right) = '');
	self.group_num := if(IsLineEmpty,R.seq_num,L.group_num);
	self := R;
end;
	
MyRecordGroups := iterate(pout,SeqIterationTrf(left,right));

//output(MyRecordGroups);

MyNameFormat := record
  MYRecordGroups.group_num;
	MyRecordGroups.Lobbyist_Name;
end;

LobbyistsNameTable := table(MyRecordGroups,MyNameFormat);

FilterNameTable := LobbyistsNameTable(Lobbyist_Name <> '');

//output(FilterNameTable);

MyPhoneFormat := record
  MYRecordGroups.group_num;
	MyRecordGroups.Lobbyists_Employer_Phone;
end;

PhoneTable := table(MyRecordGroups,MyPhoneFormat);

FilterPhoneTable := PhoneTable(Lobbyists_Employer_Phone <> '');

//output(FilterPhoneTable);

MyEmployerFormat := record
  MyRecordGroups.seq_num;
  MyRecordGroups.group_num;
	MyRecordGroups.Lobbyists_Employer_Name_And_Address;
end;

EmployerTable := table(MyRecordGroups,MyEmployerFormat);

FilterEmployerTable := EmployerTable(Lobbyists_Employer_Name_And_Address <> '');

//output(FilterEmployerTable);

Layout_Name_Phone := record
  MyRecordGroups.group_num;
	string employer_phone;
	string lobbyist_name;
end;

Layout_Name_Phone NamePhoneJoinTrf(MyNameFormat l, MyPhoneFormat r) := transform
	self.lobbyist_name  := l.Lobbyist_Name;
	self.employer_phone := r.Lobbyists_Employer_Phone;
	self := l;
end;

ds_with_name_phone := join(FilterNameTable,FilterPhoneTable,left.group_num = right.group_num, NamePhoneJoinTrf(left,right),left outer);


Layout_Employer := record
  MyRecordGroups.group_num;
	string employer_name;
	string contact_name;
	string employer_address1;
	string employer_address2;
end;

Layout_Employer EmpTransform(MyEmployerFormat l) := transform
	self.group_num         := l.group_num;
	self.employer_name     := if((l.seq_num-l.group_num) = 0,l.Lobbyists_Employer_Name_And_Address,'');
	self.contact_name      := if((l.seq_num-l.group_num) = 1,l.Lobbyists_Employer_Name_And_Address,'');
	self.employer_address1 := if((l.seq_num-l.group_num) = 2,l.Lobbyists_Employer_Name_And_Address,'');
	self.employer_address2 := if((l.seq_num-l.group_num) = 3,l.Lobbyists_Employer_Name_And_Address,'');
end;
	
EmployeeGroupRecs := project(FilterEmployerTable,EmpTransform(left));

//output(EmployeeGroupRecs);

Layout_Employer EmpRollup(Layout_Employer l, Layout_Employer r) := transform
	self.group_num         := l.group_num;
	self.employer_name     := if(l.employer_name = '',r.Employer_name,l.Employer_name);
	self.contact_name      := if(l.contact_name  = '',r.contact_name,l.contact_name);
	self.employer_address1 := if(l.employer_address1 = '',r.employer_address1,l.employer_address1);
	self.employer_address2 := if(l.employer_address2 = '',r.employer_address2,l.employer_address2);
end;

Employee_recs_rollup := rollup(EmployeeGroupRecs, EmpRollup(Left, Right), group_num);
//output(Employee_recs_rollup);

Layout_formatted_record := record
  string employer_name;
	string employer_address1;
	string employer_address2;
	string employer_contact_name;
  string employer_phone;
	string lobbyist_name;	
end;

Layout_formatted_record FullEmpJoinTransform(Layout_Employer l, Layout_Name_Phone r) := transform
	self.employer_name         := l.employer_name;	
	self.employer_address1     := l.employer_address1;
	self.employer_address2     := l.employer_address2;
	self.employer_phone        := r.employer_phone;
	self.employer_contact_name := trim(map(stringlib.StringToUpperCase(l.contact_name[1..5]) = 'ATTN:' => l.contact_name[6..],
																				 stringlib.StringToUpperCase(l.contact_name[1..5]) = 'ATT: ' => l.contact_name[5..],
																			   l.contact_name),left,right);
	self.lobbyist_name         := r.lobbyist_name;	
end;

Formatted_ds := join(Employee_recs_rollup,ds_with_name_phone,left.group_num = right.group_num, FullEmpJoinTransform(left,right),left outer);


Layout_Lobbyists_Common MyTransform(Formatted_ds input) := transform
	self.Key          := 'VT' + hash64(input.Lobbyist_Name + input.Employer_Contact_Name);
	self.Process_Date := '20050328';
	self.Source_State := 'VT';
	self.Lobbyist_Name_Full        := stringlib.StringToUpperCase(input.Lobbyist_Name);
	self.Association_Name_Full     := stringlib.StringToUpperCase(input.Employer_Name);
	self.Association_Address_Street_Line := stringlib.StringToUpperCase(input.Employer_Address1); 
	self.Association_Address_CSZ_Line    := stringlib.StringToUpperCase(input.Employer_Address2);
	self.Association_Phone := lib_stringlib.stringlib.stringfilter(input.Employer_Phone[2..4]+
																																 input.Employer_Phone[7..9]+
																																 input.Employer_Phone[11..], '0123456789');
	self.Association_Contact_Name_Full := stringlib.StringToUpperCase(input.Employer_Contact_Name);
	self.Lobby_Legislative_Year_Start  := '2005';
	self.Lobby_Legislative_Year_End    := '2005';
	self := [];
end;	
 
export Mapping_VT_2005_As_Common :=  project(Formatted_ds,MyTransform(left));	