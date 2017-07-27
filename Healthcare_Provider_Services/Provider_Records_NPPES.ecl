Import NPPES;
EXPORT Provider_Records_NPPES := Module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	Export get_nppes_providers_base (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			base_data:= join(dedup(sort(input,record),record),  NPPES.Key_NPPES_npi,
											keyed((string)left.prov_id = right.npi), 
											transform(myLayouts.npi_base_with_input,self.l_providerid:=(integer)right.npi;self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			baseRecs := project(base_data,myTransforms.build_npi_base(left,maxPenalty));
			npi_providers_final_sorted := sort(baseRecs, acctno, HCID, Src);
			npi_providers_final_grouped := group(npi_providers_final_sorted, acctno, HCID, Src);
			npi_providers_rolled := rollup(npi_providers_final_grouped, group, myTransforms.doNPIBaseRecordSrcIdRollup(left,rows(left)));			
			return npi_providers_rolled;
	end;
end;
