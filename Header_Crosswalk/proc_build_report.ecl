IMPORT Header_Crosswalk;

EXPORT proc_build_report(
  STRING str_version,
  DATASET(Header_Crosswalk.Layouts.summary) ds_summary = Header_Crosswalk.Files.Build_Summary
) := FUNCTION

  // Filter @ds_summary according to @str_version
  ds_build_summary := ds_summary(version = str_version);

  // Pivot Pairs report
  mac_pairs_report(ds_input, base_id, input_id1, input_id2) := FUNCTIONMACRO
    
    // Declare output layout
    LOCAL layout_pairs := RECORD
      STRING base_id;
      STRING input_id1;
      STRING input_id2;
    END;

    // Constrain @ds_input to Pairs evaluated from @base_id
    LOCAL ds_pairs := ds_input(
      REGEXFIND('(\\d+)', attribute, NOCASE),
      (id1 = #TEXT(base_id) OR id2 = #TEXT(base_id))
    );

    // Return joint result from (@base_id,@input_id1) and (@base_id,@input_id2) pairs
    ds_joint := JOIN(ds_pairs(id2 = #TEXT(input_id1)), ds_pairs(id2 = #TEXT(input_id2)), LEFT.attribute = RIGHT.attribute, TRANSFORM(layout_pairs,
      SELF.base_id := MAX(LEFT.attribute, RIGHT.attribute);
      SELF.input_id1 := LEFT.value; 
      SELF.input_id2 := RIGHT.value; 
    ));

    // Order by base_id bucket
    RETURN SORT(ds_joint(input_id1 <> '' AND input_id2 <> ''), (UNSIGNED) REGEXFIND('(\\d+)', base_id, 1), base_id);

  ENDMACRO;

  mac_counterpart_report(ds_input, base_id, input_id1, input_id2) := FUNCTIONMACRO
    
    // Declare output layout
    LOCAL layout_counterpairs := RECORD
      STRING id;
      STRING Total;
      STRING input_id1;
      STRING input_id2;
    END;

    // Constrain @ds_input to Pairs evaluated from @base_id
    LOCAL ds_pairs := ds_input(
      attribute IN ['Available ID', 'DID counterpart'],
      (id1 = #TEXT(base_id) OR id2 = #TEXT(base_id))
    );

    RETURN DATASET(1, TRANSFORM(layout_counterpairs,
      SELF.id := #TEXT(base_id);
      SELF.Total := MAX(ds_pairs(attribute = 'Available ID'), value);
      SELF.input_id1 := MAX(ds_pairs(attribute = 'DID counterpart', id2 = #TEXT(input_id1)), value);
      SELF.input_id2 := MAX(ds_pairs(attribute = 'DID counterpart', id2 = #TEXT(input_id2)), value);
    ));
  ENDMACRO;

  RETURN PARALLEL(
    OUTPUT(mac_pairs_report(ds_build_summary, lexid, lnpid, seleid), NAMED('lexid_pairs'));
    OUTPUT(mac_pairs_report(ds_build_summary, lnpid, lexid, seleid), NAMED('lnpid_pairs'));
    OUTPUT(mac_pairs_report(ds_build_summary, seleid, lexid, lnpid), NAMED('seleid_pairs'));
    OUTPUT(mac_counterpart_report(ds_build_summary, lexid, lnpid, seleid), NAMED('lexid_counterpart'));
    OUTPUT(mac_counterpart_report(ds_build_summary, lnpid, lexid, seleid), NAMED('lnpid_counterpart'));
    OUTPUT(mac_counterpart_report(ds_build_summary, seleid, lexid, lnpid), NAMED('seleid_counterpart'));
  );

END; 