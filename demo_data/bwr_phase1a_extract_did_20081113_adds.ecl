bk := demo_data.base_files.file_bankruptcy_search;
bk_did_layout := record
unsigned6 did :=(integer) bk.did;
end;
did_bk 			:= table(choosesets(bk,(integer) did<>0 =>10),bk_did_layout);


bk_bdid_layout := record
unsigned6 bdid := (integer) bk.bdid;
end;
bdid_bk 		:= table(choosesets(bk,(integer) bdid<>0 =>10),bk_bdid_layout);
//
liens := demo_data.base_files.file_liens_party;
liens_bdid_layout := record
unsigned6 bdid := (integer) liens.bdid;
end;
bdid_liens 		:= table(choosesets(liens,(integer) bdid<>0 =>10),liens_bdid_layout);

prop := demo_data.base_files.file_ln_propertyv2_file_search_did;
prop_bdid_layout := record
unsigned6 bdid := (integer) prop.bdid;
end;
bdid_prop 		:= table(choosesets(prop,(integer) bdid<>0 =>10),prop_bdid_layout);

mv:= demo_data.base_files.file_vehiclev2_party;
mv_bdid_layout := record
unsigned6 bdid :=  mv.append_bdid;
end;
bdid_mv					:=table(choosesets(mv, append_bdid<>0 => 10),mv_bdid_layout);

uccx:=demo_data.base_files.file_uccv2_party_base;
uccx_bdid_layout := record
unsigned6 bdid :=  uccx.bdid;
end;
bdid_ucc 		:= table(choosesets(uccx, bdid<>0 =>10),uccx_bdid_layout);

prop_by_zip := demo_data.base_files.file_ln_propertyv2_file_search_did(zip='48009'); 
propz_bdid_layout := record
unsigned6 bdid := (integer) prop_by_zip.bdid;
end;
bdid_prop_zip 		:= table(prop_by_zip,propz_bdid_layout);
propz_did_layout := record
unsigned6 did := (integer) prop_by_zip.did;
end;
did_prop_zip 		:= table(prop_by_zip,propz_did_layout);

new_dids := dedup(sort(did_bk+did_prop_zip,record),all);
new_bdids:= dedup(sort(bdid_bk+bdid_liens+bdid_prop+bdid_mv+bdid_ucc+bdid_prop_zip,record),all);
//
output(new_dids ,,'~thor_200::base::demo_data_dids_bk_avm_add20081113',overwrite);
output(new_bdids,,'~thor_200::base::demo_data_bdids_basefile_avm_add20081113',overwrite);
