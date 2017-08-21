import ut, PromoteSupers;
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_cid',              'Q',mk_cid)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_bdid',             'Q',mk_bdid)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_did',              'Q',mk_did)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid',              'Q',mk_sid)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_wid',              'Q',mk_wid)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_hullnum',          'Q',mk_hullnum)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_offnum',           'Q',mk_offnum)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_vslnam',           'Q',mk_vslnam)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_linkids',          'Q',mk_linkids)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid::linkids',     'Q',mk_sid_linkids)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft_Source_Rec_Id',    'Q',mk_SourceRecId)

// fcra 
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::fcra::cid',        'Q',mk_fcra_cid)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::fcra::did',        'Q',mk_fcra_did)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::fcra::sid',        'Q',mk_fcra_sid)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::fcra::wid',        'Q',mk_fcra_wid)

PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::address',     'Q',do1)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::addressb2',   'Q',do2)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::citystname',  'Q',do3)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::citystnameb2','Q',do4)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::fein2',       'Q',do5)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::name',        'Q',do6)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::nameb2',      'Q',do7)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::namewords2',  'Q',do8)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::payload',     'Q',do9)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::phone2',      'Q',do10)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::phoneb2',     'Q',do11)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::ssn2',        'Q',do12)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::stname',      'Q',do13)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::stnameb2',    'Q',do14)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::zip',         'Q',do15)
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::watercraft::autokey::zipb2',       'Q',do16)



mk := parallel(mk_cid,mk_bdid,mk_did,mk_sid,mk_wid,mk_hullnum,mk_offnum,mk_vslnam,mk_linkids,mk_sid_linkids,mk_SourceRecId,mk_fcra_cid,mk_fcra_did,mk_fcra_sid,mk_fcra_wid,
               do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16);

export Proc_AcceptSK_toQA := mk;