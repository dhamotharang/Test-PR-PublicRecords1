IMPORT Data_Services;

EXPORT Raw := MODULE

  EXPORT get_byLexid(ds_in, did_field, mod_access, data_env = Data_Services.data_env.iNonFCRA, out_layout='dx_Email.Layouts.i_Payload') := FUNCTIONMACRO

    IMPORT Doxie, dx_Email;

    LOCAL ds_slim := PROJECT(ds_in, TRANSFORM(Doxie.layout_references, SELF.did := (UNSIGNED)LEFT.did_field));

    LOCAL _all_email_ids := dx_Email.Ids.mac_byLexID(ds_slim, DID, data_env);
    LOCAL _all_payload := dx_Email.Get(_all_email_ids, email_rec_key, mod_access, data_env, out_layout);

    RETURN _all_payload;

  ENDMACRO;

  EXPORT get_byLexidBatch(ds_in, did_field, mod_access, data_env = Data_Services.data_env.iNonFCRA, out_layout='dx_Email.Layouts.i_Payload') := FUNCTIONMACRO

    LOCAL _email_payload := dx_Email.Raw.get_byLexid(ds_in,did_field,mod_access,data_env);  // returns results in dx_Email.Layouts.i_Payload by default
    // restore accountNo etc.
    LOCAL _all_recs := JOIN(ds_in, _email_payload, (UNSIGNED) LEFT.did_field = RIGHT.DID,
                           TRANSFORM(out_layout, SELF:=RIGHT, SELF:=LEFT, SELF:=[]));
    RETURN _all_recs;
  ENDMACRO;

  EXPORT get_event(ds_in, email_field, _oldest_date = '', _source = '', left_outer=FALSE) := FUNCTIONMACRO

    IMPORT STD;
    LOCAL _email_addresses := PROJECT(ds_in, TRANSFORM(dx_Email.layouts.i_Event_lkp,
                                    SELF.email_address := STD.Str.ToUpperCase(LEFT.email_field),
                                    SELF := []));
    LOCAL _email_events := JOIN(_email_addresses, dx_Email.Key_event_lkp(),
                          KEYED(LEFT.email_address = RIGHT.email_address)
                          #IF (#TEXT(_oldest_date<>''))
                           AND KEYED(RIGHT.date_added >= _oldest_date)
                          #END
                          #IF (#TEXT(_source<>''))
                            #IF (#TEXT(_oldest_date=''))
                             AND WILD(RIGHT.date_added)
                            #END
                          AND KEYED(RIGHT.source = _source)
                          #END
                          ,TRANSFORM(dx_Email.layouts.i_Event_lkp,
                             SELF.email_address := LEFT.email_address,
                             SELF := RIGHT)
                          #IF (left_outer)
                            ,LEFT OUTER
                          #END
                          ,KEEP(1000),LIMIT(0));
    RETURN _email_events;
  ENDMACRO;

  EXPORT get_domain(ds_in, domain_field) := FUNCTIONMACRO
    IMPORT STD;
    LOCAL _email_domains := PROJECT(ds_in, TRANSFORM(dx_Email.layouts.i_Domain_lkp,
                                    SELF.domain_name := STD.Str.ToUpperCase(LEFT.domain_field),
                                    SELF := []));
    LOCAL __email_domains := JOIN(_email_domains, dx_Email.Key_domain_lkp(),
                                 KEYED(LEFT.domain_name = RIGHT.domain_name)
                                ,TRANSFORM(dx_Email.layouts.i_Domain_lkp,
                                       SELF := RIGHT)
                                ,KEEP(1000),LIMIT(0));
    RETURN __email_domains;
  ENDMACRO;



END;
