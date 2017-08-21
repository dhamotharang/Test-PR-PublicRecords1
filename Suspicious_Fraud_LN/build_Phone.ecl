import header,ut,RoxieKeybuild,Suspicious_Fraud_LN,header_quick, doxie_build,mdr,risk_indicators;

export build_phone(string filedate) := function

isFCRA := false;

phone_table := Suspicious_Fraud_LN.phone_risk_table(isFCRA);

ut.MAC_SF_BuildProcess(phone_table,'~thor_Data400::base::suspicious_fraud_phone',build_phone_base,2,,true)

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Suspicious_Fraud_LN.key_phone_extract,'~thor_data400::key::suspicious_fraud::phone_extract','~thor_data400::key::suspicious_fraud::'+filedate+'::phone_extract',build_phonekey,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::suspicious_fraud::phone_extract','~thor_data400::key::suspicious_fraud::'+filedate+'::phone_extract',move_tobuilt_phonekey);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::suspicious_fraud::phone_extract','Q',move_toqa_phonekey);


build_all := sequential(build_phone_base, build_phonekey,move_tobuilt_phonekey,move_toqa_phonekey);

return build_all;

end;