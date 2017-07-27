import ut, doxie_build, Business_Header_SS, uccd, header,property,watchdog,suppress,watercraft;
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_did','P',out1) 
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_lnum','P',out2)
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_trad','P',out3)
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_records','P',out4)
ut.MAC_SK_Move('~thor_Data400::key::bkrupt_did','P',out5)
ut.MAC_SK_Move('~thor_data400::key::bkrupt_casenum','P',out6)
ut.MAC_SK_Move('~thor_Data400::key::bankrupt_didslim','P',out7)
ut.MAC_SK_Move('~thor_data400::key::bkrupt_full','P',out8)
ut.mac_sk_move('~thor_data400::key::civil_court_did','P',out9)
ut.MAC_SK_Move('~thor_data400::key::ccw_doxie_did','P',out10)
ut.MAC_SK_Move('~thor_data400::key::hunters_doxie_did','P',out11)
ut.MAC_SK_Move('~thor_data400::key::voters_doxie_did','P',out12)
ut.MAC_SK_Move('~thor_data400::key::airmen_did','P',out13)
ut.MAC_SK_Move('~thor_data400::key::aircraft_reg_did','P',out14)
ut.MAC_SK_Move('~thor_data400::key::faa_airmen_certs','P',out15)
ut.mac_sk_move('~thor_data400::key::flcrash_did','P',out16)
ut.mac_sk_move('~thor_data400::key::dea_did','P',out17)
ut.mac_sk_move('~thor_data400::key::prolicense_did','P',out18)
ut.mac_sk_move('~thor_data400::key::proflic_licensenum','P',out19)
ut.MAC_SK_Move('~thor_data400::key::relatives','P',out20)
ut.MAC_SK_Move('~thor_data400::key::rel_names','P',out21)
out22 := doxie_build.Proc_AcceptSK_veh_toProd;
out27 := doxie_build.Proc_AcceptSK_so_toProd;
ut.MAC_SK_Move('~hthor::key::codes_v3','P',out30)
out31 := doxie_build.Proc_AcceptSK_dl_toProd;
out32 := Business_Header_SS.Proc_AcceptSK_ToProd;
out33 := UCCD.Proc_AcceptSK_ToProd;
out34 := header.Proc_AcceptSK_toProd;
out35 := property.Proc_AcceptSK_toProd;
out36 := watchdog.Proc_AcceptSK_toProd;
out37 := suppress.Proc_AcceptSK_toProd;
out38 := watercraft.Proc_AcceptSK_toProd;

all_moves := sequential(out1,out2,out3,out4,out5,out6,out7,out8,out9,
					out10,out11,out12,out13,out14,out15,out16,out17,
					out18,out19,out20,out21,out22,
					out27,out30, out31, out32, out33, out34,out35,out36,out37,out38);

export Proc_AcceptSK_toProd := all_moves;