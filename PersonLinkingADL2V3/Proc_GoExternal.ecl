import RoxieKeybuild,doxie,PersonLinkingADL2V3;

export Proc_GoExternal(string filedate,string source_cluster, string dest_cluster1, string dest_cluster2, string dest_cluster3) := function

src_cluster_name  := '~' + source_cluster + '::key';

keyname_LFZ := '::PersonLinkingADL2V3PersonHeaderLFZRefs';
keyname_address3 := '::personlinkingadl2v3personheaderaddress3refs';
keyname_SSN := '::personlinkingadl2v3personheadersrefs';
keyname_SSN4 := '::personlinkingadl2v3personheaderssn4refs';
keyname_DOB := '::personlinkingadl2v3personheaderdorefs';
keyname_PHONE := '::personlinkingadl2v3personheaderphrefs';
keyname_ZPRF := '::personlinkingadl2v3personheaderzprfrefs';
keyname_FLST := '::personlinkingadl2v3personheaderflstrefs';

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_LFZ.Key,src_cluster_name + keyname_LFZ, src_cluster_name + '::'+filedate+keyname_LFZ,BK1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_ADDRESS3.Key,src_cluster_name + keyname_address3, src_cluster_name + '::'+filedate+keyname_address3,BK4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_S.Key,src_cluster_name + keyname_SSN, src_cluster_name + '::'+filedate+keyname_SSN,BK5);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_SSN4.Key,src_cluster_name + keyname_SSN4, src_cluster_name + '::'+filedate+keyname_SSN4,BK6);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_DO.Key,src_cluster_name + keyname_DOB, src_cluster_name + '::'+filedate+keyname_DOB,BK7);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_PH.Key,src_cluster_name + keyname_PHONE, src_cluster_name + '::'+filedate+keyname_PHONE,BK9);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_ZPRF.Key,src_cluster_name + keyname_ZPRF, src_cluster_name + '::'+filedate+keyname_ZPRF,BK10);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_FLST.Key, src_cluster_name + keyname_FLST, src_cluster_name + '::'+filedate+keyname_FLST,BK11);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_LFZ, src_cluster_name + '::'+filedate+keyname_LFZ,MK1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_address3, src_cluster_name + '::'+filedate+keyname_address3,MK4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_SSN, src_cluster_name + '::'+filedate+keyname_SSN,MK5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_SSN4, src_cluster_name + '::'+filedate+keyname_SSN4,MK6);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_DOB, src_cluster_name + '::'+filedate+keyname_DOB,MK7);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_PHONE, src_cluster_name + '::'+filedate+keyname_PHONE,MK9);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_ZPRF, src_cluster_name + '::'+filedate+keyname_ZPRF,MK10);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(src_cluster_name + keyname_FLST, src_cluster_name + '::'+filedate+keyname_FLST,MK11);

//copy index on other local clusters
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_LFZ, source_cluster, dest_cluster1, filedate, CK11)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_address3, source_cluster, dest_cluster1, filedate, CK12)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_SSN, source_cluster, dest_cluster1, filedate, CK13)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_SSN4, source_cluster, dest_cluster1, filedate, CK14)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_DOB, source_cluster, dest_cluster1, filedate, CK15)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_PHONE, source_cluster, dest_cluster1, filedate, CK16)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_ZPRF, source_cluster, dest_cluster1, filedate, CK17)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_FLST, source_cluster, dest_cluster1, filedate, CK18)

PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_LFZ, source_cluster, dest_cluster3, filedate, CK21_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_address3, source_cluster, dest_cluster3, filedate, CK22_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_SSN, source_cluster, dest_cluster3, filedate, CK23_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_SSN4, source_cluster, dest_cluster3, filedate, CK24_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_DOB, source_cluster, dest_cluster3, filedate, CK25_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_PHONE, source_cluster, dest_cluster3, filedate, CK26_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_ZPRF, source_cluster, dest_cluster3, filedate, CK27_)
PersonLinkingADL2V3.Mac_Keys_Copyprocess(keyname_FLST, source_cluster, dest_cluster3, filedate, CK28_)

//add new files to the original superfile version ('thor_data400')

	c1 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_LFZ + '_built');
	c2 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_address3 + '_built');
	c3 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_SSN + '_built');
	c4 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_SSN4 + '_built');
	c5 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_DOB + '_built');
	c6 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_PHONE + '_built');
	c7 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_ZPRF + '_built');
	c8 := fileservices.clearsuperfile('~thor_Data400::key' + keyname_FLST + '_built');
	
	a1 := fileservices.addsuperfile('~thor_Data400::key' + keyname_LFZ + '_built',src_cluster_name + '::'+filedate+keyname_LFZ );
	a2 := fileservices.addsuperfile('~thor_Data400::key' + keyname_address3 + '_built',src_cluster_name + '::'+filedate+keyname_address3);
	a3 := fileservices.addsuperfile('~thor_Data400::key' + keyname_SSN + '_built',src_cluster_name + '::'+filedate+keyname_ssn);
	a4 := fileservices.addsuperfile('~thor_Data400::key' + keyname_SSN4 + '_built',src_cluster_name + '::'+filedate+keyname_ssn4);
	a5 := fileservices.addsuperfile('~thor_Data400::key' + keyname_DOB + '_built',src_cluster_name + '::'+filedate+keyname_dob);
	a6 := fileservices.addsuperfile('~thor_Data400::key' + keyname_PHONE + '_built',src_cluster_name + '::'+filedate+keyname_phone);
	a7 := fileservices.addsuperfile('~thor_Data400::key' + keyname_ZPRF + '_built',src_cluster_name + '::'+filedate+keyname_zprf);
	a8 := fileservices.addsuperfile('~thor_Data400::key' + keyname_FLST + '_built',src_cluster_name + '::'+filedate+keyname_flst);

full_keys := sequential(
											PersonLinkingADL2V3.specificities(PersonLinkingADL2V3.File_PersonHeader).BUILD,//Two step build.  This part does not have to be done every month as specificites don't change much.
											parallel(
															BK1
															,BK4
															,BK5
															,BK6
															,BK7
															,BK9
															,BK10
															,BK11
															)
											,parallel(
															MK1
															,MK4
															,MK5
															,MK6
															,MK7
															,MK9
															,MK10
															,MK11
															)
											,parallel(
															CK11
															,CK12
															,CK13
															,CK14
															,CK15
															,CK16
															,CK17
															,CK18
															)
											
									   	,parallel(
															 CK21_
															,CK22_
															,CK23_
															,CK24_
															,CK25_
															,CK26_
															,CK27_
															,CK28_
															)
										 ,parallel(c1,c2,c3,c4,c5,c6,c7,c8)
                                         ,parallel(a1,a2,a3,a4,a5,a6,a7,a8)
											);

return full_keys;
end;