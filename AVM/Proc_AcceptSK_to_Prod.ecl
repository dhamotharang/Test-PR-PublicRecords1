import ut;

ut.MAC_SK_Move_v2('~thor_data400::key::avm::address','P',avm_address)
ut.MAC_SK_Move_v2('~thor_data400::key::avm::apn','P',avm_apn)

mv := parallel(avm_address,avm_apn);

export Proc_AcceptSK_to_Prod := mv;