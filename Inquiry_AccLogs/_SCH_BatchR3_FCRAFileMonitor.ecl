import ut;

#workunit('name','Prod R3 File Monitor')

datetime := stringlib.stringfilter(ut.GetTimeDate(), '0123456789');

BatchR3ContentsProd := fileservices.superfilecontents(ut.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::fcra::inquirytracking');

isempty(string ftype) := 
		count(fileservices.superfilecontents(ut.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::fcra::inquirytracking')) > 0;

BatchR3FileProd := inquiry_acclogs.Proc_Prod_R3Monitoring.File_Monitoring_FCRA;

prod := if(count(BatchR3Contentsprod) > 0, 'PROD ', '');

emailcontents := workunit + ' - ' + prod;
emailsubject := 'BatchR3 Logs Output - ' + datetime;

emailSend := if(count(BatchR3Contentsprod) > 0,
									fileservices.sendemail('cecelie.guyton@lexisnexis.com', emailsubject, emailcontents));

/* CLEAR CONTENTS */

isSunday := ut.weekday((unsigned6)ut.GetDate[1..8]) = 'SUNDAY';		

/* PERFORM CALLS */

sequential(

if(isSunday,fileservices.clearsuperfile('~thor10_231::in::batchr3_acclogs_contents'));

parallel(

if(count(BatchR3ContentsProd) > 0,
sequential(
	output(BatchR3ContentsProd, named('BatchR3Prod_Superfile_Contents')),
		output(BatchR3FileProd,, '~thor10_231::in::'+datetime+'_Prod::batchr3', overwrite, __compressed__);
		output(BatchR3ContentsProd,,'~thor10_231::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents');
	fileservices.addsuperfile('~thor10_231::in::prodr3_acclogs_preprocess', '~thor10_231::in::'+datetime+'_Prod::batchr3');
	fileservices.addsuperfile('~thor10_231::in::batchr3_acclogs_contents','~thor10_231::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents')
)))
,emailSend
)

	: WHEN(CRON('00 0-23/12 * * *'));

