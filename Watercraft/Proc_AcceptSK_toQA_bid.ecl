import ut;
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_bid',             'Q',mk_bid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid_bid',         'Q',mk_sid)

// fcra 

ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::fcra::sid_bid',    'Q',mk_fcra_sid)

ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::address',     'Q',do1)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::addressb2',   'Q',do2)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::citystname',  'Q',do3)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::citystnameb2','Q',do4)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::fein2',       'Q',do5)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::name',        'Q',do6)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::nameb2',      'Q',do7)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::namewords2',  'Q',do8)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::payload',     'Q',do9)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::phone2',      'Q',do10)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::phoneb2',     'Q',do11)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::ssn2',        'Q',do12)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::stname',      'Q',do13)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::stnameb2',    'Q',do14)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::zip',         'Q',do15)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::zipb2',       'Q',do16)



mk := parallel(mk_bid,mk_sid,mk_fcra_sid,
                do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16);

export Proc_AcceptSK_toQA_bid := mk;