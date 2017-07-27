import Gong,Gong_v2,ut;

d:= dataset(Gong_v2.thor_cluster+'base::gongv2_built',Gong.layout_gong,thor);

layout := record

string3     bell_id:= '';
string11    filedate:= '';
string1     dual_name_flag:= '';
string10    sequence_number:= '';
string1     listing_type_bus:= '';
string1     listing_type_res:= '';
string1     listing_type_gov:= '';
string1     publish_code:= '';
string1     style_code:= '';
string1     indent_code:= '';
string20    book_neighborhood_code:= '';
string3     prior_area_code:= '';
string10    phone10:= '';
string10    prim_range:= '';
string2     predir:= '';
string28    prim_name:= '';
string4     suffix:= '';
string2     postdir:= '';
string10    unit_desig:= '';
string8     sec_range:= '';
string25    p_city_name:= '';
string2     v_predir:= '';
string28    v_prim_name:= '';
string4     v_suffix:= '';
string2     v_postdir:= '';
string25    v_city_name:= '';
string2     st:= '';
string5     z5:= '';
string4     z4:= '';
string4     cart:= '';
string1     cr_sort_sz:= '';
string4     lot:= '';
string1     lot_order:= '';
string2     dpbc:= '';
string1     chk_digit:= '';
string2     rec_type:= '';
string5     county_code:= '';
string10    geo_lat:= '';
string11    geo_long:= '';
string4     msa:= '';
string7     geo_blk:= '';
string1     geo_match:= '';
string4     err_stat:= '';
string32    designation:= '';
string5     name_prefix:= '';
string20    name_first:= '';
string20    name_middle:= '';
string20    name_last:= '';
string5     name_suffix:= '';
string120   listed_name:= '';
string254   caption_text:= '';
string10    group_id:= '';
string10    group_seq:= '';
string1     omit_address:= '';
string1     omit_phone:= '';
string1     omit_locality:= '';
string64    see_also_text:= '';

end;

	


layout trecs(d L) := transform
self.listed_name := L.company_name;
self.phone10 := L.phoneno;
self := L;
end;

p_d := project(d,trecs(left));


export File_Gong_Base := p_d;





