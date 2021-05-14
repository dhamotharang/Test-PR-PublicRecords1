import FLAccidents_Ecrash, _control, Data_Services, std;

//Request from ecrash team ==> https://jira.rsi.lexisnexis.com/browse/CRU-1549
export Update_Incident_MI_Vendor_Iyetek2MSP :=function

	Env := if(_control.ThisEnvironment.Name = 'Prod', '~', Data_Services.foreign_prod);	

	Good_MIOri :=	['MI3849700','MI6116100','MI1911900','MI0610600','MI8277500','MI3813800','MI8218200','MI8270900','MI3787000','MI4748200',
								 'MI3384300','MI7866000','MI8247100','MI7817800','MI7835800','MI4620200','MI8121800','MI2312300','MI3313300','MI3467900',
								 'MI0310300','MI1972500','MI3759900','MI3713700','MI1323700','MI3413400','MI7859600','MI2583900','MI4614600','MI5425600',
								 'MI4632000','MI1356000','MI5415400'];

	ds_incident := dataset(Env + 'thor_data400::in::ecrash::incidnt_raw_new'
												 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
												 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID'):PERSIST('~thor::persist::incidnt_raw_new::vendorcode_upd', single, expire(5));
	
  ds_incident_Iytk := ds_incident(std.Str.ToUpperCase(trim(vendor_code,all)) = 'IYETEK');
	ds_incident_Not_Iytk := ds_incident(~(std.Str.ToUpperCase(trim(vendor_code,all)) = 'IYETEK'));	

	ds_incident_Iytk_MI := ds_incident_Iytk(STD.Str.ToUpperCase(trim(Loss_State_Abbr,all)) ='MI');
	ds_incident_Iytk_Not_MI := ds_incident_Iytk(~(STD.Str.ToUpperCase(trim(Loss_State_Abbr,all)) ='MI'));		

	ds_incident_Iytk_MI_TmTf:= ds_incident_Iytk_MI(std.Str.ToUpperCase(trim(source_id,all)) in ['TM','TF']);
	ds_incident_Iytk_MI_NotTmTf := ds_incident_Iytk_MI(~(std.Str.ToUpperCase(trim(source_id,all)) in ['TM','TF']));
	
	ds_incident_Iytk_MI_TmTf_good := ds_incident_Iytk_MI_TmTf(std.Str.ToUpperCase(trim(ori_number,all)) in Good_MIOri );
	ds_incident_Iytk_MI_TmTf_bad := ds_incident_Iytk_MI_TmTf(~(std.Str.ToUpperCase(trim(ori_number,all)) in Good_MIOri ));
	
	FLAccidents_Ecrash.Layout_Infiles.incident_new UpdVendorCode(ds_incident_Iytk_MI_TmTf_bad L) := transform
			self.Vendor_Code := 'MSP';
			self := L;
  end;

	ds_incident_Iytk_MI_TmTf_bad_upd := project(ds_incident_Iytk_MI_TmTf_bad, UpdVendorCode(left));
	
	ds_incident_all := ds_incident_Not_Iytk + ds_incident_Iytk_Not_MI + ds_incident_Iytk_MI_NotTmTf + 
	                   ds_incident_Iytk_MI_TmTf_good + ds_incident_Iytk_MI_TmTf_bad_upd;
										 
	ds_incident_upd := output(ds_incident_all,,'~thor_data400::in::ecrash::incident_update_vendorcode_'+ workunit, overwrite, __compressed__,
				                    csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

	do_all :=  sequential(
	                      ds_incident_upd,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', false),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_update_vendorcode_' + workunit),
												FileServices.FinishSuperFileTransaction()
											 );
					 
		return do_all;
end;

	// output(count(ds_incident_Iytk), named('ds_incident_Iytk')); 
	// output(count(ds_incident_Not_Iytk), named('ds_incident_Not_Iytk'));
	// output(count(ds_incident_Iytk_MI), named('ds_incident_Iytk_MI'));
	// output(count(ds_incident_Iytk_Not_MI), named('ds_incident_Iytk_Not_MI'));
	// output(count(ds_incident_Iytk_MI_TmTf), named('ds_incident_Iytk_MI_TmTf'));
	// output(count(ds_incident_Iytk_MI_NotTmTf), named('ds_incident_Iytk_MI_NotTmTf'));
	// output(count(ds_incident_Iytk_MI_TmTf_good), named('ds_incident_Iytk_MI_TmTf_good'));
	// output(count(ds_incident_Iytk_MI_TmTf_bad), named('ds_incident_Iytk_MI_TmTf_bad'));
	// output(count(ds_incident), named('ds_incident'));
	// output(count(ds_incident_all), named('ds_incident_all'));
	// cnt_msp_before := count(ds_incident(std.Str.ToUpperCase(trim(vendor_code,all)) = 'MSP'));
	// cnt_msp_after := count(ds_incident_all(std.Str.ToUpperCase(trim(vendor_code,all)) = 'MSP'));
	// output(cnt_msp_before, named('cnt_msp_before'));
	// output(cnt_msp_after, named('cnt_msp_after'));
	// output((cnt_msp_after - cnt_msp_before), named('cnt_msp_updated'));
  //W20200409-121305
