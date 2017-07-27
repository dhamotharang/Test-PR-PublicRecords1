import ln_property;

// Assessor year select
assessor_year_list := ['2000','2001','2002','2003','2004','2005','2006'];

ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

//assessor_base := ln_property.File_Assessment;
assessor_base := dataset('~thor_data400::base::ln_property::20060619::assessor', LN_Property.Layout_Property_Common_Model_BASE, flat);
assessor_file := assessor_base(state_code in ln_property_valid_state,
                                             vendor_source_flag in ['DAYTN','OKCTY'],
									assessed_value_year in assessor_year_list,
									new_record_type_code <> 'PP');

// avm search file

//sfa := avm_search(ln_fares_id[1] in ['D','O'], ln_fares_id[2] = 'A');
sfa := dataset('TEMP::avm_search', Layout_AVM_Search, flat)(ln_fares_id[1] in ['D','O'], ln_fares_id[2] = 'A');

// Format output assessor records
Layout_AVM_Assessor_Append FormatAssessorAppendOut(assessor_file l, sfa r) := transform
self.avm_property_id := intformat(r.avm_property_id, 12, 1);
self := l;
end;

avm_assessor_append_init := join(assessor_file,
                                 sfa,
					        left.ln_fares_id = right.ln_fares_id,
					        FormatAssessorAppendOut(left, right),
					        hash);
					 
avm_assessor_append_sort := sort(avm_assessor_append_init, avm_property_id, ln_fares_id);
                          
export avm_assessor_append_out := avm_assessor_append_sort : persist('TEMP::avm_assessor_append_out');