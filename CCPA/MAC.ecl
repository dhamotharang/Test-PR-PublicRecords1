import $;

export MAC := module

  export GetCollection(in_did, k_did_field = 'did', kname, cname, lname, lver) := functionmacro
    
    local raw_recs := join(dids, kname, keyed(left.k_did_field = right.did), transform(right), keep(100), limit(0)); // tmp limits

    iesp.consumer_collection_report.t_Collection xtCollection() := transform
      self._name := cname;
      self.LayoutName := lname;
      self.LayoutVersion := lver;
      self.Records := project(raw_recs, transform(iesp.consumer_collection_report.t_CollectionRecord,
        self.PrivacySourceID := (string) left.record_sid;,
        self.GlobalRecordId := (string) left.global_sid;
        self.Content := '[' + TOJSON(left) + ']';
        ));
    end;
    return row(xtCollection());

  endmacro; 

end;