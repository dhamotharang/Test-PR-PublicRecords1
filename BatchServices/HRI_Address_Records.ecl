import risk_indicators, ut, USPIS_HotList, Autokey_batch;

layout_slim	:= BatchServices.HRI_Address_Layout.output_slim;
layout_in		:= Autokey_batch.Layouts.rec_inBatchMaster;
layout_out	:= BatchServices.HRI_Address_Layout.outrecs;
limit_val 	:= BatchServices.constants.HRIADDR_SERVICE_JOIN_LIMIT;

export HRI_Address_Records(dataset(layout_in) in_data) := function
	
	sequenced_input := project(in_data,transform(layout_in,self.seq := counter,self := left));
	
	//Find addresses in new HRI file.
	records_HRI := join(sequenced_input,Risk_Indicators.Key_Address_To_Sic_Full_HRI,
                   keyed(left.z5=right.z5 and 
                   left.prim_name=right.prim_name and                     
                   left.addr_suffix=right.suffix and
                   left.predir=right.predir and
                   left.postdir=right.postdir and
                   left.prim_range=right.prim_range) and     
												ut.nneq(left.sec_range,right.sec_range), 
												BatchServices.HRI_Address_Transform.get_results(left,right),
												limit(limit_val,skip));
	
	//Find addresses in all business records file
	records_AllBiz := join(sequenced_input,Risk_Indicators.Key_Address_To_Sic,
                   keyed(left.z5=right.z5 and 
                   left.prim_name=right.prim_name and                     
                   left.addr_suffix=right.suffix and
                   left.predir=right.predir and
                   left.postdir=right.postdir and
                   left.prim_range=right.prim_range) and     
												ut.nneq(left.sec_range,right.sec_range), 
												BatchServices.HRI_Address_Transform.get_results_biz(left,right),
												limit(limit_val,skip));
	
	//Find fraudulent address as listed in the USPIS file.	
	records_USPIS := join(sequenced_input,USPIS_HotList.key_addr_search_zip,
												keyed((left.z5=right.zip and left.z5 <> '')and 
												(left.prim_range=right.prim_range and left.prim_range <> '') and     
												(left.prim_name=right.prim_name and left.prim_name <> '') and                     
                   left.addr_suffix=right.addr_suffix and
                   left.predir=right.predir and
                   left.postdir=right.postdir) and                   
												ut.nneq(left.sec_range,right.sec_range),
												BatchServices.HRI_Address_Transform.get_alert_flag(left,right),
												keep(1), limit (0));

	//Merge results from all three look ups above. HRI + BIZ
	ds_outrecs := dedup(sort(group(sort((records_HRI + records_AllBiz),acctno,-ranking),acctno,ranking),-ranking),ranking);
	
	//Pick top few records for each input result and add the USPIS records.
	ds_slim := TOPN(GROUP(sort(ds_outrecs,acctno),acctno), BatchServices.Constants.HRIADDR_SICCODE_DESC_LIMIT, acctno) + records_USPIS;
	
	//Rollup USPIS hits.
	ds_final := rollup(ds_slim, (left.seq=right.seq and left.acctno=right.acctno and left.addr_fraud_alert_flag <> ''), BatchServices.HRI_Address_Transform.xform_rollup(left,right));
	
	//Rank sic codes and attach descriptions.
	ds_results := project(ds_final,BatchServices.HRI_Address_Transform.xform_flat_results(left));
	
	/*Debug 
	output(sequenced_input, named('input'));
	output(ds_slim, named('ds_slim'));
	output(records_USPIS,named('records_USPIS'));
	output(records_HRI,named('records_HRI'));
	output(records_AllBiz,named('records_AllBiz'));
	*/
	return ds_results;

end;