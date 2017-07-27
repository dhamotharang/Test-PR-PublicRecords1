import dea;
EXPORT Provider_Records_DEA := Module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	Export get_dea_providers_base (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			base_data:= join(dedup(sort(input,record),record), DEA.Key_dea_reg_num,
											keyed((string)left.prov_id = right.dea_registration_number),
											transform(myLayouts.dea_base_with_input,self.l_providerid:=(integer)right.dea_registration_number;self.rawData:=right;self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			baseRecs := project(base_data,myTransforms.build_Dea_base(left,maxPenalty));
			dea_providers_final_sorted := sort(baseRecs, acctno, HCID, Src);
			dea_providers_final_grouped := group(dea_providers_final_sorted, acctno, HCID, Src);
			dea_providers_rolled := rollup(dea_providers_final_grouped, group, myTransforms.doDEABaseRecordSrcIdRollup(left,rows(left)));			
			return dea_providers_rolled;
	end;
end;