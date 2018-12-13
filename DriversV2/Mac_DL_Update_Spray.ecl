import DriversV2;

//***** Usage :-
//***** DriversV2.Mac_DL_Update_Spray
//***** (
//*****		'edata12.br.seisint.com',    //edata12
//*****		'/data_build_1/dl_temp/',    //File Path
//*****		'OH_DRFile_E_20070530.txt',  //File name
//*****		'OH',                        //state_code
//*****		'',                          //file_type
//*****		'20070530',                  //process_date
//*****		'20070530',                  //file_date
//*****		'thor_dataland_linux',       //group 
//***** )


//***** Note:-
//*****   File types are only available for "MO" state - valid type are "BASIC", "ICISSU", "MEDCERT", or "NOCERT".
//*****   For all other states it should be set to '' (empty)


//***** Modification History :-
//***** Removed "MO" data, per Jill Luber to be compliant with the new state law(bug#37550; 20090309)
//***** re-instated MO per Jill Luber 20090716

export Mac_DL_Update_Spray(source_IP,source_path,file_name,state,file_type='',process_dte,filedate,group_name) := 
macro

#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(st)
#uniquename(ftype)
#uniquename(subname)
#uniquename(recSize)
#uniquename(add_Clean_super)
#uniquename(super_Clean_main)
#uniquename(IfnotCreate_CleanSuper)
#uniquename(Create_CleanSuper)
#uniquename(check_clean)
#uniquename(cleaned_file)
#uniquename(scrub_files)
#uniquename(add_Raw_super)
#uniquename(IfnotCreate_RawSuper)
#uniquename(super_Raw_main)
#uniquename(Create_RawSuper)
#uniquename(check_raw)
#uniquename(spray_raw)
#uniquename(As_DL_mapper)
#uniquename(IfnotCreate_As_DL_Super)
#uniquename(super_As_DL)
#uniquename(add_AS_Dl_super)

//#workunit('name','DrvLic '+ state + ' Spray & CLean');

%sourceCsvSeparater% := if (state='NC','$',if (state='MA','\\|\\|','\\|'));
%sourceCsvTeminater% := '\\n,\\r\\n';
%sourceCsvQuote% := '\"';

%st% := stringlib.StringToUpperCase(trim(state,left,right));

// Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
//re-instated MO per Jill Luber 20090716
//#if (%st% in ['CT','FL','ME','MI','MN','MO','OH','TN','TX','WI','WV','WY'])
#if (%st% in ['CT','FL','LA','MA','ME','MI','MN','MO','NC','NE','NV','OH','TN','TX','WI','WV','WY'])

	%ftype% := stringlib.StringToUpperCase(trim(file_type,left,right));

	%subname% :=  if(trim(state,left,right) = 'MO' and trim(file_type,left,right) = 'NOCERT',
	                %st%,
						      if(trim(state,left,right) = 'MO' and trim(file_type,left,right) = 'MEDCERT',
									   %st% + '_' + %ftype%, 
										 if(trim(state,left,right) = 'MO' and length(trim(file_type,left,right)) = 0,
										   ERROR('FILE TYPE IS INCORRECT. PLEASE ENTER THE CORRECT FILE TYPE'),
											 if (length(trim(file_type,left,right)) > 0,
											    %st% + '_' + %ftype%,
	                        %st%
												))));

	%recSize% := map(%subname% = 'CT'        => 196,
					 %subname% = 'LA'        => 151,
					//%subname% = 'MA'        => 227,
					//%subname% = 'ME'        => 309,
					 %subname% = 'ME_MEDCERT' => 519,
					 //%subname% = 'MI'        => 211,
			     %subname% = 'MI'        => 212,
					 %subname% = 'MN'        => 245,
					// Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
					//re-instated MO per Jill Luber 20090716
					 %subname% = 'MO_BASIC'  => 376,  //ebcdic
					 %subname% = 'MO_ICISSU' => 392,  //ebcdic
					 %subname% = 'NE'        => 130,
					 %subname% = 'NV'        => 307,
					 %subname% = 'OH'        => 402,
					 //%subname% = 'TN'        => 219,
					 %subname% = 'TN'        => 253,
					 //%subname% = 'TX'        => 275,  //ebcdic
					 %subname% = 'WI'        => 386,  //ebcdic
					 %subname% = 'WV'        => 201,
					 //%subname% = 'WY'        => 192,			
					 %subname% = 'WY_MEDCERT' => 203,	
					 8192  //FL, MO,MO_MEDCERT, & TX is a varying length
					);
					
	// Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
	//re-instated MO per Jill Luber 20090716
	//%spray_raw% := if (%st% in ['CT', 'ME', 'MI', 'MN', 'MO', 'OH', 'TN', 'TX', 'WI', 'WV', 'WY'],
	//%spray_raw% := if (%st% in ['CT', 'LA','ME', 'MI', 'MN','MO','NE','NV','OH', 'TN', 'TX', 'WI', 'WV', 'WY'],
	%spray_raw% := if (%st% in ['CT', 'LA','ME', 'MI', 'MN','NE','NV','OH', 'TN', 'WI', 'WV', 'WY'] OR
	                   %subname% = 'MO_BASIC' OR %subname% = 'MO_ICISSU',
						FileServices.SprayFixed(Source_IP
												,source_path + file_name
												,%recSize%
												,group_name
												,DriversV2.Constants.cluster +'in::dl2::'+filedate+'::'+%subname%+'_Update_Raw'
												,-1
												,
												,
												,true
												,true),
						FileServices.SprayVariable(Source_IP
												   ,source_path + file_name
												   ,
												   ,%sourceCsvSeparater%
												   ,
												   ,%sourceCsvQuote%
												   ,group_name
												   ,DriversV2.Constants.cluster +'in::dl2::'+filedate+'::'+%subname%+'_Update_Raw'
												  ,-1
												   ,
												   ,
												   ,true
												   ,
												   ,true));
    %check_raw%  :=if (not FileServices.FileExists(DriversV2.Constants.cluster + 'in::dl2::'+filedate+'::'+%subname%+'_Update_Raw'),%spray_raw%);

	%Create_RawSuper% := FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Raw_updates::Superfile',false);
	
	%IfnotCreate_RawSuper% := if (not FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Raw_updates::Superfile'),%Create_RawSuper%); 
	
    %super_Raw_main% := sequential(
							FileServices.StartSuperFileTransaction(),
					
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Raw_updates::Superfile', 
											  DriversV2.Constants.cluster +'in::dl2::'+filedate+'::'+%subname%+'_Update_Raw'), 
							FileServices.FinishSuperFileTransaction());

	%add_Raw_super% := if(FileServices.FindSuperFileSubName(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Raw_updates::Superfile',  DriversV2.Constants.cluster +'in::dl2::'+filedate+'::'+%subname%+'_Update_Raw') = 0, %super_Raw_main%); 

	%cleaned_file% := case(%subname%,
	                       'CT' => output(DriversV2.Cleaned_DL_CT(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'FL' => output(DriversV2.Cleaned_DL_FL(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'LA' => output(DriversV2.Cleaned_DL_LA(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'MA' => output(DriversV2.Cleaned_DL_MA(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),							 
												 //New Layout for ME DL includes medical certification data               
												 'ME_MEDCERT' => output(DriversV2.Cleaned_DL_ME(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'MI' => output(DriversV2.Cleaned_DL_MI(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'MN' => output(DriversV2.Cleaned_DL_MN(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'NC' => output(DriversV2.Cleaned_DL_NC(process_dte, filedate,file_type),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'NC_CHG' => output(DriversV2.Cleaned_DL_NC(process_dte, filedate,file_type),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'NE' => output(DriversV2.Cleaned_DL_NE(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'NV' => output(DriversV2.Cleaned_DL_NV(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 // Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
												 //re-instated MO per Jill Luber 20090716
												 //Original New layout for MO DL
												 'MO' => output(DriversV2.Cleaned_DL_MO(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 //New Layout for MO DL includes medical certification data               
												 'MO_MEDCERT' => parallel(output(DriversV2.Cleaned_DL_MO_MedCert(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
																									DriversV2.Cleaned_DL_MO_ConvPoints_MedCert(process_dte, filedate)
																								 ),
												 'MO_BASIC' => output(DriversV2.Cleaned_DL_MO_Basic(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'MO_ICISSU' => output(DriversV2.Cleaned_DL_MO_Icissu(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'OH' => output(DriversV2.Cleaned_DL_OH(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'TN' => output(DriversV2.Cleaned_DL_TN_Update(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'TX' => output(DriversV2.Cleaned_DL_TX(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),														 
												 'WI' => output(DriversV2.Cleaned_DL_WI(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 'WV' => output(DriversV2.Cleaned_DL_WV(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__),
												 //'WY' => output(DriversV2.Cleaned_DL_WY(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__)	
												 //New Layout for WY DL includes medical certification data               
												 'WY_MEDCERT' => output(DriversV2.Cleaned_DL_WY_MEDCERT(process_dte, filedate),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',overwrite,__compressed__)				
												);
						  
						  
	
	%check_clean% := if(not FileServices.FileExists(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned'),
											  %cleaned_file%);
												
	%As_DL_mapper% := case(%subname%,
													'CT' => output(DriversV2.CT_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',drivers.Layout_CT_Full,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'FL' => output(DriversV2.FL_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',drivers.Layout_FL_Update,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//'LA' => output(DriversV2.LA_as_DL,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'MA' => output(DriversV2.MA_as_DL_New(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layout_DL_MA_In.Layout_MA_With_Clean,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),							 
													//New Layout for ME DL includes medical certification data               
													'ME_MEDCERT' => output(DriversV2.ME_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',drivers.Layout_ME_Full,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'MI' => output(DriversV2.MI_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_MI_In.Layout_MI_Cleaned,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//'MN' => output(DriversV2.MN_New_as_dl,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'NC' => output(DriversV2.NC_As_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'NC_CHG' => output(DriversV2.NC_As_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'NE' => output(DriversV2.NE_As_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_NE_In.Layout_NE_With_Clean,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'NV' => output(DriversV2.NV_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layout_DL_NV_In.Cleaned,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//Original New layout for MO DL
													//'MO' => output(DriversV2.MO_as_DL,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//New Layout for MO DL includes medical certification data
													'MO_MEDCERT' => sequential(output(DriversV2.MO_as_DL_New(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_MO_New_In.Layout_MO_with_Clean_MedCert,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
																										 DriversV2.Mapping_DL_MO_New_As_ConvPoints(filedate).Build_DL_MO_Convpoints
																										),													
													//'MO_BASIC' => output(DriversV2.MO_as_DL,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//'MO_ICISSU' => output(DriversV2.MO_as_DL,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'OH' => output(DriversV2.OH_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'TN' => output(DriversV2.TN_as_DL_Update(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_TN_In.Layout_TN_Update2_Cleaned,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													'TX' => output(DriversV2.TX_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_TX_Update.Layout_DL_TX_Update2,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),														 
													'WI' => output(DriversV2.WI_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',Drivers.Layout_WI_Full,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//'WV' => output(DriversV2.WV_as_DL,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__),
													//New Layout for WY DL includes medical certification data               
													'WY_MEDCERT' => output(DriversV2.WY_Medcert_as_DL(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned',DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Cleaned,thor)),,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL',overwrite,__compressed__)				
												);

	%scrub_files% := case(%subname%
	                     ,'CT'             => DriversV2.Scrub_DL(filedate).CT
 	                     ,'FL'             => DriversV2.Scrub_DL(filedate).FL
	                     // ,'LA'             => DriversV2.Scrub_DL(filedate).LA
	                     ,'MA'             => DriversV2.Scrub_DL(filedate).MA
	                     ,'ME_MEDCERT'     => DriversV2.Scrub_DL(filedate).ME_MEDCERT
	                     ,'MI'             => DriversV2.Scrub_DL(filedate).MI
	                     // ,'MO'             => DriversV2.Scrub_DL(filedate).MO
	                     // ,'MO_MEDCERT'     => DriversV2.Scrub_DL(filedate).MO_MEDCERT
	                     ,'NE'             => DriversV2.Scrub_DL(filedate).NE
	                     ,'NC'             => DriversV2.Scrub_DL(filedate).NC
	                     ,'NV'             => DriversV2.Scrub_DL(filedate).NV											 
	                     ,'OH'             => DriversV2.Scrub_DL(filedate).OH
	                     ,'TN'             => DriversV2.Scrub_DL(filedate).TN
	                     ,'TX'             => DriversV2.Scrub_DL(filedate).TX
	                     ,'WI'             => DriversV2.Scrub_DL(filedate).WI
	                     ,'WY_MEDCERT'     => DriversV2.Scrub_DL(filedate).WY_MEDCERT
                       );
											  
	%Create_CleanSuper% := FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Clean_updates::Superfile',false);
	
	%IfnotCreate_CleanSuper% := if (not FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Clean_updates::Superfile'),%Create_CleanSuper%); 										  
	
	%super_Clean_main% := sequential(
							FileServices.StartSuperFileTransaction(),
					
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Clean_updates::Superfile', 
											  DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned'), 
							FileServices.FinishSuperFileTransaction());

	%add_Clean_super% := if(FileServices.FindSuperFileSubName(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_Clean_updates::Superfile', DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_update::'+filedate+'::cleaned') = 0, %super_Clean_main%);
	
	//*** Adding As_DL state mapper files to a common superfile.
	%IfnotCreate_As_DL_Super% := sequential( if (not FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::As_DL_Mappers'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::As_DL_Mappers',false)),
																					 if (not FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::father::As_DL_Mappers'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::father::As_DL_Mappers')),
																					 if (not FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::grandfather::As_DL_Mappers'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::grandfather::As_DL_Mappers')),
																					 if (not FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::delete::As_DL_Mappers'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::delete::As_DL_Mappers'))
																				 );
	
	%super_As_DL% := sequential(
							FileServices.StartSuperFileTransaction(),
					
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::As_DL_Mappers', 
											  DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL'), 
							FileServices.FinishSuperFileTransaction());

	%add_AS_Dl_super% := if(FileServices.FindSuperFileSubName(DriversV2.Constants.cluster + 'in::dl2::As_DL_Mappers', DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'::'+filedate+'::As_DL') = 0, %super_As_DL%); 


	sequential(%check_raw%, %IfnotCreate_RawSuper%, %add_Raw_super%, %check_clean%, %As_DL_mapper%, %scrub_files%, %IfnotCreate_CleanSuper%, %add_Clean_super%, %IfnotCreate_As_DL_Super%, %add_AS_Dl_super%
						 ,NOTIFY((%st% + ' SPRAY COMPLETE FOR ' + filedate),'*'));
#else
	ERROR('Job failed - STATE code passed is not a valid Drivers License state code. ' +
	      'Please double check the state code passed - if you are sure, than need to modify ' +
		  'the code to accommodate the new state before re-running this spray macro.'
		 );
#end
endmacro;