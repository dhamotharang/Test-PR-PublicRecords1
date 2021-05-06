IMPORT dx_Header_Crosswalk;
IMPORT Header_Crosswalk;

EXPORT DATASET(dx_Header_Crosswalk.Layouts.lexid_2_lnpid) fn_lexid_lnpid(
  DATASET(Header_Crosswalk.Layouts.lnpid_segmentation) ds_lnpid_segmentation
) := FUNCTION
  
  // Stage 1) Filter-out @ds_lnpid_segmentation with no lexid information
  ds_lnpid_segmentation_useful := ds_lnpid_segmentation(best_lexid > 0);

  // Stage 2) Keep 1:1 (lexid,lnpid) pairs unique to each lnpid tier
  ds_lexid_summary := TABLE(ds_lnpid_segmentation_useful, {
    lexid := best_lexid;
    single_tier := NOT(segmentation_ind IN Header_Crosswalk.Constants.set_lnpid_tier1 AND segmentation_ind IN Header_Crosswalk.Constants.set_lnpid_tier2);
    unique_pair := COUNT(GROUP) = 1;
    unique_lnpid := MIN(GROUP, lnpid);
  }, best_lexid, 
  NOT(segmentation_ind IN Header_Crosswalk.Constants.set_lnpid_tier1 AND segmentation_ind IN Header_Crosswalk.Constants.set_lnpid_tier2),
  MERGE);

  ds_useful_pairs := ds_lexid_summary(
    single_tier, // Must be present on either tier1 or tier2, but not in both
    unique_pair // Must have 1:1 relationship
  );

  // Stage 3) Project pairs into result layout
  RETURN PROJECT(ds_useful_pairs, TRANSFORM(dx_Header_Crosswalk.Layouts.lexid_2_lnpid,
    SELF.lexid := LEFT.lexid;
    SELF.lnpid := LEFT.unique_lnpid;
  ));
END;