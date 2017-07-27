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
export fn_smart_aka_entities(dataset(iesp.bps_share.t_BpsReportIdentity) names2dedup,
                             dataset(iesp.bps_share.t_BpsReportIdentity) aka2dedup) := function
 names_wdup := project(names2dedup,transform(iesp.share.t_Name, self := left.name));
 ssns_wdup  := project(aka2dedup,transform(iesp.share.t_SSNInfoEx, self := left.SSNInfoEx));
 dobs_wdup  := project(aka2dedup,transform(iesp.share.t_date, self := left.dob));
 s_names    := dedup(sort(names_wdup, record), record); 
 s_ssns     := dedup(sort(ssns_wdup, record), record); 
 s_dobs     := dedup(sort(dobs_wdup, record), record); 
 
 outrec loadAka() := transform
    self.UniqueID := aka2dedup[1].UniqueID;
		self.Names := s_names;
		self.SSNs := s_ssns ;
		self.DOBs := s_dobs;
 end;
 
 outrecs := dataset([loadAka()]);
 return outrecs;
end;