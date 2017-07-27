import ut;

ut.MAC_SK_Move_v2('~thor_data400::key::superior_liens_did', 'Q', move_did_qa, '2')
ut.MAC_SK_Move_v2('~thor_data400::key::superior_liens_bdid', 'Q', move_bdid_qa, '2')

export Proc_Accept_SK_To_QA := parallel(move_did_qa,move_bdid_qa);

