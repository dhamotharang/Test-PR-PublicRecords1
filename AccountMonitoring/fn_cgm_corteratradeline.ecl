IMPORT AccountMonitoring,Cortera,dx_common,dx_Cortera_Tradeline;
 
EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_corteratradeline(
       DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
       DATASET(AccountMonitoring.layouts.documents.corteratradeline.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.corteratradeline.base),
       AccountMonitoring.i_Job_Config job_config
  ) := 
  FUNCTION
		
    // Filter and distribute Portfolio appropriately. 
    portfolio_dist_LinkIds := 
      DISTRIBUTE(
        in_portfolio,
        HASH64(SeleId)
     ) : INDEPENDENT;

    // ******* Key File(s) *******
    // * Applicable keys: 
    // * thor_data400::key::cortera_tradeline::20201111::linkids
    // *  ( dx_cortera_tradeline.Key_LinkIds.Key )
		
    // For those Portfolio entities having a valid SeleId, we'll join those records using
    // the linkIds pivot only. 
    // dx_cortera_tradeline.Key_LinkIds
    key_CorteraTradeLinkIds := 
      DISTRIBUTED(
        AccountMonitoring.product_files.Corteratradeline.TradelineLinkids_key,
        HASH64(SeleId)
      ) : INDEPENDENT; 
			
  // ******* Layouts *******
    temp_layout := RECORD
      in_portfolio.pid;
      in_portfolio.rid;
      in_documents.hid;
      in_portfolio.UltId;   // pivot fields
      in_portfolio.OrgId;   // pivot fields
      in_portfolio.SeleId;  // pivot fields
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.link_id; // unique Cortera company
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.ar_date;  // Monitored fields
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.total_ar;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.current_ar;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.aging_1to30;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.aging_31to60;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.aging_61to90;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.aging_91plus;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.dt_first_seen;
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.dt_last_seen;  // used for sorting purposed
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.dt_vendor_last_reported;  // used for sorting purposed
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.record_sid;  // needed for deduping delta records in dx_common.Incrementals.mac_Rollupv2
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.dt_effective_first;  // needed for deduping delta records in dx_common.Incrementals.mac_Rollupv2
      dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key.dt_effective_last;  // needed for deduping delta records in dx_common.Incrementals.mac_Rollupv2
    END;

    ds_LinkIdKeyRecs := 
      JOIN(key_CorteraTradeLinkIds,portfolio_dist_LinkIds, 
           LEFT.UltID = RIGHT.UltId AND
           LEFT.OrgId = RIGHT.OrgId AND
           LEFT.SeleId = RIGHT.SeleId,
          TRANSFORM(temp_layout,
            SELF.pid := RIGHT.pid,
            SELF.rid := RIGHT.rid,
            SELF.hid := 0,
            SELF.UltId := LEFT.UltId,  // Pivot fields
            SELF.OrgId := LEFT.OrgId,  // Pivot fields
            SELF.SeleId := LEFT.SeleId,  // Pivot fields
            SELF.Link_Id := LEFT.Link_Id,  // dedup field -- unique Cortera accounts
            SELF.ar_date := LEFT.ar_date,  // Remaining fields are monitored fields
            SELF.total_ar := LEFT.total_ar,
            SELF.current_ar := LEFT.current_ar,
            SELF.aging_1to30 := LEFT.aging_1to30,
            SELF.aging_31to60 := LEFT.aging_31to60,
            SELF.aging_61to90 := LEFT.aging_61to90,
            SELF.aging_91plus := LEFT.aging_91plus,
            SELF.dt_first_seen := LEFT.dt_first_seen,
            SELF.dt_last_seen := LEFT.dt_last_seen,  // added last seen dates for sorting purposes
            SELF.dt_vendor_last_reported := LEFT.dt_vendor_last_reported,
            SELF.record_sid := LEFT.record_sid,
            SELF.dt_effective_first := LEFT.dt_effective_first,
            SELF.dt_effective_last := LEFT.dt_effective_last),
        LOCAL);
 
    ds_LinkIdRecs := 
      dx_common.Incrementals.mac_Rollupv2(ds_LinkIdKeyRecs,use_distributed := TRUE);

    ds_LinkIdRecsDeduped := 
      DEDUP(
        SORT(
          DISTRIBUTE(ds_LinkIdRecs,HASH64(pid,rid)),
          pid,rid,UltId,OrgId,SeleId,Link_id,-dt_last_seen,-dt_vendor_last_reported,RECORD,LOCAL 
        ),
        pid,rid,UltId,OrgId,SeleId,Link_Id,LOCAL
      );

    // Now create a hash value from only the fields we're interested in (these are the
    // non *id fields in the temp_layout).
    ds_temp_unrolled_hashes := 
      PROJECT(
        ds_LinkIdRecsDeduped,
        TRANSFORM(AccountMonitoring.layouts.history,
          SELF.pid := LEFT.pid,
          SELF.rid := LEFT.rid,
          SELF.hid := 0,
          SELF.did := 0,
          SELF.bdid := 0,
          SELF.product_mask := AccountMonitoring.Constants.pm_corteratradeline,
          SELF.timestamp := '',
          SELF.hash_value := 
            HASH64(
              LEFT.ar_date,
              LEFT.total_ar,
              LEFT.current_ar,
              LEFT.aging_1to30,
              LEFT.aging_31to60,
              LEFT.aging_61to90,
              LEFT.aging_91plus,
              LEFT.dt_first_seen),
        ) ); 

    //Then roll up the hashes for all records for a particular pid/rid.
    temp_rolled_hashes := 
      ROLLUP(
        DISTRIBUTE(
          ds_temp_unrolled_hashes,
          HASH64(pid, rid)
        ),
        TRANSFORM(AccountMonitoring.layouts.history,
          SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
          SELF := LEFT
        ),
        pid,rid,LOCAL
    ); 

   RETURN temp_rolled_hashes;
		
	END;