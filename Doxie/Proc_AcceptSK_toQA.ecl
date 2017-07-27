import ut,doxie_build,header,property,suppress;

export Proc_AcceptSK_toQA(string filedate) := function

ut.MAC_SK_Move('~thor_data400::key::atf_firearms_did','Q',out1) 
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_lnum','Q',out2)
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_trad','Q',out3)
ut.MAC_SK_Move('~thor_data400::key::atf_firearms_records','Q',out4)
ut.MAC_SK_Move('~thor_Data400::key::bkrupt_did','Q',out5)
ut.MAC_SK_Move('~thor_data400::key::bkrupt_casenum','Q',out6)
ut.MAC_SK_Move('~thor_Data400::key::bankrupt_didslim','Q',out7)
ut.MAC_SK_Move('~thor_data400::key::bkrupt_full','Q',out8)
ut.mac_sk_move('~thor_data400::key::civil_court_did','Q',out9)
ut.MAC_SK_Move('~thor_data400::key::ccw_doxie_did','Q',out10)
ut.MAC_SK_Move('~thor_data400::key::hunters_doxie_did','Q',out11)
ut.MAC_SK_Move('~thor_data400::key::voters_doxie_did','Q',out12)
ut.MAC_SK_Move('~thor_data400::key::airmen_did','Q',out13)
ut.MAC_SK_Move('~thor_data400::key::aircraft_reg_did','Q',out14)
ut.MAC_SK_Move('~thor_data400::key::faa_airmen_certs','Q',out15)
ut.mac_sk_move('~thor_data400::key::flcrash_did','Q',out16)
ut.mac_sk_move('~thor_data400::key::dea_did','Q',out17)
ut.mac_sk_move('~thor_data400::key::prolicense_did','Q',out18)
ut.mac_sk_move('~thor_data400::key::proflic_licensenum','Q',out19)
ut.MAC_SK_Move('~thor_data400::key::relatives','Q',out20)
ut.MAC_SK_Move('~thor_data400::key::rel_names','Q',out21)
out22 := doxie_build.Proc_AcceptSK_veh_toQA;
out27 := doxie_build.Proc_AcceptSK_so_toQA;
ut.MAC_SK_Move('~hthor::key::codes_v3','Q',out30)
out31 := doxie_build.Proc_AcceptSK_dl_toQA;
out32 := header.Proc_AcceptSK_toQA(filedate);
out33 := property.Proc_AcceptSK_toQA;
out34 := suppress.Proc_AcceptSK_toQA;

all_moves := sequential(out1,out2,out3,out4,out5,out6,out7,out8,out9,
					out10,out11,out12,out13,out14,out15,out16,out17,
					out18,out19,out20,out21,out22,
					out27,out30,out31,out32,out33,out34);

return all_moves;

end;