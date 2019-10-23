import	_control,RoxieKeyBuild,ut,Orbit3,Scrubs_DoNotCall;

export	proc_build_DNC(string	sourceIP,string	fileDate,string	NationalSourceFile,string	DMASourceFile	=	'',string	groupName	=	'thor400_44',string	emailTarget	=	' ')	:=
function
	sprayIP	:=	map(	sourceIP	=	'edata10'		   =>	_control.IPAddress.edata10,
										sourceIP	=	'edata11'		   =>	_control.IPAddress.edata11,
										sourceIP	=	'edata11b'	   =>	_control.IPAddress.edata11b,
										sourceIP	=	'edata14'		   =>	_control.IPAddress.edata14,
										sourceIP	=	'edata14a'     =>	_control.IPAddress.edata14a,
										sourceIP  = 'bctlpedata10' => _control.IPAddress.bctlpedata10,
										sourceIP
									);
	
	RoxieKeyBuild.Mac_Daily_Email_Local('DO NOT CALL','SUCC',fileDate,sendSuccMsg,if(emailTarget<>' ',emailTarget,DMA.Email_Notification_List));
	RoxieKeyBuild.Mac_Daily_Email_Local('DO NOT CALL','FAIL',fileDate,sendFailMsg,if(emailTarget<>' ',emailTarget,'christopher.brodeur@lexisnexis.com;kgummadi@seisint.com;randy.reyes@lexisnexis.com;manuel.tarectecan@lexisnexis.com'));
	
	sprayFileNational	:=	fileservices.sprayVariable(	sprayIP,
																										NationalSourceFile,,',',,'"',
																										groupName,
																										'~thor_data400::in::suppression::TPS_National_'+fileDate,,,,,true
																									);	
	sprayFileDMA			:=	fileservices.sprayVariable(	sprayIP,
																										DMASourceFile,,'\\t',,'"',
																										groupName,
																										'~thor_data400::base::suppression::TPS_DMA_'+fileDate,,,,,true,true
																									);
		
	addSuperNational	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::suppression::TPS_National','~thor_data400::in::suppression::TPS_National_'+filedate),
																		fileservices.finishsuperfiletransaction()
																	);
	
	addSuperDMA	:=	sequential(	fileservices.startsuperfiletransaction(),
															fileservices.addsuperfile('~thor_data400::base::suppression::TPS_DMA_delete','~thor_data400::base::suppression::TPS_DMA_grandfather',,true),
															fileservices.clearsuperfile('~thor_data400::base::suppression::TPS_DMA_grandfather'),
															fileservices.addsuperfile('~thor_data400::base::suppression::TPS_DMA_grandfather','~thor_data400::base::suppression::TPS_DMA_father',,true),
															fileservices.clearsuperfile('~thor_data400::base::suppression::TPS_DMA_father'),
															fileservices.addsuperfile('~thor_data400::base::suppression::TPS_DMA_father','~thor_data400::base::suppression::TPS_DMA',,true),
															fileservices.clearsuperfile('~thor_data400::base::suppression::TPS_DMA'),
															fileservices.addsuperfile('~thor_data400::base::suppression::TPS_DMA','~thor_data400::base::suppression::TPS_DMA_'+filedate),
															fileservices.finishsuperfiletransaction(),
															fileservices.clearsuperfile('~thor_data400::base::suppression::TPS_DMA_delete',true)
														);
													
	doDMA	:=	if(	DMASourceFIle	=	'',
								output('No DMA phone suppression files available'),
								sequential(sprayFileDMA,addSuperDMA)
							);

	ut.MAC_SF_BuildProcess(DMA.proc_build_tps_all(fileDate).proc_build_base_national,'~thor_data400::base::suppression::tps_national',buildNationalBase,3,,true)
	ut.MAC_SF_BuildProcess(DMA.proc_build_tps_all(fileDate).proc_build_base,'~thor_data400::base::suppression::tps',buildBase,3,,true)
	
	buildKey	:=	DMA.proc_build_tps_all(fileDate).proc_build_key : success(sendSuccMsg),failure(sendFailMsg);
	
	updateVersion	:=	RoxieKeyBuild.updateversion('DoNotCallKeys',fileDate,'kgummadi@seisint.com;cbrodeur@seisint.com;randy.reyes@lexisnexis.com;manuel.tarectecan@lexisnexis.com;abednego.escobal@lexisnexis.com',,'N');

  create_orbit_build:= Orbit3.proc_Orbit3_CreateBuild ('Do Not Call',fileDate,'N');	
	
	tpsBase		:=	distribute(DMA.file_suppressionTPS.Base,hash(phonenumber));
	tpsFather	:=	distribute(DMA.file_suppressionTPS_father,hash(phonenumber));

	typeof(tpsBase)	getNewRecs(DMA.layout_suppressionTPS.Base	l,DMA.layout_suppressionTPS.Base	r)	:=
	transform
		self	:=	l;
	end;

	sampleRecs	:=	join(	tpsBase,
												tpsFather,
												left.phonenumber	=	right.phonenumber,
												getNewRecs(left,right),
												left only,
												local
											);
	
	qaRecs 	:= output(choosen(sampleRecs,1000),named('DNC_Sample_Records'));
	qaEmail	:= fileservices.sendemail(	'christopher.brodeur@lexisnexis.com;randy.reyes@lexisnexis.com;manuel.tarectecan@lexisnexis.com;qualityassurance@seisint.com;camaral@seisint.com;abednego.escobal@lexisnexis.com',
																			'DNC sample data for build version '	+	fileDate,
																			'http://prod_esp:8010/WsWorkunits/WUInfo?Wuid='	+	workunit
																		);
	
	return	sequential(	sprayFileNational,
											addSuperNational,
											doDMA,
											buildNationalBase,
											buildBase,
											buildKey,
											updateVersion,
											create_orbit_build,
											qaRecs,
											qaEmail,
											Scrubs_DoNotCall.fnRunScrubs(fileDate,'')
										);
	
end;