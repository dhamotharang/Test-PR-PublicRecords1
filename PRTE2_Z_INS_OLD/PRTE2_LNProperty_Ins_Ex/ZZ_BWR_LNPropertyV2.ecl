//* BWR_LNPropertyV2 //*
IMPORT PRTE, PRTE_CSV, PRTE2, ut,_control;
#WORKUNIT ('name', 'CustTest LNProperty');
string filedate         := '20130501';
string pIndexOldVersion := '20110503';
string todays_date := ut.GetDate;
string6 new_date := todays_date[3..8];
OUTPUT (new_date); 
 
 Sequential(
					PRTE2_LNProperty.NEW_Proc_Build_LNPropertyV2_keys(filedate)
//* CopyMissingKeys and UpdateVersion may only be run in PROD !!!      *//
//*  			,PRTE2.CopyMissingKeys('LNPropertyV2Keys',filedate,pIndexOldVersion)
//* Update Version after verifying the build:
/*         ,PRTE.UpdateVersion(	'LNPropertyV2Keys',							//	Package name
																					filedate,		//	Package version
																					_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
																					'B',																	//	B = Boca,A = Alpharetta
																					'N',																	//	N = Non-FCRA,F = FCRA
																					'N'																		//	N = Do not also include boolean,Y = Include boolean,too
																				) 
																PRTE.UpdateVersion(	'FCRA_LNPropertyV2Keys',										//	Package name
																					pIndexVersion,												//	Package version
																					_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
																					'B',																	//	B = Boca,A = Alpharetta
																					'F',																	//	N = Non-FCRA,F = FCRA
																					'N'																		//	N = Do not also include boolean,Y = Include boolean,too
																				) */
						); 
OUTPUT ('NEW LNPROPERTY V2 KEYS BUILT');