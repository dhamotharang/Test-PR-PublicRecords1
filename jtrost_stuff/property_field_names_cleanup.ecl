import address;

export property_field_names_cleanup(dataset(recordof(jtrost_stuff.layout_property_field_names_normalized)) in_ds) := function;

layout_property_field_names_normalized xform_cleanup1(jtrost_stuff.property_field_names_normalized le) := transform
 
 integer v_name_length := length(trim(le.orig_name));
 boolean v_last_char_is_comma := le.orig_name[v_name_length]=',';
 
 self.name_standard := if(v_last_char_is_comma,le.orig_name[1..v_name_length-1],le.orig_name);
 self := le;
end;

ds_remove_trailing_comma := project(jtrost_stuff.property_field_names_normalized,xform_cleanup1(left));

layout_property_field_names_normalized xform_cleanup2(layout_property_field_names_normalized le) := transform
 
 string v_name1  := stringlib.stringfindreplace(le.name_standard, ' LN ',' LOAN ');
 string v_name2  := stringlib.stringfindreplace(v_name1, ' SVCS ',' SERVICES ');
 string v_name3  := stringlib.stringfindreplace(v_name2, ' HM ',' HOME ');
 string v_name4  := stringlib.stringfindreplace(v_name3, ' LNS ',' LOANS ');
 string v_name5  := stringlib.stringfindreplace(v_name4, ' SVCNG ',' SERVICING ');
 string v_name6  := stringlib.stringfindreplace(v_name5, ' BKNG ',' BANKING ');
 string v_name7  := stringlib.stringfindreplace(v_name6, ' FINL ',' FINANCIAL ');
 string v_name8  := stringlib.stringfindreplace(v_name7, ' FIN ',' FINANCE ');
 string v_name9  := stringlib.stringfindreplace(v_name8, ' MTG ',' MORTGAGE ');
 string v_name10 := stringlib.stringfindreplace(v_name9, ' CORP ',' CORPORATION ');
 string v_name11 := stringlib.stringfindreplace(v_name10,' DEPT ',' DEPARTMENT ');
 string v_name12 := stringlib.stringfindreplace(v_name11,' NATL ',' NATIONAL ');
 string v_name13 := stringlib.stringfindreplace(v_name12,' ASSN ',' ASSOCIATION ');
 string v_name14 := stringlib.stringfindreplace(v_name13,' INS ',' INSURANCE ');
 string v_name15 := stringlib.stringfindreplace(v_name14,' BK ',' BANK ');
 string v_name16 := stringlib.stringfindreplace(v_name15,' NAT\'L ',' NATIONAL ');
 
 string v_ln_found    := if(stringlib.stringfind(le.name_standard,' LN ',1)>0,   'LN|','');
 string v_svcs_found  := if(stringlib.stringfind(le.name_standard,' SVCS ',1)>0, 'SVCS|','');
 string v_hm_found    := if(stringlib.stringfind(le.name_standard,' HM ',1)>0,   'HM|','');
 string v_lns_found   := if(stringlib.stringfind(le.name_standard,' LNS ',1)>0,  'LNS|','');
 string v_svcng_found := if(stringlib.stringfind(le.name_standard,' SVCNG ',1)>0,'SVCNG|','');
 string v_bkng_found  := if(stringlib.stringfind(le.name_standard,' BKNG ',1)>0, 'BKNG|','');
 string v_finl_found  := if(stringlib.stringfind(le.name_standard,' FINL ',1)>0, 'FINL|','');
 string v_fin_found   := if(stringlib.stringfind(le.name_standard,' FIN ',1)>0,  'FIN|','');
 string v_mtg_found   := if(stringlib.stringfind(le.name_standard,' MTG ',1)>0,  'MTG|','');
 string v_corp_found  := if(stringlib.stringfind(le.name_standard,' CORP ',1)>0, 'CORP|','');
 string v_dept_found  := if(stringlib.stringfind(le.name_standard,' DEPT ',1)>0, 'DEPT|','');
 string v_natl_found  := if(stringlib.stringfind(le.name_standard,' NATL ',1)>0, 'NATL|','');
 string v_natl2_found := if(stringlib.stringfind(le.name_standard,' NAT\'L ',1)>0, 'NAT\'L|','');
 string v_assn_found  := if(stringlib.stringfind(le.name_standard,' ASSN ',1)>0, 'ASSN|','');
 string v_ins_found   := if(stringlib.stringfind(le.name_standard,' INS ',1)>0,  'INS|','');
 string v_bk_found    := if(stringlib.stringfind(le.name_standard,' BK ',1)>0,   'BK|','');
 
 
 self.name_standard := v_name16;
 self.abbreviations_found := v_ln_found+v_svcs_found+v_hm_found+v_lns_found+v_svcng_found
                            +v_bkng_found+v_finl_found+v_fin_found+v_mtg_found+v_corp_found
														+v_dept_found+v_natl_found+v_natl2_found+v_assn_found+v_ins_found+v_bk_found;
 self := le;
end;

ds_expand_abbreviations := project(ds_remove_trailing_comma,xform_cleanup2(left));
improved_names          := ds_expand_abbreviations;
 
address.Mac_Is_Business(improved_names,name_standard,add_entity_flag,nametype,false,false);

ds_add_entity_flag0 := add_entity_flag : persist('persist::jtrost_epic_add_entity_flag');
ds_add_entity_flag  := dataset('~thor400_20::persist::jtrost_epic_add_entity_flag',recordof(ds_add_entity_flag0),flat);
 													
return ds_add_entity_flag0;

end;
//EXPORT property_field_names_cleanup := ds_add_entity_flag0;