import roxiekeybuild;
export Proc_Build_Boolean_Key (string filedate) := function
							
e_mail_fail := fileservices.sendemail(
													
													'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',
													'BK Boolean Build FAILED - ' + filedate,
													failmessage);

mdata := bankruptcyv2.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata complete'));
boolean_key := bankruptcyv2.BWR_BKV2_Boolean(filedate) : 
					success(output('Boolean build complete')),
					failure(e_mail_fail);

retval :=  sequential(mdata
							,boolean_key
							,Roxiekeybuild.updateversion('BankruptcyV2Keys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com','Y','B',,'Y',,,'Y')
							,notify('BANKRUPTCY BOOLEAN BUILD COMPLETE','*'));

return retval;

end;