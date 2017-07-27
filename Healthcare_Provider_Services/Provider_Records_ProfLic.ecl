Import Prof_LicenseV2;
EXPORT Provider_Records_ProfLic := Module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	Export get_proflic_providers_base (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			base_data:= join(dedup(sort(input,record),record), Prof_LicenseV2.Key_Proflic_Did(),
											keyed(left.prov_id = right.did), 
											transform(myLayouts.proflic_base_with_input,self.l_providerid:=right.did;self.rawData:=right;self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			baseRecs := project(base_data,myTransforms.build_ProfLic_base(left,maxPenalty));
			proflic_providers_final_sorted := sort(baseRecs, acctno, HCID, Src);
			proflic_providers_final_grouped := group(proflic_providers_final_sorted, acctno, HCID, Src);
			proflic_providers_rolled := rollup(proflic_providers_final_grouped, group, myTransforms.doProfLicBaseRecordSrcIdRollup(left,rows(left)));			
			return proflic_providers_rolled;
	end;
end;