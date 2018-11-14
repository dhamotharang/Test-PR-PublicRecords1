import std,_control,tools;
/*
jobregex := '((BIPV2_Proxid(_dev)? 20130521 iter 3[0-5])|(BIPV2_Proxid Specificites [+] kick off iterations 30.34)|(BIPV2_Proxid_dev Specificites [+] kick off iterations 35.35))';
dwks20130521 := WorkMan.mac_CreateSummaryReport ( 'W20130525-100331' ,'W20130614-232519',pOwner := 'lbentley_prod' , pcluster := '',pjobname := ['BIPV2*',jobregex] , parchived := true); //everything for 20130521 run
output(dwks20130521,all);
*/
EXPORT CreateSummaryReport(
   string                    pLowWuid                  = ''      
  ,string                    pHighWuid                 = ''               
  ,string                    pOwner                    = ''
  ,string                    pCluster                  = ''
  ,set of string             pJobname                  = ['','']     //may contain wildcards(*?)
  ,string                    pState                    = ''
  ,string                    pPriority                 = ''
  ,string                    pFileread                 = ''     //may contain wildcards(*?)
  ,string                    pFilewritten              = ''     //may contain wildcards(*?)
  ,string                    pRoxiecluster             = ''
  ,string                    pEclcontains              = ''     //may contain wildcards(*?) 
  ,boolean                   pOnline                   = true
  ,boolean                   pArchived                 = false
  ,boolean                   pShouldRestore            = false
  ,boolean                   pIsTesting                = true
  ,string                    pfilename                 = ''
) :=
function

  // get workunits
  dgetwuidlist := STD.System.Workunit.WorkunitList ( 
   pLowWuid        
  ,pHighWuid                
  ,pOwner       
  ,pCluster     
  ,pJobname[1]       
  ,pState       
  ,pPriority    
  ,pFileread      
  ,pFilewritten   
  ,pRoxiecluster
  ,pEclcontains    
  ,pOnline      
  ,pArchived    
  ) : global;

	jobname_filter					:= if(pJobname[2]			!= '', regexfind(pJobname[2]	  , dgetwuidlist.Job	, nocase), true);
	
	wks_filt							:= dgetwuidlist(//owner_filter	
																			jobname_filter
																			);
  
//  restorewuids := apply(wks_filt(online = false),output(WorkMan.Restore_Workunit(wuid),named('RestoreWuids'),EXTEND));
  
  // retrieve important stuff from them
  tools.mac_LayoutTools(STD.System.Workunit.WorkunitRecord,layouttools,false,false,'^(?!(roxiecluster|created|modified).*).*$',true);

  r := RECORD
    UNSIGNED2 Conf;
    UNSIGNED MatchesFound;
  END;

  vs := {INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0};

  re := RECORD
    UNSIGNED2 RuleNumber;
    STRING Rule;
    UNSIGNED MatchesFound ;
  END;
  
  //add workunit description
  slimrec := {layouttools.layout_record,string description,string TotalThorTime,string PreClusterCount,string PostClusterCount,string MatchesPerformed,string TotalSamples,dataset(r) ConfidenceLevels,dataset(vs) ValidityStatistics,dataset(re) RuleEfficacy};
  dproj := project(wks_filt,transform(slimrec
    ,self                     := left;
    ,self.totalthortime       := WorkMan.get_WUInfo(left.wuid).totalthortime;
    ,self.description         := WorkMan.get_WUInfo(left.wuid).Description;
    ,self.TotalSamples        := WorkMan.get_DS_Count     (left.wuid,'AllSamplesCands' );
    ,self.MatchesPerformed    := WorkMan.get_Scalar_Result(left.wuid,'MatchesPerformed');
    ,self.PreClusterCount     := WorkMan.get_Scalar_Result(left.wuid,'PreClusterCount' );
    ,self.PostClusterCount    := WorkMan.get_Scalar_Result(left.wuid,'PostClusterCount');

//    ,self.ConfidenceLevels    := WorkMan.get_DS_Result    (left.wuid,'ConfidenceLevels'  ,r );
//    ,self.ValidityStatistics  := WorkMan.get_DS_Result    (left.wuid,'ValidityStatistics',vs);
//    ,self.RuleEfficacy        := WorkMan.get_DS_Result    (left.wuid,'RuleEfficacy'      ,re);
  ,self := [];
));
   
  dme := sort(dproj,wuid);
  
//  writefile := tools.macf_writefile(pfilename,dsort);

//  dme := dataset(pfilename,slimrec,flat);
  //8-9, 11-13, 5, 19
 ConfidenceLevels1    := if((unsigned)dme[1 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[1 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels2    := if((unsigned)dme[2 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[2 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels3    := if((unsigned)dme[3 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[3 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels4    := if((unsigned)dme[4 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[4 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels5    := if((unsigned)dme[5 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[5 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels6    := if((unsigned)dme[6 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[6 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels7    := if((unsigned)dme[7 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[7 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels8    := if((unsigned)dme[8 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[8 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels9    := if((unsigned)dme[9 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[9 ].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels10   := if((unsigned)dme[10].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[10].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels11   := if((unsigned)dme[11].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[11].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels12   := if((unsigned)dme[12].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[12].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels13   := if((unsigned)dme[13].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[13].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels14   := if((unsigned)dme[14].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[14].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels15   := if((unsigned)dme[15].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[15].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels16   := if((unsigned)dme[16].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[16].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels17   := if((unsigned)dme[17].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[17].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels18   := if((unsigned)dme[18].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[18].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels19   := if((unsigned)dme[19].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[19].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));
 ConfidenceLevels20   := if((unsigned)dme[20].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[20].wuid,'ConfidenceLevels'  ,r )  ,dataset([],r));

 ValidityStatistics1    := if((unsigned)dme[1 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[1 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics2    := if((unsigned)dme[2 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[2 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics3    := if((unsigned)dme[3 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[3 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics4    := if((unsigned)dme[4 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[4 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics5    := if((unsigned)dme[5 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[5 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics6    := if((unsigned)dme[6 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[6 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics7    := if((unsigned)dme[7 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[7 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics8    := if((unsigned)dme[8 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[8 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics9    := if((unsigned)dme[9 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[9 ].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics10   := if((unsigned)dme[10].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[10].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics11   := if((unsigned)dme[11].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[11].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics12   := if((unsigned)dme[12].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[12].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics13   := if((unsigned)dme[13].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[13].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics14   := if((unsigned)dme[14].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[14].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics15   := if((unsigned)dme[15].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[15].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics16   := if((unsigned)dme[16].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[16].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics17   := if((unsigned)dme[17].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[17].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics18   := if((unsigned)dme[18].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[18].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics19   := if((unsigned)dme[19].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[19].wuid,'ValidityStatistics',vs)  ,dataset([],vs));
 ValidityStatistics20   := if((unsigned)dme[20].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[20].wuid,'ValidityStatistics',vs)  ,dataset([],vs));

 RuleEfficacy1    := if((unsigned)dme[1 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[1 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy2    := if((unsigned)dme[2 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[2 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy3    := if((unsigned)dme[3 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[3 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy4    := if((unsigned)dme[4 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[4 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy5    := if((unsigned)dme[5 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[5 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy6    := if((unsigned)dme[6 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[6 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy7    := if((unsigned)dme[7 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[7 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy8    := if((unsigned)dme[8 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[8 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy9    := if((unsigned)dme[9 ].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[9 ].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy10   := if((unsigned)dme[10].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[10].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy11   := if((unsigned)dme[11].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[11].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy12   := if((unsigned)dme[12].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[12].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy13   := if((unsigned)dme[13].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[13].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy14   := if((unsigned)dme[14].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[14].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy15   := if((unsigned)dme[15].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[15].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy16   := if((unsigned)dme[16].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[16].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy17   := if((unsigned)dme[17].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[17].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy18   := if((unsigned)dme[18].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[18].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy19   := if((unsigned)dme[19].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[19].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));
 RuleEfficacy20   := if((unsigned)dme[20].MatchesPerformed != 0 ,WorkMan.get_DS_Result    (dme[20].wuid,'RuleEfficacy'    ,re)  ,dataset([],re));

  dproj2 := project(dme,transform(recordof(left),
    self.ConfidenceLevels    := choose(counter
                                  ,ConfidenceLevels1 
                                  ,ConfidenceLevels2 
                                  ,ConfidenceLevels3 
                                  ,ConfidenceLevels4 
                                  ,ConfidenceLevels5 
                                  ,ConfidenceLevels6 
                                  ,ConfidenceLevels7 
                                  ,ConfidenceLevels8 
                                  ,ConfidenceLevels9 
                                  ,ConfidenceLevels10    
                                  ,ConfidenceLevels11    
                                  ,ConfidenceLevels12    
                                  ,ConfidenceLevels13    
                                  ,ConfidenceLevels14    
                                  ,ConfidenceLevels15    
                                  ,ConfidenceLevels16    
                                  ,ConfidenceLevels17    
                                  ,ConfidenceLevels18    
                                  ,ConfidenceLevels19    
                                  ,ConfidenceLevels20    
                              );
    self.ValidityStatistics    := choose(counter
                                  ,ValidityStatistics1 
                                  ,ValidityStatistics2 
                                  ,ValidityStatistics3 
                                  ,ValidityStatistics4 
                                  ,ValidityStatistics5 
                                  ,ValidityStatistics6 
                                  ,ValidityStatistics7 
                                  ,ValidityStatistics8 
                                  ,ValidityStatistics9 
                                  ,ValidityStatistics10    
                                  ,ValidityStatistics11    
                                  ,ValidityStatistics12    
                                  ,ValidityStatistics13    
                                  ,ValidityStatistics14    
                                  ,ValidityStatistics15    
                                  ,ValidityStatistics16    
                                  ,ValidityStatistics17    
                                  ,ValidityStatistics18    
                                  ,ValidityStatistics19    
                                  ,ValidityStatistics20    
                              );
    self.RuleEfficacy    := choose(counter
                                  ,RuleEfficacy1 
                                  ,RuleEfficacy2 
                                  ,RuleEfficacy3 
                                  ,RuleEfficacy4 
                                  ,RuleEfficacy5 
                                  ,RuleEfficacy6 
                                  ,RuleEfficacy7 
                                  ,RuleEfficacy8 
                                  ,RuleEfficacy9 
                                  ,RuleEfficacy10    
                                  ,RuleEfficacy11    
                                  ,RuleEfficacy12    
                                  ,RuleEfficacy13    
                                  ,RuleEfficacy14    
                                  ,RuleEfficacy15    
                                  ,RuleEfficacy16    
                                  ,RuleEfficacy17    
                                  ,RuleEfficacy18    
                                  ,RuleEfficacy19    
                                  ,RuleEfficacy20    
                              );
  //  ,self.ValidityStatistics  := WorkMan.get_DS_Result    (left.wuid,'ValidityStatistics',vs);
   // ,self.RuleEfficacy        := WorkMan.get_DS_Result    (left.wuid,'RuleEfficacy'      ,re);
    self                     := left
  )
  );


  return sequential(
//    writefile
    output(dproj2,all);
  );
    
end;
