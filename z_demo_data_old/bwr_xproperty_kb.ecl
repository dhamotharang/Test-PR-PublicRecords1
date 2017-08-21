import ln_propertyv2, roxiekeybuild;
import demo_data_scrambler;

#workunit('name','Property  keybuilds and superfile tx')

wuid := '20090603';
filedate:= wuid;
//
s1:= fileservices.clearsuperfile('~thor_data400::base::ln_propertyv2::Addl::fares_deed');
s2:= output(demo_data_scrambler.scramble_ln_propertyv2_file_addl_fares_deed,,'~thor::base::demo_data_file_ln_propertyv2_addl_fares_deed'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::ln_propertyv2::Addl::fares_deed','~thor::base::demo_data_file_ln_propertyv2_addl_fares_deed'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::ln_propertyv2::Addl::fares_tax');
s5:= output(demo_data_scrambler.scramble_ln_propertyv2_file_addl_fares_tax,,'~thor::base::demo_data_file_ln_propertyv2_addl_fares_tax'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::ln_propertyv2::Addl::fares_tax','~thor::base::demo_data_file_ln_propertyv2_addl_fares_tax'+wuid+'_scrambled');

s7:= fileservices.clearsuperfile('~thor_data400::base::ln_propertyv2::Addl::legal');
s8:= output(demo_data_scrambler.scramble_ln_propertyv2_file_addl_legal,,'~thor::base::demo_data_file_ln_propertyv2_addl_legal'+wuid+'_scrambled',overwrite);
s9:= fileservices.addsuperfile('~thor_data400::base::ln_propertyv2::Addl::legal','~thor::base::demo_data_file_ln_propertyv2_addl_legal'+wuid+'_scrambled');

s10 := fileservices.clearsuperfile('~thor_data400::base::ln_propertyv2::search');
s11 := output(demo_data_scrambler.scramble_ln_propertyv2_file_search_did,,'~thor::base::demo_data_file_ln_propertyv2_file_search_did'+wuid+'_scrambled',overwrite);
s12 := fileservices.addsuperfile('~thor_data400::base::ln_propertyv2::search','~thor::base::demo_data_file_ln_propertyv2_file_search_did'+wuid+'_scrambled');

s13 := fileservices.clearsuperfile('~thor_data400::base::ln_propertyv2::assesor');
s14 := output(demo_data_scrambler.scramble_ln_propertyv2_file_assessment,,'~thor::base::demo_data_file_ln_propertyv2_file_assessment'+wuid+'_scrambled',overwrite);
s15 := fileservices.addsuperfile('~thor_data400::base::ln_propertyv2::assesor','~thor::base::demo_data_file_ln_propertyv2_file_assessment'+wuid+'_scrambled');

s16 := fileservices.clearsuperfile('~thor_data400::base::ln_propertyv2::deed');
s17 := output(demo_data_scrambler.scramble_ln_propertyv2_file_deed,,'~thor::base::demo_data_file_ln_propertyv2_file_deed'+wuid+'_scrambled',overwrite);
s18 := fileservices.addsuperfile('~thor_data400::base::ln_propertyv2::deed','~thor::base::demo_data_file_ln_propertyv2_file_deed'+wuid+'_scrambled');

build_keys 			:= LN_PropertyV2.proc_build_keys(filedate);	
// build_boolean1 	:= LN_PropertyV2.Proc_Build_Boolean_Keys(filedate); 
// build_boolean2	:= LN_PropertyV2.Proc_Build_Deed_Boolean_Keys(filedate); 

sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,build_keys /*,build_boolean1,build_boolean2 */);
