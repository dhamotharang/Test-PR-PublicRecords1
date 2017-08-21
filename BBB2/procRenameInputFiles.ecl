import bbb2;
export procRenameInputFiles(string pDate) :=
function

d1 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_member1_' + pdate, '~thor_data400::in_rolling::bbb::' + pdate + '::member_1');
d2 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_member2_' + pdate, '~thor_data400::in_rolling::bbb::' + pdate + '::member_2');
d3 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_member3_' + pdate, '~thor_data400::in_rolling::bbb::' + pdate + '::member_3');

d4 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember10_' + pdate, '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_10');
d5 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember1_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_1');
d6 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember2_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_2');
d7 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember3_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_3');
d8 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember4_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_4');
d9 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember5_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_5');
d10 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember6_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_6');
d11 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember7_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_7');
d12 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember8_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_8');
d13 := fileservices.RenameLogicalFile('~thor_data400::in::bbb_nonmember9_' + pdate,  '~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_9');

d14 := fileservices.AddSuperFile(bbb2.Filenames().Input.Member.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::member_1');
d15 := fileservices.AddSuperFile(bbb2.Filenames().Input.Member.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::member_2');
d16 := fileservices.AddSuperFile(bbb2.Filenames().Input.Member.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::member_3');
d17 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_10');
d18 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_1');
d19 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_2');
d20 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_3');
d21 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_4');
d22 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_5');
d23 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_6');
d24 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_7');
d25 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_8');
d26 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::' + pdate + '::Nonmember_9');

return sequential(
	
 d1 
,d2 
,d3 

,d4 
,d5 
,d6 
,d7 
,d8 
,d9 
,d10
,d11
,d12
,d13

,d14
,d15
,d16
,d17
,d18
,d19
,d20
,d21
,d22
,d23
,d24
,d25
,d26

);

end;