import ut;

ut.MAC_SK_Move_v2('~thor_data400::key::bdid_table','Q',a)
ut.MAC_SK_Move_v2('~thor_data400::key::BDID_risk_table','Q',h)
ut.MAC_SK_Move_v2('~thor_data400::key::fein_table','Q',b)
ut.MAC_SK_Move_v2('~thor_data400::key::groupid_cnt','Q',c)
//ut.MAC_SK_Move_v2('~thor_data400::key::header_ssn_address','Q',d,2);	// in header build
ut.mac_sk_move_v2('~thor_data400::key::business_instantID_FEIN2Addr','Q',e,2);
ut.mac_sk_move_v2('~thor_data400::key::BH_BDID_To_Phone','Q',f,2);
ut.mac_sk_move_v2('~thor_data400::key::bh_contacts_did_2_bdid','Q',g,2);
ut.mac_sk_move_v2('~thor_data400::key::br_bus_header_address','Q',i,2);

export proc_accept_brisk_keys_to_QA := parallel(a,b,c,e,f,g,h,i);