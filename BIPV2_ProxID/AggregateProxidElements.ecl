import Business_DOT_SALT_micro9,tools;
EXPORT AggregateProxidElements(
	 dataset(layout_DOT_Base)	pDataset
) :=
function
	dslim := project(pDataset, transform(
	{pDataset.proxid,pDataset.dotid/*,pDataset.company_name*/,pDataset.cnp_name
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
	
	dpost := tools.mac_AggregateFieldsPerID(dslim,proxid,,false,pLimitChildDatasts := 100);
	
	dcountdotids := project(dpost,transform({unsigned6 proxid,unsigned6 cnt_dotids,recordof(left) - company_phones - dotids - proxid,unsigned4 cnt_phones}
//    ,self.cnt_dotids    := count(left.dotids  )
//    ,self.cnt_contacts  := count(left.contacts)
//    ,self.cnt_srcvlids  := count(left.srcvlids)
    ,self.cnt_phones    := count(left.company_phones)
    ,self.cnt_dotids    := count(left.dotids)
 //   ,self.cnt_company_names    := count(left.company_names)
    ,self := left
  ));
//	dcountdotids := project(dpost,transform({recordof(left) - dotids - contacts,unsigned4 cnt_dotids,unsigned4 cnt_contacts},self.cnt_dotids := count(left.dotids),self.cnt_contacts := count(left.contacts),self := left));
		
	return dcountdotids;
	
end;
