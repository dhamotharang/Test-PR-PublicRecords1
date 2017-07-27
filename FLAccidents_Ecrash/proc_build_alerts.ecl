export proc_build_alerts(string timestamp):= function

d := FLAccidents_Ecrash.BaseFile;

layout_corrections := record
string entity_type;
string entity_id;
string entity_id2;
string create_date;
end;

layout_corrections trecs(d L) := transform
self.entity_type  := 'ecr-rpt';
self.entity_id    := L.Case_Identifier; 
self.entity_id2   := 'Florida Highway Patrol';//L.Agency_Name;
self.create_date  := L.date_vendor_last_reported;
end;

precs := project(dedup(d(case_identifier!=''),case_identifier,all),trecs(left));

return
sequential(
	 output(dedup(precs,record,all),,'~thor_data400::out::ecrash::'+timestamp+'::report_update'
												,csv(terminator('\n')
												,separator(','))
												,overwrite)
	,fileservices.Despray('~thor_data400::out::ecrash::'+timestamp+'::report_update'
												, 'edata12-bld.br.seisint'
												, '/super_credit/ecrash/account_monitoring/ecrash_'+timestamp+'_report-update.csv')
					);

end;