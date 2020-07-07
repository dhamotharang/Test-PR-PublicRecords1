IMPORT dx_header,InsuranceHeader_xLink,versionControl;
EXPORT data_key_first_ingest(STRING filedate):=FUNCTION

    new_ingest_date:=versionControl.fGetFilenameVersion(header.File_header_raw_latest.fileName);
    // take old key with first_ingest dates
    ds_old:=pull(dx_header.key_first_ingest());

    // take linking payload key (with incremental) and find blank (IOW new rids)
    ds_pyld:=InsuranceHeader_xLink.Key_InsuranceHeader_DID;
    no_persistent_rid_set := ['TN','TU','TS','LT'];
    // assign date frist ingest based on latest header raw
    ds_for_new_key:=
    join( distribute(ds_pyld,hash(rid)),
          distribute(ds_old ,hash(rid)),
          LEFT.rid=RIGHT.rid,
          TRANSFORM({ds_old},SELF.rid:=LEFT.rid,
                                                    // we assign a new date if cannot find the rid in old fid key AND
                                                    // the record it is NOT in no persist rid source set
                             SELF.first_ingest_date:=IF(RIGHT.rid=0 AND 
                                                        ~(LEFT.src in no_persistent_rid_set),
                                                            new_ingest_date,
                                                            RIGHT.first_ingest_date)),
          LEFT OUTER,
          LOCAL);
                
    // return updated dataset to build key
    RETURN ds_for_new_key;

END;