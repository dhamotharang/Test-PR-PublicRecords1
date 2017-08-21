import ut;
export proc_create_business_relationships(string filedate) := function

	// Function to add/define relationship to all indexes within a dataset.
	// Determine the following before adding relationship (if any)
	// 1. Index where the firstname(string) and lastname(unicode) are always upper-cased
	// 2. A name in Index translated using a phonetic key.
	// 3. Index that is built with fields that has upper case, and only include digits and alphabetic.
	// 4. Index with a field that that needs to remove accents and then uppercase
	// 5. The cardinality - which indicates how many records may match on each side. one to many etc.
	
	// NOTE: Whenever there is a new key, add relationships to the key if necessary.
	// If the relationship was not created during build time no worries, we can run this function
	// as standalone by passing the version with which the keys were built.
	
	// If the keys were deployed before adding relationships, it needs to be 
	// redeployed.
			
	checkkey(string keyname) := function
		return if ( ~fileservices.fileexists(keyname),
					keyname + '\n','');
	end;
	
	// Check if all the indexes are available if not 
	
	string keylist := 
	        checkkey('~thor_data400::key::business_header::'+filedate+'::search::bdid.pl') + 
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::companyname.bdid.cn_bdids')+
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::companyname') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::addr.pr.pn.sr.st') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::addr.pr.pn.zip') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::addr.st') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::addr.zip') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::phone') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::fein') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::bdid') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::addr') +			
			checkkey('~thor_data400::key::business_header::'+filedate+'::supergroup::groupid') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::rcid') +
			checkkey('~thor_data400::key::business_header::'+filedate+'::commercialbus::sic_zip_code') + 
			checkkey('~thor_data400::key::business_header::'+filedate+'::search::conamewordsmetaphone')
		;

	// If all the keys are available, add relationships. If not send an email
	// create the relationships for roxie keys with header payload keys on DID
	companyname_bdid_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::companyname.bdid.cn_bdids',
						'bdid', 'bdid', 'link', '1:M', true
						);
	companyname_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::companyname',
						'bdid', 'bdid', 'link', '1:M', true
						);
	addr_pr_pn_st_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::addr.pr.pn.sr.st',
						'bdid', 'bdid', 'link', '1:M', true
						);
	addr_pr_pn_zip_to_busheader:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::addr.pr.pn.zip',
						'bdid', 'bdid', 'link', '1:M', true
						);
	addr_st_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::addr.st',
						'bdid', 'bdid', 'link', '1:M', true
						);
	addr_zip_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::addr.zip',
						'bdid', 'bdid', 'link', '1:M', true
						);				
	phone_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::phone',
						'bdid', 'bdid', 'link', '1:M', true
						);					
	fein_to_bus_header := fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::fein',
						'bdid', 'bdid', 'link', '1:M', true
						);
	bdid_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::bdid',
						'bdid', 'bdid', 'link', '1:M', true
						);
	addr_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::addr',
						'bdid', 'bdid', 'link', '1:M', true
						);
						
	groupid_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::supergroup::groupid',
						'bdid', 'bdid', 'link', '1:M', true
						);
		
		
	rcid_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::rcid',
						'bdid', 'bdid', 'link', '1:M', true
						);
						
	sic_zip_code_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::commercialbus::sic_zip_code',
						'bdid', 'bdid', 'link', '1:M', true
						);
	
	conamewordsmetaphone_to_bus_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::business_header::'+filedate+'::search::bdid.pl',
						'~thor_data400::key::business_header::'+filedate+'::search::conamewordsmetaphone',
						'bdid', 'bdid', 'link', '1:M', true
						);
		
	retval := if(keylist = '',
					sequential(
	
					//create relationships
					companyname_bdid_to_bus_header
					,companyname_to_bus_header
					,addr_pr_pn_st_to_bus_header
					,addr_pr_pn_zip_to_busheader
					,addr_st_to_bus_header
					,addr_zip_to_bus_header
					,phone_to_bus_header
					,fein_to_bus_header
					,bdid_to_bus_header
					,addr_to_bus_header
					,groupid_to_bus_header			
					 ,rcid_to_bus_header
					 ,sic_zip_code_to_bus_header
					 ,conamewordsmetaphone_to_bus_header
						),
					FileServices.sendemail
						(
						'wma@seisint.com;lbentley@seisint.com', 
						'Header Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
	
end;





