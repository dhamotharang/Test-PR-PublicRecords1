import ut,roxiekeybuild;

ut.MAC_SK_Move_v2('~thor_Data400::key::bkrupt_did','Q',do1,,true)
ut.MAC_SK_Move_v2('~thor_data400::key::bkrupt_casenum','Q',do2,,true)
ut.MAC_SK_Move_v2('~thor_Data400::key::bankrupt_didslim','Q',do3,,true)
ut.MAC_SK_Move_v2('~thor_data400::key::bkrupt_full','Q',do4,,true)
ut.mac_sk_move_v2('~thor_data400::key::bankrupt_bdid','Q',do5);
ut.mac_sk_move_v2('~thor_data400::key::bkrupt_ssn','Q',do6);
ut.mac_sk_move_v2('~thor_data400::key::bkrupt_address','Q',do7);
ut.MAC_SK_Move_v2('~thor_data400::key::bankrupt::bocashell_did', 'Q',do10);

//FCRA
ut.mac_sk_move_v2 ('~thor_Data400::key::bankrupt::fcra::didslim','Q',do8);
ut.mac_sk_move_v2 ('~thor_Data400::key::bankrupt::fcra::full','Q',do9);
ut.MAC_SK_Move_v2('~thor_data400::key::bankrupt::fcra::bocashell_did', 'Q',do11);
ut.MAC_SK_Move_v2('~thor_data400::key::bkrupt_did_fcra','Q',do12);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::bankrupt::fcra::@version@::casenum','Q',do13);

export Proc_Accept_SK_To_QA := parallel(/*do1,do2,do3,do4,do5,do6,do7,*/do8,do9,/*do10,*/do11,do12,do13);