IMPORT Header_Crosswalk;
IMPORT dx_Header_Crosswalk;

// Evaluates a summarized status for a set of crosswalk logical files.
EXPORT DATASET(Header_Crosswalk.Layouts.summary) fn_summary(
  STRING str_version,
  DATASET(dx_Header_Crosswalk.Layouts.lexid_2_seleid) ds_lexid_seleid,
  DATASET(dx_Header_Crosswalk.Layouts.lexid_2_lnpid) ds_lexid_lnpid,
  DATASET(dx_Header_Crosswalk.Layouts.lnpid_2_seleid) ds_lnpid_seleid
) := FUNCTION

  mac_single_id(ds_input, did1) := FUNCTIONMACRO

    ds_available_input := TABLE(ds_input, {id}, id, MERGE);

    RETURN DATASET([
      {#TEXT(did1), 'Available ID', COUNT(ds_available_input)}
    ], Layouts.summary AND NOT [version,id2,sharedid]);
  ENDMACRO;

  // Independent summary for a single @ds_input. Evaluate attributes based on (@did1,@did2) pairs
  mac_independent(ds_input, did1, did2) := FUNCTIONMACRO
    IMPORT STD;
    IMPORT Header_Crosswalk.Layouts;

    // Number of @did1 nodes. Single link if edge count is 1
    LOCAL ds_node_1 := TABLE(ds_input, {did1, edges := COUNT(GROUP); single_edge := COUNT(GROUP) = 1}, did1, MERGE);
    // Number of @did2 nodes. Single link if edge count is 1
    LOCAL ds_node_2 := TABLE(ds_input, {did2, edges := COUNT(GROUP); single_edge := COUNT(GROUP) = 1}, did2, MERGE);

    // ds_input.(@did1,@did2) is a unique pair IFF @did1.single_edge and @did2.single_edge
    LOCAL ds_unique_pairs := JOIN(JOIN(ds_input, ds_node_1(single_edge), LEFT.did1 = RIGHT.did1, HASH), ds_node_2(single_edge), LEFT.did2 = RIGHT.did2, HASH);

    RETURN DATASET([
      // Available pairs
      {#TEXT(did1), #TEXT(did2), 'Available Pairs', COUNT(ds_input)},
      {#TEXT(did1), #TEXT(did2), 'Unique Pairs', COUNT(ds_unique_pairs)},
      {#TEXT(did1), #TEXT(did2), 'DID counterpart', COUNT(ds_node_1)},
      {#TEXT(did2), #TEXT(did1), 'DID counterpart', COUNT(ds_node_2)},
      
      // did1 edge distribution
      {#TEXT(did1), #TEXT(did2), '1 Pair', COUNT(ds_node_1(edges = 1))},
      {#TEXT(did1), #TEXT(did2), '[2,5] Pairs', COUNT(ds_node_1(edges BETWEEN 2 AND 5))},
      {#TEXT(did1), #TEXT(did2), '[6,20] Pairs', COUNT(ds_node_1(edges BETWEEN 6 AND 20))},
      {#TEXT(did1), #TEXT(did2), '[21,50] Pairs', COUNT(ds_node_1(edges BETWEEN 21 AND 50))},
      {#TEXT(did1), #TEXT(did2), '[51,100] Pairs', COUNT(ds_node_1(edges BETWEEN 51 AND 100))},
      {#TEXT(did1), #TEXT(did2), '[101,500] Pairs', COUNT(ds_node_1(edges BETWEEN 101 AND 500))},
      {#TEXT(did1), #TEXT(did2), '[501,1000] Pairs', COUNT(ds_node_1(edges BETWEEN 501 AND 1000))},
      {#TEXT(did1), #TEXT(did2), '1001+ Pairs', COUNT(ds_node_1(edges > 1000))},

      // did2 edge distribution
      {#TEXT(did2), #TEXT(did1), '1 Pair', COUNT(ds_node_2(edges = 1))},
      {#TEXT(did2), #TEXT(did1), '[2,5] Pairs', COUNT(ds_node_2(edges BETWEEN 2 AND 5))},
      {#TEXT(did2), #TEXT(did1), '[6,20] Pairs', COUNT(ds_node_2(edges BETWEEN 6 AND 20))},
      {#TEXT(did2), #TEXT(did1), '[21,50] Pairs', COUNT(ds_node_2(edges BETWEEN 21 AND 50))},
      {#TEXT(did2), #TEXT(did1), '[51,100] Pairs', COUNT(ds_node_2(edges BETWEEN 51 AND 100))},
      {#TEXT(did2), #TEXT(did1), '[101,500] Pairs', COUNT(ds_node_2(edges BETWEEN 101 AND 500))},
      {#TEXT(did2), #TEXT(did1), '[501,1000] Pairs', COUNT(ds_node_2(edges BETWEEN 501 AND 1000))},
      {#TEXT(did2), #TEXT(did1), '1001+ Pairs', COUNT(ds_node_2(edges > 1000))}

    ], Layouts.summary AND NOT [version, sharedid]);
  ENDMACRO;

  // Joint summary for two @ds_input_did1 and @ds_input_did2. Evaluate attributes based on (did1,did_shared) and (did_shared,did2)
  mac_joint_summary(ds_input_did1, ds_input_did2, did_shared, did1, did2) := FUNCTIONMACRO
    IMPORT STD;
    IMPORT Header_Crosswalk.Layouts;

    // Use @did_shared to check avaliable 2-length paths
    LOCAL ds_paths := JOIN(ds_input_did1, ds_input_did2, LEFT.did_shared = RIGHT.did_shared, HASH);

    // Number of 2-length paths between (did1,did2)
    LOCAL ds_path_count := TABLE(ds_paths, {did1, did2, paths := COUNT(GROUP); single_path := COUNT(GROUP) = 1}, did1, did2, MERGE);

    RETURN DATASET([
      // Available paths
      {#TEXT(did1), #TEXT(did_shared), #TEXT(did2), 'Available Paths', COUNT(ds_paths)},
      {#TEXT(did1), #TEXT(did_shared), #TEXT(did2), 'Single Paths', COUNT(ds_path_count(single_path))}
    ], Layouts.summary AND NOT [version]);
  ENDMACRO;

  // All single did
  ds_single_did := PROJECT((+)(
    mac_single_id(PROJECT(ds_lexid_seleid, TRANSFORM({UNSIGNED id}, SELF.id := LEFT.lexid)) + PROJECT(ds_lexid_lnpid, TRANSFORM({UNSIGNED id}, SELF.id := LEFT.lexid)), lexid),
    mac_single_id(PROJECT(ds_lexid_lnpid, TRANSFORM({UNSIGNED id}, SELF.id := LEFT.lnpid)) + PROJECT(ds_lnpid_seleid, TRANSFORM({UNSIGNED id}, SELF.id := LEFT.lnpid)), lnpid),
    mac_single_id(PROJECT(ds_lexid_seleid, TRANSFORM({UNSIGNED id}, SELF.id := LEFT.seleid)) + PROJECT(ds_lnpid_seleid, TRANSFORM({UNSIGNED id}, SELF.id := LEFT.seleid)), seleid)
  ), TRANSFORM(Header_Crosswalk.Layouts.summary,
    SELF.version := str_version;
    SELF.sharedid := '';
    SELF.id2 := '';
    SELF := LEFT;
  ));

  // All independent combinations
  ds_independent := PROJECT((+)(
    mac_independent(ds_lexid_seleid, lexid, seleid),
    mac_independent(ds_lexid_lnpid, lexid, lnpid),
    mac_independent(ds_lnpid_seleid, lnpid, seleid)
  ), TRANSFORM(Header_Crosswalk.Layouts.summary,
    SELF.version := str_version;
    SELF.sharedid := '';
    SELF := LEFT;
  ));

  ds_joint_summary := PROJECT((+)(
    mac_joint_summary(ds_lexid_seleid, ds_lexid_lnpid, lexid, seleid, lnpid),
    mac_joint_summary(ds_lexid_seleid, ds_lnpid_seleid, seleid, lexid, lnpid),
    mac_joint_summary(ds_lexid_lnpid, ds_lnpid_seleid, lnpid, lexid, seleid)
  ), TRANSFORM(Header_Crosswalk.Layouts.summary,
    SELF.version := str_version;
    SELF := LEFT;
  ));

  RETURN SORT(ds_single_did + ds_independent + ds_joint_summary, id1, id2, sharedid);
END;