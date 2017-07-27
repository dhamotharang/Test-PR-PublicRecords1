import ut;

ut.mac_sk_move_v2('~thor_Data400::key::dnb_bdid','Q',do1,2);
ut.mac_sk_move_v2('~thor_data400::key::dnb_contactname','Q',do2,2);
ut.mac_sk_move_v2('~thor_data400::key::dnb_contacts_dunsnum','Q',do3,2);
ut.mac_sk_move_v2('~thor_data400::key::dnb_dunsnum','Q',do4,2);

export proc_accept_keys_to_QA := sequential(do1,do2,do3,do4);
