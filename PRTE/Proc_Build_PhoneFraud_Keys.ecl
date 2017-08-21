import	_control, PRTE_CSV;

EXPORT Proc_Build_PhoneFraud_Keys(string pIndexVersion) := function

//OTP
	rKeyPhonefraud_otp := record
		PRTE_CSV.PhoneFraud.rthor_data400_key_phonefraud_otp;
	end;
	
	dKeyPhonefraud_otp				:= 	project(PRTE_CSV.PhoneFraud.dthor_data400_key_phonefraud_otp, rKeyPhonefraud_otp);
	kKeyPhonefraud_otp				:=	index(dKeyPhonefraud_otp, {otp_phone}, {dKeyPhonefraud_otp}, '~prte::key::' + pIndexVersion + '::phonefraud_otp');
	
//Spoofing	
	rKeyPhonefraud_spoofing := record
		PRTE_CSV.PhoneFraud.rthor_data400_key_phonefraud_spoofing;
	end;
	
	dKeyPhonefraud_spoofing		:= 	project(PRTE_CSV.PhoneFraud.dthor_data400_key_phonefraud_spoofing, rKeyPhonefraud_spoofing);
	kKeyPhonefraud_spoofing		:=	index(dKeyPhonefraud_spoofing, {phone}, {dKeyPhonefraud_spoofing}, '~prte::key::' + pIndexVersion + '::phonefraud_spoofing');	
	
	return	sequential(
											parallel(
																build(kKeyPhonefraud_otp, update),
																build(kKeyPhonefraud_spoofing, update)
															 ),
																					PRTE.UpdateVersion('PhoneFraudKeys',			//	Package name
																					pIndexVersion,														//	Package version
																					_control.MyInfo.EmailAddressNormal,				//	Who to email with specifics
																					'B',																			//	B = Boca, A = Alpharetta
																					'N',																			//	N = Non-FCRA, F = FCRA
																					'N'																				//	N = Do not also include boolean, Y = Include boolean, too
																					)
										 );

end;