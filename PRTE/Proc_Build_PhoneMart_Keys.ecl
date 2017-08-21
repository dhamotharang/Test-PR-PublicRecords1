IMPORT	_control, PRTE_CSV,PhoneMart;

IMPORT PRTE2_Common;

EXPORT Proc_Build_PhoneMart_Keys(string pIndexVersion, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
	
	rKeyPhoneMart__did__key	:= RECORD
		PRTE_CSV.PhoneMart.rthor_data400__key__phonesplus__did;
	END;
                                                       
	dKeyPhoneMart__did__key	:= 	project(PRTE_CSV.PhoneMart.dthor_data400__key__phonemart__did, rKeyPhoneMart__did__key);	
	kKeyPhoneMart__did__key	:=	index(dKeyPhoneMart__did__key, {l_did}, {dKeyPhoneMart__did__key}, '~prte::key::phonemart::' + pIndexVersion + '::did');

	//---------- making DOPS optional and only in PROD build -------------------------------													
	notifyEmail 						:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 								:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
	PerformUpdate 					:= PRTE.UpdateVersion('PhoneMartKeys',					//	Package name
																								pIndexVersion,						//	Package version
																								notifyEmail,							//	Who to email with specifics
																								'B',											//	B = Boca, A = Alpharetta
																								'N',											//	N = Non-FCRA, F = FCRA
																								'N'												//	N = Do not also include boolean, Y = Include boolean, too
																								);
	PerformUpdateOrNot 			:= IF(doDOPS,PerformUpdate,NoUpdate);

	RETURN	SEQUENTIAL(BUILD(kKeyPhoneMart__did__key, update),
										 PerformUpdateOrNot);

END;
