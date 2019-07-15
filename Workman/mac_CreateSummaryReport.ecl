import std,_control,tools,WorkMan;
/*
JIRA HPCC TRACKER ISSUE #9532 -- DATASET(WORKUNIT()) with a variable workunit causes problems 
  says fixed in 4.2.  will allow removal of pNumRecords parameter, and won't have to generate all of the code for the child datasets

jobregex := '((BIPV2_Proxid(_dev)? 20130521 iter 3[0-5])|(BIPV2_Proxid Specificites [+] kick off iterations 30.34)|(BIPV2_Proxid_dev Specificites [+] kick off iterations 35.35))';
dwks20130521 := WorkMan.mac_CreateSummaryReport ( 'W20130525-100331' ,'W20130614-232519','lbentley_prod','',['BIPV2*',jobregex],['MatchesPerformed','PreClusterCount','PostClusterCount']
,['ConfidenceLevels'  ,'{UNSIGNED2 Conf,UNSIGNED MatchesFound}'
 ,'ValidityStatistics','{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}'
 ,'RuleEfficacy'      ,'{UNSIGNED2 RuleNumber;STRING Rule;UNSIGNED MatchesFound ;}'
 ]
,['AllSamplesCands'],parchived := true,pOutputEcl := false); //everything for 20130521 run
output(dwks20130521);

*/
EXPORT mac_CreateSummaryReport(
   pversion                                     // version date of build looking to summarize
  ,pLowWuid                  = ''      
  ,pHighWuid                 = ''               
  ,pOwner                    = ''
  ,pCluster                  = ''
  ,pJobname                  = '[\'\',\'\']'    //may contain wildcards(*?).  First item in set is used in the workunit query(STD.System.Workunit.WorkunitList) so can only contain wildcards.  Second can be full regular expression.
  ,pSetScalarResults         = '[]'             //get these results. i.e ['MatchesPerformed','PreClusterCount']
  ,pSetDatasetResults        = '[]'             //get these Dataset results. in pairs, result name,layout.  i.e ['ConfidenceLevels','{UNSIGNED2 Conf;UNSIGNED MatchesFound;}','RuleEfficacy','{UNSIGNED2 RuleNumber;STRING Rule;UNSIGNED MatchesFound;}']
  ,pSetDatasetCounts         = '[]'             //get the count of records in these dataset results. i.e  ['ConfidenceLevels']
  ,pSetExtraFields           = '[]'             //Extra fields you want added to layout(all string fields)
  ,pSetExtraFieldsassigments = '[]'             //assignment code for above extra fields to be used in transform
  ,pIsTesting                = 'true'
	,pOutputEcl					       = 'false'					// Should output the ecl as a string(for testing) or actually run the ecl
  ,pNumRecords               = '150'            //default is 100 which should cover most all workunits.  if yours is less, it will work.
  ,pFilesReadRegexFilter     = '\'\''           //filter files read by the workunit using this filter
  ,pFilesWrittenRegexFilter  = '\'\''           //filter files written by the workunit using this filter
  ,pOutputFilename           = ''               //filename to output results to.  If blank, just returns the dataset.  if not populated, when restoring, it will just return the apply,not the dataset
  ,pOutputSuperfile          = ''               //filename to add the above file to.
  ,pOverwrite                = 'false'          //overwrite file?
  
  ,pState                    = ''
  ,pPriority                 = ''
  ,pFileread                 = ''               //may contain wildcards(*?)
  ,pFilewritten              = ''               //may contain wildcards(*?)
  ,pRoxiecluster             = ''
  ,pEclcontains              = ''               //may contain wildcards(*?) 
  ,pOnline                   = 'true'
  ,pArchived                 = 'false'          //also pick up archived workunits?
  ,pShouldRestore            = 'false'          //true = will restore the workunits found.
  ,pEsp                      = 'WorkMan._Config.LocalEsp'
) :=
functionmacro
import std,_control,tools,WorkMan;

  #UNIQUENAME(ECL)
  #UNIQUENAME(TEMPECL)
  #UNIQUENAME(ECLSTRING)
  #UNIQUENAME(CNTR)
  #UNIQUENAME(NESTEDCNTR)
  #UNIQUENAME(LAYOUTTOOLS)
  #UNIQUENAME(SCALARFIELD)
  #UNIQUENAME(SCALARRESULT)
  #UNIQUENAME(SCALARINDEXFIELD)
  #UNIQUENAME(SCALARFIELDS)
  #UNIQUENAME(SCALARSETFIELDS)
  #UNIQUENAME(SCALARTRANSFORM)
  #UNIQUENAME(SCALARFIELDS)
  #UNIQUENAME(SCALARTRANSFORM)
  #UNIQUENAME(DSCOUNTSFIELDS    )
  #UNIQUENAME(DSCOUNTSTRANSFORM )
  #UNIQUENAME(DATASETFIELDS    )
  #UNIQUENAME(DATASETTRANSFORM )
  #UNIQUENAME(GETDSRESULT )
  #UNIQUENAME(EXTRAFIELDS    )
  #UNIQUENAME(EXTRATRANSFORM    )
  #UNIQUENAME(FILESREADREGEXFILTER       )
  #UNIQUENAME(FILESWRITTENREGEXFILTER    )
  #UNIQUENAME(TOTALTHORTIMEVALUES)
  #UNIQUENAME(DESCRIPTIONVALUES)
  #UNIQUENAME(WUIDFILES)
  #UNIQUENAME(RECORDS)
  #UNIQUENAME(RECORDTEMPLATE)
  #UNIQUENAME(SCALARTEMP)
  
//  { wks_filt[1].wuid 	,wks_filt[1].owner ,wks_filt[1].cluster ,wks_filt[1].job 	,wks_filt[1].state 	,wks_filt[1].priority ,wks_filt[1].online ,wks_filt[1].protected 
  // get workunits
  #SET(ECL  ,'dgetwuidlist := global(WorkMan.get_WorkunitList ( \n')  //remove nothor as per Heather
  #APPEND(ECL  ,' ' + #TEXT(pLowWuid) + '   \n')     
  #APPEND(ECL  ,',' + #TEXT(pHighWuid) + '  \n')              
  #APPEND(ECL  ,',' + #TEXT(pOwner) + '     \n')  
  #APPEND(ECL  ,',' + #TEXT(pCluster) + '   \n')  
  #APPEND(ECL  ,',' + #TEXT(pJobname[1]) + '\n')       
  #APPEND(ECL  ,',' + #TEXT(pState ) + '    \n')  
  #APPEND(ECL  ,',' + #TEXT(pPriority ) + ' \n')  
  #APPEND(ECL  ,',' + #TEXT(pFileread ) + ' \n')    
  #APPEND(ECL  ,',' + #TEXT(pFilewritten ) + ' \n') 
  #APPEND(ECL  ,',' + #TEXT(pRoxiecluster ) + '\n')
  #APPEND(ECL  ,',' + #TEXT(pEclcontains  ) + '\n')  
  #APPEND(ECL  ,',' + #TEXT(pOnline      ) + ' \n')
  #APPEND(ECL  ,',' + #TEXT(pArchived    ) + ' \n') 
  #APPEND(ECL  ,',' + #TEXT(pEsp         ) + ' \n') 
  #APPEND(ECL  ,'),few);\n\n')
  
  #APPEND(ECL  ,'jobname_filter					:= if(' + #TEXT(pJobname[2]) + '			!= \'\', regexfind(' + #TEXT(pJobname[2]) + '	  , dgetwuidlist.Job	, nocase), true);\n')
	
	#APPEND(ECL  ,'wks_filt							:= sort(dgetwuidlist(//owner_filter	\n')
	#APPEND(ECL  ,'											jobname_filter\n')
	#APPEND(ECL  ,'											),wuid);\n')

	#APPEND(ECL  ,'restorewuids := apply(wks_filt(online = false),output(WorkMan.Restore_Workunit(wuid,' + #TEXT(pEsp) + '),named(\'RestoreWuids\'),EXTEND));\n')
  #SET(LAYOUTTOOLS ,tools.mac_FilterLayout(STD.System.Workunit.WorkunitRecord,true,'^(?!(roxiecluster|created|modified|priorityvalue).*).*$',true))

  //need to loop to generate code to get the extra fields
  #SET(CNTR ,1)
  #SET(EXTRAFIELDS     ,'')
  #SET(EXTRATRANSFORM  ,'')
  
  #LOOP
    #IF(%CNTR% > count(pSetExtraFields))
      #BREAK
    #END
    
    //add this field to layout
    #APPEND(EXTRAFIELDS     ,',string ' + pSetExtraFields[%CNTR%])

    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > pNumRecords)
        #BREAK
      #END

      #APPEND(EXTRATRANSFORM  ,pSetExtraFields[%CNTR%] + %'NESTEDCNTR'% + ' := ' + regexreplace('@dataset@',pSetExtraFieldsassigments[%CNTR%],'wks_filt[' + %'NESTEDCNTR'% + ' ]',nocase) + ';\n')
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END

    #SET(CNTR ,%CNTR% + 1)    
  #END
  #APPEND(EXTRAFIELDS  ,'')
///////////////
  ////////////////////////////////
  //need to loop to generate code to get the scalar results
  //can also be indexed dataset results, ['MatchesPerformed','PreClusterCount[1].Proxid_Count','{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}']
  //but the next element in the set must be the dataset results' layout.  The name of the field in the summary dataset will be that of the dataset name by default
  //u can change that by prefacing the name u want, i.e. ['MtchPerformed MatchesPerformed','ProxidCount PreClusterCount[1].Proxid_Count','{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}']
  ////////////////////////////////
  #SET(CNTR ,1)
  #SET(SCALARFIELDS     ,'')
  #SET(SCALARTRANSFORM  ,'')
  #SET(SCALARSETFIELDS  ,'[')
  
  #LOOP
    #IF(%CNTR% > count(pSetScalarResults))
      #BREAK
    #END
    
    #SET(SCALARTEMP   ,WorkMan.mac_parsefieldname(pSetScalarResults[%CNTR%]))
    
    #SET(SCALARFIELD      ,STD.Str.Extract(%'SCALARTEMP'%,1))
    #SET(SCALARRESULT     ,STD.Str.Extract(%'SCALARTEMP'%,2))
    #SET(SCALARINDEXFIELD ,STD.Str.Extract(%'SCALARTEMP'%,3))
    #IF(%CNTR% = 1)
      #APPEND(SCALARSETFIELDS ,'\'' + %'SCALARFIELD'% + '\'')
    #ELSE
      #APPEND(SCALARSETFIELDS ,',\'' + %'SCALARFIELD'% + '\'')
    #END
    //add this field to layout
    #APPEND(SCALARFIELDS  ,',string ' + %'SCALARFIELD'%)

    #IF(trim(%'SCALARINDEXFIELD'%) != '')
      #APPEND(SCALARTRANSFORM  ,%'SCALARFIELD'% + '_lay := ' + pSetScalarResults[%CNTR% + 1] + ';\n')
    #END
    
    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > pNumRecords)
        #BREAK
      #END
      #IF(trim(%'SCALARINDEXFIELD'%) = '')
        #APPEND(SCALARTRANSFORM  ,%'SCALARFIELD'% + %'NESTEDCNTR'% + ' := global(WorkMan.get_Scalar_Result(wks_filt[' + %'NESTEDCNTR'% + ' ].wuid,\'' + %'SCALARRESULT'% + '\',' + #TEXT(pEsp) + '),few);\n')
      #ELSE
        #APPEND(SCALARTRANSFORM  ,%'SCALARFIELD'% + %'NESTEDCNTR'% + ' := global(if((unsigned)WorkMan.get_DS_Count(wks_filt[' + %'NESTEDCNTR'% + ' ].wuid,\'' + %'SCALARRESULT'% + '\',' + #TEXT(pEsp) + ') != 0,WorkMan.get_DS_Result    (wks_filt[' + %'NESTEDCNTR'% + '].wuid,\'' + %'SCALARRESULT'% + '\'  ,' + %'SCALARFIELD'% + '_lay' + ' ,' + #TEXT(pEsp) + ')  ,dataset([],' + %'SCALARFIELD'% + '_lay' + '))' + %'SCALARINDEXFIELD'% + ',few);\n')
      #END
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END

    #IF(trim(%'SCALARINDEXFIELD'%) = '')
      #SET(CNTR ,%CNTR% + 1) 
    #ELSE
      #SET(CNTR ,%CNTR% + 2) 
    #END
  #END
  #APPEND(SCALARFIELDS  ,'')
  #APPEND(SCALARSETFIELDS  ,']')
//  #SET(SCALARFIELDS  ,'\nSCALARTEMP: ' + %'SCALARTEMP'% + '\n')

///////////
  ////////////////////////////////
  //need to loop to generate code to get the Dataset count results
  ////////////////////////////////
  #SET(CNTR ,1)
  #SET(DSCOUNTSFIELDS      ,'')
  #SET(DSCOUNTSTRANSFORM   ,'' )
  
  #LOOP
    #IF(%CNTR% > count(pSetDatasetCounts))
      #BREAK
    #END
    
    //add this field to layout
    #APPEND(DSCOUNTSFIELDS  ,',string ' + pSetDatasetCounts[%CNTR%])

    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > pNumRecords)
        #BREAK
      #END
      
      #APPEND(DSCOUNTSTRANSFORM  ,pSetDatasetCounts[%CNTR%] + %'NESTEDCNTR'% + ' := global(WorkMan.get_DS_Count(wks_filt[' + %'NESTEDCNTR'% + ' ].wuid,\'' + pSetDatasetCounts[%CNTR%] + '\',' + #TEXT(pEsp) + '),few);\n')
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END


    #SET(CNTR ,%CNTR% + 1)    
  #END
  #APPEND(DSCOUNTSFIELDS  ,'')

  ////////////////////////////////
  //loop for default fields
  ////////////////////////////////
  #SET(CNTR ,1)
  #SET(TOTALTHORTIMEVALUES  ,'')
  #SET(DESCRIPTIONVALUES    ,'')
  #SET(WUIDFILES            ,'')
  #SET(FILESREADREGEXFILTER    ,#TEXT(pFilesReadRegexFilter   ))
  #SET(FILESWRITTENREGEXFILTER ,#TEXT(pFilesWrittenRegexFilter))
  
  #LOOP
    #IF(%CNTR% > pNumRecords)
      #BREAK
    #END
    #APPEND(TOTALTHORTIMEVALUES  ,'totalthortime'+ %'CNTR'% + ' := global(WorkMan.get_TotalTime    (wks_filt[' + %'CNTR'% + ' ].wuid,' + #TEXT(pEsp) + '),few);\n')
    #APPEND(DESCRIPTIONVALUES    ,'description'  + %'CNTR'% + ' := global(WorkMan.get_Description  (wks_filt[' + %'CNTR'% + ' ].wuid,' + #TEXT(pEsp) + '),few);\n')

    #APPEND(WUIDFILES  ,'filesreadraw'+ %'CNTR'% + '     := global(nothor(project((WorkMan.get_FilesRead   (trim(wks_filt[' + %'CNTR'% + ' ].wuid,all),' + #TEXT(pEsp) + ')(if(' + %'FILESREADREGEXFILTER'%    + ' != \'\' ,regexfind(' + %'FILESREADREGEXFILTER'%    + ',name,nocase)  ,true))),{string name})),few);\n')
    #APPEND(WUIDFILES  ,'fileswritten'+ %'CNTR'% + '     := global(nothor(project((WorkMan.get_FilesWritten(trim(wks_filt[' + %'CNTR'% + ' ].wuid,all),' + #TEXT(pEsp) + ')(if(' + %'FILESWRITTENREGEXFILTER'% + ' != \'\' ,regexfind(' + %'FILESWRITTENREGEXFILTER'% + ',name,nocase)  ,true))),{string name})),few);\n')
    #APPEND(WUIDFILES  ,'setfileswritten'+ %'CNTR'% + '  := set(fileswritten'+ %'CNTR'% + ',name);\n')
    #APPEND(WUIDFILES  ,'filesread'+ %'CNTR'% + '        := global(filesreadraw'+ %'CNTR'% + '(name not in setfileswritten'+ %'CNTR'% + '),few);\n')

    #SET(CNTR ,%CNTR% + 1)    
  #END

  //need to loop to generate code to get the Dataset results
  #SET(CNTR ,1)
  #SET(DATASETFIELDS      ,'')
  #SET(DATASETTRANSFORM   ,'')
  #SET(GETDSRESULT        ,'')
  
  #LOOP
    #IF(%CNTR% > count(pSetDatasetResults))
      #BREAK
    #END

    //add this field to layout
    #APPEND(DATASETFIELDS  ,',dataset( ' + pSetDatasetResults[%CNTR% + 1] + ') ' + pSetDatasetResults[%CNTR%])
    
    #APPEND(DATASETTRANSFORM  ,'  self.' + pSetDatasetResults[%CNTR%] + ' := choose(counter\n')
    #APPEND(GETDSRESULT  ,pSetDatasetResults[%CNTR%] + '_lay := ' + pSetDatasetResults[%CNTR% + 1] + ';\n')
    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > pNumRecords)
        #BREAK
      #END
      
      #APPEND(GETDSRESULT  , pSetDatasetResults[%CNTR%] + %'NESTEDCNTR'% + '   := global(if((unsigned)WorkMan.get_DS_Count(wks_filt[' + %'NESTEDCNTR'% + ' ].wuid,\'' + pSetDatasetResults[%CNTR%] + '\',' + #TEXT(pEsp) + ') != 0,WorkMan.get_DS_Result    (wks_filt[' + %'NESTEDCNTR'% + '].wuid,\'' + pSetDatasetResults[%CNTR%] + '\'  ,' + pSetDatasetResults[%CNTR%] + '_lay' + ' ,' + #TEXT(pEsp) + ')  ,dataset([],' + pSetDatasetResults[%CNTR%] + '_lay' + ')),few);\n')
      #APPEND(DATASETTRANSFORM  ,'    ,' + pSetDatasetResults[%CNTR%] + %'NESTEDCNTR'% + '\n')

      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END

    #SET(CNTR ,%CNTR% + 2)    
  #APPEND(DATASETTRANSFORM  ,'  );\n')
  #END
  #APPEND(DATASETFIELDS  ,'')

  #SET(LAYOUTTOOLS  ,%'LAYOUTTOOLS'%[1..(length(%'LAYOUTTOOLS'%) - 1)] + ',string TotalThorTime,string Description,string version' + %'EXTRAFIELDS'% + %'SCALARFIELDS'% + %'DSCOUNTSFIELDS'% + %'DATASETFIELDS'% + ',dataset({string name}) FilesRead,dataset({string name}) FilesWritten}\n')
  #APPEND(ECL  ,'layouttools := ' + %'LAYOUTTOOLS'% + ';\n\n' )

  #APPEND(ECL ,%'GETDSRESULT'% + '\n')
  #APPEND(ECL ,%'TOTALTHORTIMEVALUES'% + %'DESCRIPTIONVALUES'% + %'SCALARTRANSFORM'% + %'DSCOUNTSTRANSFORM'% + %'WUIDFILES'% + %'EXTRATRANSFORM'%)

  
  #APPEND(ECL  ,'dproj := dataset([\n')
  
  //need to loop to generate code for the master dataset definition
  #SET(CNTR             ,1)
  #SET(RECORDS          ,'')
  #SET(RECORDTEMPLATE   ,'')

  #LOOP
    #IF(%CNTR% > pNumRecords)
      #BREAK
    #END
    
    #IF(%CNTR% != 1)
      #APPEND(RECORDS ,',')
    #ELSE
      #APPEND(RECORDS ,' ')
    #END
    
    #APPEND(RECORDS ,'{ wks_filt[' + %'CNTR'% + '].wuid 	,wks_filt[' + %'CNTR'% + '].owner ,wks_filt[' + %'CNTR'% + '].cluster ,wks_filt[' + %'CNTR'% + '].job 	,wks_filt[' + %'CNTR'% + '].state 	,wks_filt[' + %'CNTR'% + '].priority ,wks_filt[' + %'CNTR'% + '].online ,wks_filt[' + %'CNTR'% + '].protected')

    #APPEND(RECORDS  ,',totalthortime'+ %'CNTR'%)
    #APPEND(RECORDS  ,',description'  + %'CNTR'%)
    #APPEND(RECORDS ,',' + #TEXT(pversion))
    
    //add extra fields
    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > count(pSetExtraFields))
        #BREAK
      #END

      #APPEND(RECORDS  ,',' + pSetExtraFields[%NESTEDCNTR%] + %'CNTR'%)
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END

    //add scalar results
    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > count(%SCALARSETFIELDS%))
        #BREAK
      #END

      #APPEND(RECORDS  ,',' + %SCALARSETFIELDS%[%NESTEDCNTR%] + %'CNTR'%)
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END
    
    //add dataset count results
    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > count(pSetDatasetCounts))
        #BREAK
      #END

      #APPEND(RECORDS  ,',' + pSetDatasetCounts[%NESTEDCNTR%] + %'CNTR'%)
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 1)    
    #END
    
    //add dataset results
    #SET(NESTEDCNTR,1)
    #LOOP
      #IF(%NESTEDCNTR% > count(pSetDatasetResults))
        #BREAK
      #END

      #APPEND(RECORDS  ,',' + pSetDatasetResults[%NESTEDCNTR%] + %'CNTR'%)
      
      #SET(NESTEDCNTR ,%NESTEDCNTR% + 2)    
    #END

    #APPEND(RECORDS  ,',filesread'    + %'CNTR'%)
    #APPEND(RECORDS  ,',fileswritten' + %'CNTR'%)

    #APPEND(RECORDS ,'}\n')
    #SET(CNTR ,%CNTR% + 1)    
  #END

  #APPEND(ECL  ,%'RECORDS'%)
  #APPEND(ECL  ,'],layouttools)(wuid != \'\');\n')
  #SET(TEMPECL  ,'')
  
  #IF(#TEXT(pOutputFilename) != '')
    #APPEND(ECL  ,'writefile := tools.macf_writefile(' + trim(#TEXT(pOutputFilename),all) + ' ,dproj ,pOverwrite := ' + #TEXT(pOverwrite) + ');\n')
    #SET(TEMPECL  ,'writefile')
    #IF(pOutputSuperfile  != '')
      #APPEND(ECL  ,'addtosuper := std.file.addsuperfile(' + trim(#TEXT(pOutputSuperfile),all) + ' ,' + trim(#TEXT(pOutputFilename),all) +  ');\n')
      #APPEND(TEMPECL  ,',addtosuper')
    #END
    #APPEND(ECL ,'dothis := sequential(')
    #IF(pShouldRestore = true)
      #APPEND(ECL ,'restorewuids,' + %'TEMPECL'% + ');\n')
    #ELSE
      #APPEND(ECL ,%'TEMPECL'% + ');\n')
    #END
  #ELSE
    #IF(pShouldRestore = true)
      #APPEND(ECL ,'dothis := sequential(restorewuids);\n')
    #ELSE
      #APPEND(ECL ,'dothis := dproj;\n')
    #END
  #END
  
  //so add return dproj to end of code if running it.  otherwise, don't
  #SET    (ECLSTRING  ,%'ECL'%            )
  #APPEND (ECL        ,'return dothis;\n' )
  
	#if(pOutputEcl = true)
		return %'ECLSTRING'%;
	#ELSE
		%ECL%
	#END
    
endmacro;