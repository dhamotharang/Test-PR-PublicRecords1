IMPORT Prof_License;

//***** Usage :-
//*****Prof_License.Mac_Prof_License_Update_Spray
//*****(
//*****		_control.IPAddress.edata12,    				//edata12
//*****		'/hds_4/prolic/in/health_licenses/',  //File Path
//*****		'/*.txt',  													  //File name
//*****		'IN',                        					//state_code
//*****		'',                          					//file_type ('' or Fixed)
//*****		'20120123',                 			 		//file_date (raw data folder date to spray files on thor)
//*****		'thor400_44'     											//cluster group
//*****);

EXPORT Mac_Prof_License_Update_Spray(source_IP, source_path, file_name, state, file_type='',
                                     filedate, group_name) := MACRO

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
  #uniquename(add_Raw_super)
  #uniquename(IfnotCreate_RawSuper)
  #uniquename(super_Raw_main)
  #uniquename(Create_RawSuper)
  #uniquename(check_raw)
  #uniquename(spray_raw)
  #uniquename(remove_file)
  #uniquename(remove_Clean_super)

  #workunit('name', 'Prof_License' + state + ' Spray & Clean');

  %sourceCsvSeparater% := '\\|';
  %sourceCsvTeminater% := '\\n,\\r\\n';
  %sourceCsvQuote% := '\"';

  %st% := stringlib.StringToUpperCase(TRIM(state, LEFT, RIGHT));

  #if (%st% in ['IN','WY'])
	  %ftype% := stringlib.StringToUpperCase(TRIM(file_type, LEFT, RIGHT));

	  %subname% := IF(LENGTH(TRIM(file_type, LEFT, RIGHT)) > 0,
					          %st% + '_' + %ftype%,
					          %st%);

	  %recSize% := MAP(%subname% = 'XX' => 192, // sample For Fixed length
					           %subname% = 'ZZ' => 345,// state code not yet specified
					           8192);  //For varying length

	  %spray_raw% :=
		  IF(%st% IN ['IN', 'WY'],
				 FileServices.SprayVariable(Source_IP
													          ,source_path + filedate + '/' +  file_name
													          ,
													          ,%sourceCsvSeparater%
													          ,
													          ,%sourceCsvQuote%
													          ,group_name
													          ,Prof_License.Constants.cluster + 'in::prolic::' + filedate +
																		   '::'+ %subname% + '_Update_Raw'
													          ,-1
													          ,
													          ,
													          ,TRUE
													          ,
													          ,TRUE),
				 FileServices.SprayFixed(Source_IP
												         ,source_path + filedate + '/' + file_name
												         ,%recSize%
												         ,group_name
												         ,Prof_License.Constants.cluster + 'in::prolic::' + filedate +
																    '::' + %subname% + '_Update_Raw'
												         ,-1
												         ,
												         ,
												         ,TRUE
												         ,TRUE));

    %check_raw% := IF(NOT FileServices.FileExists(Prof_License.Constants.cluster + 'in::prolic::' +
		                                                 filedate + '::' + %subname% + '_Update_Raw'),
											%spray_raw%);

	  %Create_RawSuper% :=
		  FileServices.CreateSuperFile(Prof_License.Constants.cluster + 'in::prolic::' + %subname% +
			                                '_Raw_updates::Superfile', FALSE);

	  %IfnotCreate_RawSuper% :=
		  IF(NOT FileServices.SuperFileExists(Prof_License.Constants.cluster + 'in::prolic::' +
			                                       %subname% + '_Raw_updates::Superfile'),
				 %Create_RawSuper%);

    %super_Raw_main% :=
		  SEQUENTIAL(FileServices.StartSuperFileTransaction(),
							   FileServices.AddSuperFile(Prof_License.Constants.cluster + 'in::prolic::' +
								                              %subname% + '_Raw_updates::Superfile',
											                     Prof_License.Constants.cluster + 'in::prolic::' +
																					    filedate + '::' + %subname% + '_Update_Raw'),
							   FileServices.FinishSuperFileTransaction());

	  %add_Raw_super% :=
		  IF(FileServices.FindSuperFileSubName(Prof_License.Constants.cluster + 'in::prolic::' +
			                                        %subname% + '_Raw_updates::Superfile',
																					 Prof_License.Constants.cluster + 'in::prolic::' +
																					    filedate + '::' + %subname% + '_Update_Raw') = 0,
				 %super_Raw_main%);

    %cleaned_file% := CASE(%subname%,
	                         'IN' => OUTPUT(Prof_License.Mapping_IN_As_ProfLic,
													                ,
																					Prof_License.Constants.cluster + 'in::prolic_' +
																					   %subname% + '_new',compressed, OVERWRITE),
						               'WY' => OUTPUT(Prof_License.Mapping_WY_As_ProfLic,
													                ,
																					Prof_License.Constants.cluster + 'in::prolic_' +
																					   %subname% + '_new', compressed,OVERWRITE));

		%remove_file% :=
		  SEQUENTIAL(FileServices.StartSuperFileTransaction(),
							   FileServices.RemoveSuperFile(Prof_License.Constants.cluster + 'in::prolic::allsources',
											                        Prof_License.Constants.cluster + 'in::prolic_' +
																							   %subname% + '_new'),
							   FileServices.FinishSuperFileTransaction());

		%remove_Clean_super% :=
		  IF(FileServices.FindSuperFileSubName(Prof_License.Constants.cluster + 'in::prolic::allsources',
		                                       Prof_License.Constants.cluster + 'in::prolic_' +
																					    %subname% + '_new') <> 0,
				 %remove_file%);

	  %super_Clean_main% :=
		  SEQUENTIAL(FileServices.StartSuperFileTransaction(),
							   FileServices.AddSuperFile(Prof_License.Constants.cluster + 'in::prolic::allsources',
											                     Prof_License.Constants.cluster + 'in::prolic_' +
																					    %subname% + '_new'),
							   FileServices.FinishSuperFileTransaction());

	  %add_Clean_super% :=
		  IF(FileServices.FindSuperFileSubName(Prof_License.Constants.cluster + 'in::prolic::allsources',
		                                       Prof_License.Constants.cluster + 'in::prolic_' +
																					    %subname% + '_new') = 0,
				 %super_Clean_main%);

	  SEQUENTIAL(%remove_Clean_super%,
		           %check_raw%,
							 %IfnotCreate_RawSuper%,
							 %add_Raw_super%,
							 %cleaned_file%,
							 %add_Clean_super%);
  #else
	  ERROR('Job failed - STATE code passed is not a valid Prof_License state code. ' +
	        'Please double check the state code passed - for new state ,you need to modify ' +
		      'the code to accommodate the new state before re-running this spray macro.');
  #end
ENDMACRO;
