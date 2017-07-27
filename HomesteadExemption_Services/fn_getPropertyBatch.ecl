IMPORT batchdatasets,BatchServices,LN_PropertyV2,suppress;
EXPORT fn_getPropertyBatch(DATASET(batchdatasets.layouts.batch_in) batch_in,
                           unsigned1 nss =suppress.constants.NonSubjectSuppression.doNothing, 
                           boolean isFCRA=FALSE) := FUNCTION
  boolean unformatted_values := FALSE;
  ds_all := BatchDatasets.fetch_Property_recs(batch_in, nss, isFCRA);
  ds_notflat := project(ds_all,transform(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes, self := left, self := []));
  ds_flat := PROJECT(ds_notflat, BatchServices.xfm_Property_make_flat(LEFT, unformatted_values));
	
  // assessed then deed
  ds_all_sort := sort(ds_flat,fid_type_desc,-LN_PropertyV2.fn_strip_pnum(assess_apna_or_pin_number),-LN_PropertyV2.fn_strip_pnum(deed_apnt_or_pin_number),-sortby_date,vendor_source_flag,acctno);
  ds_dedup := dedup(ds_all_sort,fid_type_desc,LN_PropertyV2.fn_strip_pnum(assess_apna_or_pin_number),LN_PropertyV2.fn_strip_pnum(deed_apnt_or_pin_number),sortby_date,acctno);
  
	BOOLEAN skip_dedup := FALSE : STORED('Skip_Dedup');  
	final_prop_recs := if(skip_dedup=true, ds_all_sort, ds_dedup);
  
  RETURN final_prop_recs;

END;//of function