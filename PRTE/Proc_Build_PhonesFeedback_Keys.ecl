import	_control, PRTE_CSV;

  export Proc_Build_PhonesFeedback_Keys(string pIndexVersion)	:= function


 rKeyPhonesFeedback__key__phonesfeedback__phone	:=record
 
PRTE_CSV.PhonesFeedback.rthor_data400__key__phonesfeedback__phone;

end;

dKeyphonesfeedback__key__phonesfeedback__phone := project(PRTE_CSV.PhonesFeedback.dthor_data400__key__phonesfeedback__phone,rKeyPhonesFeedback__key__phonesfeedback__phone);
kKeyphonesfeedback__key__phonesfeedback__phone := index(dKeyphonesfeedback__key__phonesfeedback__phone, {phone_number}, {dKeyphonesfeedback__key__phonesfeedback__phone}, '~prte::key::phonesfeedback::' + pIndexVersion + '::phone');


return	sequential(	build(kKeyphonesfeedback__key__phonesfeedback__phone,  update),


   											PRTE.UpdateVersion('PhoneFeedbackKeys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								
								
								);
								 

end;

