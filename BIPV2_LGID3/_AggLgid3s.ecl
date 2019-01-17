import BIPV2_LGID3,tools;
EXPORT _AggLgid3s(
	 pDataset
   ,pBIP_ID = 'lgid3'
) :=
functionmacro
	dslim := project(pDataset, transform(
	{pDataset.pBIP_ID  
  #IF(not regexfind('(lgid3|seleid)',#TEXT(pBIP_ID),nocase))  ,pDataset.seleid  #END
  /*,pDataset.source,pDataset.dt_last_seen,pDataset.company_name*/,pDataset.cnp_name//,pdataset.nodes_total
  ,pDataset.active_duns_number,string sbfe_id,string fein,string9 duns_number2,string address,string deleted_key
	,string active_enterprise_number
  ,string active_domestic_corp_key,string foreign_corp_key//,pdataset.company_phone
},
//		self.corp_key	:= if(left.company_charter_state != '' and left.company_charter_number != ''	,trim(left.company_charter_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');
		self.fein			    := left.company_fein;
		self.duns_number2 := left.duns_number;
		// self.corp_key := if(mdr.sourcetools.SourceIsCorpV2(left.source) ,left.vl_id  ,'');
		self.address	:= stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
		// self.address	:= stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
//		self.address	:= stringlib.stringcleanspaces(trim(left.company_prim_range,left,right) + ' ' + trim(left.company_prim_name,left,right) + ' ' + trim(left.company_sec_range,left,right) + ' ' + trim(left.company_v_city_name,left,right) + ' ' + trim(left.company_st,left,right) + ' ' + trim(left.company_zip5));
//		self.contact	:= trim(left.fname,left,right) + ' ' + trim(left.lname,left,right);
//    self.srcvlid  := trim(left.source,left,right) + '-' + trim((string)left.source_record_id,left,right) + '-' + trim(left.vl_id,left,right);
		self					:= left;	
    self          := [];
	));
	
	dpost := tools.mac_AggregateFieldsPerID(dslim,pBIP_ID,,false,pLimitChildDatasts := 100);
	
	dcountdotids := project(dpost,transform({recordof(left) /*,unsigned4 cnt_seleids*/}
//    ,self.cnt_dotids    := count(left.dotids  )
//    ,self.cnt_contacts  := count(left.contacts)
//    ,self.cnt_srcvlids  := count(left.srcvlids)
    // ,self.cnt_phones    := count(left.company_phones)
    // ,self.cnt_seleids   := count(left.seleids)
    // ,self.dt_last_seens              := choosen(left.dt_last_seens              ,50)
    // ,self.cnp_names                  := choosen(left.cnp_names                  ,50)
    // ,self.cnp_numbers                := choosen(left.cnp_numbers                ,50)
    // ,self.cnp_btypes                 := choosen(left.cnp_btypes                 ,50)
    // ,self.addresss                   := choosen(left.addresss                   ,50)
    // ,self.company_charter_numbers    := choosen(left.company_charter_numbers    ,50)
    // ,self.company_inc_states         := choosen(left.company_inc_states         ,50)
    // ,self.active_duns_numbers        := choosen(left.active_duns_numbers        ,50)
    // ,self.duns_number2s               := choosen(left.duns_number2s               ,50)
    // ,self.active_enterprise_numbers  := choosen(left.active_enterprise_numbers  ,50)
    // ,self.company_foreign_domestics  := choosen(left.company_foreign_domestics  ,50)
    // ,self.active_domestic_corp_keys  := choosen(left.active_domestic_corp_keys  ,50)
    // ,self.foreign_corp_keys          := choosen(left.foreign_corp_keys          ,50)
    // ,self.feins                      := choosen(left.feins                      ,50)
 //   ,self.cnt_company_names    := count(left.company_names)
    ,self := left
  ));
//	dcountdotids := project(dpost,transform({recordof(left) - dotids - contacts,unsigned4 cnt_dotids,unsigned4 cnt_contacts},self.cnt_dotids := count(left.dotids),self.cnt_contacts := count(left.contacts),self := left));
		
	return dcountdotids;
	
endmacro;
