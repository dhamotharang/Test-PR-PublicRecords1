IMPORT	_control, PRTE_CSV;

EXPORT Proc_Build_BusReg_Keys(STRING pIndexVersion          = ''
                             ,BOOLEAN	pUseOtherEnvironment	= FALSE) := FUNCTION
			
	kKeyBusReg__company_bdid		:=	index(PRTE_CSV.BusReg(pIndexVersion).dthor_data400__key__BusReg__company_bdid(),
	                                      {bdid},
	                                      {PRTE_CSV.BusReg(pIndexVersion).dthor_data400__key__BusReg__company_bdid},
	                                      PRTE_CSV.BusReg_Keyfilenames(pIndexVersion,pUseOtherEnvironment).company_bdid.old);
	kKeyBusReg__company_linkids	:=	index(PRTE_CSV.BusReg(pIndexVersion).dthor_data400__key__BusReg__company_linkids, 
	                                      {ultid,orgid,seleid,proxid,powid,empid,dotid}, 
																				{PRTE_CSV.BusReg(pIndexVersion).dthor_data400__key__BusReg__company_linkids}, 	
																				PRTE_CSV.BusReg_Keyfilenames(pIndexVersion,pUseOtherEnvironment).company_linkids.old);
	kKeyBusReg__contact_bdid		:=	index(PRTE_CSV.BusReg(pIndexVersion).dthor_data400__key__BusReg__contact_bdid(),
	                                      {bdid}, 
	                                      {PRTE_CSV.BusReg(pIndexVersion).dthor_data400__key__BusReg__contact_bdid}, 
	                                      PRTE_CSV.BusReg_Keyfilenames(pIndexVersion,pUseOtherEnvironment).contact_bdid.old);

	return	sequential(
											parallel(																																
																build(kKeyBusReg__company_bdid						    	, update)
															 ,build(kKeyBusReg__company_linkids						    , update)
															 ,build(kKeyBusReg__contact_bdid						    	, update)																		
																																																
															 ),
											PRTE.UpdateVersion('BusinessRegKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
