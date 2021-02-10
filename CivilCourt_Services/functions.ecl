IMPORT iesp, civil_court, ut, Census_Data;

EXPORT functions := MODULE

  //
  // do the first project of the input dataset after the county name is added.
  // because of the nested structure of 3 datasets witin a larger dataset.
  // Parties DS
  // Activity DS
  // Matter DS
  // there are 3 projects done to setup the internal datasets. The results of each
  // of these 3 projects are then placed into the final layout outer structure which
  // is the iesp.civilcourt.t_CivilCourtReportRecord
  //
  
  EXPORT fnCivilCourtReportVal(DATASET(civil_court.Layout_Roxie_Party) in_partyDS,
                              DATASET(civil_court.Layout_Roxie_Case_Activity) in_activityDS,
                              DATASET(civil_court.Layout_Roxie_Matter) in_matterDS) := 
  FUNCTION
                             
    // add in the county name into the layout so that it can be put into final layout.
    temp_in_partyDS := PROJECT(in_partyDS, TRANSFORM(civilcourt_services.layouts.PartyLayoutPlus,
      SELF.countyname := '',
      SELF := LEFT));
                              
    civilcourt_services.layouts.PartyLayoutPlus xform(
      civilcourt_services.layouts.PartyLayoutPlus l,
      Census_Data.Key_Fips2County r) := 
    TRANSFORM
      SELF.countyname := r.county_name;
      SELF := l;
    END;
    
   // apply county name conversion to in_partyDS dataset here.
   // to populate county name may need to add a county name field here.
   final_in_partyDS := JOIN (temp_in_partyDS, Census_Data.Key_Fips2County,
      (LEFT.st1<>'') AND (LEFT.ace_fips_county1<>'') AND
      (TRIM(LEFT.st1) = RIGHT.state_code) AND
      (TRIM(LEFT.ace_fips_county1) = RIGHT.county_fips), 
    xform(LEFT, RIGHT),
    LEFT OUTER, KEEP(1),
    LIMIT(civilcourt_services.Constants.max_recs_on_civilCourt_join,SKIP));
                            
    // sort 1st by Plaintiff, Attorney For Plaintiff, Defendant, Attorney For Defendant using numeric value in
    // entity_type_code_1_master, and then
    // then reverse sort by entity_type_description_1_orig
    final_in_partyDS_sorted := SORT(final_in_partyDS, entity_type_code_1_master, -entity_type_description_1_orig, RECORD);
    iesp.civilCourt.t_CivilCourtReportParty xform1(civilcourt_services.layouts.PartyLayoutPlus l) := 
    TRANSFORM   
      SELF.Ruling := l.ruled_for_against;
      SELF.PartyType := l.entity_type_description_1_orig;
      SELF.PartyName := l.entity_1;
      SELF.Address := iesp.ECL2ESP.setAddress(l.prim_name1,l.prim_range1,l.predir1, l.postdir1,l.addr_suffix1,
        l.unit_desig1, l.sec_range1, l.v_city_name1,
        l.st1, l.zip1,l.zip41,l.countyname);
      SELF.PartyType2 := '';
      SELF.PartyName2 := '';
      SELF.Address2 := iesp.ECL2ESP.setAddress(l.prim_name2,l.prim_range2,l.predir2, l.postdir2,'',
        l.unit_desig2, l.sec_range2, l.v_city_name2, l.st2, l.zip2,l.zip42,''),
    END;

    Parties_final := PROJECT(final_in_partyDS_sorted, xform1(LEFT));
    iesp.civilcourt.t_CivilCourtReportEvent xform2(
      civil_court.Layout_Roxie_Case_Activity l ) := 
    TRANSFORM
      SELF.Date.Year := (INTEGER2) l.event_date[1..4],
      SELF.Date.Month := (INTEGER2) l.event_date[5..6],
      SELF.Date.Day := (INTEGER2) l.event_date[7..8],
      SELF.EventType := l.event_type_description_1,
    END;
     // set up the internal data set based on activity Data set.
     // sort DS before populating final structure with data.
    in_activityDS_sorted := SORT(in_activityDS, event_date);
    events_final := PROJECT(in_activityDS_sorted, xform2(LEFT));

    iesp.civilcourt.t_CivilCourtReportFiling xform3(
      civil_court.Layout_Roxie_Matter l) := 
    TRANSFORM
      SELF.FilingDate.Year := (INTEGER2) l.filing_date[1..4];
      SELF.FilingDate.Month := (INTEGER2) l.filing_date[5..6];
      SELF.FilingDate.Day := (INTEGER2) l.filing_date[7..8];
      SELF.FilingManner := l.manner_of_filing;
      SELF.JudgmentDate.Year := (INTEGER2) l.judgmt_date[1..4];
      SELF.JudgmentDate.Month := (INTEGER2) l.judgmt_date[5..6];
      SELF.JudgmentDate.Day := (INTEGER2) l.judgmt_date[7..8];
      SELF.JudgmentManner := l.manner_of_judgmt;
      SELF.JudgmentType := l.judgmt_type;
      SELF.JudgmentDisposition := l.judgmt_disposition;
      SELF.DispositionDate.Year := (INTEGER2) l.disposition_date[1..4];
      SELF.DispositionDate.Month := (INTEGER2) l.disposition_date[5..6];
      SELF.DispositionDate.Day := (INTEGER2) l.disposition_date[7..8];
      SELF.Disposition := l.disposition_description;
      SELF.SuitAmount := l.suit_amount;
      SELF.AwardAmount := l.award_amount;
      SELF.Cause := l.case_cause;
      SELF.Ruling := l.ruled_for_against;
    END;
    
    // set up the internal data set named filings.
    Filings_final := PROJECT(in_matterDS, xform3(LEFT));
     
    iesp.civilcourt.t_CivilCourtReportRecord xform4(
      civilcourt_services.layouts.PartyLayoutPlus l,
      DATASET (iesp.civilcourt.t_CivilCourtReportParty) param_Parties_final,
      DATASET (iesp.civilcourt.t_CivilCourtReportEvent) param_Events_final,
      DATASET (iesp.civilcourt.t_CivilCourtReportFiling) param_Filings_final
      ) := 
    TRANSFORM
      SELF.CaseTitle := l.case_title,
      SELF.CaseType := l.case_Type,
      SELF.CaseNumber := l.Case_Number,
      SELF.State := ut.St2Name(l.state_origin),
      SELF.Court := l.Court,
      SELF.Parties := param_parties_final,
      SELF.Events := param_events_final,
      SELF.Filings := param_Filings_final
    END;
      
    // wait till now to dedup otherwise miss populating the parties in the final structure.
    //
    final_in_partyDS_deduped := DEDUP(SORT(final_in_partyDS, case_key), case_key);
    report_final := PROJECT(final_in_partyDS_deduped, xform4(LEFT, Parties_final, Events_final, Filings_final));
    // output(parties_final,named('parties_final'));
    // output(report_final,named('report_final'));
    // output(final_in_partyDS_deduped,named('final_in_partyDS_deduped'));
    // output(final_in_partyDS_sorted,named('final_in_partyDS_sorted'));
    RETURN report_final;
  END; // FUNCTION
   
   // function used for the civil court search
   
  EXPORT fnCivilCourtSearchVal(DATASET(CivilCourt_services.Layouts.partylayoutPlus) in_recs) := FUNCTION
  
    iesp.civilcourt.t_CivilCourtSearchRecord xform(CivilCourt_services.Layouts.partylayoutPlus l)
                                  := TRANSFORM
      SELF.CaseTitle := l.case_title;
      SELF.CaseId := l.case_key;
      SELF.CaseType := l.case_type;
      SELF.PartyType := l.entity_type_description_1_orig;
      SELF.PartyName := IF (l.entity_1 <> '', l.entity_1,
        l.v1_fname1 + '' + l.v1_mname1 + '' + l.v1_lname1 + ' ' + l.v1_suffix1);
      SELF.City := l.v_city_name1;
      SELF.State := l.st1;
      SELF.StateOfOrigin := ut.St2Name(l.state_origin);
      SELF.Jurisdiction := l.court;
      SELF.PrimaryEntity := l.primary_entity_2;
      SELF.EntityTypeDescription := l.entity_type_description_1_orig;
      SELF.EntityAddresses := DATASET([
        {l.entity_1_address_1},
        {l.entity_1_address_2},
        {l.entity_1_address_3},
        {l.entity_1_address_4},
        {l.entity_2_address_1},
        {l.entity_2_address_2},
        {l.entity_2_address_3},
        {l.entity_2_address_4}
      ], iesp.share.t_StringArrayItem);
      SELF._penalty := 0;
      SELF.AlsoFound := FALSE;
    END;
    
    temp_final := PROJECT(in_recs, xform(LEFT));
    
    // this sorts case titles with blank to the end and then does alphbetical sort by casetitle
    // since boolean false sorts above boolean true.
    final_result := SORT(temp_final, IF (caseTitle = '', 1, 0), caseTitle, 
      partyType, partyName, stateOforigin, RECORD);
    RETURN final_result;
  END; // FUNCTION
 END; // MODULE
