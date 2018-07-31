IMPORT STD, Data_services, ut;

EXPORT proc_BuildSBFEReportBase(string pEndDate, string pBeginDate = '' )  := function

rt := record
string company_id := '';
string transaction_id := '';
string sequence_number := '';
string datetime := '';
string source := '' ;
end;

edate   := if(pEndDate > pBegindate, pEndDate, pBeginDate);
nxdate := ut.date_math(edate,1);

bgDate  := edate[1..6] + '01'; 
bdate   := if(pBeginDate > pEndDate, if(trim(pEndDate,all)='',bgDate,pEndDate ), if(trim(pBeginDate,all)='',bgDate,pBeginDate ));

histbase 	:= Inquiry_AccLogs.File_Inquiry_MBS
(search_info.datetime[1..8] between bdate and edate 	 
and (source = 'BATCH' or source = 'ACCURINT'));

dailybase := (Inquiry_acclogs.File_Accurint_Logs_Common +
						 Inquiry_AccLogs.File_Batch_Logs_Common)
						 (search_info.datetime[1..8] between bdate and edate);
					
hbase 			:= histbase + dailybase;
dbase       := dedup(sort(distribute(hbase), record, local), record, local):persist('~persist::base::inquiry::' + bdate + '::' + edate + '::sbfe::report');

cid       :=	dbase(trim(mbs.company_id,all)<>'');
nocid     :=	dbase(trim(mbs.company_id,all)='');

pRegFind := '('+ edate[1..6] + '[0-9_]+)';

list(string source='', string regex='') := nothor(fileservices.superfilecontents('~ thor100_21::in::'+source+'_acclogs_processed'))(regexfind(regex, name));
addnextdayfile(string nxsource) 				:= if(STD.File.FileExists('~thor100_21::in::' + nxdate + '::' + nxsource+'_acclog')
																								,nothor(STD.File.AddSuperFile('~thor100_21::in::'+nxsource+'_acclogs_reprocess'
																																						 ,'~thor100_21::in::' + nxdate + '::' + nxsource+'_acclog'))) ;	
acc_list := list('accurint',pRegFind);
bat_list:= list('batch',pRegFind);

inpacc := dataset(Data_Services.foreign_logs + 'thor100_21::in::accurint_acclogs_reprocess', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
racc := record
inpacc.orig_company_id;
inpacc.orig_transaction_id;
inpacc.orig_DATEADDED;
orig_sequence_number := '';
source := 'ACCURINT';
end;
tacc := table(inpacc,racc);
accfix := project(tacc,transform(rt, 
														self.COMPANY_ID := left.orig_company_id;
														self.Transaction_ID := left.orig_transaction_id;
														fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_dateadded);
														fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
														self.DateTime := fixTime;
														self.Sequence_number := '';
														self.source := 'ACCURINT'));

inpbat := dataset(Data_Services.foreign_logs + 'thor100_21::in::batch_acclogs_reprocess', Inquiry_AccLogs.Layout_Batch_Logs.extendedInput, csv(maxlength(10000), separator('|'),quote('"')), opt);
rbat := record
inpbat.orig_company_id;
inpbat.orig_job_id;
inpbat.orig_datetime_stamp;
inpbat.orig_sequence_number;
end;

tbat := table(inpbat,rbat);

batfix := project(tbat,transform(rt, 
														self.COMPANY_ID := left.orig_company_id;
														self.Transaction_ID := left.orig_job_id;
														self.Sequence_number := left.orig_sequence_number;
														fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.orig_datetime_stamp[1..8] + ' ' + left.orig_datetime_stamp[9..16]);
														self.DateTime := fixTime;
														self.source := 'BATCH'));

tofix  := accfix + batfix;

dn := sort(distribute(nocid,
                 hash(search_info.transaction_id,search_info.sequence_number, search_info.datetime, source)), 
								 search_info.transaction_id,search_info.sequence_number, search_info.datetime, source, record, local);

df := sort(distribute(tofix,
                 hash(transaction_id,sequence_number,datetime, source)), 
								 transaction_id, sequence_number, datetime, source, record, local);

cid_fixed :=join(dn,df, 
										left.search_info.transaction_id = right.transaction_id and
										left.search_info.sequence_number = right.sequence_number and 
										left.search_info.datetime = right.datetime,
										transform(recordof(dn), 
										self.mbs.company_id := right.company_id,
										self := left), 
										left outer,local);

base := dedup(distribute(cid + cid_fixed),record,local); 

build_reprocess_acc := sequential(STD.File.ClearSuperFile('~thor100_21::in::accurint_acclogs_reprocess'),
																	nothor(Apply(acc_list, STD.File.AddSuperFile('~thor100_21::in::accurint_acclogs_reprocess','~'+name))),
																	addnextdayfile('accurint')
																	);

build_reprocess_bat := sequential(STD.File.ClearSuperFile('~thor100_21::in::batch_acclogs_reprocess'),
																	nothor(Apply(bat_list, STD.File.AddSuperFile('~thor100_21::in::batch_acclogs_reprocess','~'+name))),
																	addnextdayfile('batch')
																	); 

build_reprocess  		:= parallel(build_reprocess_acc,
																build_reprocess_bat);

buildbase := output(base,,'~thor100_21::out::inquiry::' + bdate + '::' + edate + '::sbfe', overwrite, __compressed__);

movebase  := nothor(fileservices.promotesuperfilelist(['~thor100_21::base::inquiry::sbfe::report',
																											 '~thor100_21::base::inquiry::sbfe::report::father',
																											 '~thor100_21::base::inquiry::sbfe::report::grandfather'],
																											 '~thor100_21::out::inquiry::' + bdate + '::' + edate + '::sbfe',true));

seq:= sequential (output(bdate + ' - ' + edate,named('date_range')),
                  build_reprocess,
									buildbase,
									movebase);
									
return seq;

end; 
