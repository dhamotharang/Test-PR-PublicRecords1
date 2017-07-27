import business_header;
//doxie_cbrs.mac_Selection_Declare()
//ut.MAC_Slim_Back(supergroup_ds, doxie_cbrs.layout_supergroup, outf)

export ds_SupergroupLevels(dataset(doxie_cbrs.layout_references) bdids = dataset([], doxie_cbrs.layout_references)) := 
	if(exists(bdids),project(bdids,transform(doxie_cbrs.layout_supergroup,self:=left,self:=[])),
	business_header.getSupergroup
	(business_header.stored_bdid_value, business_header.stored_use_Levels_val));