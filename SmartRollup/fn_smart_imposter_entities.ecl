import iesp,smartRollup;
/*
t_SLR_entities  := record
   string12 UniqueId {xpath('UniqueId')};
	 dataset(iesp.share.t_Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.SMART.MaxAKA)};
	 dataset(iesp.share.t_SSNInfoEx) SSNs {xpath('SSNs/SSN'), MAXCOUNT(iesp.Constants.SMART.MaxAKA)};
	 dataset(iesp.share.t_date) DOBs {xpath('DOBs/DOB'), MAXCOUNT(iesp.Constants.SMART.MaxAKA)};
 end;
*/
outrec := iesp.smartlinxReport.t_SLRentities;
export fn_smart_imposter_entities(dataset(iesp.bps_share.t_BpsReportImposter) imposters2dedup) := function
 outrec loadImposters(imposters2dedup l) := transform
    akaNames := SmartRollup.fn_smart_rollup_names(l.akas);
		entity := fn_smart_aka_entities(akaNames, l.akas)[1];
    self.uniqueId :=  entity.uniqueId;
    self.Names :=  entity.Names;
    self.SSNs :=  entity.SSNs;
    self.DOBs :=  entity.DOBs;
  end;
 outrecs := project(imposters2dedup, loadImposters(left));
 return outrecs;
end;
