import ut,header_slimsort;
ut.MAC_SK_Move('~thor_data400::key::did_hhid','Q',out1);
ut.MAC_SK_Move('~thor_data400::key::hhid_did','Q',out2);
ut.MAC_SK_Move('~thor_data400::key::zip_did','Q',out3);
ut.MAC_SK_Move('~thor_data400::key::zip_did_full','Q',out4);
ut.MAC_SK_Move('~thor_data400::key::header.ssn.did','Q',out5);
ut.MAC_SK_Move('~thor_data400::key::ssn_map','Q',out6);
ut.MAC_SK_Move('~thor_data400::key::header.rid','Q',out7);
ut.MAC_SK_Move('~thor_data400::key::header.phone','Q',out8);
ut.MAC_SK_Move('~thor_data400::key::header.st.fname.lname','Q',out9);
ut.MAC_SK_Move('~thor_data400::key::header.da','Q',out10);
ut.MAC_SK_Move('~thor_data400::key::header.pname.prange.st.city.sec_range.lname','Q',out11);
ut.MAC_SK_Move('~thor_data400::key::header.st.city.fname.lname','Q',out12);
ut.MAC_SK_Move('~thor_data400::key::header.lname.fname','Q',out20);
ut.MAC_SK_Move('~thor_data400::key::header.zip.lname.fname','Q',out21);
ut.MAC_SK_Move('~thor_data400::key::header.pname.zip.name.range','Q',out27);
ut.MAC_SK_Move('~thor_data400::key::header','Q',out13);
ut.MAC_SK_Move('~thor_data400::key::header_lookups','Q',out14);
ut.mac_sk_move('~thor_data400::key::lssi.determiner','Q',out14b)
ut.mac_sk_move('~thor_data400::key::header_rid_srid','Q',out23)
ut.mac_sk_move('~thor_data400::key::header_sources','Q',out24);
ut.MAC_SK_Move_v2('~thor_data400::key::rid_did','Q',out25)
ut.MAC_SK_Move_v2('~thor_data400::key::rid_did2','Q',out26)

out15 := sequential(fileservices.clearsuperfile('~thor_data400::base::header_prod'),
fileservices.addsuperfile('~thor_data400::base::header_prod','~thor_data400::base::header',,true));

out16 := sequential(fileservices.clearsuperfile('~thor_data400::base::relatives_prod'),
fileservices.addsuperfile('~thor_data400::base::relatives_prod','~thor_data400::base::relatives',,true));

out17 := sequential(fileservices.clearsuperfile('~thor_data400::base::hhid_prod'),
fileservices.addsuperfile('~thor_data400::base::hhid_prod','~thor_data400::base::hhid',,true));

out18 := header_slimsort.proc_accept_sf_to_Prod; 
out19 := header_slimsort.Proc_AcceptSK_toQA;

ut.MAC_SK_Move_v2('~thor_data400::key::nbr_address','Q',out22,2);

all_keys := sequential(out1,out2,out3,out4,out5,out6,out7,
			out8,out9,out10,out11,out12,out13,out14,out14b,out15, out16, out17,
			out18,out19,out20,out21,out22,out23,out24,
			out25,out26,out27);

export Proc_AcceptSK_toQA := all_keys;