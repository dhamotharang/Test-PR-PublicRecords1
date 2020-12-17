
IMPORT dx_OSHAIR, OSHAIR, OSHAIR_Services, ut, doxie, codes, suppress, census_data, standard;

OUT_REC := OSHAIR_Services.layouts.SourceOutput;

// For full report in_ids here contains one is at most!
EXPORT out_rec GetDataSourceByID (GROUPED DATASET (OSHAIR_Services.layouts.id) in_ids) := FUNCTION

  // Fetch common info, calculating penalty for every record.
  OUT_REC GetCommonInfo (dx_OSHAIR.key_payload_inspection L) := TRANSFORM
    // As of now activity number is considered always to be an integer, represented by 10-chars string,
    // padded with leading zeros, if needed, so that "12345", "012345" and "0000012345" are the same.
    // TODO: consider creating field with other name (different types)
    SELF.activity_number := INTFORMAT (L.activity_number, 10, 1);
    SELF.report_id := L.Region_Code + L.Area_Code + L.Office_Code;

    // GET VIOLATIONS
    all_violations := CHOOSEN (dx_OSHAIR.key_payload_violations (keyed (activity_number = L.Activity_Number)), Constants.VIOLATION_MAX);
    OSHAIR_Services.layouts.Violation SetViolations (all_violations L) := TRANSFORM
      SELF.id_number := L.Citation_Number + L.Item_Number;
      SELF.Violation_Contest_Desc := IF (L.Violation_Contest = 'X', 'YES', 'NO');
      SELF := L;
    END;
    SELF.violations := SORT (PROJECT (all_violations, SetViolations (Left)), id_number);

    // GET SUBSTANCES, compact up to 5 of them into child
    all_substances := CHOOSEN (dx_OSHAIR.Key_payload_hazardous_substance(keyed (activity_number = L.Activity_Number)), Constants.SUBSTANCE_MAX);
    layouts.Hazardous_Substance CompactHazards (all_substances L) := transform
      SELF.id_number := L.Citation_Number + L.Item_Number;
      SELF.substance :=
        IF (L.hazardous_substance_1 != '', DATASET ([{L.hazardous_substance_1, L.hazardous_sub_desc_1}], layouts.hsubstance)) +
        IF (L.hazardous_substance_2 != '', DATASET ([{L.hazardous_substance_2, L.hazardous_sub_desc_2}], layouts.hsubstance)) +
        IF (L.hazardous_substance_3 != '', DATASET ([{L.hazardous_substance_3, L.hazardous_sub_desc_3}], layouts.hsubstance)) +
        IF (L.hazardous_substance_4 != '', DATASET ([{L.hazardous_substance_4, L.hazardous_sub_desc_4}], layouts.hsubstance)) +
        IF (L.hazardous_substance_5 != '', DATASET ([{L.hazardous_substance_5, L.hazardous_sub_desc_5}], layouts.hsubstance));
      SELF := L;
    end;
    SELF.substances := SORT (PROJECT (all_substances, CompactHazards (Left)), id_number);

    // GET ACCIDENTS
    all_accidents := CHOOSEN (dx_OSHAIR.key_payload_accident(keyed (activity_number = L.Activity_Number)), Constants.ACCIDENT_MAX);
    OSHAIR_Services.layouts.Accident SetAccidents (all_accidents L) := transform
      SELF.sex_desc := MAP (L.sex = 'M' => 'MALE', L.sex = 'F' => 'FEMALE', '');
      SELF := L;
    end;
    SELF.accidents := PROJECT (all_accidents, SetAccidents (Left));

    SELF.address.prim_range := l.prim_range;
    SELF.address.predir := l.predir;
    SELF.address.prim_name := l.prim_name;
    SELF.address.addr_suffix := l.addr_suffix;
    SELF.address.postdir := l.postdir;
    SELF.address.unit_desig := l.unit_desig;
    SELF.address.sec_range := l.sec_range;
    SELF.address.p_city_name := l.p_city_name;
    SELF.address.v_city_name := l.v_city_name;
    SELF.address.st := l.st;
    SELF.address.zip5 := l.zip5;
    SELF.address.zip4 := l.zip4;
    SELF.address.fips_state := l.fips_state;
    SELF.address.fips_county := l.fips_county;
    SELF.address.addr_rec_type := l.addr_rec_type;

    // set state
    SELF.address.state := stringlib.StringToUpperCase (codes.general.state_long (L.st));
    // county full name calculated after
    SELF.address.county := '';

    // Codes and descriptions
    SELF.industry_codes.DUNS_Number := L.DUNS_Number;
    SELF.industry_codes.sic_code    := L.sic_code;
    SELF.industry_codes.secondary_sic := L.SIC_Guide;
    // SELF.industry_codes.NAICS_Code      := IF (((integer) L.NAICS_Code) = 0,           '', L.NAICS_Code);
    // SELF.industry_codes.secondary_NAICS := IF (((integer) L.NAICS_Secondary_Code) = 0, '', L.NAICS_Secondary_Code);
    // SELF.industry_codes.inspected_NAICS := IF (((integer) L.NAIC_Inspected) = 0,       '', L.NAIC_Inspected);

    sic_codes_set := [INTFORMAT (L.sic_code, 4, 1), INTFORMAT (L.SIC_Guide, 4, 1)];
    sic_codes := SET (LIMIT (codes.Key_SIC4 (sic4_code IN sic_codes_set), 2, skip), sic4_description);
    SELF.industry_codes.sic_code_desc      := sic_codes[1];
    SELF.industry_codes.secondary_sic_desc := sic_codes[2];

    naics_codes := DATASET ([{'primary', L.NAICS_Code}, {'secondary', L.NAICS_Secondary_Code}, {'inspected', L.NAIC_Inspected}],
                             layouts.naics_codes);
    naics_codes_descript := JOIN (naics_codes ((integer) code != 0), codes.Key_NAICS,
                                  keyed (Left.code = Right.naics_code),
                                  transform (layouts.naics_codes, Self.description := Right.naics_description, Self := Left),
                                  ATMOST (1));
    SELF.industry_codes.naics := naics_codes_descript;

    // descriptions:
    SELF.Safety_Health_Desc := MAP (L.Safety_Health_Flag = 'S' => 'SAFETY',
                                    L.Safety_Health_Flag = 'H' => 'HEALTH', '');

    SELF.union_flag_desc := MAP (L.union_flag = 'Y' => 'YES',
                                 L.union_flag = 'N' => 'NO', '');

    SELF.why_no_insp_desc := OSHAIR.lookup_oshair_mini.Why_No_Inspection_lookup (L.Why_No_Inspection_Code);

    // inspection flags, according to Rosemary tehre can be atmost one.
    planning_guide_desc := MAP (
      L.Safety_PG_Manufacturing_Insp_Flag = 'X' => 'SAFETY PLANNING GUIDE - MANUFACTURING INSPECTION',
      L.Safety_PG_Construction_Insp_Flag  = 'X' => 'SAFETY PLANNING GUIDE - CONSTRUCTION INSPECTION',
      L.Safety_PG_Maritime_Insp_Flag      = 'X' => 'SAFETY PLANNING GUIDE - MARITIME INSPECTION',

      L.Health_PG_Manufacturing_Insp_Flag  = 'X' => 'HEALTH PLANNING GUIDE - MANUFACTURING INSPECTION',
      L.Health_PG_Construction_Insp_Flag   = 'X' => 'HEALTH PLANNING GUIDE - CONSTRUCTION INSPECTION',
      L.Health_PG_Maritime_Insp_Flag       = 'X' => 'HEALTH PLANNING GUIDE - MARITIME INSPECTION',
      L.Migrant_Farm_Insp_Flag  = 'X' => 'INSPECTION OF MIGRANT FARM WORKER CAMP', '');

    layouts.PlanningGuides SetProgramDesc (dx_OSHAIR.key_payload_program L) := transform
      SELF.description := MAP (L.Program_Type = 'L' => 'LOCAL EMPHASIS PROGRAM: ',
                               L.Program_Type = 'N' => 'NATIONAL SPECIAL EMPHASIS PROGRAM: ',
                               L.Program_Type = 'N' => 'STRATEGIC PLAN: ',
                               '') + L.Program_Value;
    end;

    program_desc_table := CHOOSEN (
      PROJECT (dx_OSHAIR.key_payload_program (keyed (activity_number = L.Activity_Number)), SetProgramDesc (Left)),
    Constants.PROGRAM_MAX);

    SELF.classification := IF (planning_guide_desc != '', DATASET ([{planning_guide_desc}], layouts.PlanningGuides)) +
                           program_desc_table;

    SELF.advance_notice_desc        := MAP (L.advance_notice_flag = 'Y' => 'YES',
                                            L.advance_notice_flag = 'N' => 'NO', '');
    SELF.walk_around_desc           := IF (L.walk_around_flag = 'X', 'YES', '');
    SELF.Employees_interviewed_desc := IF (L.Employees_interviewed_flag = 'X', 'YES', '');

    SELF.inspection_hours :=
      IF (L.PA_Prep_Time        != 0, DATASET ([{'PREP', L.PA_Prep_Time}], layouts.InspectionTime)) +
      IF (L.PA_Travel_Time      != 0, DATASET ([{'TRAVEL', L.PA_Travel_Time}], layouts.InspectionTime)) +
      IF (L.PA_On_site_Time     != 0, DATASET ([{'ON-SITE', L.PA_On_site_Time}], layouts.InspectionTime)) +
      IF (L.PA_Tech_supp_Time   != 0, DATASET ([{'ABATEMENT ASSISTANCE', L.PA_Tech_supp_Time}], layouts.InspectionTime)) +
      IF (L.PA_Report_prep_Time != 0, DATASET ([{'RESEARCH', L.PA_Report_prep_Time}], layouts.InspectionTime)) +
      IF (L.PA_Other_conf_Time  != 0, DATASET ([{'CONFERENCES', L.PA_Other_conf_Time}], layouts.InspectionTime)) +
      IF (L.PA_Litigation_Time  != 0, DATASET ([{'LITIGATION PREP', L.PA_Litigation_Time}], layouts.InspectionTime)) +
      IF (L.PA_Denial_Time      != 0, DATASET ([{'DENIAL ACTIVITY', L.PA_Denial_Time}], layouts.InspectionTime)) +
      IF (L.PA_Sum_hours        != 0, DATASET ([{'TOTAL', L.PA_Sum_hours}], layouts.InspectionTime));

    SELF := L;
  END;

  src_fetched := JOIN (in_ids, dx_OSHAIR.key_payload_inspection,
                   keyed (Left.activity_number = Right.activity_number),
                   GetCommonInfo (Right),
                   KEEP (100)); //

/*
// this is another way of getting child sets, if more complex job required

  violations_clean_layout := RECORD
    dx_OSHAIR.layouts.Layout_Violations - dx_common.layout_metadata
  END;

  violations_rec := violations_clean_layout;
  src_violations := JOIN (in_ids, OSHAIR.Key_payload_violations,
                          keyed (Left.activity_number = Right.activity_number),
                          transform (violations_rec, SELF := Right),
                          LIMIT (VIOLATION_MAX));

  violations_grp := GROUP (SORTED (src_violations, activity_number), activity_number);

  violation_rolled_rec := RECORD // {MAXCOUNT (1)}
    big_endian unsigned4 Activity_Number;
    DATASET (OSHAIR_Services.layouts.Violation) violations {MAXCOUNT (VIOLATION_MAX)};
  END;

  violation_rolled_rec RollViolations (violations_rec L, DATASET (violations_rec) all_recs) := TRANSFORM
    SELF.Activity_Number := L.Activity_Number;
    SELF.violations := PROJECT (all_recs, OSHAIR_Services.layouts.Violation);
  END;
  violations_res := ROLLUP (violations_grp, GROUP, RollViolations (Left, ROWS (Left)));

  res := JOIN (src_fetched, violations_res,
               Left.activity_number = Right.activity_number,
               transform (OUT_REC, SELF.violations := Right.violations; SELF := Left),
               LEFT OUTER, ATMOST (1));
*/
  //  add county name
  census_data.MAC_Fips2County_Keyed (src_fetched, address.st, address.fips_county, address.county, ds_cnty);


  res := ds_cnty;
  RETURN res;
END;
