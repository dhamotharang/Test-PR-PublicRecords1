/*2015-11-16T20:58:47Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-07-24T21:31:44Z (Srilatha Katukuri)
#173256
*/
/*2015-04-15T19:10:34Z (Srilatha Katukuri)
#173256 - Check in

*/
/*2015-02-11T00:44:35Z (Ayeesha Kayttala)
bug# 173256 - code review 
*/
export Key_EcrashV2_Partial_Report_Nbr := index(mod_PrepEcrashPRKeys().clean_partnbr,
                                                {partial_report_nbr,report_code, jurisdiction_state,jurisdiction,accident_date} ,
																								{l_accnbr,orig_Accnbr,addl_report_number, report_type_id,work_type_id,vendor_code,vendor_report_id,Idfield,ReportLinkID },
																								Files_PR.FILE_KEY_PARTIAL_ACCNBR_SF);
																							
																								 