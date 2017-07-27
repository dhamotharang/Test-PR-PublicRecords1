import Doxie, Header;
EXPORT Provider_Records_Boca_Header := Module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	Export get_boca_header_base (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			doxie.MAC_Header_Field_Declare()
			base_data0:= join(dedup(sort(input,record),record), doxie.key_header,
											keyed((integer)left.prov_id = right.s_did), 
											transform(recordof(doxie.Key_Header), self := right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			Header.MAC_GlbClean_Header(base_data0, base_data_cleaned);
			base_data := join(input, base_data_cleaned,
												left.prov_id = right.s_did, 
											transform(myLayouts.bocahdr_base_with_input,self.l_providerid:=right.s_did;self.rawData:=right;self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			baseRecs := project(base_data,myTransforms.build_BocaHdr_base(left,maxPenalty));
			bocaHeader_providers_final_sorted := sort(baseRecs, acctno, HCID, Src);
			bocaHeader_providers_final_grouped := group(bocaHeader_providers_final_sorted, acctno, HCID, Src);
			bocaHeader_providers_rolled := rollup(bocaHeader_providers_final_grouped, group, myTransforms.doBocaHeaderBaseRecordSrcIdRollup(left,rows(left)));			
			return bocaHeader_providers_rolled;
	end;
end;