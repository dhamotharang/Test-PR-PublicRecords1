import ut;

ut.MAC_SK_Move_v2('~thor_data400::key::avm::address','Q',avm_address)
ut.MAC_SK_Move_v2('~thor_data400::key::avm::apn','Q',avm_apn)

mv := parallel(avm_address,avm_apn);

export Proc_AcceptSK_to_QA := mv;