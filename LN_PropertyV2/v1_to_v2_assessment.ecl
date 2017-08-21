
import Ln_property, ln_propertyv2;

//assessment_in := dataset('~thor_data400::base::ln_property::20070705::assessor', LN_Property.Layout_Property_Common_Model_BASE, flat);
inAssessorV1 := dataset(ln_property.filenames.inAssessor, LN_Property.Layout_Property_Common_Model_BASE, thor)(fips_code[1..2] in ['12', '39']);
inAssessorReplV1 := dataset(ln_property.filenames.inAssessorRepl, LN_Property.Layout_Property_Common_Model_BASE, thor)(fips_code[1..2] in ['12', '39']); 


LN_PropertyV2.layout_property_common_model_base  tformat(LN_Property.Layout_Property_Common_Model_BASE L) := transform



self.vendor_source_flag := map( l.vendor_source_flag = 'FAR_F' => 'F', 
                                l.vendor_source_flag = 'FAR_S' => 'S',
								l.vendor_source_flag = 'OKCTY' => 'O', 
				                l.vendor_source_flag = 'DAYTN' => 'D', '');

self.current_record := '';
self.tape_cut_date  := L.filler2[1..8];
self.certification_date := L.filler2[9..16];
self.edition_number := '';
self.prop_addr_propagated_ind := '';

self := L;

end;


outAssessorV2 := project(inAssessorV1, tformat(left));
outAssessorReplV2 := project(inAssessorReplV1, tformat(left));

//output(assessment_out,, '~thor_data400::base::ln_propertyv2::20070705::v1_to_V2_assessor', __compressed__, overwrite);
outV2 := output(outAssessorV2,, '~thor_data400::in::ln_propertyv2::fl_oh::v1_to_V2_assessor', __compressed__, overwrite);
outreplV2 := output(outAssessorReplV2,, '~thor_data400::in::ln_propertyv2::fl_oh::v1_to_V2_repl_assessor', __compressed__, overwrite);

add_outV2_superfile := FileServices.AddSuperFile(ln_propertyV2.filenames.inAssessor, '~thor_data400::in::ln_propertyv2::fl_oh::v1_to_V2_assessor');
add_outreplV2_superfile := FileServices.AddSuperFile(ln_propertyV2.filenames.inAssessorRepl, '~thor_data400::in::ln_propertyv2::fl_oh::v1_to_V2_repl_assessor');

export v1_to_v2_assessment := sequential(outV2, outreplV2, add_outV2_superfile, add_outreplV2_superfile);