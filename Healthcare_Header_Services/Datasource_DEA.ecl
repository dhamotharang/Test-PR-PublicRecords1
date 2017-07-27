import dea;
EXPORT Datasource_DEA := Module
	Export get_dea_entity (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
			// rawdataIndividual:= join(dedup(sort(input(lnpid>0),record),record), DEA.Key_lnpid,
											// keyed(left.lnpid = right.lnpid),
											// transform(Layouts.dea_base_with_input, 
																		// self.l_providerid := left.lnpid;
																		// self.vendorid:=right.dea_registration_number;
																		// self.rawData:=right;
																		// self:=left),
											// keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(input,rawdataIndividual,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input, self:=left),left only);
			noHits := input;
			rawdataIndividualbyVendorid:= join(dedup(sort(noHits(vendorid<>''),record),record),   DEA.Key_dea_reg_num,
											keyed(left.vendorid = right.dea_registration_number),
											transform(Layouts.dea_base_with_input,
																		self.l_providerid := left.lnpid;
																		self.vendorid:=right.dea_registration_number;
																		self.glb_ok := left.glb_ok;
																		self.dppa_ok := left.dppa_ok;
																		self.did:=(integer)right.did;
																		self.bdid:=(integer)right.bdid;
																		self.rawData:=right;
																		self:=left;
																		self:=right;),
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// baseRecs := project(rawdataIndividual+rawdataIndividualbyVendorid,Transforms.build_Dea_base(left));
			baseRecs := project(rawdataIndividualbyVendorid,Transforms.build_Dea_base(left));
			dea_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src);
			dea_providers_final_grouped := group(dea_providers_final_sorted, acctno, LNPID, Src);
			dea_providers_rolled := rollup(dea_providers_final_grouped, group, Transforms.doDEABaseRecordSrcIdRollup(left,rows(left)));			
			return dea_providers_rolled;
	end;
end;