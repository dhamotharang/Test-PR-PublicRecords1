import ut,header_slimsort;
ut.MAC_SK_Move('~thor_data400::key::did_hhid','P',out1);
ut.MAC_SK_Move('~thor_data400::key::hhid_did','P',out2);
ut.MAC_SK_Move('~thor_data400::key::zip_did','P',out3);
ut.MAC_SK_Move('~thor_data400::key::zip_did_full','P',out4);
ut.MAC_SK_Move('~thor_data400::key::header.ssn.did','P',out5);
ut.MAC_SK_Move('~thor_data400::key::ssn_map','P',out6);
ut.MAC_SK_Move('~thor_data400::key::header.rid','P',out7);
ut.MAC_SK_Move('~thor_data400::key::header.phone','P',out8);
ut.MAC_SK_Move('~thor_data400::key::header.st.fname.lname','P',out9);
ut.MAC_SK_Move('~thor_data400::key::header.da','P',out10);
ut.MAC_SK_Move('~thor_data400::key::header.pname.prange.st.city.sec_range.lname','P',out11);
ut.MAC_SK_Move('~thor_data400::key::header.st.city.fname.lname','P',out12);
ut.MAC_SK_Move('~thor_data400::key::header.lname.fname','P',out20);
ut.MAC_SK_Move('~thor_data400::key::header.zip.lname.fname','P',out21);
ut.MAC_SK_Move('~thor_data400::key::header.pname.zip.name.range','P',out27);
ut.MAC_SK_Move('~thor_data400::key::header','P',out13);
ut.MAC_SK_Move('~thor_data400::key::header_lookups','P',out14);
ut.mac_sk_move('~thor_data400::key::lssi.determiner','Q',out14b)
ut.mac_sk_move('~thor_data400::key::header_rid_srid','P',out23)
ut.mac_sk_move('~thor_data400::key::header_sources','P',out24);
ut.MAC_SK_Move_v2('~thor_data400::key::rid_did','P',out25)
ut.MAC_SK_Move_v2('~thor_data400::key::rid_did2','P',out26)

out15 := header_slimsort.Proc_AcceptSK_toProd;

ut.mac_sk_move_v2('~thor_data400::key::nbr_address','P',out16,2);

all_keys := sequential(out1,out2,out3,out4,out5,out6,out7,
			out8,out9,out10,out11,out12,out13,out14,out14b,out15,out16,out20,out21,out23,out24,
			out25,out26,out27);

export Proc_AcceptSK_toProd := all_keys;