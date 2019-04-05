IMPORT Data_Services, STD;

EXPORT log := MODULE
  
  EXPORT transaction_id := FUNCTION
    RETURN (STRING) HASH((string)STD.Date.CurrentTime()+STD.System.Job.Name()); // temporary for POC only
    /*
    // add these to global module?
    string TransactionID := '' : stored('_TransactionId');
    string BatchJobID := '' : stored('_BatchJobId');
    RETURN IF(TransactionID <> '', TransactionID, BatchJobID);
    */
  END;

  EXPORT layout_log_sold_to_transactions := RECORD
    string20 transaction_id;
    string32 local_id;
    string1 domain;
    string80 query_name;
    integer mbs_gcid;
    string25 mbs_billind_id;
    integer mbs_product_id;
    unsigned1 fcra;
    unsigned1 glba_use;
    unsigned1 dppa_use;
    unsigned1 hipaa;
    unsigned1 deathmaster;
    // probably have a single bitmap field with all these last 5 permissions
  END;

  EXPORT layout_log_sold_to_sources := RECORD
    string20 transaction_id;
    string32 local_id;
    unsigned6 LexID;
    utf8 source_list; /* JSON format: [{“S”:1234}, {“S”:1235,”R”:666},{“S”:1237}] */
  END;

  EXPORT layout_log_record_interm := RECORD
    layout_log_sold_to_sources;
    unsigned4 global_sid; 
    unsigned8 record_sid;
  END;

  EXPORT logSoldToSources(ds_in, mod_access, did_field='did') := MACRO
    IMPORT STD;
   
    #uniquename(rec_log)
    %rec_log% := doxie.log.layout_log_record_interm;

    #uniquename(ds_slim)
    #uniquename(toLogFormat)
    #uniquename(l_lexid)
    #uniquename(t_id)
    %rec_log% %toLogFormat% (RECORDOF (ds_in) L) := TRANSFORM
      %l_lexid% :=  (unsigned6) L.did_field;
      %t_id% := doxie.log.transaction_id; // from where? read from stored('_TransactionId') in gateway.Configuration
      SELF.transaction_id := %t_id%;
      SELF.local_id := %t_id%; // temporarily assigning local id
      SELF.LexID :=  %l_lexid%;
      SELF.global_sid:= L.global_sid; //orbitID of the dataset being searched
      SELF.record_sid := IF ( %l_lexid% = 0, L.record_sid, 0); //  // if we have a lexid, we only need to log source ids
      SELF.source_list := IF(%l_lexid% = 0,
        '{'+TOJSON(ROW({L.global_sid, L.record_sid}, {unsigned4 S; unsigned8 R;}))+'}',
        '{'+TOJSON(ROW({L.global_sid}, {unsigned4 S;}))+'}');
    END;
    %ds_slim% := PROJECT (ds_in, %toLogFormat% (LEFT));
    
    #uniquename(ds_ddp)
    %ds_ddp% := DEDUP(SORT (%ds_slim%, LexID, global_sid, record_sid), LexID, global_sid, record_sid);
         
    #uniquename(rollToLog)
    %rec_log% %rollToLog% (%rec_log% L, %rec_log% R) := TRANSFORM
       SELF.source_list := IF (L.source_list != '', 
          L.source_list + IF(R.source_list != '', ','+R.source_list, ''),
          R.source_list);
      SELF := L;
    END;

    #uniquename(ds_sold_to_sources)
    %ds_sold_to_sources% := PROJECT(
      ROLLUP(%ds_ddp%, LEFT.LexID > 0 AND LEFT.LexID = RIGHT.LexID, %rollToLog%(LEFT, RIGHT))
      , TRANSFORM(doxie.log.layout_log_sold_to_sources,
          SELF.source_list := '[' + LEFT.source_list + ']';
          SELF := LEFT;
        ));
    
    IF(mod_access.log_record_source AND exists(ds_in), OUTPUT(%ds_sold_to_sources%, NAMED('log__sold_to_sources'), EXTEND));

  ENDMACRO;

  EXPORT logSoldToTransaction(mod_access, env_flag = Data_Services.data_env.iNonFCRA) := FUNCTIONMACRO
  
    IMPORT Data_Services, STD;

    t_id := doxie.log.transaction_id;

    // no uniquenames as this macro must always be called just once 
    doxie.log.layout_log_sold_to_transactions toLogFormat() := TRANSFORM
      SELF.transaction_id := t_id;
      SELF.local_id := t_id; // temporarily assigning local id
      SELF.domain := 'P'; // TODO: define enum [P, I, H] somewhere
      SELF.query_name := STD.System.Job.Name();
      SELF.mbs_gcid := 0; // ??
      SELF.mbs_billind_id := ''; // ??
      SELF.mbs_product_id := 0; // ??
      SELF.fcra := IF(env_flag = Data_Services.data_env.iFCRA, 1, 0);
      SELF.hipaa := IF(env_flag = Data_Services.data_env.iHIPAA, 1, 0);
      SELF.deathmaster := 0; // ??
      SELF.glba_use := mod_access.glb;
      SELF.dppa_use := mod_access.dppa;
    END;
    RETURN IF(mod_access.log_record_source, OUTPUT(DATASET([toLogFormat()]), NAMED('log__sold_to_transactions')));
     
  ENDMACRO;

END;
