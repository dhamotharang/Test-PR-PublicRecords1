import ut;
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_cid','Q',mk_cid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_bdid','Q',mk_bdid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_did','Q',mk_did)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_sid','Q',mk_sid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_wid','Q',mk_wid)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_hullnum','Q',mk_hullnum)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_offnum','Q',mk_offnum)
ut.MAC_SK_Move_v2('~thor_data400::key::watercraft_vslnam','Q',mk_vslnam)

mk := parallel(mk_cid,mk_bdid,mk_did,mk_sid,mk_wid,mk_hullnum,mk_offnum,mk_vslnam);

export Proc_AcceptSK_toQA := mk;