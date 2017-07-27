sf := AVM.avm_search;

layout_avm_property_id := record
sf.avm_property_id;
cnt := count(group);
end;

sf_stat := table(sf, layout_avm_property_id, avm_property_id);
output(count(sf_stat), named('Unique_Property_ID__Count'));
output(topn(sf_stat, 1000, -cnt), named('Property_ID_Distribution_Stat'), all);

afids := sf(ln_fares_id[2] = 'A');

layout_avm_property_id_assessor := record
afids.avm_property_id;
cnt := count(group);
end;

afids_stat := table(afids, layout_avm_property_id_assessor, avm_property_id);
output(count(afids_stat), named('Unique_Property_ID_Assessor_Count'));
output(topn(afids_stat, 1000, -cnt), named('Property_ID_Assessor_Distribution_Stat'), all);

dfids := sf(ln_fares_id[2] in ['D','M']);

layout_avm_property_id_deeds := record
dfids.avm_property_id;
cnt := count(group);
end;

dfids_stat := table(dfids, layout_avm_property_id_deeds, avm_property_id);
output(count(dfids_stat), named('Unique_Property_ID_Deed_Count'));
output(topn(dfids_stat, 1000, -cnt), named('Property_ID_Deed_Distribution_Stat'), all);

layout_assessor_deed_match := record
unsigned6 avm_property_id;
integer assessor_count;
integer deed_count;
end;

admatch := join(afids_stat,
                dfids_stat,
			 left.avm_property_id = right.avm_property_id,
			 transform(layout_assessor_deed_match,
			           self.assessor_count := left.cnt,
					 self.deed_count := right.cnt,
					 self := left),
			 hash);
			 
output(count(admatch), named('Assessor_Deed_Match_by_Unique_Property_ID_Count'));
output(topn(admatch, 1000, -(assessor_count + deed_count)), named('Property_ID_Assessor_Deed_Match_Distribution_Stat'), all);



