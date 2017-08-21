IMPORT	_Control,Infutor_NARE;

//Reads the input directory and sprays all files in the directory to the target
//location. The input files are with txt extention and delimited by tab.

EXPORT proc_spray_nare(string	fileDate)	:=	FUNCTION

srcCSVseparator		:= '\\t';
srcCSVterminator	 := '\\n,\\r\\n';
srcCSVquote				:= '';
maxrecordsize			:= 3500;
//srcCSVterminator	 := '\\n,\\r\\n';
//srcCSVquote				  := '';
sprayIP	:=	_control.IPAddress.bctlpedata12;
group_name := 'thor400_44';

sourcePath	:= '/data/data_build_4/infutor_nare/'+fileDate+'/';


//Spray Files
InfutorEmail_AK :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_AK_'+fileDate),
											output('Infutor AK spray completed in previous run'),
											FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_AK.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_AK_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_AL :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_AL_'+fileDate),
												output('Infutor AL spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_AL.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_AL_'+fileDate,-1,,,true,false,true));


InfutorEmail_AR :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_AR_'+fileDate),
												output('Infutor AR spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_AR.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_AR_'+fileDate,-1,,,true,false,true));

InfutorEmail_AZ :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_AZ_'+fileDate),
												output('Infutor AZ spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_AZ.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_AZ_'+fileDate,-1,,,true,false,true));

InfutorEmail_CA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_CA_'+fileDate),
												output('Infutor CA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_CA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_CA_'+fileDate,-1,,,true,false,true));


InfutorEmail_CO :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_CO_'+fileDate),
												output('Infutor CO spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_CO.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_CO_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_CT :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_CT_'+fileDate),
												output('Infutor CT spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_CT.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_CT_'+fileDate,-1,,,true,false,true));

InfutorEmail_DC :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_DC_'+fileDate),
												output('Infutor DC spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_DC.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_DC_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_DE :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_DE_'+fileDate),
												output('Infutor DE spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_DE.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_DE_'+fileDate,-1,,,true,false,true));

InfutorEmail_FL :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_FL_'+fileDate),
												output('Infutor FL spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_FL.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_FL_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_GA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_GA_'+fileDate),
												output('Infutor GA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_GA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_GA_'+fileDate,-1,,,true,false,true));																							
																								
InfutorEmail_HI :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_HI_'+fileDate),
												output('Infutor HI spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_HI.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_HI_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_IA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_IA_'+fileDate),
												output('Infutor IA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_IA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_IA_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_ID :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_ID_'+fileDate),
												output('Infutor ID spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_ID.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_ID_'+fileDate,-1,,,true,false,true));

InfutorEmail_IL :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_IL_'+fileDate),
												output('Infutor IL spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_IL.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_IL_'+fileDate,-1,,,true,false,true));

InfutorEmail_IN :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_IN_'+fileDate),
												output('Infutor IN spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_IN.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_IN_'+fileDate,-1,,,true,false,true));

InfutorEmail_KS :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_KS_'+fileDate),
												output('Infutor KS spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_KS.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_KS_'+fileDate,-1,,,true,false,true));

InfutorEmail_KY :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_KY_'+fileDate),
												output('Infutor KY spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_KY.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_KY_'+fileDate,-1,,,true,false,true));

InfutorEmail_LA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_LA_'+fileDate),
												output('Infutor LA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_LA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_LA_'+fileDate,-1,,,true,false,true));

InfutorEmail_MA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MA_'+fileDate),
												output('Infutor MA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MA_'+fileDate,-1,,,true,false,true));

InfutorEmail_MD :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MD_'+fileDate),
												output('Infutor MD spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MD.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MD_'+fileDate,-1,,,true,false,true));

InfutorEmail_ME :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_ME_'+fileDate),
												output('Infutor ME spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_ME.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_ME_'+fileDate,-1,,,true,false,true));

InfutorEmail_MI :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MI_'+fileDate),
												output('Infutor MI spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MI.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MI_'+fileDate,-1,,,true,false,true));

InfutorEmail_MN :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MN_'+fileDate),
												output('Infutor MN spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MN.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MN_'+fileDate,-1,,,true,false,true));

InfutorEmail_MO :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MO_'+fileDate),
												output('Infutor MO spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MO.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MO_'+fileDate,-1,,,true,false,true));																							

InfutorEmail_MS :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MS_'+fileDate),
												output('Infutor MS spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MS.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MS_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_MT :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_MT_'+fileDate),
												output('Infutor MT spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_MT.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_MT_'+fileDate,-1,,,true,false,true));

InfutorEmail_NC :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NC_'+fileDate),
												output('Infutor NC spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NC.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NC_'+fileDate,-1,,,true,false,true));

InfutorEmail_ND :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_ND_'+fileDate),
												output('Infutor ND spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_ND.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_ND_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_NE :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NE_'+fileDate),
												output('Infutor NE spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NE.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NE_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_NH :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NH_'+fileDate),
												output('Infutor NH spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NH.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NH_'+fileDate,-1,,,true,false,true));

InfutorEmail_NJ :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NJ_'+fileDate),
												output('Infutor NJ spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NJ.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NJ_'+fileDate,-1,,,true,false,true));

InfutorEmail_NM :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NM_'+fileDate),
												output('Infutor NM spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NM.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NM_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_NV :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NV_'+fileDate),
												output('Infutor NV spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NV.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NV_'+fileDate,-1,,,true,false,true));

InfutorEmail_NY :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_NY_'+fileDate),
												output('Infutor NY spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_NY.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_NY_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_OH :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_OH_'+fileDate),
												output('Infutor OH spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_OH.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_OH_'+fileDate,-1,,,true,false,true));

InfutorEmail_OK :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_OK_'+fileDate),
												output('Infutor OK spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_OK.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_OK_'+fileDate,-1,,,true,false,true));

InfutorEmail_OR :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_OR_'+fileDate),
												output('Infutor OR spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_OR.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_OR_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_PA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_PA_'+fileDate),
												output('Infutor PA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_PA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_PA_'+fileDate,-1,,,true,false,true));

InfutorEmail_PR :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_PR_'+fileDate),
												output('Infutor PR spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_PR.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_PR_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_RI :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_RI_'+fileDate),
												output('Infutor RI spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_RI.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_RI_'+fileDate,-1,,,true,false,true));

InfutorEmail_SC :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_SC_'+fileDate),
												output('Infutor SC spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_SC.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_SC_'+fileDate,-1,,,true,false,true));

InfutorEmail_SD :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_SD_'+fileDate),
												output('Infutor SD spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_SD.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_SD_'+fileDate,-1,,,true,false,true));

InfutorEmail_TN :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_TN_'+fileDate),
												output('Infutor TN spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_TN.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_TN_'+fileDate,-1,,,true,false,true));



InfutorEmail_TX :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_TX_'+fileDate),
												output('Infutor TX spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_TX.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_TX_'+fileDate,-1,,,true,false,true));

InfutorEmail_UT :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_UT_'+fileDate),
												output('Infutor UT spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_UT.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_UT_'+fileDate,-1,,,true,false,true));

InfutorEmail_VA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_VA_'+fileDate),
												output('Infutor VA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_VA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_VA_'+fileDate,-1,,,true,false,true));


InfutorEmail_VT :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_VT_'+fileDate),
												output('Infutor VT spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_VT.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_VT_'+fileDate,-1,,,true,false,true));
																								
InfutorEmail_WA :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_WA_'+fileDate),
												output('Infutor WA spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_WA.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_WA_'+fileDate,-1,,,true,false,true));

InfutorEmail_WI :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_WI_'+fileDate),
												output('Infutor WI spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_WI.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_WI_'+fileDate,-1,,,true,false,true));																								

InfutorEmail_WV :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_WV_'+fileDate),
												output('Infutor WV spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_WV.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_WV_'+fileDate,-1,,,true,false,true));

InfutorEmail_WY :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_WY_'+fileDate),
												output('Infutor WY spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_WY.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_WY_'+fileDate,-1,,,true,false,true));

InfutorEmail_00 :=	if(fileservices.fileexists('~thor_data400::in::email::infutor_email_00_'+fileDate),
												output('Infutor 00 spray completed in previous run'),
												FileServices.SprayVariable(sprayIP,
																									sourcePath+'NARE_00.txt',
																									maxrecordsize,
																									srcCSVseparator,
																									srcCSVterminator,
																									srcCSVquote,
																									group_name,
																									'~thor_data400::in::email::infutor_email_00_'+fileDate,-1,,,true,false,true));
																								
// Run file sprays
runspray := sequential (InfutorEmail_AK, InfutorEmail_AL, InfutorEmail_AR, InfutorEmail_AZ,
						InfutorEmail_CA, InfutorEmail_CO, InfutorEmail_CT, 
						InfutorEmail_DC, InfutorEmail_DE, 
						InfutorEmail_FL, InfutorEmail_GA, InfutorEmail_HI,
						InfutorEmail_IA, InfutorEmail_ID, InfutorEmail_IL, InfutorEmail_IN,
						InfutorEmail_KS, InfutorEmail_KY, InfutorEmail_LA, 
						InfutorEmail_MA, InfutorEmail_MD, InfutorEmail_ME, InfutorEmail_MI,
   					InfutorEmail_MN, InfutorEmail_MO, InfutorEmail_MS, InfutorEmail_MT,
						InfutorEmail_NC, InfutorEmail_ND, InfutorEmail_NE, InfutorEmail_NH,
 						InfutorEmail_NJ, InfutorEmail_NM, InfutorEmail_NV, InfutorEmail_NY,
						InfutorEmail_OH, InfutorEmail_OK, InfutorEmail_OR, 
						InfutorEmail_PA, InfutorEmail_PR, InfutorEmail_RI, 
						InfutorEmail_SC, InfutorEmail_SD,
						InfutorEmail_TN, InfutorEmail_TX, InfutorEmail_UT,
						InfutorEmail_VA, InfutorEmail_VT, 
						InfutorEmail_WA, InfutorEmail_WI, InfutorEmail_WV, InfutorEmail_WY,
						InfutorEmail_00);
						
// Superfile transactions
addEmailSuper :=	sequential(FileServices.ClearSuperFile('~thor_data400::in::email::infutor_email_raw',true),
														FileServices.StartSuperFileTransaction(),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_AK_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_AL_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_AR_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_AZ_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_CA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_CO_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_CT_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_DC_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_DE_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_FL_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_GA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_HI_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_IA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_ID_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_IL_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_IN_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_KS_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_KY_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_LA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MD_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_ME_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MI_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MN_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MO_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MS_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_MT_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NC_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_ND_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NE_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NH_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NJ_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NM_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NV_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_NY_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_OH_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_OK_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_OR_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_PA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_PR_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_RI_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_SC_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_SD_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_TN_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_TX_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_UT_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_VA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_VT_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_WA_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_WI_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_WV_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_WY_'+fileDate),
														FileServices.AddSuperFile('~thor_data400::in::email::infutor_email_raw','~thor_data400::in::email::infutor_email_00_'+fileDate),
														FileServices.FinishSuperFileTransaction()
														);
														
	RETURN IF(sourcePath != '',SEQUENTIAL(runspray,addEmailSuper),output('No new email files to spray'));
END;