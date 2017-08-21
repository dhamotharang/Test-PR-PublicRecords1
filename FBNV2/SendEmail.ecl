import _control;
export SendEmail(string filedate):= module
	
	export EmailBody := 	'Keys		1)thor_data400::key::fbnv2::qa::rmsid_business(thor_data400::key::fbnv2::'+filedate+'::rmsid_business),\n' + 
								'								2)thor_data400::key::fbnv2::qa::autokey::address(thor_data400::key::fbnv2::'+filedate+'::autokey::address),\n' + 
								'								3)thor_data400::key::fbnv2::qa::autokey::addressb2(thor_data400::key::fbnv2::'+filedate+'::autokey::addressb2),\n' + 
								'								4)thor_data400::key::fbnv2::qa::autokey::citystname(thor_data400::key::fbnv2::'+filedate+'::autokey::citystname),\n' + 
								'								5)thor_data400::key::fbnv2::qa::autokey::citystnameb2(thor_data400::key::fbnv2::'+filedate+'::autokey::citystnameb2),\n' + 
								'								6)thor_data400::key::fbnv2::qa::autokey::fein2(thor_data400::key::fbnv2::'+filedate+'::autokey::fein2),\n' + 
								'								7)thor_data400::key::fbnv2::qa::autokey::name(thor_data400::key::fbnv2::'+filedate+'::autokey::name),\n' + 
								'								8)thor_data400::key::fbnv2::qa::autokey::nameb2(thor_data400::key::fbnv2::'+filedate+'::autokey::nameb2),\n' + 
								'								9)thor_data400::key::fbnv2::qa::autokey::namewords2(thor_data400::key::fbnv2::'+filedate+'::autokey::namewords2),\n' + 
								'								10)thor_data400::key::fbnv2::qa::autokey::payload(thor_data400::key::fbnv2::'+filedate+'::autokey::payload),\n' + 
								'								11)thor_data400::key::fbnv2::qa::autokey::phone2(thor_data400::key::fbnv2::'+filedate+'::autokey::phone2),\n' + 
								'								12)thor_data400::key::fbnv2::qa::autokey::phoneb2(thor_data400::key::fbnv2::'+filedate+'::autokey::phoneb2),\n' + 
						 // ' 							13)thor_data400::key::fbnv2::qa::autokey::ssn2(thor_data400::key::fbnv2::'+filedate+'::autokey::ssn2),\n' + 
								'								13)thor_data400::key::fbnv2::qa::autokey::stname(thor_data400::key::fbnv2::'+filedate+'::autokey::stname),\n' + 
								'								14)thor_data400::key::fbnv2::qa::autokey::stnameb2(thor_data400::key::fbnv2::'+filedate+'::autokey::stnameb2),\n' + 
								'								15)thor_data400::key::fbnv2::qa::autokey::zip(thor_data400::key::fbnv2::'+filedate+'::autokey::zip),\n' + 
								'								16)thor_data400::key::fbnv2::qa::autokey::zipb2(thor_data400::key::fbnv2::'+filedate+'::autokey::zipb2),\n' + 
								'								17)thor_data400::key::fbnv2::qa::bdid(thor_data400::key::fbnv2::'+filedate+'::bdid),\n' + 
						 // ' 							19)thor_data400::key::fbnv2::qa::date(thor_data400::key::fbnv2::'+filedate+'::date),\n' + 
								'								18)thor_data400::key::fbnv2::qa::did(thor_data400::key::fbnv2::'+filedate+'::did),\n' + 
								'								19)thor_data400::key::fbnv2::qa::filing_number(thor_data400::key::fbnv2::'+filedate+'::filing_number),\n' + 
						 // ' 							22)thor_data400::key::fbnv2::qa::jurisdiction(thor_data400::key::fbnv2::'+filedate+'::jurisdiction),\n' + 
								'								20)thor_data400::key::fbnv2::qa::rmsid(thor_data400::key::fbnv2::'+filedate+'::rmsid),\n' + 
								'								21)thor_data400::key::fbnv2::qa::rmsid_contact(thor_data400::key::fbnv2::'+filedate+'::rmsid_contact),\n' + 
								'								22)thor_data400::key::fbnv2::qa::linkids(thor_data400::key::fbnv2::'+filedate+'::linkids),\n' + 
								'     						 have been built and ready to be deployed to QA.'; 
				
	export key_success := fileservices.sendemail(_control.MyInfo.EmailAddressNotify+'; roxiebuilds@seisint.com',
													'FBNV2 Roxie Key Build Completed ' + filedate,
													EmailBody);

	export build_failure := fileservices.sendemail(
												_control.MyInfo.EmailAddressNotify,
												'FBNV2 '+filedate+' Roxie Build FAILED',
												workunit);			
												
	export build_success := fileservices.sendemail(_control.MyInfo.EmailAddressNotify+';qualityassurance@seisint.com',
											'FBNV2 Roxie Build Succeeded ' +filedate,
											'Sample records are in WUID: ' +workunit);
end;
