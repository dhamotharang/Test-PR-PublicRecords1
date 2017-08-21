IMPORT ut, business_header;

EXPORT fRollupBaseBusLnk(DATASET(business_header.Layout_Business_Linking.Company_) pDataset) := FUNCTION

   dDistributed	 :=	DISTRIBUTE(pDataset,HASH(source, vl_id));

   dDataset_sort := SORT(dDistributed,
	                       RECORD,
	                       EXCEPT dt_first_seen, dt_last_seen,dt_vendor_last_reported,source_record_id,
												 LOCAL);	
       	 
   business_header.Layout_Business_Linking.Company_ RollupUpdate(business_header.Layout_Business_Linking.Company_ l,
	                                                                business_header.Layout_Business_Linking.Company_ r) := TRANSFORM
     SELF.dt_first_seen		         := MIN(l.dt_first_seen,	r.dt_first_seen);
		 SELF.dt_last_seen 		         := MAX(l.dt_last_seen,	r.dt_last_seen);
		 SELF.dt_vendor_last_reported  := MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		 SELF.dt_vendor_first_reported := MIN(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		 SELF.source_record_id	       := IF (l.dt_vendor_first_reported < r.dt_vendor_first_reported, l.source_record_id, r.source_record_id);
		 SELF                          := l;
   END;
	 
   dDataset_rollup := ROLLUP(dDataset_sort,
                             RollupUpdate(LEFT, RIGHT),
	                           RECORD,
														 EXCEPT dt_first_seen, dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,source_record_id,
                             LOCAL);
  																											
   RETURN dDataset_rollup;
END;
