IMPORT civil_court;

EXPORT Raw := MODULE

    EXPORT civil_court.Layout_roxie_party byCaseIDParty(STRING60 in_casekey) := FUNCTION
    
      caseKeyDS1 := DATASET([{(STRING60) in_casekey}], civilCourt_services.layouts.caseIDLayout);
      
      partySet := JOIN(caseKeyDS1, civil_court.key_caseID,
        KEYED(LEFT.case_key = RIGHT.case_key),
        TRANSFORM(civil_court.Layout_Roxie_Party,
        SELF := RIGHT),
        LIMIT(civilCourt_services.constants.max_recs_on_civilCourt_join, SKIP));
        
      RETURN PartySet;
    END;
       
    EXPORT civil_court.Layout_Roxie_case_activity byCaseIDActivity(STRING60 in_casekey) := FUNCTION
          
      caseKeyDS2 := DATASET([{(STRING60) in_casekey}], civilCourt_services.layouts.caseIDLayout);
      
      ActivitySet := JOIN(caseKeyDS2, civil_court.key_caseID_activity,
        KEYED(LEFT.case_key = RIGHT.case_key),
        TRANSFORM(civil_court.Layout_Roxie_Case_Activity,
        SELF := RIGHT),
        LIMIT(civilcourt_services.constants.max_recs_on_civilCourt_join, SKIP));
               
      RETURN ActivitySet;
    END;
    
       
    EXPORT civil_court.Layout_Roxie_Matter byCaseIDMatter(STRING60 in_casekey) := FUNCTION
    
      caseKeyDS3 := DATASET([{(STRING60) in_casekey}], civilCourt_services.layouts.caseIDLayout);
        
      MatterSet := JOIN(caseKeyDS3, civil_court.key_caseID_matter,
        KEYED(LEFT.case_key = RIGHT.case_key),
        TRANSFORM(civil_court.Layout_Roxie_Matter,
        SELF := RIGHT),
        LIMIT(civilcourt_services.constants.max_recs_on_civilCourt_join, SKIP));
    
      RETURN MatterSet;
    END;
    
END;
