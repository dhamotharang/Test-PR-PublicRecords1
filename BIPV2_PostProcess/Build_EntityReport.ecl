import STD;
import BIPV2;
import BIPV2_Best;

EXPORT Build_EntityReport(

    string                            pVersion  = bipv2.KeySuffix  
   ,dataset(BIPV2.CommonBase.Layout)  pBase     = BIPV2.CommonBase.DS_BUILT
   ,dataset(BIPV2_Best.Layouts.base)  pBest     = BIPV2_Best.Files().base.built
   ,string20                          TheSprint = 'Sprint ' + BIPV2.KeySuffix_mod2.SprintNumber(pversion) //'Sprint 26'
   
) := 
Module
  rpt_timestamp := (UNSIGNED)(StringLib.StringFilterOut(Std.Date.SecondsToString(Std.Date.CurrentSeconds(FALSE), '%F%H%M%S%u'), '-')[1..14]) : INDEPENDENT;

  ER := EntityReport(pBase, pBest, (unsigned)pVersion[1..8]);
  
  allStats      := ER.allStats;
  activeStats   := ER.activeStats;
  inactiveStats := ER.inactiveStats;
  defunctStats  := ER.defunctStats;
  goldStats     := ER.goldStats_newgold;
  rawSegStats   := ER.rawSegStats_scores;
  cleanSegStats := ER.cleanSegStats_scores;
    
  layout_Entity_Report.file_layout formatForStorage(layout_Entity_Report.report_rec l, STRING20 rptType ) := transform
                                                    self.version := pVersion;
                                                    self.workunitName := workunit;
                                                    self.timestamp := rpt_timestamp;
                                                    self.reportType := rptType;
                                                    self:=l;
  end;
  
  storeAll      := project(allStats.countsAllAndStateReport,      formatForStorage(left, 'All'));
  storeGold     := project(goldStats.countsAllAndStateReport,     formatForStorage(left, 'Gold'));
  storeActive   := project(activeStats.countsAllAndStateReport,   formatForStorage(left, 'Active'));
  storeInactive := project(inactiveStats.countsAllAndStateReport, formatForStorage(left, 'Inactive'));
  storeDefunct  := project(defunctStats.countsAllAndStateReport,  formatForStorage(left, 'Defunct'));
  storeCleanSeg := project(rawSegStats.countsAllAndStateReport,   formatForStorage(left, 'CleanSeg'));
  storeRawSeg   := project(cleanSegStats.countsAllAndStateReport, formatForStorage(left, 'RawSeg'));
  
  allStore := storeAll & storeGold & storeActive & storeInactive & storeDefunct & storeCleanSeg & storeRawSeg;

  superFilename   := filenames().EntityStatsSuperFilename;
  logicalFilename := filenames(pVersion).EntityStatsLogicalBaseFilename + workunit;
  
  write_logical_File := output(allStore, , logicalFilename);
  add_to_superfile   := STD.File.AddSuperfile(superFilename, logicalFilename);
  
  export run := sequential(
                 parallel (
                  output(pversion                                                                      ,named('pversion'                   )     ),
                  output(TheSprint                                                                     ,named('TheSprint'                  )     ),
                  write_logical_File,
                  
                  output(ER.formatCntAll                    (allStats      .countsAllAndStateReport  ) ,named('all_count'                  ), all),
                  output(ER.formatPercentAll                (allStats      .percentAllAndStateReport ) ,named('all_percent'                ), all),
                     
                  output(ER.formatCntActiveOnly             (goldStats     .countsAllAndStateReport  ) ,named('gold_count'                 ), all),
                  output(ER.formatPercentActiveOnly         (goldStats     .percentAllAndStateReport ) ,named('gold_percent'               ), all),
                  
                  output(ER.formatCntActiveOnly             (activeStats   .countsAllAndStateReport  ) ,named('active_count'               ), all),
                  output(ER.formatPercentActiveOnly         (activeStats   .percentAllAndStateReport ) ,named('active_percent'             ), all),

                  output(ER.formatCntInactiveOnly           (inactiveStats .countsAllAndStateReport  ) ,named('inactive_count'             ), all),
                  output(ER.formatPercentInactiveOnly       (inactiveStats .percentAllAndStateReport ) ,named('inactive_percent'           ), all),

                  output(ER.formatCntDefunctOnly            (defunctStats  .countsAllAndStateReport  ) ,named('defunct_count'              ), all),
                  output(ER.formatPercentDefunctOnly        (defunctStats  .percentAllAndStateReport ) ,named('defunct_percent'            ), all),
                        
                  output(ER.formatBySegment                 (cleanSegStats .countsAllAndStateReport  ) ,named('seg_count_scores'           ), all),
                  output(ER.formatBySegmentSourceMakeup     (cleanSegStats .countsAllAndStateReport  ) ,named('seg_clean_src_makeup_scores'), all),
                  output(ER.formatBySegmentSourceMakeupSBFE (rawSegStats   .countsAllAndStateReport  ) ,named('seg_raw_src_makeup_scores'  ), all)
                  ),
                IF(NOT STD.File.SuperFileExists(superfilename), STD.File.CreateSuperFile(superfilename)),               
                add_to_superfile
                );      
end;

								