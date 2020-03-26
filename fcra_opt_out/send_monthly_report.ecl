//Sends via email a monthly report including the number of unique DIDs in the FCRA Optout file
import ut, did_add, _control, Data_Services;
dids_qa 			 		:= pull(fcra_opt_out.key_did);
unique_dids_qa 		:= count(dedup(sort(distribute(dids_qa (l_DID > 0), hash(l_DID)), l_DID, local), l_DID, local));
prod_version 			:= did_add.get_EnvVariable('fcra_optout_version', _control.roxieEnv.prod_batch_fcra);
prod_file_        := Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fcra::optout::' + prod_version  + '::did';

FileTest					:= fileservices.FileExists(prod_file_);
rec								:= record
										string filename := '';
										end;
d									:= dataset([{'na'}],rec);
rec x(d l) 				:= transform
										self.filename := if(FileTest,prod_file_,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fcra::optout::did_qa'); 
										end;
p									:= nothor(project(global(d,few),x(left)));
prod_file         := p[1].filename;
dids_prod 				:= pull(index(fcra_opt_out.key_did, prod_file ));

unique_dids_prod  :=  count(dedup(sort(distribute(dids_prod (l_DID > 0), hash(l_DID)), l_DID, local), l_DID, local));
notification_list := 'angela.herzberg@lexisnexis.com; mike.woodberry@lexisnexis.com; brad.dolesh@lexisnexis.com; Seth.Partain@lexisnexisrisk.com; Jamie.Martin@lexisnexisrisk.com; Chad.Kimble@lexisnexisrisk.com' ;
subject 					:= 'REPORT - Equifax Prescreen Opt-Out';
Body 							:= 'Total number of unique LexIds in the Equifax Prescreen Opt-Out file: ' +   ut.intWithCommas(unique_dids_qa) + '*\n\n' +
										'*figure reflects data under QA.  ' + 
										if(fileservices.FileExists(prod_file_), '\nCurrent production figure is ' + ut.intWithCommas(unique_dids_prod), '') ;

fileservices.sendemail(notification_list,
														Subject,
														Body );

//Every first monday of the month at 9 am
//EveryMonth := CRON('* 14 * 1-12/1 1');
//sequential(email_report);
// :WHEN(EveryMonth);