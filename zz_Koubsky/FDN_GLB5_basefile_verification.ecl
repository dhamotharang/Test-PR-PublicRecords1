#workunit('name','FDN_GLB5_basefile_validation');
// EXPORT FDN_GLB5_basefile_verification := 'todo';

import FraudDefenseNetwork, ut;

eyeball := 50;
// glb_persist_filename := '~thor400_sta::temp::glb5_1';
glb_persist_filename := '~thor400_60::temp::glb5_1';
basefile_name := '~thor_data400::base::fdn::qa::main';
// basefile_name := ut.foreign_prod + 'thor_data400::base::fdn::20150803::main';

expand_lay := record
	FraudDefenseNetwork.Layouts.base.main;
	boolean cmpyid_flag := false;
	boolean gcid_flag := false;
end;

ds_basefile := dataset('~thor_data400::base::fdn::qa::main', FraudDefenseNetwork.Layouts.base.main, thor);
ds_base_glb := distribute(ds_basefile(source = 'GLB5'), random());

expand_lay check_bad_recs(FraudDefenseNetwork.Layouts.base.main le) := transform

		self.cmpyid_flag := 	le.Sub_Customer_ID in zz_Koubsky.FDN_excluded_cmpy_ids.non_ins_company_id_list;
													// or le.Sub_Customer_ID in zz_Koubsky.FDN_excluded_cmpy_ids.insurance_company_id_list;
		
		// Changed 8/3/2015: Insurance provided customer ID's are actually GC_ID's
		self.gcid_flag := 	le.Customer_ID in zz_Koubsky.FDN_excluded_cmpy_ids.non_insurance_gcid_list
												or le.Sub_Customer_ID in zz_Koubsky.FDN_excluded_cmpy_ids.insurance_company_id_list;
		
		self := le;
end;

ds_flags := project(ds_base_glb, check_bad_recs(left));
ds_bad_cmpyid := ds_flags(cmpyid_flag = true);
ds_bad_gcid := ds_flags(gcid_flag = true);

// **** Total GLB5 Records *******************************
output('**** Total GLB5 Records *******************************');
output(count(ds_base_glb), named('ds_base_glb_count'));
output(choosen(ds_base_glb, eyeball), named('ds_base_glb'));
// **** Total Bad Company IDs ****************************
output('**** Total Bad Company IDs ****************************');
output(count(ds_bad_cmpyid), named('ds_bad_cmpyid_count'));
output(choosen(ds_bad_cmpyid, eyeball), named('ds_bad_cmpyid'));
// **** Total Bad GC_IDs *********************************
output('**** Total Bad GC_IDs *********************************');
output(count(ds_bad_gcid), named('ds_bad_gcid_count'));
output(choosen(ds_bad_gcid, eyeball), named('ds_bad_gcid'));

// Can't test USA restriction

ds_glb := dataset(glb_persist_filename, FraudDefenseNetwork.Layouts.base.Glb5, thor);

dInSegment   := project (ds_glb , transform( FraudDefenseNetwork.Layouts.base.Glb5, 

       self.Industry_segment := map( 
                              left.sybase_app_type in ['INS','AUTO','AIG','LIFE']    => 'INSURANCE' , 
			                        left.sybase_app_type in ['LE','LEG','USLM']      => 'LEGAL' , 
			                        left.sybase_app_type in ['TCOL', 'FCOL', 'COL','COLLECTIONS'] => 'COLLECTIONS' ,
															left.sybase_app_type ='IRB' => 'IRB',
			                        left.sybase_app_type = 'XBPS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'LEGAL',
															left.sybase_app_type = ''  and left.sybase_vertical not in [ 'CORE','','AUTO','USLM'] => left.sybase_vertical ,
			                        left.sybase_app_type = ''  and left.sybase_vertical in [ 'CORE',''] 
															and left.sybase_sub_market = 'PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS' , 'OTHERS'); 
				
				self.sybase_app_type  := map ( 	left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'LIFE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'AUTO',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'USLM',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'USLM',
															left.sybase_app_type = ''  and left.sybase_vertical ='COLLECTIONS' => 'COLLECTIONS',
															left.sybase_app_type = ''  and left.sybase_vertical ='EMERGING' => 'EMERGING',
															left.sybase_app_type = ''  and left.sybase_vertical ='FINANCIAL SERVICES' => 'FINANCIAL SERVICES',
															left.sybase_app_type = ''  and self.Industry_segment ='OTHERS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_sub_market ='PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS',
															left.sybase_app_type);
				
				self := left ));
				
Jdedup       := dedup(dInSegment,linkid, orig_company_id, orig_global_company_id , datetime,all ); 


// What app_types are included in Industry Segment 'OTHERS'?
ds_others := Jdedup(Industry_segment = 'OTHERS');
t_Industry_segment := table(ds_others, {Jdedup.sybase_app_type; _count := count(group)}, sybase_app_type);

// **** Industries from Industry_segment 'OTHERS' *****************************
output('**** Industries from Industry_segment OTHERS *****************************');
output(count(ds_others), named('industry_other_count'));
output(sort(t_Industry_segment, -_count), named('other_industry_segments'));


ds_non_USA := ds_glb(sybase_MAIN_COUNTRY_CODE <> 'USA');

// **** Non USA records *********************************
output('**** Non USA records *********************************');
output(count(ds_non_USA), named('ds_non_USA_count'));
output(choosen(ds_non_USA, eyeball), named('ds_non_USA'));


tbl := table(ds_base_glb, {Rawlinkid, Customer_ID, sub_Customer_ID, event_date, reported_date, _count := count(group)}, Rawlinkid, Customer_ID, sub_Customer_ID, event_date, reported_date, local);
tbl_2 := table(tbl, {Rawlinkid, Customer_ID, sub_Customer_ID, event_date, reported_date, rec_count := sum(group, _count)}, Rawlinkid, Customer_ID, sub_Customer_ID, event_date, reported_date);
tbl_keep := tbl_2(rec_count > 1);

dup_recs := join(ds_base_glb, tbl_keep, 
									left.Rawlinkid = right.Rawlinkid
									and (left.Customer_ID = right.Customer_ID
									or left.sub_Customer_ID = right.sub_Customer_ID)
									and left.event_date = right.event_date
									// and left.reported_date = right.reported_date,
									and left.reported_date = right.reported_date,
									transform(FraudDefenseNetwork.Layouts.base.main, self := left));

// **** Duplicate records *********************************
output('**** Duplicate records *********************************');
output(count(dup_recs), named('dup_recs_count'));
output(choosen(sort(dup_recs,did, Customer_ID, sub_Customer_ID, event_date), eyeball), named('dup_recs'));
