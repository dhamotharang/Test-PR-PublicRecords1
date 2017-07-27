import ut;

ut.MAC_SK_Move_v2('~thor_Data400::key::bkrupt_did','Q',do1,,true)
ut.MAC_SK_Move_v2('~thor_data400::key::bkrupt_casenum','Q',do2,,true)
ut.MAC_SK_Move_v2('~thor_Data400::key::bankrupt_didslim','Q',do3,,true)
ut.MAC_SK_Move_v2('~thor_data400::key::bkrupt_full','Q',do4,,true)
ut.mac_sk_move_v2('~thor_data400::key::bankrupt_bdid','Q',do5);

export Proc_Accept_SK_To_QA := parallel(do1,do2,do3,do4,do5);