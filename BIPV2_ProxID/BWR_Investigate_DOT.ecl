lproxid := 206036;
pDataset := BIPV2_ProxID.Files().base.qa;
ddotsinproxid := pdataset(proxid = lproxid);
dAggOverall_raw := BIPV2_ProxID.AggregateDOTidElements(ddotsinproxid,false);
dAggOverall	:= project(dAggOverall_raw	,transform(recordof(dAggOverall_raw)	
,self.company_names		 := sort(left.company_names		,company_name		)
,self.dba_names				 := sort(left.dba_names				,dba_name				)
,self.corp_legal_names				 := sort(left.corp_legal_names				,corp_legal_name				)
,self.addresss				 := sort(left.addresss				,address				)
,self.contacts				 := sort(left.contacts				,contact				)
,self.sources				 	 := sort(left.sources				,source				)
,self.vl_ids				 	 := sort(left.vl_ids				,vl_id				)
,self.active_domestic_corp_keys				 := sort(left.active_domestic_corp_keys				,active_domestic_corp_key				)
,self := left
));
output(dAggOverall,all);
