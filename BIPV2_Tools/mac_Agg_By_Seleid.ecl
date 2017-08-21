import tools;

EXPORT mac_Agg_By_Seleid(
	 pDataset
) :=
functionmacro

	dslim := project(pDataset, transform(
	{pDataset.seleid,pDataset.proxid,pDataset.company_name,pDataset.cnp_name
  ,pDataset.cnp_number,pDataset.cnp_btype
	,pDataset.prim_name,string address/*,string contact*/,pDataset.source,pDataset.active_duns_number,pDataset.hist_duns_number,pDataset.active_enterprise_number
  ,string1 company_foreign_domestic,string active_domestic_corp_key,string foreign_corp_key,string fein,pdataset.company_phone
},
//		self.corp_key	:= if(left.company_charter_state != '' and left.company_charter_number != ''	,trim(left.company_charter_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');
		self.fein			:= left.company_fein;
		self.address	:= stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
//		self.address	:= stringlib.stringcleanspaces(trim(left.company_prim_range,left,right) + ' ' + trim(left.company_prim_name,left,right) + ' ' + trim(left.company_sec_range,left,right) + ' ' + trim(left.company_v_city_name,left,right) + ' ' + trim(left.company_st,left,right) + ' ' + trim(left.company_zip5));
//		self.contact	:= trim(left.fname,left,right) + ' ' + trim(left.lname,left,right);
//    self.srcvlid  := trim(left.source,left,right) + '-' + trim((string)left.source_record_id,left,right) + '-' + trim(left.vl_id,left,right);
		self					:= left;	
	));
	
	dpost := tools.mac_AggregateFieldsPerID(dslim,seleid,,false);
	
	dcountdotids := project(dpost,transform({recordof(left) - company_phones - proxids,unsigned4 cnt_phones,unsigned4 cnt_proxids}
    ,self.cnt_phones    := count(left.company_phones)
    ,self.cnt_proxids   := count(left.proxids)
    ,self := left
  ));
		
	return dcountdotids;
	
endmacro;
