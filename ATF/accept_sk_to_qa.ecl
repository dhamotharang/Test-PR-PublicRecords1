import ut;

ut.mac_sk_move_v2('~thor_data400::key::atf::firearms::did','Q',do1)
ut.mac_sk_move_v2('~thor_data400::key::atf::firearms::lnum','Q',do2)
ut.mac_sk_move_v2('~thor_data400::key::atf::firearms::bdid','Q',do3)
ut.mac_sk_move_v2('~thor_data400::key::atf::firearms::records','Q',do4)
ut.mac_sk_move_v2('~thor_data400::key::atf::firearms::atfid','Q',do5)

export accept_sk_to_qa := sequential(do1,do2,do3,do4,do5);