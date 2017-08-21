EXPORT Lookup_Lists := Module

shared List_Rec:=record
	string entry;
end;

export Function_List := dataset([
																 'MFAEnrollSubject','MFAGenerateOTP','MFAGenerateOTPOnce','UpdateSubject',
																 'MFAGenOTPOnce_CN','MFAGenOTPOnce_DE','MFAGenOTPOnce_FR','MFAGenOTPOnce_GB','MFAGenOTPOnce_IN',
																 'MFAGenOTPOnce_PR','MFAGenOTPOnce_US','MFAGenOTPOnce_VN','MFAUpdateSubject','MFAUpdVerifySubj',
																 'MFAUpdVfySubj_AU','MFAUpdVfySubj_BE','MFAUpdVfySubj_CA','MFAUpdVfySubj_CH','MFAUpdVfySubj_CN',
																 'MFAUpdVfySubj_CO','MFAUpdVfySubj_CR','MFAUpdVfySubj_DE','MFAUpdVfySubj_ES','MFAUpdVfySubj_FR',
																 'MFAUpdVfySubj_GB','MFAUpdVfySubj_HK','MFAUpdVfySubj_ID','MFAUpdVfySubj_IE','MFAUpdVfySubj_IN',
																 'MFAUpdVfySubj_IT','MFAUpdVfySubj_JP','MFAUpdVfySubj_KR','MFAUpdVfySubj_MX','MFAUpdVfySubj_MY',
																 'MFAUpdVfySubj_NL','MFAUpdVfySubj_PH','MFAUpdVfySubj_PR','MFAUpdVfySubj_TH','MFAUpdVfySubj_TR',
																 'MFAUpdVfySubj_TW','MFAUpdVfySubj_VN','MFAUpdVfySubj_ZA','MFAVerifyOTP','MFAVerifyOTPOnce',
																 'UpdVerifySubj','UpdVfySubj_AE','UpdVfySubj_AR','UpdVfySubj_AU','UpdVfySubj_BE','UpdVfySubj_BR',
																 'UpdVfySubj_CA','UpdVfySubj_CH','UpdVfySubj_CL','UpdVfySubj_CN','UpdVfySubj_CO','UpdVfySubj_CR',
																 'UpdVfySubj_DE','UpdVfySubj_DK','UpdVfySubj_ES','UpdVfySubj_FR','UpdVfySubj_GB','UpdVfySubj_GR',
																 'UpdVfySubj_HK','UpdVfySubj_ID','UpdVfySubj_IN','UpdVfySubj_IT','UpdVfySubj_JP','UpdVfySubj_KR',
																 'UpdVfySubj_MX','UpdVfySubj_MY','UpdVfySubj_NL','UpdVfySubj_NZ','UpdVfySubj_PE','UpdVfySubj_PH',
																 'UpdVfySubj_PR','UpdVfySubj_SG','UpdVfySubj_TH','UpdVfySubj_TR','UpdVfySubj_TW','UpdVfySubj_VE',
																 'UpdVfySubj_VN','UpdVfySubj_ZA',''],List_Rec);
																 
export Carrier_List:=  dataset(['1','0','6','BellSouth','7-11 Speakout','\\N','AT&T'],List_Rec);

																

end;