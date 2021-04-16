import bipv2_proxid,tools;
EXPORT AggregateProxidElements(
	  pDataset
   ,pID                         = 'proxid'
   ,pLimit_ChildDatasets        = '100'
   ,pPrepend_Source_to_Address  = 'true'
   ,pPrepend_Source_to_Phone    = 'true'
   ,pAddDotid                   = 'false'
   ,pOnlyPassedInID             = 'false'
) :=
functionmacro

  import mdr;

	dslim := project(pDataset, transform(
	{
  #IF(trim(#TEXT(pID)) not in ['address','source_record_id','sbfe_id','vl_id'] and trim(#TEXT(pID)) != 'cnp_name_raw')
     pDataset.pId
    ,string source
  #ELSE
     string source
  #END

   #IF(#TEXT(pID) not in ['dotid'] and pAddDotid = true)
    ,pDataset.dotid
   #END

   #IF(pOnlyPassedInID = false)
     #IF(#TEXT(pID) not in ['proxid'])
      ,pDataset.proxid
     #END
     #IF(#TEXT(pID) not in ['lgid3'])
      ,pDataset.lgid3
     #END
     #IF(#TEXT(pID) not in ['seleid'])
      ,pDataset.seleid
     #END
     #IF(#TEXT(pID) not in ['orgid'])
      ,pDataset.orgid
     #END
     #IF(#TEXT(pID) not in ['ultid'])
      ,pDataset.ultid
     #END
   #END
  ,string cnp_name_raw
  ,pDataset.cnp_name
  ,string address
  #IF(trim(#TEXT(pID)) != 'company_phone')
  ,string company_phone
  #END
  ,string a_duns,string a_entnum
  ,string a_corpkey,string fein
  ,string sbfe_id,string vl_id
  ,string source_record_id

  ,pDataset.cnp_number,pDataset.cnp_btype
	,pDataset.prim_name,pDataset.hist_duns_number
  ,string1 company_foreign_domestic,string foreign_corp_key
  ,pDataset.company_name//,string srcridvlid
},
      source_index := STD.Str.Find( left.source, '-', 1 );
//		self.corp_key	:= if(left.company_charter_state != '' and left.company_charter_number != ''	,trim(left.company_charter_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');

    self.sbfe_id           := if(mdr.sourcetools.SourceIsBusiness_Credit(left.source),left.vl_id ,'');
    self.source            :=                                 left.source + '- ' + trim(mdr.sourceTools.translatesource(left.source));
    self.cnp_name          :=                                 left.source + '- ' + trim(left.ingest_status) + '- '+ trim(left.cnp_name                               );
    self.vl_id             := if(trim(left.vl_id)      != '' ,left.source + '- ' + trim(left.vl_id                                  ) ,'');
    self.source_record_id  := if(left.source_record_id != 0  ,left.source + '- ' + trim((string)left.source_record_id               ) ,'');
    self.cnp_name_raw      := left.cnp_name;
    
		self.fein		    := left.company_fein;
    self.a_duns     := left.duns_number;
    self.a_entnum   := left.active_enterprise_number;
    self.a_corpkey  := if(mdr.sourcetools.SourceIsCorpV2(left.source),left.vl_id ,'');
  #IF(trim(#TEXT(pID)) != 'address' and pPrepend_Source_to_Address = true)
		self.address	  := left.source + '- ' +  stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
  #ELSE
		self.address	  := stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
  #END

  #IF(trim(#TEXT(pID)) != 'company_phone' and pPrepend_Source_to_Phone = true)
		self.company_phone := if(trim(left.company_phone) != '' ,left.source + '- ' +  trim(left.company_phone)  ,'');
  #ELSE
		self.company_phone  := trim(left.company_phone);
  #END
//		self.address	:= stringlib.stringcleanspaces(trim(left.company_prim_range,left,right) + ' ' + trim(left.company_prim_name,left,right) + ' ' + trim(left.company_sec_range,left,right) + ' ' + trim(left.company_v_city_name,left,right) + ' ' + trim(left.company_st,left,right) + ' ' + trim(left.company_zip5));
//		self.contact	:= trim(left.fname,left,right) + ' ' + trim(left.lname,left,right);
    // self.srcridvlid  := trim(left.source,left,right) + '-' + trim((string)left.source_record_id,left,right) + '-' + trim(left.vl_id,left,right);
		self					:= left;	
	));
  
  ds_filt := dslim(pID != (typeof(dslim.pID))'') : independent;
	
	dpost := tools.mac_AggregateFieldsPerID(ds_filt,pID,,false,pLimitChildDatasts := pLimit_ChildDatasets);
	
	dcountdotids := project(dpost,transform({recordof(left)}
//    ,self.cnt_dotids    := count(left.dotids  )
//    ,self.cnt_contacts  := count(left.contacts)
//    ,self.cnt_srcvlids  := count(left.srcvlids)
    // ,self.cnt_phones    := count(left.company_phones)
 //   ,self.cnt_company_names    := count(left.company_names)
    ,self := left
  ));
//	dcountdotids := project(dpost,transform({recordof(left) - dotids - contacts,unsigned4 cnt_dotids,unsigned4 cnt_contacts},self.cnt_dotids := count(left.dotids),self.cnt_contacts := count(left.contacts),self := left));
		
	return dcountdotids;
	
endmacro;