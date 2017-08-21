import ut;
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_cid','P',mk_cid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_bdid','P',mk_bdid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_did','P',mk_did)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid','P',mk_sid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_wid','P',mk_wid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_hullnum','P',mk_hullnum)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_offnum','P',mk_offnum)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_vslnam','P',mk_vslnam)

ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::address',     'P',do1)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::addressb2',   'P',do2)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::citystname',  'P',do3)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::citystnameb2','P',do4)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::fein2',       'P',do5)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::name',        'P',do6)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::nameb2',      'P',do7)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::namewords2',  'P',do8)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::payload',     'P',do9)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::phone2',      'P',do10)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::phoneb2',     'P',do11)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::ssn2',        'P',do12)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::stname',      'P',do13)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::stnameb2',    'P',do14)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::zip',         'P',do15)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::zipb2',       'P',do16)

ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_bid','P',mk_bid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid_bid','P',mk_sid_bid)

ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::address',     'P',do1b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::addressb2',   'P',do2b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::citystname',  'P',do3b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::citystnameb2','P',do4b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::fein2',       'P',do5b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::name',        'P',do6b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::nameb2',      'P',do7b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::namewords2',  'P',do8b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::payload',     'P',do9b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::phone2',      'P',do10b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::phoneb2',     'P',do11b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::ssn2',        'P',do12b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::stname',      'P',do13b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::stnameb2',    'P',do14b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::zip',         'P',do15b)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::bid::zipb2',       'P',do16b)

mk := parallel(mk_cid,
mk_bdid,mk_did,mk_sid,mk_wid,mk_hullnum,mk_offnum,mk_vslnam,
do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16
);
mkb := parallel(mk_cid,
mk_bid,mk_sid,
do1b,do2b,do3b,do4b,do5b,do6b,do7b,do8b,do9b,do10b,do11b,do12b,do13b,do14b,do15b,do16b
);

export Proc_AcceptSK_toProd := parallel(mk,if(Constants.BUILD_BID_KEY_FLAG,mkb));