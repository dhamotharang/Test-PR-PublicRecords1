IMPORT $;

EXPORT MAC := MODULE

  EXPORT GetLayoutMeta(l_in):= FUNCTIONMACRO	
    
    #DECLARE(l_def_str); #SET(l_def_str,'');
    #DECLARE(l_field_cnt); #SET(l_field_cnt,0);
    #EXPORTXML(fields,l_in);
    #FOR(fields)
      #FOR(Field)
        #APPEND(l_def_str,%'{@ecltype}'% + ' ' + %'{@label}'% + ';' + '\n');
        #SET(l_field_cnt,%l_field_cnt% + 1);
      #END
    #END
    
    RETURN ROW({%'l_def_str'%, %l_field_cnt%}, {string text; integer cnt;});
  ENDMACRO;

  EXPORT GetCollectionFromRaw(raw_recs, in_mod, collection_name, k_name, k_did_field, k_date_field, date_format = $.Constants.DateFormat.YYYYMMDD, max_records = $.Constants.MaxCollectionRecords) 
  := FUNCTIONMACRO
    
    IMPORT iesp, STD;
    LOCAL meta := MAC.GetLayoutMeta(k_name);

    LOCAL collection_recs := PROJECT(SORT(raw_recs(in_mod.isDateOk((UNSIGNED) k_date_field, date_format)), k_did_field, -k_date_field, RECORD), 
      TRANSFORM(iesp.consumer_collection_report.t_CollectionRecord,
        SELF.PrivacySourceID := (string) LEFT.record_sid;
        SELF.GlobalRecordId := (string) LEFT.global_sid;
        SELF.Content := TOJSON(left);
    ));

    iesp.consumer_collection_report.t_Collection xtCollection() := TRANSFORM
      SELF.Metadata.Name := collection_name;
      SELF.Metadata.RecordCount := COUNT(collection_recs);
      SELF.Metadata.KeyAttribute := STD.Str.FilterOut(#TEXT(k_name), ' ');
      SELF.Metadata.DateField := #TEXT(k_date_field);
      SELF.Metadata.EclLayout.Text := IF(in_mod.ReturnEclLayoutText, meta.text, '');
      SELF.Metadata.EclLayout.FieldCount := meta.cnt;
      SELF.Metadata.EclLayout.Hash := (STRING) HASH32(meta.text);
      SELF.Records := CHOOSEN(collection_recs, max_records);
    end;
    IF(in_mod.debug, OUTPUT(raw_recs, NAMED('raw_'+collection_name)));
    RETURN ROW(xtCollection());

  ENDMACRO; 

  EXPORT GetCollection(in_dids, in_mod, collection_name, k_name, k_did_field, k_date_field, date_format = $.Constants.DateFormat.YYYYMMDD, max_records = $.Constants.MaxCollectionRecords) 
  := FUNCTIONMACRO
    
    IMPORT iesp;
    LOCAL raw_recs := JOIN(in_dids, k_name, 
      KEYED(LEFT.did = RIGHT.k_did_field), 
      TRANSFORM(RECORDOF(k_name),
        SELF.k_date_field := IF(in_mod.isDateOk((unsigned) RIGHT.k_date_field, date_format), RIGHT.k_date_field, skip);
        SELF := RIGHT;
        ), KEEP(max_records), LIMIT(0)); 

    RETURN MAC.GetCollectionFromRaw(raw_recs, in_mod, collection_name, k_name, k_did_field, k_date_field, date_format, max_records);

  ENDMACRO; 

  


END;
