import Drivers, DriversV2;

//***** Usage :-
//***** DriversV2.Mac_DL_ConvPoints_Spray
//***** (
//*****		'edata12.br.seisint.com',    //edata12
//*****		'/data_build_1/dl_temp/',    //File Path
//*****		'OH_DRFile_E_20070530.txt',  //File name
//*****		'OH',                        //state_code
//*****		'E',                         //file_type
//*****		'20070530',                  //process_date
//*****		'20070530',                  //file_date
//*****		'thor_dataland_linux',       //group 
//*****		'N'                          //Clear Superfile
//***** )
//***** NOTE:- The following are the File types for "MO", OH, & TN states - 
//*****        File type for MO are - "ACTION" or "POINTS" or "DPRDPS".
//*****                      OH are - "E" or "F" or "G" or "H" or "I" or "J" or "K"
//*****                      TN are - "TN" or "WDL" 
//***** Modification History :-
//***** Removed "MO" data, per Jill Luber to be compliant with the new state law(bug#37550; 20090309)
//***** Commented out "WY", per Ellison.  There is no interest in the WY Convictions Data.
export Mac_DL_ConvPoints_Spray(source_IP,source_path,file_name,state,file_type,process_dte,filedate,group_name,clear_Super='N') := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(Layout_In_File)
#uniquename(Layout_Out_File)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(raw_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)
#uniquename(Create_Superfiles)
#uniquename(CreateSuperFiles)
#uniquename(recSize)
#uniquename(st)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)
#uniquename(subname)
#uniquename(ftype)
#uniquename(stype)
#uniquename(As_DL_CP_mapper)
#uniquename(Create_As_DL_CP_Superfiles)
#uniquename(scrub_files)

#workunit('name', state + ' DrvLic Conviction/Points Spray');

%sourceCsvSeparater% := '\\|';
%sourceCsvTeminater% := '\\n,\\r\\n';
%sourceCsvQuote% := '\"';

%st%    := stringlib.StringToUpperCase(trim(state,left,right));

// Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
//#if (%st% in ['OH','MO','WY'])
#if (%st% in ['OH','MN','TN'])

	%ftype% := stringlib.StringToUpperCase(trim(file_type,left,right));

	%subname% := if (length(trim(file_type,left,right)) > 0, 
					 %st% + '_' + %ftype%,
					 %st%
					);
		

/* Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
	#if (%st% = 'MO' and %ftype% = 'ACTION') 
	  %stype% := 'MO_ACTION';
	#end
	#if (%st% = 'MO' and %ftype% = 'POINTS')
	  %stype% := 'MO_POINTS';  
	#end
	#if (%st% = 'MO' and %ftype% = 'DPRDPS')
	  %stype% := 'MO_DPRDPS';   
	#end
*/
	#if (%st% = 'OH')
	  %stype% := 'OH';  //OH Convictions data
	#end
	#if (%st% = 'MN')
	  %stype% := 'MN';  //MN Convictions data
	#end
  #if (%st% = 'TN' and %ftype% = ' ')
	  %stype% := 'TN';  //TN Convictions data
	#end
	#if (%st% = 'TN' and %ftype% = 'WDL')
	  %stype% := 'TN_WDL';  //TN Withdrawals data
	#end
 /*	
	#if (%st% = 'WY')
	  %stype% := 'WY';      //WY Convictions data
	#end
  Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
	#if (%stype% = 'MO_ACTION')
	  %recSize% := 328;  //ebcdic
	#end
	#if (%stype% = 'MO_POINTS')
	  %recSize% := 217;  //ebcdic
	#end
	#if (%stype% = 'MO_DPRDPS')
	  %recSize% := 74;   //ebcdic
	#end
*/
	#if (%stype% = 'OH')
	  %recSize% := 602;  //OH Convictions data
	#end
	#if (%stype% = 'MN')
	  %recSize% := 245;  //MN Convictions data
	#end
  #if (%stype% = 'TN')
	  %recSize% := 200;  //TN Convictions data
	#end
	#if (%stype% = 'TN_WDL') 
	  %recSize% := 200;  //TN Withdrawals data
	#end
	/*
	#if (%stype% = 'WY')
	  %recSize% := 172;  //WY Convictions data
	#end
  */
	%doCleanup% := sequential(FileServices.RemoveSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old',
															DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate),
															FileServices.RemoveSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Delete',
															DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate),
															FileServices.RemoveSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile',
															DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate),
															FileServices.DeleteLogicalFile(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate));

	%deleteIfExist% := if(FileServices.FileExists(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate),
						  %doCleanup%);
												
/* Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
	%spray_main% := if (%stype% in ['MO_ACTION', 'MO_POINTS', 'MO_DPRDPS', 'OH','WY'],
*/
	%spray_main% := if (%stype% in ['OH','MN','TN','TN_WDL'],
						FileServices.SprayFixed(Source_IP
												,source_path + file_name
												,%recSize%
												,group_name
												,DriversV2.Constants.cluster +'in::dl2::'+%subname%+'_cp_update::raw_'+filedate
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
												   ,DriversV2.Constants.cluster +'in::dl2::'+%subname%+'_cp_update::raw_'+filedate
												   ,-1
												   ,
												   ,
												   ,true
												   ,true));

	%Layout_In_File% := record
	/* Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)
		#if(%stype%  = 'MO_ACTION')
			DriversV2.Layouts_DL_MO_In.Layout_MO_Actions;
		#end
		#if(%stype% = 'MO_POINTS')
			DriversV2.Layouts_DL_MO_In.Layout_MO_Points;  // Fixed length vendor raw data structure
		#end
		#if(%stype%  = 'MO_DPRDPS')
			DriversV2.Layouts_DL_MO_In.Layout_MO_DPRDPS;  // Fixed length vendor raw data structure
		#end
	*/
		#if(%stype% = 'OH')
			DriversV2.Layouts_DL_OH_In.Layout_OH_CP;  // Fixed length vendor raw data structure
		#end
		#if(%stype% = 'MN')
			DriversV2.Layouts_DL_MN_In.Layout_MN_Convic;  // Fixed length vendor raw data structure
		#end
    #if(%stype% = 'TN')
			DriversV2.Layouts_DL_TN_In.Layout_TN_CP;      // Fixed length vendor raw data structure
		#end
		#if(%stype% = 'TN_WDL')
			DriversV2.Layouts_DL_TN_In.Layout_TN_WDL;     // Fixed length vendor raw data structure
		#end
		/*
		#if(%stype% = 'WY')
			DriversV2.Layouts_DL_WY_In.Layout_WY_CP;  // Fixed length vendor raw data structure
		#end
    */
	end;

	%Layout_Out_File% := record
	/* Removed "MO" data, to be compliant with the new state law(bug#37550; 20090309)	
		#if(%stype% = 'MO_ACTION')
			DriversV2.Layouts_DL_MO_In.Layout_MO_Actions_PDate;
		#end
		#if(%stype%  = 'MO_POINTS')
			DriversV2.Layouts_DL_MO_In.Layout_MO_Points_PDate;  // Fixed length vendor raw data structure
		#end
		#if(%stype%  = 'MO_DPRDPS')
			DriversV2.Layouts_DL_MO_In.Layout_MO_DPRDPS_PDate;  // Fixed length vendor raw data structure
		#end
	*/
		#if(%stype% = 'OH')
			DriversV2.Layouts_DL_OH_In.Layout_OH_CP_PDate;  // Fixed length vendor raw data structure
		#end	
		#if(%stype% = 'MN')
			DriversV2.Layouts_DL_MN_In.Layout_MN_conv_ProcessDte;  // Fixed length vendor raw data structure
		#end
    #if(%stype% = 'TN')
			DriversV2.Layouts_DL_TN_In.Layout_TN_CP_With_ProcessDte;     // Fixed length vendor raw data structure
		#end
		#if(%stype% = 'TN_WDL')
			DriversV2.Layouts_DL_TN_In.Layout_TN_WDL_With_ProcessDte;     // Fixed length vendor raw data structure
		#end
		/*
		#if(%stype% = 'WY')
			DriversV2.Layouts_DL_WY_In.Layout_WY_CP_With_ProcessDte;  // Fixed length vendor raw data structure
		#end
    */
	end;

	// Adding process date to layout.
	%Layout_Out_File% %trfProject%(%Layout_In_File% l) := transform
	   self.process_date := process_dte;												
	   self              := l;
	end;

	%outfile% := project(dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_CP_update::raw_'+ filedate,%Layout_In_File%,thor),%trfProject%(left));

	%ds% := output(%outfile%,,DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_CP_update::'+ filedate,overwrite);

	%As_DL_CP_mapper% := case(%stype%,
														//***  MO MEDCERT conviction as_mapper is done in Mac_DL_Update_Spray itself along with the regular DL mapper, because both DL's and conviction fields are provided in the same vendor file.
														// 'MO_MEDCERT' => DriversV2.Mapping_DL_MO_New_As_ConvPoints(filedate).Build_DL_MO_Convpoints,
														//***  MN conviction date is not being updated anymore.
														// 'MN' => DriversV2.Mapping_DL_MN_New_As_ConvPoints(filedate, dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_CP_update::'+filedate+'::cleaned',drivers.Layout_CT_Full,thor)).Build_DL_MN_New_Convpoints,
														 'OH' 		=> DriversV2.Mapping_DL_OH_As_ConvPoints(filedate, dataset(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_CP_update::'+filedate,DriversV2.Layouts_DL_OH_In.Layout_OH_CP_Pdate,thor)).Build_DL_OH_Convpoints,
														 'TN' 		=> sequential(DriversV2.Cleaned_DL_TN_ConvPoints(filedate),
																										DriversV2.Mapping_DL_TN_As_ConvPoints(filedate).Build_DL_TN_Conviction
																										),
														 'TN_WDL' => sequential(DriversV2.Cleaned_DL_TN_Withdrawals(filedate),
																										DriversV2.Mapping_DL_TN_As_ConvPoints(filedate).Build_DL_TN_Suspension
																										)
														);
														
  %scrub_files% := case(%stype%
												,'TN'        => DriversV2.Scrub_DL(filedate).TN_CONV
	                      ,'TN_WDL'    => DriversV2.Scrub_DL(filedate).TN_WDL
                        );
						
	%Create_Superfiles% := sequential(FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile',false),
									   FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Delete',false),
									   FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old',false)																	
									  );
	%CreateSuperFiles% := if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile'),%Create_Superfiles%); 

	%Create_As_DL_CP_Superfiles% := sequential( if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Convictions')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Convictions')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Convictions')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Convictions')),
																																														
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Convictions_restricted'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Convictions_restricted')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Convictions_restricted'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Convictions_restricted')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Convictions_restricted'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Convictions_restricted')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Convictions_restricted'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Convictions_restricted')),
																							
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Suspension'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Suspension')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Suspension'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Suspension')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Suspension'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Suspension')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Suspension'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Suspension')),
																							
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_DR_Info'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_DR_Info')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_DR_Info'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_DR_Info')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_DR_Info'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_DR_Info')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_DR_Info'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_DR_Info')),
																							
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Accident'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Accident')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Accident'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Accident')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Accident'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Accident')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Accident'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Accident')),
																							
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Insurance'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Insurance')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Insurance'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Insurance')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Insurance'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Insurance')),
																							if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Insurance'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Insurance'))
																						);
																						
																						

	%super_main% := sequential(FileServices.StartSuperFileTransaction(),
					//FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Delete',
					//						  DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old',, true),
					FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old'),
					FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old', 
											  DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile',, true),
					//FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile'),
					FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile', 
											  DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate), 
					FileServices.FinishSuperFileTransaction()/*,
					FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Delete',true)*/);

	%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
					 FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Delete',
					  						   DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old',, true),
					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old'),
					 FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Old', 
											   DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile',, true),
					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile'),
					 FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Superfile', 
											   DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_cp_update::'+filedate), 
					 FileServices.FinishSuperFileTransaction(),
					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::'+%stype%+'_CP_updates::Delete',true));

	%raw_delete% := if (FileServices.FileExists(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_CP_update::raw_'+ filedate), 
						FileServices.DeleteLogicalFile(DriversV2.Constants.cluster + 'in::dl2::'+%subname%+'_CP_update::raw_'+ filedate));


	%do_super%  := sequential(output('do super 1...'),%CreateSuperFiles%, %deleteIfExist%, %spray_main%, %ds%, %Create_As_DL_CP_Superfiles%, %As_DL_CP_mapper%, %super_main%, %scrub_files%, %raw_delete%);

	%do_super1% := sequential(output('do super 2...'),%CreateSuperFiles%, %deleteIfExist%, %spray_main%, %ds%, %Create_As_DL_CP_Superfiles%, %As_DL_CP_mapper%, %super_main1%, %scrub_files%, %raw_delete%);

	%out_super% := if(clear_Super = 'N', sequential(%do_super%), sequential(%do_super1%));

	sequential(%out_super%
	           ,NOTIFY((%stype% + ' SPRAY COMPLETE FOR ' + filedate),'*'));
 #else
	ERROR('Job failed - STATE code passed is not a valid Conviction Points state code. ' +
	      'Please double check the state code passed - if you are sure, than need to modify ' +
		  'the code to accommodate the new state before re-running this spray macro.');
#end

endmacro;