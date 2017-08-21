layout_master := record
Gong.Layout_Master_origOnly_PR;
Gong.Layout_MasterFieldsOnly;
end;

d	:= dataset('~thor_200::in::pr_master.20060707.d00',layout_master,thor);

stat_rec :=  record

d.bell_id;

totalrecs := count(group);

has_bell_id := AVE(group,IF(stringlib.stringfilterout(d.bell_id,'0')<>' ',100,0));
has_filedate := AVE(group,IF(stringlib.stringfilterout(d.filedate,'0')<>' ',100,0));
has_sequence_number := AVE(group,IF(stringlib.stringfilterout(d.sequence_number,'0')<>' ',100,0));
has_master_id := AVE(group,IF(stringlib.stringfilterout(d.master_id,'0')<>' ',100,0));
has_dual_name_flag := AVE(group,IF(stringlib.stringfilterout(d.dual_name_flag,'0')<>' ',100,0));
has_action_code := AVE(group,IF(stringlib.stringfilterout(d.action_code,'0')<>' ',100,0));
has_recid := AVE(group,IF(stringlib.stringfilterout(d.recid,'0')<>' ',100,0));
has_listing_type_bus := AVE(group,IF(stringlib.stringfilterout(d.listing_type_bus,'0')<>' ',100,0));
has_listing_type_res := AVE(group,IF(stringlib.stringfilterout(d.listing_type_res,'0')<>' ',100,0));
has_listing_type_gov := AVE(group,IF(stringlib.stringfilterout(d.listing_type_gov,'0')<>' ',100,0));
has_publish_code := AVE(group,IF(stringlib.stringfilterout(d.publish_code,'0')<>' ',100,0));
has_style_code := AVE(group,IF(stringlib.stringfilterout(d.style_code,'0')<>' ',100,0));
has_line_type := AVE(group,IF(stringlib.stringfilterout(d.line_type,'0')<>' ',100,0));
has_indent_code := AVE(group,IF(stringlib.stringfilterout(d.indent_code,'0')<>' ',100,0));
has_book_neighborhood_code := AVE(group,IF(stringlib.stringfilterout(d.book_neighborhood_code,'0')<>' ',100,0));
has_prior_area_code := AVE(group,IF(stringlib.stringfilterout(d.prior_area_code,'0')<>' ',100,0));
has_area_code_change_date := AVE(group,IF(stringlib.stringfilterout(d.area_code_change_date,'0')<>' ',100,0));
has_area_code := AVE(group,IF(stringlib.stringfilterout(d.area_code,'0')<>' ',100,0));
has_phone_number := AVE(group,IF(stringlib.stringfilterout(d.phone_number,'0')<>' ',100,0));
has_listed_name := AVE(group,IF(stringlib.stringfilterout(d.listed_name,'0')<>' ',100,0));
has_caption_text := AVE(group,IF(stringlib.stringfilterout(d.caption_text,'0')<>' ',100,0));
has_name1_prefix := AVE(group,IF(stringlib.stringfilterout(d.name1_prefix,'0')<>' ',100,0));
has_name1_first := AVE(group,IF(stringlib.stringfilterout(d.name1_first,'0')<>' ',100,0));
has_name1_middle := AVE(group,IF(stringlib.stringfilterout(d.name1_middle,'0')<>' ',100,0));
has_name1_last := AVE(group,IF(stringlib.stringfilterout(d.name1_last,'0')<>' ',100,0));
has_name1_suffix := AVE(group,IF(stringlib.stringfilterout(d.name1_suffix,'0')<>' ',100,0));
has_name2_prefix := AVE(group,IF(stringlib.stringfilterout(d.name2_prefix,'0')<>' ',100,0));
has_name2_first := AVE(group,IF(stringlib.stringfilterout(d.name2_first,'0')<>' ',100,0));
has_name2_middle := AVE(group,IF(stringlib.stringfilterout(d.name2_middle,'0')<>' ',100,0));
has_name2_last := AVE(group,IF(stringlib.stringfilterout(d.name2_last,'0')<>' ',100,0));
has_name2_suffix := AVE(group,IF(stringlib.stringfilterout(d.name2_suffix,'0')<>' ',100,0));
has_designation := AVE(group,IF(stringlib.stringfilterout(d.designation,'0')<>' ',100,0));
has_prim_range := AVE(group,IF(stringlib.stringfilterout(d.prim_range,'0')<>' ',100,0));
has_predir := AVE(group,IF(stringlib.stringfilterout(d.predir,'0')<>' ',100,0));
has_prim_name := AVE(group,IF(stringlib.stringfilterout(d.prim_name,'0')<>' ',100,0));
has_suffix := AVE(group,IF(stringlib.stringfilterout(d.suffix,'0')<>' ',100,0));
has_postdir := AVE(group,IF(stringlib.stringfilterout(d.postdir,'0')<>' ',100,0));
has_unit_desig := AVE(group,IF(stringlib.stringfilterout(d.unit_desig,'0')<>' ',100,0));
has_sec_range := AVE(group,IF(stringlib.stringfilterout(d.sec_range,'0')<>' ',100,0));
has_p_city_name := AVE(group,IF(stringlib.stringfilterout(d.p_city_name,'0')<>' ',100,0));
has_v_predir := AVE(group,IF(stringlib.stringfilterout(d.v_predir,'0')<>' ',100,0));
has_v_prim_name := AVE(group,IF(stringlib.stringfilterout(d.v_prim_name,'0')<>' ',100,0));
has_v_suffix := AVE(group,IF(stringlib.stringfilterout(d.v_suffix,'0')<>' ',100,0));
has_v_postdir := AVE(group,IF(stringlib.stringfilterout(d.v_postdir,'0')<>' ',100,0));
has_v_city_name := AVE(group,IF(stringlib.stringfilterout(d.v_city_name,'0')<>' ',100,0));
has_st := AVE(group,IF(stringlib.stringfilterout(d.st,'0')<>' ',100,0));
has_z5 := AVE(group,IF(stringlib.stringfilterout(d.z5,'0')<>' ',100,0));
has_z4 := AVE(group,IF(stringlib.stringfilterout(d.z4,'0')<>' ',100,0));
has_cart := AVE(group,IF(stringlib.stringfilterout(d.cart,'0')<>' ',100,0));
has_cr_sort_sz := AVE(group,IF(stringlib.stringfilterout(d.cr_sort_sz,'0')<>' ',100,0));
has_lot := AVE(group,IF(stringlib.stringfilterout(d.lot,'0')<>' ',100,0));
has_lot_order := AVE(group,IF(stringlib.stringfilterout(d.lot_order,'0')<>' ',100,0));
has_dpbc := AVE(group,IF(stringlib.stringfilterout(d.dpbc,'0')<>' ',100,0));
has_chk_digit := AVE(group,IF(stringlib.stringfilterout(d.chk_digit,'0')<>' ',100,0));
has_rec_type := AVE(group,IF(stringlib.stringfilterout(d.rec_type,'0')<>' ',100,0));
has_county := AVE(group,IF(stringlib.stringfilterout(d.county,'0')<>' ',100,0));
has_geo_lat := AVE(group,IF(stringlib.stringfilterout(d.geo_lat,'0')<>' ',100,0));
has_geo_long := AVE(group,IF(stringlib.stringfilterout(d.geo_long,'0')<>' ',100,0));
has_msa := AVE(group,IF(stringlib.stringfilterout(d.msa,'0')<>' ',100,0));
has_geo_blk := AVE(group,IF(stringlib.stringfilterout(d.geo_blk,'0')<>' ',100,0));
has_geo_match := AVE(group,IF(stringlib.stringfilterout(d.geo_match,'0')<>' ',100,0));
has_err_stat := AVE(group,IF(stringlib.stringfilterout(d.err_stat,'0')<>' ',100,0));

end;

stats := table(d,stat_rec,bell_id,few);
stats_sorted := sort(stats,bell_id);

export stats_FieldPop_GongMaster := output(choosen(stats_sorted,all)); 
