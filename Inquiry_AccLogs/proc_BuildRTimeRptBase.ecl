IMPORT STD, Data_services, ut, inql_v2;

EXPORT proc_BuildRTimeRptBase(string pBeginDate, string pEndDate)  := function

FS:= FileServices;
nxdate 			:= ut.date_math(pEndDate,1);
pRegFind 		:= '('+ pEndDate[1..6] + '[0-9_]+)';

list(string source='', string regex='') := nothor(fileservices.superfilecontents('~thor100_21::in::'+source+'_acclogs_processed'))(regexfind(regex, name));
nextdayFile															:= nothor(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs_processed'))(regexfind(nxdate, name));
acc_list 																:= list('accurint',pRegFind) + nextdayFile;

build_reprocess_acc := sequential(
												FS.StartSuperFileTransaction(),	
														STD.File.ClearSuperFile('~thor100_21::in::accurint_acclogs_reprocess'),
														nothor(Apply(acc_list, STD.File.AddSuperFile('~thor100_21::in::accurint_acclogs_reprocess','~'+name))),
												FS.FinishSuperFileTransaction()
												);																	

raw_log := dataset('~thor100_21::in::accurint_acclogs_reprocess',	Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);															
rt:= record
transaction_id			:= raw_log.orig_transaction_id;
datetime 						:= Inquiry_AccLogs.fncleanfunctions.tTimeAdded(Inquiry_AccLogs.fncleanfunctions.tDateAdded(raw_log.orig_dateadded));
orig_response_time  := raw_log.orig_response_time;
orig_billing_code 	:= raw_log.orig_billing_code;
orig_loginid        := raw_log.orig_loginid;
end;
t_raw   := table(raw_log, rt);
d_raw   := sort(distribute(t_raw,
                 hash(transaction_id, datetime)), 
								 transaction_id, datetime, local);

dbase			:= pull(inql_v2.files().inql_base.qa) 
							(source = 'ACCURINT' 											and 
							search_info.datetime[1..8] >= pBegindate 	and 
							search_info.datetime[1..8] <= pEndDate);
						
wbase			:= pull(inql_v2.files(,false).inql_base.qa)
								(source = 'ACCURINT' 										 and
								search_info.datetime[1..8] >= pBegindate and 
								search_info.datetime[1..8] <= pEndDate);

base    	:= if(inql_v2._Versions.nonfcra_history_base[1..8] > pBegindate,
								dbase + wbase,
								dbase);

d_base 		:= sort(distribute(base,
									hash(search_info.transaction_id, search_info.datetime)), 
									search_info.transaction_id, search_info.datetime, local);

j_base 		:= project(join(d_base,d_raw, 
										left.search_info.transaction_id = right.transaction_id and
										left.search_info.datetime = right.datetime,local), 
										transform({recordof(d_base), rt -transaction_id -datetime},
										          self:=left));

basename  := '~thor100_21::out::inquiry::' + pBeginDate + '::' + pEndDate + '::rtime';

fileexist :=  nothor(fileservices.fileexists(basename));

buildbase := output(j_base,,basename, overwrite, __compressed__);

cleansf    := sequential(
												nothor(fileservices.ClearSuperFile('~thor100_21::base::inquiry::rtime::report')), 
												buildbase,
												nothor(fileservices.AddSuperFile('~thor100_21::base::inquiry::rtime::report',basename)),
												);
												
promotesf  := sequential(buildbase, 
												 nothor(fileservices.promotesuperfilelist(['~thor100_21::base::inquiry::rtime::report',
																																	'~thor100_21::base::inquiry::rtime::report::father',
																																	'~thor100_21::base::inquiry::rtime::report::grandfather'],
																																	basename,true))
												);

seq:= sequential (output(pBeginDate + ' - ' + pEndDate,named('date_range')),
                  build_reprocess_acc,
									if (fileexist, cleansf, promotesf);
									);
									
return seq;

end; 