IMPORT data_services, STD;

EXPORT log := MODULE

  EXPORT DOMAIN := 'P'; // P-Public Records, H-Healthcare, I-Insurance

  EXPORT clean_query_name := FUNCTION
    q_name := STD.Str.ToLowerCase(STD.System.Job.Name());
    idx := STD.Str.Find(q_name,'.',2) - 1; // removing appended version number.
    RETURN IF(idx > 0, q_name[1..idx], q_name);
  END;

  EXPORT layout_sold_to_sources_common := RECORD
    unsigned6 did;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;

  EXPORT layout_log_sold_to_transactions_rec := RECORD
    string30 transaction_id;
    string1 domain;
    string80 query_name;
    integer mbs_gcid;
    unsigned1 fcra;
    unsigned1 glba_use;
    unsigned1 dppa_use;
    unsigned1 hipaa;
  END;

  EXPORT layout_log_sold_to_transactions := RECORD
    DATASET(layout_log_sold_to_transactions_rec) records {XPATH('Records/Rec'), MAXCOUNT(1)};
  END;

  EXPORT layout_log_sold_to_sources_rec := RECORD
    string30 transaction_id;
    unsigned6 LexID;
    utf8 source_list; /* JSON format: [{“S”:1234}, {“S”:1235,”R”:666},{“S”:1237}] */
  END;

  EXPORT layout_log_sold_to_sources := RECORD
    DATASET(layout_log_sold_to_sources_rec) records {XPATH('Records/Rec')};
  END;

  EXPORT layout_log_record_internal := RECORD
    layout_log_sold_to_sources_rec;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;

  EXPORT logSoldToSources(ds_in, mod_access, did_field='did') := FUNCTIONMACRO

    rec_log := doxie.log.layout_log_record_internal;
    rec_log toLogFormat (RECORDOF (ds_in) L) := TRANSFORM
      l_lexid :=  (unsigned6) L.did_field;
      SELF.transaction_id := mod_access.transaction_id;
      SELF.LexID := l_lexid;
      SELF.global_sid:= L.global_sid;
      SELF.record_sid := IF (l_lexid = 0, L.record_sid, 0); // if we have a lexid, we only need to log source ids
      SELF.source_list := IF(l_lexid = 0,
        '{'+TOJSON(ROW({L.global_sid, L.record_sid}, {unsigned4 S; unsigned8 R;}))+'}',
        '{'+TOJSON(ROW({L.global_sid}, {unsigned4 S;}))+'}');
    END;
    ds_slim := PROJECT (ds_in, toLogFormat(LEFT));
    ds_ddp := DEDUP(SORT (ds_slim, LexID, global_sid, record_sid), LexID, global_sid, record_sid);

    rec_log rollToLog (rec_log L, rec_log R) := TRANSFORM
       SELF.source_list := IF (L.source_list != '',
          L.source_list + IF(R.source_list != '', ','+R.source_list, ''),
          R.source_list);
      SELF := L;
    END;
    ds_sold_to_sources := PROJECT(
      ROLLUP(ds_ddp, LEFT.LexID > 0 AND LEFT.LexID = RIGHT.LexID, rollToLog(LEFT, RIGHT))
      , TRANSFORM(doxie.log.layout_log_sold_to_sources_rec,
          SELF.source_list := '[' + LEFT.source_list + ']';
          SELF := LEFT;
        ));
    ds_log_sold_to_sources := DATASET([{ds_sold_to_sources}], doxie.log.layout_log_sold_to_sources);

    // Below we should really be doing ds_in(global_sid<>0) to avoid logging "empty" records.
    // It would also take care of cases where we may log empty records after 'left outer' joins.
    // TODO: replace this later, once data team starts populating global_sids.
    RETURN IF(mod_access.log_record_source AND exists(ds_in),
      OUTPUT(ds_log_sold_to_sources, NAMED('FILE_privacy__logs_sold__to__sources'), EXTEND));

  ENDMACRO;

  EXPORT logSoldToTransaction(mod_access, env_flag = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

    IMPORT doxie, data_services, STD;

    // absolutely no uniquenames as this macro must always be called just once
    doxie.log.layout_log_sold_to_transactions_rec toLogFormat() := TRANSFORM
      SELF.transaction_id :=  mod_access.transaction_id;
      SELF.domain := doxie.log.DOMAIN;
      SELF.query_name := doxie.log.clean_query_name;
      SELF.mbs_gcid := mod_access.global_company_id;
      SELF.fcra := IF(env_flag = Data_Services.data_env.iFCRA, 1, 0);
      SELF.hipaa := IF(env_flag = Data_Services.data_env.iHIPAA, 1, 0);
      SELF.glba_use := mod_access.glb;
      SELF.dppa_use := mod_access.dppa;
    END;
    ds_log_transaction_rec := DATASET([toLogFormat()]);
    ds_log_transaction := DATASET([{ds_log_transaction_rec}], doxie.log.layout_log_sold_to_transactions);

    RETURN IF(mod_access.log_record_source,
      OUTPUT(ds_log_transaction, NAMED('FILE_privacy__logs_sold__to__transactions')));

  ENDMACRO;

END;
