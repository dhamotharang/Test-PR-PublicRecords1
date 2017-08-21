import ut,header_slimsort;

keyname_LFZ := '::key::PersonLinkingADL2V3PersonHeaderLFZRefs';
keyname_address3 := '::key::personlinkingadl2v3personheaderaddress3refs';
keyname_SSN := '::key::personlinkingadl2v3personheadersrefs';
keyname_SSN4 := '::key::personlinkingadl2v3personheaderssn4refs';
keyname_DOB := '::key::personlinkingadl2v3personheaderdorefs';
keyname_PHONE := '::key::personlinkingadl2v3personheaderphrefs';
keyname_ZPRF := '::key::personlinkingadl2v3personheaderzprfrefs';
keyname_FLST := '::key::personlinkingadl2v3personheaderflstrefs';

cluster_1 := '~' + header_slimsort.Cluster.Cluster_84;
cluster_2 := '~' + header_slimsort.Cluster.Cluster_92;
cluster_3 := '~' + header_slimsort.Cluster.Cluster_20;
cluster_4 := '~' + header_slimsort.Cluster.Cluster_30;

ut.mac_sk_move('~thor_Data400' + keyname_LFZ,'Q',out1);
ut.mac_sk_move('~thor_Data400' + keyname_address3,'Q',out2);
ut.mac_sk_move('~thor_Data400' + keyname_SSN,'Q',out3);
ut.mac_sk_move('~thor_Data400' + keyname_SSN4,'Q',out4);
ut.mac_sk_move('~thor_Data400' + keyname_DOB,'Q',out5);
ut.mac_sk_move('~thor_Data400' + keyname_PHONE,'Q',out6);
ut.mac_sk_move('~thor_Data400' + keyname_ZPRF,'Q',out7);
ut.mac_sk_move('~thor_Data400' + keyname_FLST,'Q',cl1m);

ut.mac_sk_move(cluster_2 + keyname_LFZ,'Q',out15);
ut.mac_sk_move(cluster_2 + keyname_address3,'Q',out16);
ut.mac_sk_move(cluster_2 + keyname_SSN,'Q',out17);
ut.mac_sk_move(cluster_2 + keyname_SSN4,'Q',out18);
ut.mac_sk_move(cluster_2 + keyname_DOB,'Q',out19);
ut.mac_sk_move(cluster_2 + keyname_PHONE,'Q',out20);
ut.mac_sk_move(cluster_2 + keyname_ZPRF,'Q',out21);
ut.mac_sk_move(cluster_2 + keyname_FLST,'Q',cl3m);

ut.mac_sk_move(cluster_3 + keyname_LFZ,'Q',out22);
ut.mac_sk_move(cluster_3 + keyname_address3,'Q',out23);
ut.mac_sk_move(cluster_3 + keyname_SSN,'Q',out24);
ut.mac_sk_move(cluster_3 + keyname_SSN4,'Q',out25);
ut.mac_sk_move(cluster_3 + keyname_DOB,'Q',out26);
ut.mac_sk_move(cluster_3 + keyname_PHONE,'Q',out27);
ut.mac_sk_move(cluster_3 + keyname_ZPRF,'Q',out28);
ut.mac_sk_move(cluster_3 + keyname_FLST,'Q',cl4m);

ut.mac_sk_move(cluster_4 + keyname_LFZ,'Q',out22_);
ut.mac_sk_move(cluster_4 + keyname_address3,'Q',out23_);
ut.mac_sk_move(cluster_4 + keyname_SSN,'Q',out24_);
ut.mac_sk_move(cluster_4 + keyname_SSN4,'Q',out25_);
ut.mac_sk_move(cluster_4 + keyname_DOB,'Q',out26_);
ut.mac_sk_move(cluster_4 + keyname_PHONE,'Q',out27_);
ut.mac_sk_move(cluster_4 + keyname_ZPRF,'Q',out28_);
ut.mac_sk_move(cluster_4 + keyname_FLST,'Q',cl4m_);

all_out := sequential(
											out1
											,out2
											,out3
											,out4
											,out5
											,out6
											,out7
											,out15
											,out16
											,out17
											,out18
											,out19
											,out20
											,out21
											,out22
											,out23
											,out24
											,out25
											,out26
											,out27
											,out28
											,cl1m
											,cl3m
											,cl4m
											,out22_
											,out23_
											,out24_
											,out25_
											,out26_
											,out27_
											,out28_
											,cl4m_
											);

export Proc_AcceptSK_toQA := all_out;