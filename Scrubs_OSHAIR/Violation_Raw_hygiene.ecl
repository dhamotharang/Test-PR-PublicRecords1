IMPORT SALT311,STD;
EXPORT Violation_Raw_hygiene(dataset(Violation_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_activity_nr_cnt := COUNT(GROUP,h.activity_nr <> (TYPEOF(h.activity_nr))'');
    populated_activity_nr_pcnt := AVE(GROUP,IF(h.activity_nr = (TYPEOF(h.activity_nr))'',0,100));
    maxlength_activity_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)));
    avelength_activity_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)),h.activity_nr<>(typeof(h.activity_nr))'');
    populated_citation_id_cnt := COUNT(GROUP,h.citation_id <> (TYPEOF(h.citation_id))'');
    populated_citation_id_pcnt := AVE(GROUP,IF(h.citation_id = (TYPEOF(h.citation_id))'',0,100));
    maxlength_citation_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.citation_id)));
    avelength_citation_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.citation_id)),h.citation_id<>(typeof(h.citation_id))'');
    populated_delete_flag_cnt := COUNT(GROUP,h.delete_flag <> (TYPEOF(h.delete_flag))'');
    populated_delete_flag_pcnt := AVE(GROUP,IF(h.delete_flag = (TYPEOF(h.delete_flag))'',0,100));
    maxlength_delete_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.delete_flag)));
    avelength_delete_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.delete_flag)),h.delete_flag<>(typeof(h.delete_flag))'');
    populated_viol_type_cnt := COUNT(GROUP,h.viol_type <> (TYPEOF(h.viol_type))'');
    populated_viol_type_pcnt := AVE(GROUP,IF(h.viol_type = (TYPEOF(h.viol_type))'',0,100));
    maxlength_viol_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.viol_type)));
    avelength_viol_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.viol_type)),h.viol_type<>(typeof(h.viol_type))'');
    populated_issuance_date_cnt := COUNT(GROUP,h.issuance_date <> (TYPEOF(h.issuance_date))'');
    populated_issuance_date_pcnt := AVE(GROUP,IF(h.issuance_date = (TYPEOF(h.issuance_date))'',0,100));
    maxlength_issuance_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.issuance_date)));
    avelength_issuance_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.issuance_date)),h.issuance_date<>(typeof(h.issuance_date))'');
    populated_abate_date_cnt := COUNT(GROUP,h.abate_date <> (TYPEOF(h.abate_date))'');
    populated_abate_date_pcnt := AVE(GROUP,IF(h.abate_date = (TYPEOF(h.abate_date))'',0,100));
    maxlength_abate_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.abate_date)));
    avelength_abate_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.abate_date)),h.abate_date<>(typeof(h.abate_date))'');
    populated_current_penalty_cnt := COUNT(GROUP,h.current_penalty <> (TYPEOF(h.current_penalty))'');
    populated_current_penalty_pcnt := AVE(GROUP,IF(h.current_penalty = (TYPEOF(h.current_penalty))'',0,100));
    maxlength_current_penalty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_penalty)));
    avelength_current_penalty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_penalty)),h.current_penalty<>(typeof(h.current_penalty))'');
    populated_initial_penalty_cnt := COUNT(GROUP,h.initial_penalty <> (TYPEOF(h.initial_penalty))'');
    populated_initial_penalty_pcnt := AVE(GROUP,IF(h.initial_penalty = (TYPEOF(h.initial_penalty))'',0,100));
    maxlength_initial_penalty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initial_penalty)));
    avelength_initial_penalty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initial_penalty)),h.initial_penalty<>(typeof(h.initial_penalty))'');
    populated_contest_date_cnt := COUNT(GROUP,h.contest_date <> (TYPEOF(h.contest_date))'');
    populated_contest_date_pcnt := AVE(GROUP,IF(h.contest_date = (TYPEOF(h.contest_date))'',0,100));
    maxlength_contest_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contest_date)));
    avelength_contest_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contest_date)),h.contest_date<>(typeof(h.contest_date))'');
    populated_final_order_date_cnt := COUNT(GROUP,h.final_order_date <> (TYPEOF(h.final_order_date))'');
    populated_final_order_date_pcnt := AVE(GROUP,IF(h.final_order_date = (TYPEOF(h.final_order_date))'',0,100));
    maxlength_final_order_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.final_order_date)));
    avelength_final_order_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.final_order_date)),h.final_order_date<>(typeof(h.final_order_date))'');
    populated_nr_instances_cnt := COUNT(GROUP,h.nr_instances <> (TYPEOF(h.nr_instances))'');
    populated_nr_instances_pcnt := AVE(GROUP,IF(h.nr_instances = (TYPEOF(h.nr_instances))'',0,100));
    maxlength_nr_instances := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nr_instances)));
    avelength_nr_instances := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nr_instances)),h.nr_instances<>(typeof(h.nr_instances))'');
    populated_nr_exposed_cnt := COUNT(GROUP,h.nr_exposed <> (TYPEOF(h.nr_exposed))'');
    populated_nr_exposed_pcnt := AVE(GROUP,IF(h.nr_exposed = (TYPEOF(h.nr_exposed))'',0,100));
    maxlength_nr_exposed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nr_exposed)));
    avelength_nr_exposed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nr_exposed)),h.nr_exposed<>(typeof(h.nr_exposed))'');
    populated_rec_cnt := COUNT(GROUP,h.rec <> (TYPEOF(h.rec))'');
    populated_rec_pcnt := AVE(GROUP,IF(h.rec = (TYPEOF(h.rec))'',0,100));
    maxlength_rec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec)));
    avelength_rec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec)),h.rec<>(typeof(h.rec))'');
    populated_gravity_cnt := COUNT(GROUP,h.gravity <> (TYPEOF(h.gravity))'');
    populated_gravity_pcnt := AVE(GROUP,IF(h.gravity = (TYPEOF(h.gravity))'',0,100));
    maxlength_gravity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gravity)));
    avelength_gravity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gravity)),h.gravity<>(typeof(h.gravity))'');
    populated_emphasis_cnt := COUNT(GROUP,h.emphasis <> (TYPEOF(h.emphasis))'');
    populated_emphasis_pcnt := AVE(GROUP,IF(h.emphasis = (TYPEOF(h.emphasis))'',0,100));
    maxlength_emphasis := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emphasis)));
    avelength_emphasis := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emphasis)),h.emphasis<>(typeof(h.emphasis))'');
    populated_hazcat_cnt := COUNT(GROUP,h.hazcat <> (TYPEOF(h.hazcat))'');
    populated_hazcat_pcnt := AVE(GROUP,IF(h.hazcat = (TYPEOF(h.hazcat))'',0,100));
    maxlength_hazcat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazcat)));
    avelength_hazcat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazcat)),h.hazcat<>(typeof(h.hazcat))'');
    populated_fta_insp_nr_cnt := COUNT(GROUP,h.fta_insp_nr <> (TYPEOF(h.fta_insp_nr))'');
    populated_fta_insp_nr_pcnt := AVE(GROUP,IF(h.fta_insp_nr = (TYPEOF(h.fta_insp_nr))'',0,100));
    maxlength_fta_insp_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_insp_nr)));
    avelength_fta_insp_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_insp_nr)),h.fta_insp_nr<>(typeof(h.fta_insp_nr))'');
    populated_fta_issuance_date_cnt := COUNT(GROUP,h.fta_issuance_date <> (TYPEOF(h.fta_issuance_date))'');
    populated_fta_issuance_date_pcnt := AVE(GROUP,IF(h.fta_issuance_date = (TYPEOF(h.fta_issuance_date))'',0,100));
    maxlength_fta_issuance_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_issuance_date)));
    avelength_fta_issuance_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_issuance_date)),h.fta_issuance_date<>(typeof(h.fta_issuance_date))'');
    populated_fta_penalty_cnt := COUNT(GROUP,h.fta_penalty <> (TYPEOF(h.fta_penalty))'');
    populated_fta_penalty_pcnt := AVE(GROUP,IF(h.fta_penalty = (TYPEOF(h.fta_penalty))'',0,100));
    maxlength_fta_penalty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_penalty)));
    avelength_fta_penalty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_penalty)),h.fta_penalty<>(typeof(h.fta_penalty))'');
    populated_fta_contest_date_cnt := COUNT(GROUP,h.fta_contest_date <> (TYPEOF(h.fta_contest_date))'');
    populated_fta_contest_date_pcnt := AVE(GROUP,IF(h.fta_contest_date = (TYPEOF(h.fta_contest_date))'',0,100));
    maxlength_fta_contest_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_contest_date)));
    avelength_fta_contest_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_contest_date)),h.fta_contest_date<>(typeof(h.fta_contest_date))'');
    populated_fta_final_order_date_cnt := COUNT(GROUP,h.fta_final_order_date <> (TYPEOF(h.fta_final_order_date))'');
    populated_fta_final_order_date_pcnt := AVE(GROUP,IF(h.fta_final_order_date = (TYPEOF(h.fta_final_order_date))'',0,100));
    maxlength_fta_final_order_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_final_order_date)));
    avelength_fta_final_order_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fta_final_order_date)),h.fta_final_order_date<>(typeof(h.fta_final_order_date))'');
    populated_hazsub1_cnt := COUNT(GROUP,h.hazsub1 <> (TYPEOF(h.hazsub1))'');
    populated_hazsub1_pcnt := AVE(GROUP,IF(h.hazsub1 = (TYPEOF(h.hazsub1))'',0,100));
    maxlength_hazsub1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub1)));
    avelength_hazsub1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub1)),h.hazsub1<>(typeof(h.hazsub1))'');
    populated_hazsub2_cnt := COUNT(GROUP,h.hazsub2 <> (TYPEOF(h.hazsub2))'');
    populated_hazsub2_pcnt := AVE(GROUP,IF(h.hazsub2 = (TYPEOF(h.hazsub2))'',0,100));
    maxlength_hazsub2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub2)));
    avelength_hazsub2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub2)),h.hazsub2<>(typeof(h.hazsub2))'');
    populated_hazsub3_cnt := COUNT(GROUP,h.hazsub3 <> (TYPEOF(h.hazsub3))'');
    populated_hazsub3_pcnt := AVE(GROUP,IF(h.hazsub3 = (TYPEOF(h.hazsub3))'',0,100));
    maxlength_hazsub3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub3)));
    avelength_hazsub3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub3)),h.hazsub3<>(typeof(h.hazsub3))'');
    populated_hazsub4_cnt := COUNT(GROUP,h.hazsub4 <> (TYPEOF(h.hazsub4))'');
    populated_hazsub4_pcnt := AVE(GROUP,IF(h.hazsub4 = (TYPEOF(h.hazsub4))'',0,100));
    maxlength_hazsub4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub4)));
    avelength_hazsub4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub4)),h.hazsub4<>(typeof(h.hazsub4))'');
    populated_hazsub5_cnt := COUNT(GROUP,h.hazsub5 <> (TYPEOF(h.hazsub5))'');
    populated_hazsub5_pcnt := AVE(GROUP,IF(h.hazsub5 = (TYPEOF(h.hazsub5))'',0,100));
    maxlength_hazsub5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub5)));
    avelength_hazsub5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub5)),h.hazsub5<>(typeof(h.hazsub5))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_activity_nr_pcnt *   0.00 / 100 + T.Populated_citation_id_pcnt *   0.00 / 100 + T.Populated_delete_flag_pcnt *   0.00 / 100 + T.Populated_viol_type_pcnt *   0.00 / 100 + T.Populated_issuance_date_pcnt *   0.00 / 100 + T.Populated_abate_date_pcnt *   0.00 / 100 + T.Populated_current_penalty_pcnt *   0.00 / 100 + T.Populated_initial_penalty_pcnt *   0.00 / 100 + T.Populated_contest_date_pcnt *   0.00 / 100 + T.Populated_final_order_date_pcnt *   0.00 / 100 + T.Populated_nr_instances_pcnt *   0.00 / 100 + T.Populated_nr_exposed_pcnt *   0.00 / 100 + T.Populated_rec_pcnt *   0.00 / 100 + T.Populated_gravity_pcnt *   0.00 / 100 + T.Populated_emphasis_pcnt *   0.00 / 100 + T.Populated_hazcat_pcnt *   0.00 / 100 + T.Populated_fta_insp_nr_pcnt *   0.00 / 100 + T.Populated_fta_issuance_date_pcnt *   0.00 / 100 + T.Populated_fta_penalty_pcnt *   0.00 / 100 + T.Populated_fta_contest_date_pcnt *   0.00 / 100 + T.Populated_fta_final_order_date_pcnt *   0.00 / 100 + T.Populated_hazsub1_pcnt *   0.00 / 100 + T.Populated_hazsub2_pcnt *   0.00 / 100 + T.Populated_hazsub3_pcnt *   0.00 / 100 + T.Populated_hazsub4_pcnt *   0.00 / 100 + T.Populated_hazsub5_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'activity_nr','citation_id','delete_flag','viol_type','issuance_date','abate_date','current_penalty','initial_penalty','contest_date','final_order_date','nr_instances','nr_exposed','rec','gravity','emphasis','hazcat','fta_insp_nr','fta_issuance_date','fta_penalty','fta_contest_date','fta_final_order_date','hazsub1','hazsub2','hazsub3','hazsub4','hazsub5');
  SELF.populated_pcnt := CHOOSE(C,le.populated_activity_nr_pcnt,le.populated_citation_id_pcnt,le.populated_delete_flag_pcnt,le.populated_viol_type_pcnt,le.populated_issuance_date_pcnt,le.populated_abate_date_pcnt,le.populated_current_penalty_pcnt,le.populated_initial_penalty_pcnt,le.populated_contest_date_pcnt,le.populated_final_order_date_pcnt,le.populated_nr_instances_pcnt,le.populated_nr_exposed_pcnt,le.populated_rec_pcnt,le.populated_gravity_pcnt,le.populated_emphasis_pcnt,le.populated_hazcat_pcnt,le.populated_fta_insp_nr_pcnt,le.populated_fta_issuance_date_pcnt,le.populated_fta_penalty_pcnt,le.populated_fta_contest_date_pcnt,le.populated_fta_final_order_date_pcnt,le.populated_hazsub1_pcnt,le.populated_hazsub2_pcnt,le.populated_hazsub3_pcnt,le.populated_hazsub4_pcnt,le.populated_hazsub5_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_activity_nr,le.maxlength_citation_id,le.maxlength_delete_flag,le.maxlength_viol_type,le.maxlength_issuance_date,le.maxlength_abate_date,le.maxlength_current_penalty,le.maxlength_initial_penalty,le.maxlength_contest_date,le.maxlength_final_order_date,le.maxlength_nr_instances,le.maxlength_nr_exposed,le.maxlength_rec,le.maxlength_gravity,le.maxlength_emphasis,le.maxlength_hazcat,le.maxlength_fta_insp_nr,le.maxlength_fta_issuance_date,le.maxlength_fta_penalty,le.maxlength_fta_contest_date,le.maxlength_fta_final_order_date,le.maxlength_hazsub1,le.maxlength_hazsub2,le.maxlength_hazsub3,le.maxlength_hazsub4,le.maxlength_hazsub5);
  SELF.avelength := CHOOSE(C,le.avelength_activity_nr,le.avelength_citation_id,le.avelength_delete_flag,le.avelength_viol_type,le.avelength_issuance_date,le.avelength_abate_date,le.avelength_current_penalty,le.avelength_initial_penalty,le.avelength_contest_date,le.avelength_final_order_date,le.avelength_nr_instances,le.avelength_nr_exposed,le.avelength_rec,le.avelength_gravity,le.avelength_emphasis,le.avelength_hazcat,le.avelength_fta_insp_nr,le.avelength_fta_issuance_date,le.avelength_fta_penalty,le.avelength_fta_contest_date,le.avelength_fta_final_order_date,le.avelength_hazsub1,le.avelength_hazsub2,le.avelength_hazsub3,le.avelength_hazsub4,le.avelength_hazsub5);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.citation_id),TRIM((SALT311.StrType)le.delete_flag),TRIM((SALT311.StrType)le.viol_type),TRIM((SALT311.StrType)le.issuance_date),TRIM((SALT311.StrType)le.abate_date),TRIM((SALT311.StrType)le.current_penalty),TRIM((SALT311.StrType)le.initial_penalty),TRIM((SALT311.StrType)le.contest_date),TRIM((SALT311.StrType)le.final_order_date),TRIM((SALT311.StrType)le.nr_instances),TRIM((SALT311.StrType)le.nr_exposed),TRIM((SALT311.StrType)le.rec),TRIM((SALT311.StrType)le.gravity),TRIM((SALT311.StrType)le.emphasis),TRIM((SALT311.StrType)le.hazcat),TRIM((SALT311.StrType)le.fta_insp_nr),TRIM((SALT311.StrType)le.fta_issuance_date),TRIM((SALT311.StrType)le.fta_penalty),TRIM((SALT311.StrType)le.fta_contest_date),TRIM((SALT311.StrType)le.fta_final_order_date),TRIM((SALT311.StrType)le.hazsub1),TRIM((SALT311.StrType)le.hazsub2),TRIM((SALT311.StrType)le.hazsub3),TRIM((SALT311.StrType)le.hazsub4),TRIM((SALT311.StrType)le.hazsub5)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.citation_id),TRIM((SALT311.StrType)le.delete_flag),TRIM((SALT311.StrType)le.viol_type),TRIM((SALT311.StrType)le.issuance_date),TRIM((SALT311.StrType)le.abate_date),TRIM((SALT311.StrType)le.current_penalty),TRIM((SALT311.StrType)le.initial_penalty),TRIM((SALT311.StrType)le.contest_date),TRIM((SALT311.StrType)le.final_order_date),TRIM((SALT311.StrType)le.nr_instances),TRIM((SALT311.StrType)le.nr_exposed),TRIM((SALT311.StrType)le.rec),TRIM((SALT311.StrType)le.gravity),TRIM((SALT311.StrType)le.emphasis),TRIM((SALT311.StrType)le.hazcat),TRIM((SALT311.StrType)le.fta_insp_nr),TRIM((SALT311.StrType)le.fta_issuance_date),TRIM((SALT311.StrType)le.fta_penalty),TRIM((SALT311.StrType)le.fta_contest_date),TRIM((SALT311.StrType)le.fta_final_order_date),TRIM((SALT311.StrType)le.hazsub1),TRIM((SALT311.StrType)le.hazsub2),TRIM((SALT311.StrType)le.hazsub3),TRIM((SALT311.StrType)le.hazsub4),TRIM((SALT311.StrType)le.hazsub5)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.citation_id),TRIM((SALT311.StrType)le.delete_flag),TRIM((SALT311.StrType)le.viol_type),TRIM((SALT311.StrType)le.issuance_date),TRIM((SALT311.StrType)le.abate_date),TRIM((SALT311.StrType)le.current_penalty),TRIM((SALT311.StrType)le.initial_penalty),TRIM((SALT311.StrType)le.contest_date),TRIM((SALT311.StrType)le.final_order_date),TRIM((SALT311.StrType)le.nr_instances),TRIM((SALT311.StrType)le.nr_exposed),TRIM((SALT311.StrType)le.rec),TRIM((SALT311.StrType)le.gravity),TRIM((SALT311.StrType)le.emphasis),TRIM((SALT311.StrType)le.hazcat),TRIM((SALT311.StrType)le.fta_insp_nr),TRIM((SALT311.StrType)le.fta_issuance_date),TRIM((SALT311.StrType)le.fta_penalty),TRIM((SALT311.StrType)le.fta_contest_date),TRIM((SALT311.StrType)le.fta_final_order_date),TRIM((SALT311.StrType)le.hazsub1),TRIM((SALT311.StrType)le.hazsub2),TRIM((SALT311.StrType)le.hazsub3),TRIM((SALT311.StrType)le.hazsub4),TRIM((SALT311.StrType)le.hazsub5)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'activity_nr'}
      ,{2,'citation_id'}
      ,{3,'delete_flag'}
      ,{4,'viol_type'}
      ,{5,'issuance_date'}
      ,{6,'abate_date'}
      ,{7,'current_penalty'}
      ,{8,'initial_penalty'}
      ,{9,'contest_date'}
      ,{10,'final_order_date'}
      ,{11,'nr_instances'}
      ,{12,'nr_exposed'}
      ,{13,'rec'}
      ,{14,'gravity'}
      ,{15,'emphasis'}
      ,{16,'hazcat'}
      ,{17,'fta_insp_nr'}
      ,{18,'fta_issuance_date'}
      ,{19,'fta_penalty'}
      ,{20,'fta_contest_date'}
      ,{21,'fta_final_order_date'}
      ,{22,'hazsub1'}
      ,{23,'hazsub2'}
      ,{24,'hazsub3'}
      ,{25,'hazsub4'}
      ,{26,'hazsub5'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Violation_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr),
    Violation_Raw_Fields.InValid_citation_id((SALT311.StrType)le.citation_id),
    Violation_Raw_Fields.InValid_delete_flag((SALT311.StrType)le.delete_flag),
    Violation_Raw_Fields.InValid_viol_type((SALT311.StrType)le.viol_type),
    Violation_Raw_Fields.InValid_issuance_date((SALT311.StrType)le.issuance_date),
    Violation_Raw_Fields.InValid_abate_date((SALT311.StrType)le.abate_date),
    Violation_Raw_Fields.InValid_current_penalty((SALT311.StrType)le.current_penalty),
    Violation_Raw_Fields.InValid_initial_penalty((SALT311.StrType)le.initial_penalty),
    Violation_Raw_Fields.InValid_contest_date((SALT311.StrType)le.contest_date),
    Violation_Raw_Fields.InValid_final_order_date((SALT311.StrType)le.final_order_date),
    Violation_Raw_Fields.InValid_nr_instances((SALT311.StrType)le.nr_instances),
    Violation_Raw_Fields.InValid_nr_exposed((SALT311.StrType)le.nr_exposed),
    Violation_Raw_Fields.InValid_rec((SALT311.StrType)le.rec),
    Violation_Raw_Fields.InValid_gravity((SALT311.StrType)le.gravity),
    Violation_Raw_Fields.InValid_emphasis((SALT311.StrType)le.emphasis),
    Violation_Raw_Fields.InValid_hazcat((SALT311.StrType)le.hazcat),
    Violation_Raw_Fields.InValid_fta_insp_nr((SALT311.StrType)le.fta_insp_nr),
    Violation_Raw_Fields.InValid_fta_issuance_date((SALT311.StrType)le.fta_issuance_date),
    Violation_Raw_Fields.InValid_fta_penalty((SALT311.StrType)le.fta_penalty),
    Violation_Raw_Fields.InValid_fta_contest_date((SALT311.StrType)le.fta_contest_date),
    Violation_Raw_Fields.InValid_fta_final_order_date((SALT311.StrType)le.fta_final_order_date),
    Violation_Raw_Fields.InValid_hazsub1((SALT311.StrType)le.hazsub1),
    Violation_Raw_Fields.InValid_hazsub2((SALT311.StrType)le.hazsub2),
    Violation_Raw_Fields.InValid_hazsub3((SALT311.StrType)le.hazsub3),
    Violation_Raw_Fields.InValid_hazsub4((SALT311.StrType)le.hazsub4),
    Violation_Raw_Fields.InValid_hazsub5((SALT311.StrType)le.hazsub5),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Violation_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_alpha_numeric','Invalid_X','Invalid_viol_type','invalid_date_ccyymm','invalid_date_future','invalid_numeric_or_period','invalid_numeric_or_period','invalid_date_ccyymm','invalid_date_future','invalid_numeric_blank','invalid_numeric_blank','Invalid_rec','invalid_numeric_blank','Invalid_X','invalid_alpha_blank','invalid_numeric_blank','invalid_date_ccyymm','invalid_numeric_or_period','invalid_date_ccyymm','invalid_date_ccyymm','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Violation_Raw_Fields.InValidMessage_activity_nr(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_citation_id(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_delete_flag(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_viol_type(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_issuance_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_abate_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_current_penalty(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_initial_penalty(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_contest_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_final_order_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_nr_instances(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_nr_exposed(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_rec(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_gravity(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_emphasis(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_hazcat(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_fta_insp_nr(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_fta_issuance_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_fta_penalty(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_fta_contest_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_fta_final_order_date(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_hazsub1(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_hazsub2(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_hazsub3(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_hazsub4(TotalErrors.ErrorNum),Violation_Raw_Fields.InValidMessage_hazsub5(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, Violation_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
