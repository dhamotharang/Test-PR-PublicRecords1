IMPORT STD,SALT311;
EXPORT NOD_Ingest(BOOLEAN incremental=FALSE
, DATASET(NOD_Layout_BKForeclosure) Delta = DATASET([],NOD_Layout_BKForeclosure)
, DATASET(NOD_Layout_BKForeclosure) dsBase = NOD_In_BKForeclosure // Change IN_BKForeclosure to change input to ingest process
, DATASET(RECORDOF(BKForeclosure.NOD_prep_ingest_file))  infile = BKForeclosure.NOD_prep_ingest_file
) := MODULE
  SHARED NullFile := DATASET([],NOD_Layout_BKForeclosure); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    NOD_Layout_BKForeclosure;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.date_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_first_seen = 0 => ri.date_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_first_seen = 0 => le.date_first_seen,
                     (UNSIGNED)le.date_first_seen < (UNSIGNED)ri.date_first_seen => le.date_first_seen, // Want the lowest non-zero value
                     ri.date_first_seen);
    SELF.date_last_seen := MAP ( le.__Tpe = 0 => ri.date_last_seen,
                     ri.__Tpe = 0 => le.date_last_seen,
                     (UNSIGNED)le.date_last_seen < (UNSIGNED)ri.date_last_seen => ri.date_last_seen, // Want the highest value
                     le.date_last_seen);
    SELF.date_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_vendor_first_reported = 0 => ri.date_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_vendor_first_reported = 0 => le.date_vendor_first_reported,
                     (UNSIGNED)le.date_vendor_first_reported < (UNSIGNED)ri.date_vendor_first_reported => le.date_vendor_first_reported, // Want the lowest non-zero value
                     ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.date_vendor_last_reported,
                     ri.__Tpe = 0 => le.date_vendor_last_reported,
                     (UNSIGNED)le.date_vendor_last_reported < (UNSIGNED)ri.date_vendor_last_reported => ri.date_vendor_last_reported, // Want the highest value
                     le.date_vendor_last_reported);
    SELF.process_date := MAP ( le.__Tpe = 0 => ri.process_date,
                     ri.__Tpe = 0 => le.process_date,
                     (UNSIGNED)le.process_date < (UNSIGNED)ri.process_date => ri.process_date, // Want the highest value
                     le.process_date);
    SELF.src := ri.src; // Derived(NEW)
    SELF.delete_flag := ri.delete_flag; // Derived(NEW)
    SELF.foreclosure_id := ri.foreclosure_id; // Derived(NEW)
    SELF.ln_filedate := MAP ( le.__Tpe = 0 => ri.ln_filedate,
                     ri.__Tpe = 0 => le.ln_filedate,
                     (UNSIGNED)le.ln_filedate < (UNSIGNED)ri.ln_filedate => ri.ln_filedate, // Want the highest value
                     le.ln_filedate);
    SELF.bk_infile_type := ri.bk_infile_type; // Derived(NEW)
    SELF.sam_pid := ri.sam_pid; // Derived(NEW)
    SELF.deed_pid := ri.deed_pid; // Derived(NEW)
		SELF.lps_internal_pid := ri.lps_internal_pid; // Derived(NEW)
    SELF.nod_source := ri.nod_source; // Derived(NEW)
    SELF.name1_nid := ri.name1_nid; // Derived(NEW)
    SELF.name1_prefix := ri.name1_prefix; // Derived(NEW)
    SELF.name1_first := ri.name1_first; // Derived(NEW)
    SELF.name1_middle := ri.name1_middle; // Derived(NEW)
    SELF.name1_last := ri.name1_last; // Derived(NEW)
    SELF.name1_suffix := ri.name1_suffix; // Derived(NEW)
    SELF.name1_company := ri.name1_company; // Derived(NEW)
    SELF.name1_did_score := ri.name1_did_score; // Derived(NEW)
    SELF.name1_did := ri.name1_did; // Derived(NEW)
    SELF.name1_bdid_score := ri.name1_bdid_score; // Derived(NEW)
    SELF.name1_bdid := ri.name1_bdid; // Derived(NEW)
    SELF.name1_dotid := ri.name1_dotid; // Derived(NEW)
    SELF.name1_dotscore := ri.name1_dotscore; // Derived(NEW)
    SELF.name1_dotweight := ri.name1_dotweight; // Derived(NEW)
    SELF.name1_empid := ri.name1_empid; // Derived(NEW)
    SELF.name1_empscore := ri.name1_empscore; // Derived(NEW)
    SELF.name1_empweight := ri.name1_empweight; // Derived(NEW)
    SELF.name1_powid := ri.name1_powid; // Derived(NEW)
    SELF.name1_powscore := ri.name1_powscore; // Derived(NEW)
    SELF.name1_powweight := ri.name1_powweight; // Derived(NEW)
    SELF.name1_proxid := ri.name1_proxid; // Derived(NEW)
    SELF.name1_proxscore := ri.name1_proxscore; // Derived(NEW)
    SELF.name1_proxweight := ri.name1_proxweight; // Derived(NEW)
    SELF.name1_seleid := ri.name1_seleid; // Derived(NEW)
    SELF.name1_selescore := ri.name1_selescore; // Derived(NEW)
    SELF.name1_seleweight := ri.name1_seleweight; // Derived(NEW)
    SELF.name1_orgid := ri.name1_orgid; // Derived(NEW)
    SELF.name1_orgscore := ri.name1_orgscore; // Derived(NEW)
    SELF.name1_orgweight := ri.name1_orgweight; // Derived(NEW)
    SELF.name1_ultid := ri.name1_ultid; // Derived(NEW)
    SELF.name1_ultscore := ri.name1_ultscore; // Derived(NEW)
    SELF.name1_ultweight := ri.name1_ultweight; // Derived(NEW)
    SELF.name2_nid := ri.name2_nid; // Derived(NEW)
    SELF.name2_prefix := ri.name2_prefix; // Derived(NEW)
    SELF.name2_first := ri.name2_first; // Derived(NEW)
    SELF.name2_middle := ri.name2_middle; // Derived(NEW)
    SELF.name2_last := ri.name2_last; // Derived(NEW)
    SELF.name2_suffix := ri.name2_suffix; // Derived(NEW)
    SELF.name2_company := ri.name2_company; // Derived(NEW)
    SELF.name2_did_score := ri.name2_did_score; // Derived(NEW)
    SELF.name2_did := ri.name2_did; // Derived(NEW)
    SELF.name2_bdid_score := ri.name2_bdid_score; // Derived(NEW)
    SELF.name2_bdid := ri.name2_bdid; // Derived(NEW)
    SELF.name2_dotid := ri.name2_dotid; // Derived(NEW)
    SELF.name2_dotscore := ri.name2_dotscore; // Derived(NEW)
    SELF.name2_dotweight := ri.name2_dotweight; // Derived(NEW)
    SELF.name2_empid := ri.name2_empid; // Derived(NEW)
    SELF.name2_empscore := ri.name2_empscore; // Derived(NEW)
    SELF.name2_empweight := ri.name2_empweight; // Derived(NEW)
    SELF.name2_powid := ri.name2_powid; // Derived(NEW)
    SELF.name2_powscore := ri.name2_powscore; // Derived(NEW)
    SELF.name2_powweight := ri.name2_powweight; // Derived(NEW)
    SELF.name2_proxid := ri.name2_proxid; // Derived(NEW)
    SELF.name2_proxscore := ri.name2_proxscore; // Derived(NEW)
    SELF.name2_proxweight := ri.name2_proxweight; // Derived(NEW)
    SELF.name2_seleid := ri.name2_seleid; // Derived(NEW)
    SELF.name2_selescore := ri.name2_selescore; // Derived(NEW)
    SELF.name2_seleweight := ri.name2_seleweight; // Derived(NEW)
    SELF.name2_orgid := ri.name2_orgid; // Derived(NEW)
    SELF.name2_orgscore := ri.name2_orgscore; // Derived(NEW)
    SELF.name2_orgweight := ri.name2_orgweight; // Derived(NEW)
    SELF.name2_ultid := ri.name2_ultid; // Derived(NEW)
    SELF.name2_ultscore := ri.name2_ultscore; // Derived(NEW)
    SELF.name2_ultweight := ri.name2_ultweight; // Derived(NEW)
    SELF.name3_nid := ri.name3_nid; // Derived(NEW)
    SELF.name3_prefix := ri.name3_prefix; // Derived(NEW)
    SELF.name3_first := ri.name3_first; // Derived(NEW)
    SELF.name3_middle := ri.name3_middle; // Derived(NEW)
    SELF.name3_last := ri.name3_last; // Derived(NEW)
    SELF.name3_suffix := ri.name3_suffix; // Derived(NEW)
    SELF.name3_company := ri.name3_company; // Derived(NEW)
    SELF.name3_did_score := ri.name3_did_score; // Derived(NEW)
    SELF.name3_did := ri.name3_did; // Derived(NEW)
    SELF.name3_bdid_score := ri.name3_bdid_score; // Derived(NEW)
    SELF.name3_bdid := ri.name3_bdid; // Derived(NEW)
    SELF.name3_dotid := ri.name3_dotid; // Derived(NEW)
    SELF.name3_dotscore := ri.name3_dotscore; // Derived(NEW)
    SELF.name3_dotweight := ri.name3_dotweight; // Derived(NEW)
    SELF.name3_empid := ri.name3_empid; // Derived(NEW)
    SELF.name3_empscore := ri.name3_empscore; // Derived(NEW)
    SELF.name3_empweight := ri.name3_empweight; // Derived(NEW)
    SELF.name3_powid := ri.name3_powid; // Derived(NEW)
    SELF.name3_powscore := ri.name3_powscore; // Derived(NEW)
    SELF.name3_powweight := ri.name3_powweight; // Derived(NEW)
    SELF.name3_proxid := ri.name3_proxid; // Derived(NEW)
    SELF.name3_proxscore := ri.name3_proxscore; // Derived(NEW)
    SELF.name3_proxweight := ri.name3_proxweight; // Derived(NEW)
    SELF.name3_seleid := ri.name3_seleid; // Derived(NEW)
    SELF.name3_selescore := ri.name3_selescore; // Derived(NEW)
    SELF.name3_seleweight := ri.name3_seleweight; // Derived(NEW)
    SELF.name3_orgid := ri.name3_orgid; // Derived(NEW)
    SELF.name3_orgscore := ri.name3_orgscore; // Derived(NEW)
    SELF.name3_orgweight := ri.name3_orgweight; // Derived(NEW)
    SELF.name3_ultid := ri.name3_ultid; // Derived(NEW)
    SELF.name3_ultscore := ri.name3_ultscore; // Derived(NEW)
    SELF.name3_ultweight := ri.name3_ultweight; // Derived(NEW)
    SELF.name4_nid := ri.name4_nid; // Derived(NEW)
    SELF.name4_prefix := ri.name4_prefix; // Derived(NEW)
    SELF.name4_first := ri.name4_first; // Derived(NEW)
    SELF.name4_middle := ri.name4_middle; // Derived(NEW)
    SELF.name4_last := ri.name4_last; // Derived(NEW)
    SELF.name4_suffix := ri.name4_suffix; // Derived(NEW)
    SELF.name4_company := ri.name4_company; // Derived(NEW)
    SELF.name4_did_score := ri.name4_did_score; // Derived(NEW)
    SELF.name4_did := ri.name4_did; // Derived(NEW)
    SELF.name4_bdid_score := ri.name4_bdid_score; // Derived(NEW)
    SELF.name4_bdid := ri.name4_bdid; // Derived(NEW)
    SELF.name4_dotid := ri.name4_dotid; // Derived(NEW)
    SELF.name4_dotscore := ri.name4_dotscore; // Derived(NEW)
    SELF.name4_dotweight := ri.name4_dotweight; // Derived(NEW)
    SELF.name4_empid := ri.name4_empid; // Derived(NEW)
    SELF.name4_empscore := ri.name4_empscore; // Derived(NEW)
    SELF.name4_empweight := ri.name4_empweight; // Derived(NEW)
    SELF.name4_powid := ri.name4_powid; // Derived(NEW)
    SELF.name4_powscore := ri.name4_powscore; // Derived(NEW)
    SELF.name4_powweight := ri.name4_powweight; // Derived(NEW)
    SELF.name4_proxid := ri.name4_proxid; // Derived(NEW)
    SELF.name4_proxscore := ri.name4_proxscore; // Derived(NEW)
    SELF.name4_proxweight := ri.name4_proxweight; // Derived(NEW)
    SELF.name4_seleid := ri.name4_seleid; // Derived(NEW)
    SELF.name4_selescore := ri.name4_selescore; // Derived(NEW)
    SELF.name4_seleweight := ri.name4_seleweight; // Derived(NEW)
    SELF.name4_orgid := ri.name4_orgid; // Derived(NEW)
    SELF.name4_orgscore := ri.name4_orgscore; // Derived(NEW)
    SELF.name4_orgweight := ri.name4_orgweight; // Derived(NEW)
    SELF.name4_ultid := ri.name4_ultid; // Derived(NEW)
    SELF.name4_ultscore := ri.name4_ultscore; // Derived(NEW)
    SELF.name4_ultweight := ri.name4_ultweight; // Derived(NEW)
    SELF.name5_nid := ri.name5_nid; // Derived(NEW)
    SELF.name5_prefix := ri.name5_prefix; // Derived(NEW)
    SELF.name5_first := ri.name5_first; // Derived(NEW)
    SELF.name5_middle := ri.name5_middle; // Derived(NEW)
    SELF.name5_last := ri.name5_last; // Derived(NEW)
    SELF.name5_suffix := ri.name5_suffix; // Derived(NEW)
    SELF.name5_company := ri.name5_company; // Derived(NEW)
    SELF.name5_did_score := ri.name5_did_score; // Derived(NEW)
    SELF.name5_did := ri.name5_did; // Derived(NEW)
    SELF.name5_bdid_score := ri.name5_bdid_score; // Derived(NEW)
    SELF.name5_bdid := ri.name5_bdid; // Derived(NEW)
    SELF.name5_dotid := ri.name5_dotid; // Derived(NEW)
    SELF.name5_dotscore := ri.name5_dotscore; // Derived(NEW)
    SELF.name5_dotweight := ri.name5_dotweight; // Derived(NEW)
    SELF.name5_empid := ri.name5_empid; // Derived(NEW)
    SELF.name5_empscore := ri.name5_empscore; // Derived(NEW)
    SELF.name5_empweight := ri.name5_empweight; // Derived(NEW)
    SELF.name5_powid := ri.name5_powid; // Derived(NEW)
    SELF.name5_powscore := ri.name5_powscore; // Derived(NEW)
    SELF.name5_powweight := ri.name5_powweight; // Derived(NEW)
    SELF.name5_proxid := ri.name5_proxid; // Derived(NEW)
    SELF.name5_proxscore := ri.name5_proxscore; // Derived(NEW)
    SELF.name5_proxweight := ri.name5_proxweight; // Derived(NEW)
    SELF.name5_seleid := ri.name5_seleid; // Derived(NEW)
    SELF.name5_selescore := ri.name5_selescore; // Derived(NEW)
    SELF.name5_seleweight := ri.name5_seleweight; // Derived(NEW)
    SELF.name5_orgid := ri.name5_orgid; // Derived(NEW)
    SELF.name5_orgscore := ri.name5_orgscore; // Derived(NEW)
    SELF.name5_orgweight := ri.name5_orgweight; // Derived(NEW)
    SELF.name5_ultid := ri.name5_ultid; // Derived(NEW)
    SELF.name5_ultscore := ri.name5_ultscore; // Derived(NEW)
    SELF.name5_ultweight := ri.name5_ultweight; // Derived(NEW)
    SELF.name6_nid := ri.name6_nid; // Derived(NEW)
    SELF.name6_prefix := ri.name6_prefix; // Derived(NEW)
    SELF.name6_first := ri.name6_first; // Derived(NEW)
    SELF.name6_middle := ri.name6_middle; // Derived(NEW)
    SELF.name6_last := ri.name6_last; // Derived(NEW)
    SELF.name6_suffix := ri.name6_suffix; // Derived(NEW)
    SELF.name6_company := ri.name6_company; // Derived(NEW)
    SELF.name6_did_score := ri.name6_did_score; // Derived(NEW)
    SELF.name6_did := ri.name6_did; // Derived(NEW)
    SELF.name6_bdid_score := ri.name6_bdid_score; // Derived(NEW)
    SELF.name6_bdid := ri.name6_bdid; // Derived(NEW)
    SELF.name6_dotid := ri.name6_dotid; // Derived(NEW)
    SELF.name6_dotscore := ri.name6_dotscore; // Derived(NEW)
    SELF.name6_dotweight := ri.name6_dotweight; // Derived(NEW)
    SELF.name6_empid := ri.name6_empid; // Derived(NEW)
    SELF.name6_empscore := ri.name6_empscore; // Derived(NEW)
    SELF.name6_empweight := ri.name6_empweight; // Derived(NEW)
    SELF.name6_powid := ri.name6_powid; // Derived(NEW)
    SELF.name6_powscore := ri.name6_powscore; // Derived(NEW)
    SELF.name6_powweight := ri.name6_powweight; // Derived(NEW)
    SELF.name6_proxid := ri.name6_proxid; // Derived(NEW)
    SELF.name6_proxscore := ri.name6_proxscore; // Derived(NEW)
    SELF.name6_proxweight := ri.name6_proxweight; // Derived(NEW)
    SELF.name6_seleid := ri.name6_seleid; // Derived(NEW)
    SELF.name6_selescore := ri.name6_selescore; // Derived(NEW)
    SELF.name6_seleweight := ri.name6_seleweight; // Derived(NEW)
    SELF.name6_orgid := ri.name6_orgid; // Derived(NEW)
    SELF.name6_orgscore := ri.name6_orgscore; // Derived(NEW)
    SELF.name6_orgweight := ri.name6_orgweight; // Derived(NEW)
    SELF.name6_ultid := ri.name6_ultid; // Derived(NEW)
    SELF.name6_ultscore := ri.name6_ultscore; // Derived(NEW)
    SELF.name6_ultweight := ri.name6_ultweight; // Derived(NEW)
    SELF.name7_nid := ri.name7_nid; // Derived(NEW)
    SELF.name7_prefix := ri.name7_prefix; // Derived(NEW)
    SELF.name7_first := ri.name7_first; // Derived(NEW)
    SELF.name7_middle := ri.name7_middle; // Derived(NEW)
    SELF.name7_last := ri.name7_last; // Derived(NEW)
    SELF.name7_suffix := ri.name7_suffix; // Derived(NEW)
    SELF.name7_company := ri.name7_company; // Derived(NEW)
    SELF.name7_did_score := ri.name7_did_score; // Derived(NEW)
    SELF.name7_did := ri.name7_did; // Derived(NEW)
    SELF.name7_bdid_score := ri.name7_bdid_score; // Derived(NEW)
    SELF.name7_bdid := ri.name7_bdid; // Derived(NEW)
    SELF.name7_dotid := ri.name7_dotid; // Derived(NEW)
    SELF.name7_dotscore := ri.name7_dotscore; // Derived(NEW)
    SELF.name7_dotweight := ri.name7_dotweight; // Derived(NEW)
    SELF.name7_empid := ri.name7_empid; // Derived(NEW)
    SELF.name7_empscore := ri.name7_empscore; // Derived(NEW)
    SELF.name7_empweight := ri.name7_empweight; // Derived(NEW)
    SELF.name7_powid := ri.name7_powid; // Derived(NEW)
    SELF.name7_powscore := ri.name7_powscore; // Derived(NEW)
    SELF.name7_powweight := ri.name7_powweight; // Derived(NEW)
    SELF.name7_proxid := ri.name7_proxid; // Derived(NEW)
    SELF.name7_proxscore := ri.name7_proxscore; // Derived(NEW)
    SELF.name7_proxweight := ri.name7_proxweight; // Derived(NEW)
    SELF.name7_seleid := ri.name7_seleid; // Derived(NEW)
    SELF.name7_selescore := ri.name7_selescore; // Derived(NEW)
    SELF.name7_seleweight := ri.name7_seleweight; // Derived(NEW)
    SELF.name7_orgid := ri.name7_orgid; // Derived(NEW)
    SELF.name7_orgscore := ri.name7_orgscore; // Derived(NEW)
    SELF.name7_orgweight := ri.name7_orgweight; // Derived(NEW)
    SELF.name7_ultid := ri.name7_ultid; // Derived(NEW)
    SELF.name7_ultscore := ri.name7_ultscore; // Derived(NEW)
    SELF.name7_ultweight := ri.name7_ultweight; // Derived(NEW)
    SELF.name8_nid := ri.name8_nid; // Derived(NEW)
    SELF.name8_prefix := ri.name8_prefix; // Derived(NEW)
    SELF.name8_first := ri.name8_first; // Derived(NEW)
    SELF.name8_middle := ri.name8_middle; // Derived(NEW)
    SELF.name8_last := ri.name8_last; // Derived(NEW)
    SELF.name8_suffix := ri.name8_suffix; // Derived(NEW)
    SELF.name8_company := ri.name8_company; // Derived(NEW)
    SELF.name8_did_score := ri.name8_did_score; // Derived(NEW)
    SELF.name8_did := ri.name8_did; // Derived(NEW)
    SELF.name8_bdid_score := ri.name8_bdid_score; // Derived(NEW)
    SELF.name8_bdid := ri.name8_bdid; // Derived(NEW)
    SELF.name8_dotid := ri.name8_dotid; // Derived(NEW)
    SELF.name8_dotscore := ri.name8_dotscore; // Derived(NEW)
    SELF.name8_dotweight := ri.name8_dotweight; // Derived(NEW)
    SELF.name8_empid := ri.name8_empid; // Derived(NEW)
    SELF.name8_empscore := ri.name8_empscore; // Derived(NEW)
    SELF.name8_empweight := ri.name8_empweight; // Derived(NEW)
    SELF.name8_powid := ri.name8_powid; // Derived(NEW)
    SELF.name8_powscore := ri.name8_powscore; // Derived(NEW)
    SELF.name8_powweight := ri.name8_powweight; // Derived(NEW)
    SELF.name8_proxid := ri.name8_proxid; // Derived(NEW)
    SELF.name8_proxscore := ri.name8_proxscore; // Derived(NEW)
    SELF.name8_proxweight := ri.name8_proxweight; // Derived(NEW)
    SELF.name8_seleid := ri.name8_seleid; // Derived(NEW)
    SELF.name8_selescore := ri.name8_selescore; // Derived(NEW)
    SELF.name8_seleweight := ri.name8_seleweight; // Derived(NEW)
    SELF.name8_orgid := ri.name8_orgid; // Derived(NEW)
    SELF.name8_orgscore := ri.name8_orgscore; // Derived(NEW)
    SELF.name8_orgweight := ri.name8_orgweight; // Derived(NEW)
    SELF.name8_ultid := ri.name8_ultid; // Derived(NEW)
    SELF.name8_ultscore := ri.name8_ultscore; // Derived(NEW)
    SELF.name8_ultweight := ri.name8_ultweight; // Derived(NEW)
    SELF.situs1_rawaid := ri.situs1_rawaid; // Derived(NEW)
    SELF.situs1_prim_range := ri.situs1_prim_range; // Derived(NEW)
    SELF.situs1_predir := ri.situs1_predir; // Derived(NEW)
    SELF.situs1_prim_name := ri.situs1_prim_name; // Derived(NEW)
    SELF.situs1_addr_suffix := ri.situs1_addr_suffix; // Derived(NEW)
    SELF.situs1_postdir := ri.situs1_postdir; // Derived(NEW)
    SELF.situs1_unit_desig := ri.situs1_unit_desig; // Derived(NEW)
    SELF.situs1_sec_range := ri.situs1_sec_range; // Derived(NEW)
    SELF.situs1_p_city_name := ri.situs1_p_city_name; // Derived(NEW)
    SELF.situs1_v_city_name := ri.situs1_v_city_name; // Derived(NEW)
    SELF.situs1_st := ri.situs1_st; // Derived(NEW)
    SELF.situs1_zip := ri.situs1_zip; // Derived(NEW)
    SELF.situs1_zip4 := ri.situs1_zip4; // Derived(NEW)
    SELF.situs1_cart := ri.situs1_cart; // Derived(NEW)
    SELF.situs1_cr_sort_sz := ri.situs1_cr_sort_sz; // Derived(NEW)
    SELF.situs1_lot := ri.situs1_lot; // Derived(NEW)
    SELF.situs1_lot_order := ri.situs1_lot_order; // Derived(NEW)
    SELF.situs1_dpbc := ri.situs1_dpbc; // Derived(NEW)
    SELF.situs1_chk_digit := ri.situs1_chk_digit; // Derived(NEW)
    SELF.situs1_record_type := ri.situs1_record_type; // Derived(NEW)
    SELF.situs1_ace_fips_st := ri.situs1_ace_fips_st; // Derived(NEW)
    SELF.situs1_fipscounty := ri.situs1_fipscounty; // Derived(NEW)
    SELF.situs1_geo_lat := ri.situs1_geo_lat; // Derived(NEW)
    SELF.situs1_geo_long := ri.situs1_geo_long; // Derived(NEW)
    SELF.situs1_msa := ri.situs1_msa; // Derived(NEW)
    SELF.situs1_geo_blk := ri.situs1_geo_blk; // Derived(NEW)
    SELF.situs1_geo_match := ri.situs1_geo_match; // Derived(NEW)
    SELF.situs1_err_stat := ri.situs1_err_stat; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported OR SELF.process_date <> le.process_date OR SELF.ln_filedate <> le.ln_filedate => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn));
  SortIngest0 := SORT(DistIngest0,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn, __Tpe, record_id, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn));
  SortBase0 := SORT(DistBase0,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn, __Tpe, record_id, LOCAL);
  GroupBase0 := GROUP(SortBase0,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn, __Tpe,record_id,LOCAL);
  Group0 := GROUP(Sort0,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number
             ,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr
             ,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr
             ,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname
             ,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book
             ,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt
             ,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type
             ,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,record_id);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.record_id := IF ( le.record_id=0, PrevBase+1+thorlib.node(), le.record_id+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(record_id=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(record_id<>0) : PERSIST('~temp::BKForeclosure::NOD_Ingest_Cache',EXPIRE(BKForeclosure.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('NODUpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,NOD_Layout_BKForeclosure);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,NOD_Layout_BKForeclosure);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,NOD_Layout_BKForeclosure);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,NOD_Layout_BKForeclosure); // Records in 'pure' format
 
f := TABLE(dsBase,{record_id}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,record_id);
DuplicateRids0 := COUNT(dsBase) - SUM(rcid_clusters,NumberOfClusters); // Should be zero
d := DATASET([{DuplicateRids0}],{UNSIGNED2 DuplicateRids0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
  EXPORT DoStats := S0;
 
  EXPORT StandardStats(BOOLEAN doInfileOverallCnt = TRUE, BOOLEAN doStatusOverallCnt = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    infileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(FilesToIngest), 'Infile', myTimeStamp));
    basefileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(dsBase), 'Basefile', myTimeStamp));
    deltaCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(Delta), 'Deltafile', myTimeStamp));
    ingestStatusOverall := IF(doStatusOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStats,, myTimeStamp));
    standardStats := infileCntOverall & basefileCntOverall & ingestStatusOverall;
    RETURN standardStats;
  END;
END;
