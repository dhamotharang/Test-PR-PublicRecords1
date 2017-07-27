import ut;
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_cid','P',mk_cid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_bdid','P',mk_bdid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_did','P',mk_did)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid','P',mk_sid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_wid','P',mk_wid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_hullnum','P',mk_hullnum)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_offnum','P',mk_offnum)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_vslnam','P',mk_vslnam)

mk := parallel(mk_cid,
mk_bdid,
mk_did,mk_sid,mk_wid
,mk_hullnum,mk_offnum,mk_vslnam
);

export Proc_AcceptSK_toProd := mk;