import STD;
import BIPV2;
import BIPV2_Best;

EXPORT Build_EntityReport(
    string   pVersion  = bipv2.KeySuffix  
   ,dataset(BIPV2.CommonBase.Layout) pBase = BIPV2.CommonBase.DS_BUILT
   ,dataset(BIPV2_Best.Layouts.base) pBest = BIPV2_Best.Files().base.built
   ,string20 TheSprint = 'Sprint ' + BIPV2.KeySuffix_mod2.SprintNumber(pversion) //'Sprint 26'
) := Module
 
  ER := EntityReport(pBase, pBest, (unsigned)pVersion[1..8]);
  allStats      := ER.allStats;
  goldStats     := ER.goldStats;
  rawSegStats   := ER.rawSegStats;
  cleanSegStats := ER.cleanSegStats;
 
  export run := parallel (
                  output(pversion,                                                                named('pversion')),
                  output(TheSprint,                                                               named('TheSprint')),
                  output(ER.formatCntAll(allStats.countsAllAndStateReport),                       named('all_count'), all),
                  output(ER.formatPercentAll(allStats.percentAllAndStateReport),                  named('all_percent'), all),
                  output(ER.formatCntActiveOnly(goldStats.countsAllAndStateReport),               named('gold_count'), all),
                  output(ER.formatPercentActiveOnly(goldStats.percentAllAndStateReport),          named('gold_percent'), all),
                  output(ER.formatBySegment(cleanSegStats.countsAllAndStateReport),               named('seg_count'), all),
                  output(ER.formatBySegmentSourceMakeup(cleanSegStats.countsAllAndStateReport),   named('seg_clean_src_makeup'), all),
                  output(ER.formatBySegmentSourceMakeupSBFE(rawSegStats.countsAllAndStateReport), named('seg_raw_src_makeup'), all),
              );
end;

								