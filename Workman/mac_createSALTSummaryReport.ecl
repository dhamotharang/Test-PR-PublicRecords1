EXPORT mac_createSALTSummaryReport(
   pversion                                     // version date of build looking to summarize
  ,pLowWuid                  = ''      
  ,pHighWuid                 = ''               
  ,pOutputFilename           = ''               //filename to output results to.  If blank, just returns the dataset.  if not populated, when restoring, it will just return the apply,not the dataset
  ,pOutputSuperfile          = ''               //filename to add the above file to.
  ,pFilesReadRegexFilter     = '\'\''           //filter files read by the workunit using this filter
  ,pFilesWrittenRegexFilter  = '\'\''           //filter files written by the workunit using this filter
  ,pLinkingID                 = '\'\''           //For Cleaves, i.e. 'Proxid' would equal 'ProxidsCreatedByCleave'
  ,pOwner                    = ''
  ,pCluster                  = ''
  ,pJobname                  = '[\'\',\'\']'    //may contain wildcards(*?).  First item in set is used in the workunit query(STD.System.Workunit.WorkunitList) so can only contain wildcards.  Second can be full regular expression.
  ,pIsTesting                = 'true'           //if true, just output the results of the research, don't do the restoring yet
	,pOutputEcl					       = 'false'					// Should output the ecl as a string(for testing) or actually run the ecl
  ,pNumRecords               = '150'            //default is 100 which should cover most all workunits.  if yours is less, it will work.
  ,pOverwrite                = 'false'          //overwrite file?
  ,pOnline                   = 'true'
  ,pArchived                 = 'false'          //also pick up archived workunits?
  ,pShouldRestore            = 'false'          //true = will restore the workunits found.
  ,pSALT28                   = 'false'           //valididity stats are different layout
) :=
functionmacro

  #UNIQUENAME(cleave                )
  #UNIQUENAME(ValidityStatsLayout   )
  #UNIQUENAME(ClusterCountsScalar   )
  #UNIQUENAME(ClusterCountsDataset  )
  
  #IF(pSALT28 = true)
    #SET(ValidityStatsLayout    ,'{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}')
    #SET(ClusterCountsScalar   ,',\'PreClusterCount[1].\'' + trim(pLinkingID,all) + '_Count\'   ,\'{UNSIGNED rcid_Count,UNSIGNED \'' + trim(pLinkingID,all) + '_Count}\',\'PostClusterCount[1].\'' + trim(pLinkingID,all) + '_Count\'  ,\'{UNSIGNED rcid_Count,UNSIGNED \'' + trim(pLinkingID,all) + '_Count}\'')
  #ELSE
    #SET(ValidityStatsLayout    ,'{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}')
    #SET(ClusterCountsScalar    ,',\'PreClusterCount\',\'PostClusterCount\'')
  #END

//    ,['MatchesPerformed','PreClusterCount','PostClusterCount','BasicMatchesPerformed','SlicesPerformed']

  #IF(pLinkingID = '')
    #SET(cleave ,'[\'MatchesPerformed\'' + %'ClusterCountsScalar'% + ',\'BasicMatchesPerformed\',\'SlicesPerformed\']')
  #ELSE
    #SET(cleave ,'[\'MatchesPerformed\'' + %'ClusterCountsScalar'% + ',\'BasicMatchesPerformed\',\'SlicesPerformed\',\'' + trim(pLinkingID,all) + 'sCreatedByCleave\']')
  #END

  return  WorkMan.mac_CreateSummaryReport ( 
     pversion
    ,pLowWuid 
    ,pHighWuid
    ,pOwner
    ,''
    ,pJobname
    ,%cleave%
    ,[
       'ConfidenceLevels'  ,'{UNSIGNED2 Conf,UNSIGNED MatchesFound}'
      ,'ValidityStatistics',%'ValidityStatsLayout'%
      ,'RuleEfficacy'      ,'{UNSIGNED2 RuleNumber;STRING Rule;UNSIGNED MatchesFound ;}'
//      %ClusterCountsDataset%
     ]
    ,['AllSamplesCands']
    ,['Iteration']
    ,['regexfind(\'iter ([[:digit:]]+)\',@dataset@.job,1,nocase)']
    ,pIsTesting
    ,pOutputEcl
    ,pNumRecords
    ,pFilesReadRegexFilter   
    ,pFilesWrittenRegexFilter
    ,pOutputFilename
    ,pOutputSuperfile
    ,pOverwrite
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,parchived                 
    ,pShouldRestore            
  ); 
/*  
  #IF(pSALT28 = true)
    return project(dsummreport  ,transform(recordof(left) -PreClusterCount - PostClusterCount - ,));
  #ELSE
    return dsummreport;
  #END
  
*/
endmacro;