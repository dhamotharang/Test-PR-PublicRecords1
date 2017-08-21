import	lib_stringlib,lib_fileservices,_control,AID,Address;

export	Spray_LN_infiles(string	pVersionDate)	:=
function
	vSourceIP					:=	_control.IPAddress.edata10;
	vSourcePath				:=	'/data_build_2/property/ln/in/spray_hpcc/' + pVersionDate +'/';
	vTargetGrp				:=	_control.TargetGroup.Thor400_30;//'thor40_241_7';//
	vFilePrefix				:=	'~thor_data400::in::ln_propertyV2::'	+	pVersionDate;
	
	sprayAssessor			:=	FileServices.sprayfixed(	vSourceIP,
																									vSourcePath	+	'ln_assessor_'	+	pVersionDate	+	'.dat',
																									2000,
																									vTargetGrp,
																									vFilePrefix	+	'::assessor_raw',
																									,,,true,,true
																								);
	
	sprayAssessorRepl	:=	FileServices.sprayfixed(	vSourceIP,
																									vSourcePath	+	'ln_repl_assessor_'	+	pVersionDate	+	'.dat',
																									2000,
																									vTargetGrp,
																									vFilePrefix	+	'::assessor_repl_raw',
																									,,,true,,true
																								);
	
	sprayDeed					:=	FileServices.sprayfixed(	vSourceIP,
																									vSourcePath	+	'ln_deed_'	+	pVersionDate	+	'.dat',
																									1500,
																									vTargetGrp,
																									vFilePrefix	+	'::deed_raw',
																									,,,true,,true
																								);
	
	sprayDeedRepl			:=	FileServices.sprayfixed(	vSourceIP,
																									vSourcePath	+	'ln_repl_deed_'	+	pVersionDate	+	'.dat',
																									1500,
																									vTargetGrp,
																									vFilePrefix	+	'::deed_repl_raw',
																									,,,true,,true
																								);
	
	sprayMortgage			:=	FileServices.sprayfixed(	vSourceIP,
																									vSourcePath	+	'ln_sam_'	+	pVersionDate	+	'.dat',
																									1250,
																									vTargetGrp,
																									vFilePrefix	+	'::mortgage_raw',
																									,,,true,,true
																								);
	
	sprayMortgageRepl	:=	FileServices.sprayfixed(	vSourceIP,
																									vSourcePath	+	'ln_repl_sam_'	+	pVersionDate	+	'.dat',
																									1250,
																									vTargetGrp,
																									vFilePrefix	+	'::mortgage_repl_raw',
																									,,,true,,true
																								);
	
	sprayFiles	:=	parallel(sprayAssessor,sprayAssessorRepl,sprayDeed,sprayDeedRepl,sprayMortgage,sprayMortgageRepl);

	add2Super		:=	sequential(	fileservices.startsuperfiletransaction(),
															
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessment			+	'_delete',LN_PropertyV2.fileNames.In.LNAssessment			+	'_father',,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl	+	'_delete',LN_PropertyV2.fileNames.In.LNAssessmentRepl	+	'_father',,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeed						+	'_delete',LN_PropertyV2.fileNames.In.LNDeed						+	'_father',,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl				+	'_delete',LN_PropertyV2.fileNames.In.LNDeedRepl				+	'_father',,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgage				+	'_delete',LN_PropertyV2.fileNames.In.LNMortgage				+	'_father',,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl		+	'_delete',LN_PropertyV2.fileNames.In.LNMortgageRepl		+	'_father',,true),
															
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNAssessment			+	'_father'),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl	+	'_father'),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNDeed						+	'_father'),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl				+	'_father'),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNMortgage				+	'_father'),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl		+	'_father'),
															
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessment			+	'_father',LN_PropertyV2.fileNames.In.LNAssessment			,,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl	+	'_father',LN_PropertyV2.fileNames.In.LNAssessmentRepl	,,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeed						+	'_father',LN_PropertyV2.fileNames.In.LNDeed						,,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl				+	'_father',LN_PropertyV2.fileNames.In.LNDeedRepl				,,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgage				+	'_father',LN_PropertyV2.fileNames.In.LNMortgage				,,true),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl		+	'_father',LN_PropertyV2.fileNames.In.LNMortgageRepl		,,true),
															
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNAssessment),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNDeed),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNMortgage),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl),
															
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessment			,vFilePrefix	+	'::assessor_raw'),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl	,vFilePrefix	+	'::assessor_repl_raw'),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeed						,vFilePrefix	+	'::deed_raw'),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl				,vFilePrefix	+	'::deed_repl_raw'),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgage				,vFilePrefix	+	'::mortgage_raw'),
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl		,vFilePrefix	+	'::mortgage_repl_raw'),
															
															fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessment			+'_history'         ,vFilePrefix	+	'::assessor_raw'),
                              fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl +'_history'         ,vFilePrefix	+	'::assessor_repl_raw'),
                              fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeed           +'_history'         ,vFilePrefix	+	'::deed_raw'),
                              fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl       +'_history'         ,vFilePrefix	+	'::deed_repl_raw'),
                              fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgage       +'_history'         ,vFilePrefix	+	'::mortgage_raw') ,
                              fileservices.addsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl   +'_history'         ,vFilePrefix	+	'::mortgage_repl_raw'),
															
															fileservices.finishsuperfiletransaction(),
															
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNAssessment			+	'_delete',true),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNAssessmentRepl	+	'_delete',true),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNDeed						+	'_delete',true),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNDeedRepl				+	'_delete',true),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNMortgage				+	'_delete',true),
															fileservices.clearsuperfile(LN_PropertyV2.fileNames.In.LNMortgageRepl		+	'_delete',true)
														);

  preprocess := sequential(LN_PropertyV2.Prep_OKC_Assessments(pVersionDate),
													 LN_PropertyV2.Prep_OKC_Deeds(pVersionDate),
                           LN_PropertyV2.Prep_OKC_Mortgages(pVersionDate)); 

	return	sequential(sprayFiles,add2Super,preprocess);
end;