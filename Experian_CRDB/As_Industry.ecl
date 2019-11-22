IMPORT TopBusiness_BIPV2, ut, _Validate, MDR;

dsExperian_CRDB := Experian_CRDB.Files().base.qa;

Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

Industry_Layout_seq := RECORD
  INTEGER1 seq := 0;
  Industry_Layout;
END;

Industry_Layout_seq Norm_Industry(dsExperian_CRDB L, INTEGER C) := TRANSFORM
  SELF.bdid                      := (UNSIGNED) L.bdid;
  SELF.bdid_score                := L.bdid_score;
  SELF.source                    := MDR.sourceTools.src_Experian_CRDB;
  SELF.source_docid              := TRIM(L.experian_bus_id,LEFT,RIGHT);
  SELF.source_rec_id             := L.source_rec_id;          
  SELF.siccode                   := CHOOSE(C, L.primary_sic_code_4_digit, L.primary_sic_code, L.second_sic_code, L.third_sic_code,
                                              L.fourth_sic_code, L.fifth_sic_code, L.sixth_sic_code,
                                              '', '', '', ''); 
  SELF.naics                     := CHOOSE(C, '', '', '', '', '', '', '',
                                              L.primary_naics_code, L.second_naics_code, L.third_naics_code, L.fourth_naics_code); 
  SELF.industry_description      := TRIM(L.primary_sic_code_industry_class_desc,LEFT,RIGHT);
  SELF.business_description      := '';
  SELF.dt_first_seen             := (UNSIGNED)L.dt_first_seen;
  SELF.dt_last_seen              := (UNSIGNED)L.dt_last_seen;
  SELF.dt_vendor_first_reported  := (UNSIGNED)L.dt_vendor_first_reported;
  SELF.dt_vendor_last_reported   := (UNSIGNED)L.dt_vendor_last_reported;
  SELF.record_type               := L.recent_update_code;
  SELF.record_date               := (UNSIGNED)L.latest_reported_date;
  SELF                           := L; 
  SELF                           := [];
END;				

dsExperian_CRDB_norm := NORMALIZE(dsExperian_CRDB,11,Norm_Industry(LEFT,COUNTER));
	
dsExperian_CRDB_dist   := DISTRIBUTE(dsExperian_CRDB_norm(siccode <> '' OR naics <> ''), HASH64(source_rec_id, source_docid));
dsExperian_CRDB_sort   := SORT(dsExperian_CRDB_dist, source_rec_id, 
                                                     source_docid,
                                                     bdid,
                                                     siccode,
                                                     naics,
                                                     industry_description,
                                                     -dt_vendor_last_reported,
                                                     -record_date,
                                                     -dt_last_seen,
                                                     LOCAL);
dsExperian_CRDB_dedup  := DEDUP(dsExperian_CRDB_sort, RECORD, LOCAL);

dsExperian_CRDB_SIC    := dsExperian_CRDB_dedup(siccode <> '');
dsExperian_CRDB_NAICS  := dsExperian_CRDB_dedup(naics <> '');

dsExperian_CRDB_SIC_group    := GROUP(dsExperian_CRDB_SIC, EXCEPT siccode, naics, LOCAL);
dsExperian_CRDB_NAICS_group  := GROUP(dsExperian_CRDB_NAICS, EXCEPT siccode, naics, LOCAL);

Industry_Layout_seq assign_seq(Industry_Layout_seq L, Industry_Layout_seq R) := TRANSFORM
    SELF.seq := L.seq +1;
    SELF     := R;
END;

dsExperian_CRDB_SIC_seq   := ITERATE(dsExperian_CRDB_SIC_group, assign_seq(LEFT, RIGHT));
dsExperian_CRDB_NAICS_seq := ITERATE(dsExperian_CRDB_NAICS_group, assign_seq(LEFT, RIGHT));

dsExperian_CRDB_final         := dsExperian_CRDB_SIC_seq + dsExperian_CRDB_NAICS_seq;
dsExperian_CRDB_final_dist    := DISTRIBUTE(dsExperian_CRDB_final, HASH(source_rec_id, source_docid));
dsExperian_CRDB_final_sort    := SORT(dsExperian_CRDB_final_dist, EXCEPT siccode, naics, LOCAL);

Industry_Layout_seq Experian_CRDB_rollup(Industry_Layout_seq L, Industry_Layout_seq R) := TRANSFORM
  SELF.siccode                  := IF(L.siccode <> '', L.siccode, R.siccode);
  SELF.naics                    := IF(L.naics <> '', L.naics, R.naics);
  SELF.dt_first_seen 						:= ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
  SELF.dt_last_seen							:= Max(L.dt_last_seen, R.dt_last_seen);
  SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
  SELF.dt_vendor_last_reported 	:= Max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
  SELF.record_date							:= Max(L.record_date, R.record_date);
  SELF                          := L;
END;

dsExperian_CRDB_rollup := ROLLUP(dsExperian_CRDB_final_sort, 
                                 LEFT.seq = RIGHT.seq AND
                                 LEFT.bdid = RIGHT.bdid AND
                                 LEFT.source_docid = RIGHT.source_docid AND
                                 LEFT.source_rec_id = RIGHT.source_rec_id AND
                                 LEFT.industry_description = RIGHT.industry_description AND
                                 LEFT.record_type = RIGHT.record_type,
                                 Experian_CRDB_rollup(LEFT, RIGHT),
                                 LOCAL);

EXPORT As_Industry := PROJECT(dsExperian_CRDB_rollup, Industry_Layout);