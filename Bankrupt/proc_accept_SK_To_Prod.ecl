import ut;

ut.mac_sk_move('~thor_Data400::key::bkrupt_did','P',do1)
ut.mac_sk_move('~thor_data400::key::bkrupt_casenum','P',do2)
ut.mac_sk_move('~thor_Data400::key::bankrupt_didslim','P',do3)
ut.mac_sk_move('~thor_data400::key::bkrupt_full','P',do4)
ut.mac_sk_move_v2('~thor_data400::key::bankrupt_bdid','P',do5);

export Proc_Accept_SK_To_Prod := parallel(do1,do2,do3,do4,do5);

