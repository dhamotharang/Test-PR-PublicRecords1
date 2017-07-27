import CLIA,Codes;
EXPORT Datasource_Clia := Module
	Export get_clia_entity (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
			// rawdataIndividual:= join(dedup(sort(input(lnpid>0),record),record), clia.keys().LNPID.qa,
											// keyed(left.lnpid = right.lnpid),
											// transform(Layouts.clia_base_with_input, 
																		// self.l_providerid := left.lnpid;
																		// self.vendorid:=right.clia_number;
																		// self:=right;
																		// self:=left),
											// keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(input,rawdataIndividual,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input, self:=left),left only);
			noHits := input;
			rawdataIndividualbyVendorid:= join(dedup(sort(noHits(vendorid<>''),record),record),  clia.keys().CLIA_Number.qa,
											keyed(left.vendorid = right.clia_number),
											transform(Layouts.clia_base_with_input,
																		self.vendorid:=right.clia_number;
																		self:=right;
																		self:=left),
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			
			// base_w_TermCodes	:= join(rawdataIndividual+rawdataIndividualbyVendorid,Codes.Key_Codes_V3,
												// keyed(right.file_name = 'CLIA_LAB_TYPE') and keyed(right.field_name = 'TERMINATION_CODE') and left.lab_term_code = right.code,
												// transform(Layouts.clia_base_with_input,self.TermCodeDesc:=right.long_desc;self:=left), left outer);
			base_w_TermCodes	:= join(rawdataIndividualbyVendorid,Codes.Key_Codes_V3,
												keyed(right.file_name = 'CLIA_LAB_TYPE') and keyed(right.field_name = 'TERMINATION_CODE') and left.lab_term_code = right.code,
												transform(Layouts.clia_base_with_input,self.TermCodeDesc:=right.long_desc;self:=left), left outer);
			baseRecs := project(base_w_TermCodes,Transforms.build_CLIA_base(left));
			clia_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src);
			clia_providers_final_grouped := group(clia_providers_final_sorted, acctno, LNPID, Src);
			clia_providers_rolled := rollup(clia_providers_final_grouped, group, Transforms.doCLIABaseRecordSrcIdRollup(left,rows(left)));			
			return clia_providers_rolled;
	end;
end;