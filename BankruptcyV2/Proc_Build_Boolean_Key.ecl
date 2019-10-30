import roxiekeybuild;
export Proc_Build_Boolean_Key (string filedate) := function
							
e_mail_fail := fileservices.sendemail(
													
													'christopher.brodeur@lexisnexis.com,avenkatachalam@seisint.com',
													'BK Boolean Build FAILED - ' + filedate,
													failmessage);

mdata := bankruptcyv2.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata complete'));
boolean_key := bankruptcyv2.BWR_BKV2_Boolean(filedate) : 
					success(output('Boolean build complete')),
					failure(e_mail_fail);

retval :=  sequential(mdata
							,boolean_key
							,Roxiekeybuild.updateversion('BankruptcyV2Keys',filedate,'avenkatachalam@seisint.com,christopher.brodeur@lexisnexis.com,manuel.tarectecan@lexisnexis.com,randy.reyes@lexisnexis.com,BocaRoxiePackageTeam@lexisnexis.com,intel357@bellsouth.net,Sayeed.ahmed@lexisnexis.com','Y','B',,'Y',,,'Y')
							,notify('BANKRUPTCY BOOLEAN BUILD COMPLETE','*'));

return retval;

end;