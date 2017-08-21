import header,ut,RoxieKeybuild,Suspicious_Fraud_LN,header_quick, doxie_build,mdr,risk_indicators;

export build_address(string filedate) := function
isFCRA := false;

address_table := Suspicious_Fraud_LN.Address_risk_table(isFCRA);

ut.MAC_SF_BuildProcess(address_table,'~thor_Data400::base::suspicious_fraud_Address',build_address_base,2,,true)

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Suspicious_Fraud_LN.key_address_extract,'~thor_data400::key::suspicious_fraud::address_extract','~thor_data400::key::suspicious_fraud::'+filedate+'::address_extract',build_Addresskey,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::suspicious_fraud::address_extract','~thor_data400::key::suspicious_fraud::'+filedate+'::address_extract',move_tobuilt_Addresskey);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::suspicious_fraud::address_extract','Q',move_toqa_Addresskey);

build_all:= sequential(build_address_base, build_addresskey,move_tobuilt_Addresskey,move_toqa_Addresskey);

return build_all;

end;
