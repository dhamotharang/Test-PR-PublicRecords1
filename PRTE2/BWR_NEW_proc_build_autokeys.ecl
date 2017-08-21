//* BWR_NEW_proc_build_autokeys - Build the ForeclosureKeys files for Customer Test *
IMPORT PRTE2, PRTE,_control;
#WORKUNIT ('name', 'Customer Test Foreclosures');
//* set filedate to current process date
string filedate := '20121109';
string pIndexOldVersion := '20100713';
string pIndexVersion := '20121109';
Sequential (
		PRTE2.NEW_proc_build_autokeys(filedate).retval, 
		PRTE2.Proc_build_foreclosure_bid(filedate),
//* CopyMissingKeys, CopyEmptyFiles, and UpdateVersion can only be run in Prod: *//
	  PRTE2.CopyMissingKeys('ForeclosureKeys',filedate,pIndexOldVersion),
	  PRTE2.CopyEmptyFiles(filedate),	
		PRTE.UpdateVersion('ForeclosureKeys',										//	Package name
																				 filedate,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				) 
		);



