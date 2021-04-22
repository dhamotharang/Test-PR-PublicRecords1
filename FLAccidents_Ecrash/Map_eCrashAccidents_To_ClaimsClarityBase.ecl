// #############################################################################################
// eCrashAccidents for Insurance Claims Clarity
// ############################################################################################# 
eCrash_Reportable := BaseFile(allow_Sale_Of_Component_Data = TRUE);

  Layout_InseCrashSlim t_eCrashSlim(eCrash_Reportable L) := TRANSFORM
    //fabricated
    SELF.accident_nbr := IF(L.source_id IN ['TM','TF'], L.state_report_number, L.case_identifier);
    SELF.accident_date := IF(L.incident_id[1..9] = '188188188', '20100901', L.crash_date);
    SELF.impact_location := IF(L.report_code = 'TM',
                               IF(L.initial_point_of_contact[1..25] <> '', 'Damaged_Area_1: ' + L.initial_point_of_contact[1..25], '')
                               +
                               IF(L.initial_point_of_contact[25..] <> '', 'Damaged_Area_2: ' + L.initial_point_of_contact[25..], ''),
                               IF(L.damaged_areas_derived1 <> '', 'Damaged_Area_1: ' + L.damaged_areas_derived1, '') 
                               +
                               IF(L.damaged_areas_derived2 <> '', 'Damaged_Area_2: ' + L.damaged_areas_derived2, '')
                              );
    SELF := L;
  END;
EXPORT Map_eCrashAccidents_To_ClaimsClarityBase := PROJECT(eCrash_Reportable, t_eCrashSlim(LEFT));
