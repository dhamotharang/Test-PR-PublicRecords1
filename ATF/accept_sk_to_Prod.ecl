import ut;

ut.mac_sk_move_v2('~thor_data400::key::atf_firearms_did','P',do1)
ut.mac_sk_move_v2('~thor_data400::key::atf_firearms_lnum','P',do2)
ut.mac_sk_move_v2('~thor_data400::key::atf_firearms_trad','P',do3)
ut.mac_sk_move_v2('~thor_data400::key::atf_firearms_records','P',do4)

export accept_sk_to_Prod := parallel(do1,do2,do3,do4);