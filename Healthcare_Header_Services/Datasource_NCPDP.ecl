import NCPDP;
EXPORT Datasource_NCPDP := Module
	Export get_ncpdp_entity (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
			noHits := input;
			rawdataIndividualbyVendorid:= join(dedup(sort(noHits(vendorid<>''),record),record),  NCPDP.key_ProviderID,
											keyed(left.vendorid = right.NCPDP_provider_id),
											transform(Layouts.ncpdp_base_with_input,
																		self.vendorid:=right.NCPDP_provider_id;
																		self:=right;
																		self:=left),
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			hasFullNCPDP := cfg[1].hasFullNCPDP;
			baseRecs := project(rawdataIndividualbyVendorid,Transforms.build_NCPDP_base(left,hasFullNCPDP));
			ncpdp_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src);
			ncpdp_providers_final_grouped := group(ncpdp_providers_final_sorted, acctno, LNPID, Src);
			ncpdp_providers_rolled := rollup(ncpdp_providers_final_grouped, group, Transforms.doNCPDPBaseRecordSrcIdRollup(left,rows(left)));			
			return ncpdp_providers_rolled;
	end;
end;