import demo_data;
import ln_propertyv2;
import lib_stringlib;
file_in:= dataset('~thor::base::demo_data_file_ln_propertyv2_file_assessment_prodcopy',LN_PropertyV2.layout_property_common_model_base,flat);

// no clean fields in this record, let's see what is displayed in the app first, may have to roll up from search

layout_rolled_names := record
string rolled_up_name;
LN_PropertyV2.Layout_DID_Out;
end;
layout_rolled_names to_prep(ln_propertyv2.layout_did_out l) := transform
self.rolled_up_name := if(l.cname<>'',l.cname,trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname));
self := l;
end;
prepped_ds := project(dedup(sort(distribute(demo_data_scrambler.scramble_ln_propertyv2_file_search_did,hash(ln_fares_id)),ln_fares_id,source_code,lname,fname,mname,local),ln_fares_id,source_code,lname,fname,mname,local),to_prep(left),local);
layout_rolled_names to_rollup_names(prepped_ds l,prepped_ds r) := transform
self.rolled_up_name := l.rolled_up_name+'/'+if(r.cname<>'',r.cname,trim(r.fname)+' '+trim(r.mname)+' '+trim(r.lname));
self := l;
end;
my_rolled_names := rollup(sort(prepped_ds,ln_fares_id,source_code,local),to_rollup_names(left,right), left.ln_fares_id=right.ln_fares_id and left.source_code=right.source_code,local);


file_in to_scramble_local(file_in l, my_rolled_names r) := transform

//self.fares_unformatted_apn := IF(L.fares_unformatted_apn <> '','X'+fn_scramblePII('SCR_SECOND',L.fares_unformatted_apn),'');
self.fares_unformatted_apn :='X'+stringlib.stringfindreplace(l.fares_unformatted_apn[2..],'1','2');
//self.apna_or_pin_number  := IF(L.apna_or_pin_number <> '','X'+fn_scramblePII('SCR_SECOND',L.apna_or_pin_number ),'');
self.apna_or_pin_number := 'X'+stringlib.stringfindreplace(l.fares_unformatted_apn[2..],'1','2');
self.assessee_name := r.rolled_up_name;
self.second_assessee_name := '';
self.mailing_care_of_name := '';
self.mailing_full_street_address := '';
self.mailing_unit_number := '';
self.mailing_city_state_zip := '';
self.property_full_street_address := trim(r.prim_range)+' '+trim(r.prim_name)+' '+trim(r.postdir);
self.property_unit_number := trim(r.unit_desig)+' '+trim(r.sec_range);
self.property_city_state_zip := trim(r.v_city_name)+' '+trim(r.st);
self.recording_date := demo_data_scrambler.fn_scramblePII('DOB',l.recording_date);
self.transfer_date:= demo_data_scrambler.fn_scramblePII('DOB',l.transfer_date);
self.sale_date:= demo_data_scrambler.fn_scramblePII('DOB',l.sale_date);
self.recorder_document_number:= demo_data_scrambler.fn_scramblePII('NUMBER',l.recorder_document_number);
self.recorder_book_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.recorder_book_number);
self.recorder_page_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.recorder_page_number);
self := l;
end;
scrambled_in := join(distribute(file_in,hash(ln_fares_id)),distribute(my_rolled_names,hash(ln_fares_id)),left.ln_fares_id=right.ln_fares_id,to_scramble_local(left,right),local,left outer);

export scramble_ln_propertyv2_file_assessment := dedup(sort(scrambled_in(vendor_source_flag='O'),record),all);
