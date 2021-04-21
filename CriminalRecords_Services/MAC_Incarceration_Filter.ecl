/*
  The logic below was originally located in CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records.
  This is an attempt to make this logic more reusable, as we currently have pieces of this same code located in multiple places.
*/

EXPORT MAC_Incarceration_Filter(inf,
                                outf,
                                releasePPOverride = FALSE,  // if true, records matching a *release* or *probation/parole* pattern
                                                            // will force the incarceration indicator to 0.
                                dedup_recs = FALSE, // sort and dedup records by did and date (if available), returning the most recent by did.
                                batch_view = FALSE, // Use 'acctno' field when sorting/deduping.
                                inc_flag_field = 'Incarceration_Flag', // The incarceration indicator field in the input dataset
                                event_dt = 'event_dt',
                                cur_stat_inm_desc = 'cur_stat_inm_desc',
                                cur_loc_inm = 'cur_loc_inm',
                                sent_length_desc = 'sent_length_desc',
                                act_rel_dt = 'act_rel_dt',
                                sch_rel_dt = 'sch_rel_dt',
                                ctl_rel_dt = 'ctl_rel_dt'
                                ) := MACRO
  import STD;
  
  #uniquename(layout_in)
  %layout_in% := RECORDOF (inf);
  
  #uniquename(layout_out_tmp)
  %layout_out_tmp% := RECORD
    %layout_in%;
    BOOLEAN isPP;
    BOOLEAN isRelease;
  END;
  
  STRING PI_PATTERN := '^(Active|Population|Inmate|Incarcerated|IN +CUSTODY|UNDER +CUSTODY|IN, +ADMISSION)|LIFE';
  PI_SENT_PATTERN := '^(LIFE|LIFE [WITHOUT|W/O]* PAROLE)$';
  RELEASE_PATTERN := '^(Release|Released)$';
  PP_PATTERN := 'Probation|Parole|P&P';
  
  UNSIGNED1 COND_OUT := 0;
  UNSIGNED1 COND_IN := 1;
  UNSIGNED1 COND_UNKNOWN := 2;
  
  UNSIGNED4 currentDt := (UNSIGNED4) STD.Date.Today() : GLOBAL;
  
  #uniquename(isProbablyNotIncarcerated)
  BOOLEAN %isProbablyNotIncarcerated%(STRING statStr, STRING sentStr, SET OF UNSIGNED4 relDates) := FUNCTION
  
    #uniquename(dateRule)
    #uniquename(statusRule)
    
    // The original logic can be found in "CriminalRecords_BatchService._possible_incarceration_vb".
    %dateRule%(UNSIGNED4 relDt, UNSIGNED4 curDt) := MAP(relDt >= curDt => COND_IN,
                                                        relDt = 0 => COND_UNKNOWN,
                                                        COND_OUT);
    %statusRule%(STRING inmStat, STRING sentDesc) := MAP(REGEXFIND(PI_PATTERN, inmStat, NOCASE) => COND_IN,
                                      LENGTH(inmStat) = 0 AND REGEXFIND(PI_SENT_PATTERN, sentDesc, NOCASE) => COND_IN,
                                      LENGTH(inmStat) = 0 => COND_UNKNOWN,
                                      COND_OUT);
    
    #uniquename(statRule)
    #uniquename(dateRule1)
    #uniquename(dateRule2)
    #uniquename(dateRule3)
    #uniquename(dtsNotIn)
    #uniquename(dtInOrOut)
    UNSIGNED1 %statRule% := %statusRule%(TRIM(statStr, LEFT, RIGHT), TRIM(sentStr, LEFT, RIGHT));
    UNSIGNED1 %dateRule1% := %dateRule%((UNSIGNED4) relDates[1], currentDt);
    UNSIGNED1 %dateRule2% := %dateRule%((UNSIGNED4) relDates[2], currentDt);
    UNSIGNED1 %dateRule3% := %dateRule%((UNSIGNED4) relDates[3], currentDt);
    BOOLEAN %dtsNotIn% := (%dateRule2% <> COND_IN AND %dateRule3% <> COND_IN) OR %dateRule1% = COND_OUT OR %dateRule3% = COND_OUT;
    BOOLEAN %dtInOrOut% := %dateRule1% <> COND_UNKNOWN OR %dateRule2% <> COND_UNKNOWN OR %dateRule3% <> COND_UNKNOWN;

    RETURN (%statRule% <> COND_IN OR %dtInOrOut%) AND (%statRule% = COND_OUT OR %dtsNotIn%);
  END;

  #uniquename(flag_incarceration)
  %layout_out_tmp% %flag_incarceration%(%layout_in% l) := TRANSFORM
      #uniquename(isIncarcerated)
      %isIncarcerated% := ~%isProbablyNotIncarcerated%(l.cur_stat_inm_desc, l.sent_length_desc, [(UNSIGNED4) l.act_rel_dt, (UNSIGNED4) l.sch_rel_dt, (UNSIGNED4) l.ctl_rel_dt]);
      #uniquename(isRel)
      %isRel% := REGEXFIND(RELEASE_PATTERN, TRIM(l.cur_stat_inm_desc, LEFT, RIGHT), NOCASE);
      #uniquename(isPnP)
      %isPnP% := REGEXFIND(PP_PATTERN, TRIM(l.cur_loc_inm, LEFT, RIGHT), NOCASE);
      SELF.inc_flag_field := IF(releasePPOverride AND (%isRel% OR %isPnP%), '0', IF(%isIncarcerated%, '1', '0')),
      SELF.isRelease := %isRel%,
      SELF.isPP := %isPnP%,
      SELF := l,
      SELF := []
  END;
  
  #uniquename(candidates)
  %candidates% := PROJECT(inf, %flag_incarceration%(LEFT));
  
  #uniquename(candidates_dd)
  %candidates_dd% := IF(~dedup_recs,
                        %candidates%,
                        DEDUP(SORT(%candidates%(event_dt<>''),
                             #IF(batch_view)
                             acctno,
                             #END
                             #IF(dedup_recs)
                             -IF(did=0, 1, 0),
                             did, -event_dt, IF(isRelease OR isPP, 0, 1), -inc_flag_field,
                             #END
                             RECORD),
                             #IF(batch_view)
                             acctno
                             #END
                             #IF(dedup_recs)
                             ,LEFT.did>0 AND LEFT.did = RIGHT.did // so we don't dedup by did, if record has no did.
                             #else
                             RECORD
                             #END
                             )
                       // will preserve records with no event dt, so if they indicate incarceration, they'll continue to be reported.
                       + %candidates%(event_dt=''));
  
  outf := PROJECT(%candidates_dd%, %layout_in%);
    
  
ENDMACRO;
