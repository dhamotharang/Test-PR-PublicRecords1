EXPORT _Functions := MODULE
	
	EXPORT fn_HoganPopDtFirstSeen(dataset(liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags) ds_party, dataset(liensv2.Layout_liens_main_module_for_hogan.layout_liens_main) ds_main):= FUNCTION	
	
		liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags findFilingDt(ds_party l, ds_main r) := transform
			self.Date_First_Seen := if(l.Date_First_Seen = '', r.orig_filing_date, l.Date_First_Seen);
			self := l;
		end;

		joinBoth 	:= join(Sort(Distribute(ds_party, Hash32(tmsid, rmsid)), record, local), 
											Sort(Distribute(ds_main(orig_filing_date <>''), Hash32(tmsid, rmsid)), record, local),
												left.tmsid = right.tmsid and 
												left.rmsid = right.rmsid, 
												findFilingDt(left, right), left outer, local);
		
		dedupJoin := dedup(sort(distribute(joinBoth, hash(tmsid, rmsid)), record, local), record, local);

		RETURN dedupJoin;
	
	END;

	EXPORT fn_PopDtFirstSeen(dataset(LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags) ds_party, dataset(LiensV2.Layout_liens_main_module.layout_liens_main) ds_main):= FUNCTION	
	
		LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags findFilingDt(ds_party l, ds_main r) := transform
      self.Date_First_Seen := if(l.Date_First_Seen = '', r.orig_filing_date, l.Date_First_Seen);
      self := l;
		end;

		joinBoth := join(Sort(Distribute(ds_party, Hash32(tmsid, rmsid)), record, local), 
										 Sort(Distribute(ds_main(orig_filing_date <>''), Hash32(tmsid, rmsid)), record, local),
											left.tmsid = right.tmsid and 
											left.rmsid = right.rmsid, 
											findFilingDt(left, right), left outer, local);
		
		dedupJoin := dedup(sort(distribute(joinBoth, hash(tmsid, rmsid)), tmsid, rmsid, local), record, local);

		RETURN dedupJoin;
	
	END;

END;	