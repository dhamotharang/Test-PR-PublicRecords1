//dsummaddr := Commercial_Fraud.Persists().fSummarizeAddressCorpV2Append;
dsummaddr		:= commercial_fraud.files('20100312b').address_summary.new;

countdsummaddr_bizataddress 	:= count(dsummaddr(Count_Business_At_Address	!= 0));
countdsummaddr_del_biz 			:= count(dsummaddr(Count_Delinquent_Business_At_Address	!= 0));
countdsummaddr_derog_biz 		:= count(dsummaddr(Count_Derogatory_Business_At_Address	!= 0));


dsummaddr_bizataddress 	:= dsummaddr(Count_Business_At_Address	!= 0);
dsummaddr_del_biz 			:= dsummaddr(Count_Delinquent_Business_At_Address	!= 0);
dsummaddr_derog_biz 		:= dsummaddr(Count_Derogatory_Business_At_Address	!= 0);

parallel(

	 output(dsummaddr_bizataddress								,named('dsummaddr_bizataddress'))
	,output(dsummaddr_del_biz 										,named('dsummaddr_del_biz'))
	,output(dsummaddr_derog_biz 									,named('dsummaddr_derog_biz'))
	,output(countdsummaddr_bizataddress								,named('countdsummaddr_bizataddress'))
	,output(countdsummaddr_del_biz 										,named('countdsummaddr_del_biz'))
	,output(countdsummaddr_derog_biz 									,named('countdsummaddr_derog_biz'))
);

dsummaddrcurrpersist := Commercial_Fraud.persists().fSummarizeAddressCorpV2Append;

dsummaddr := Commercial_Fraud.fSummarize_Address_CorpV2();

countdsummaddr_bizataddress 	:= count(dsummaddr(Count_Business_At_Address	!= 0));
countdsummaddr_del_biz 			:= count(dsummaddr(Count_Delinquent_Business_At_Address	!= 0));
countdsummaddr_derog_biz 		:= count(dsummaddr(Count_Derogatory_Business_At_Address	!= 0));

countdsummaddrcurrpersist_bizataddress := count(dsummaddrcurrpersist(Count_Business_At_Address	!= 0));
countdsummaddrcurrpersist_del_biz 			:= count(dsummaddrcurrpersist(Count_Delinquent_Business_At_Address	!= 0));
countdsummaddrcurrpersist_derog_biz 		:= count(dsummaddrcurrpersist(Count_Derogatory_Business_At_Address	!= 0));

dsummaddr_bizataddress 	:= dsummaddr(Count_Business_At_Address	!= 0);
dsummaddr_del_biz 			:= dsummaddr(Count_Delinquent_Business_At_Address	!= 0);
dsummaddr_derog_biz 		:= dsummaddr(Count_Derogatory_Business_At_Address	!= 0);

dsummaddrcurrpersist_bizataddress := dsummaddrcurrpersist(Count_Business_At_Address	!= 0);
dsummaddrcurrpersist_del_biz 			:= dsummaddrcurrpersist(Count_Delinquent_Business_At_Address	!= 0);
dsummaddrcurrpersist_derog_biz 		:= dsummaddrcurrpersist(Count_Derogatory_Business_At_Address	!= 0);

sequential(

parallel(
	 output(dsummaddrcurrpersist_bizataddress 		,named('dsummaddrcurrpersist_bizataddress'))
	,output(dsummaddrcurrpersist_del_biz 				,named('dsummaddrcurrpersist_del_biz'))
	,output(dsummaddrcurrpersist_derog_biz 			,named('dsummaddrcurrpersist_derog_biz'))
	,output(countdsummaddrcurrpersist_bizataddress 		,named('countdsummaddrcurrpersist_bizataddress'))
	,output(countdsummaddrcurrpersist_del_biz 				,named('countdsummaddrcurrpersist_del_biz'))
	,output(countdsummaddrcurrpersist_derog_biz 			,named('countdsummaddrcurrpersist_derog_biz'))
)
/*,parallel(

	 output(dsummaddr_bizataddress								,named('dsummaddr_bizataddress'))
	,output(dsummaddr_del_biz 										,named('dsummaddr_del_biz'))
	,output(dsummaddr_derog_biz 									,named('dsummaddr_derog_biz'))
	,output(countdsummaddr_bizataddress								,named('countdsummaddr_bizataddress'))
	,output(countdsummaddr_del_biz 										,named('countdsummaddr_del_biz'))
	,output(countdsummaddr_derog_biz 									,named('countdsummaddr_derog_biz'))
)
*/
);
//////////////////////////////////////////////////////////////////////////////////////////////
dbusSummary		:= commercial_fraud.files().business_summary.qa;
dcorpy := corp2.files().base.corp.qa;

dbussummary_time_diss_rein_nonzero				:= dbusSummary(time_between_dissolution_reinstatement != 0);
dbussummary_diss_nonzero									:= dbusSummary(Date_Most_Recent_Dissolution != 0);
dbussummary_rein_nonzero									:= dbusSummary(Date_Most_Recent_Reinstatement != 0);
dbussummary_diss_rein_both_nonzero				:= dbusSummary(Date_Most_Recent_Reinstatement != 0,Date_Most_Recent_Dissolution != 0);
dbussummary_diss_rein_time_three_nonzero 	:= dbusSummary(Date_Most_Recent_Reinstatement != 0,Date_Most_Recent_Dissolution != 0,time_between_dissolution_reinstatement != 0);


output(count(dbusSummary															)	,named('countdbusSummary'																));
output(count(dbussummary_time_diss_rein_nonzero				)	,named('countdbussummary_time_diss_rein_nonzero'				));
output(count(dbussummary_diss_nonzero									)	,named('countdbussummary_diss_nonzero'									));
output(count(dbussummary_rein_nonzero									)	,named('countdbussummary_rein_nonzero'									));
output(count(dbussummary_diss_rein_both_nonzero				)	,named('countdbussummary_diss_rein_both_nonzero'				));
output(count(dbussummary_diss_rein_time_three_nonzero	)	,named('countdbussummary_diss_rein_time_three_nonzero'	));

dcorpy_diss := dcorpy(commercial_fraud.business_functions.fisDissolved	(corp_status_cd,corp_status_desc));
dcorpy_rein := dcorpy(commercial_fraud.business_functions.fisReinstated	(corp_status_cd,corp_status_desc));

dcorpy_unique := table(dcorpy, {corp_key}, corp_key);
dcorpy_diss_unique := table(dcorpy_diss, {corp_key}, corp_key);
dcorpy_rein_unique := table(dcorpy_rein, {corp_key}, corp_key);

output(count(dcorpy				)	,named('countdcorpy'));
output(count(dcorpy_diss				)	,named('countdcorpy_diss'));
output(count(dcorpy_rein				)	,named('countdcorpy_rein'));
output(count(dcorpy_unique	)	,named('dcorpy_unique'));
output(count(dcorpy_diss_unique	)	,named('countdcorpy_diss_unique'));
output(count(dcorpy_rein_unique	)	,named('countdcorpy_rein_unique'));
output(enth(dcorpy_diss,100)	,named('enthdcorpy_diss'));
output(enth(dcorpy_rein,100)	,named('enthdcorpy_rein'));


//Commercial_Fraud.Stats('20100312');

/*
check current_contact_change -- it is zero, while
count_contact_changes is 9,000
--wasn't populating it in the contact summary file -- fixed, need to test

check reinstatement, there is only 1 in dell file
if that is correct, make sure that record does not also have a dissolution
because time_between_dissolution_reinstatement is zero.
-- very small number of records have both a reinstatement and a dissolution 20 million dissolutions, 6500 reinstatements, 250 that have both

check count_derogatory_business_at_address -- it is zero, while count_delinquent_business_at_address is 44,000
the persist file I am using to pull in these count business fields has the first two populated, but not the derog one

*/

