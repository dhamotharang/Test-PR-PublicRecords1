import header,ut,RoxieKeybuild,Suspicious_Fraud_LN,header_quick, doxie_build,mdr,risk_indicators;

export build_SSN(string filedate) := function

isFCRA := false;

ssn_table := Suspicious_Fraud_LN.SSN_risk_table(isFCRA);

ut.MAC_SF_BuildProcess(ssn_table,'~thor_Data400::base::suspicious_fraud_SSN',build_SSN_base,2,,true)

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Suspicious_Fraud_LN.key_SSN_extract,'~thor_data400::key::suspicious_fraud::ssn_extract','~thor_data400::key::suspicious_fraud::'+filedate+'::ssn_extract',build_ssnkey,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::suspicious_fraud::ssn_extract','~thor_data400::key::suspicious_fraud::'+filedate+'::ssn_extract',move_tobuilt_ssnkey);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::suspicious_fraud::ssn_extract','Q',move_toqa_ssnkey);


build_all := sequential(build_SSN_base, build_ssnkey,move_tobuilt_ssnkey,move_toqa_ssnkey);

return build_all;

end;