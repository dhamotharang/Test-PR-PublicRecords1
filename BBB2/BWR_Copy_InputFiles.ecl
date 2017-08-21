import bbb2;
//thor_data400::in_rolling::bbb::sprayed::member

//Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=lib_system.ws_fs_server, integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false)

d1 := fileservices.Copy('~thor_data400::in::bbb_member1_20051108', 'thor_data400', '~thor_data400::in_rolling::bbb::20051108::member_1');
d2 := fileservices.Copy('~thor_data400::in::bbb_member1_20051109', 'thor_data400', '~thor_data400::in_rolling::bbb::20051109::member_1');
d3 := fileservices.Copy('~thor_data400::in::bbb_member2_20051108', 'thor_data400', '~thor_data400::in_rolling::bbb::20051108::member_2');

d4 := fileservices.Copy('~thor_data400::in::bbb_nonmember10_20051108', 'thor_data400', '~thor_data400::in_rolling::bbb::20051108::Nonmember_10');
d5 := fileservices.Copy('~thor_data400::in::bbb_nonmember1_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_1');
d6 := fileservices.Copy('~thor_data400::in::bbb_nonmember2_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_2');
d7 := fileservices.Copy('~thor_data400::in::bbb_nonmember3_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_3');
d8 := fileservices.Copy('~thor_data400::in::bbb_nonmember4_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_4');
d9 := fileservices.Copy('~thor_data400::in::bbb_nonmember5_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_5');
d10 := fileservices.Copy('~thor_data400::in::bbb_nonmember6_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_6');
d11 := fileservices.Copy('~thor_data400::in::bbb_nonmember7_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_7');
d12 := fileservices.Copy('~thor_data400::in::bbb_nonmember8_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_8');
d13 := fileservices.Copy('~thor_data400::in::bbb_nonmember9_20051108', 'thor_data400',  '~thor_data400::in_rolling::bbb::20051108::Nonmember_9');

d14 := fileservices.AddSuperFile(bbb2.Filenames().Input.Member.Sprayed,'~thor_data400::in_rolling::bbb::20051108::member_1');
d15 := fileservices.AddSuperFile(bbb2.Filenames().Input.Member.Sprayed,'~thor_data400::in_rolling::bbb::20051109::member_1');
d16 := fileservices.AddSuperFile(bbb2.Filenames().Input.Member.Sprayed,'~thor_data400::in_rolling::bbb::20051108::member_2');
d17 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_10');
d18 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_1');
d19 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_2');
d20 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_3');
d21 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_4');
d22 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_5');
d23 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_6');
d24 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_7');
d25 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_8');
d26 := fileservices.AddSuperFile(bbb2.Filenames().Input.NonMember.Sprayed,'~thor_data400::in_rolling::bbb::20051108::Nonmember_9');

sequential(
	
//d1 
d2 
,d3 

,d4 
//,d5 
,d6 
,d7 
,d8 
,d9 
,d10
,d11
,d12
,d13

//,d14
,d15
,d16
,d17
//,d18
,d19
,d20
,d21
,d22
,d23
,d24
,d25
,d26

);