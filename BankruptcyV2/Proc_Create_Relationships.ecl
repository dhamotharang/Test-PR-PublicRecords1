import ut;
export Proc_Create_Relationships(string filedate,string emaillist) := function
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
	
	string keylist := checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::addressb2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::address') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::citystnameb2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::citystname') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::fein2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::nameb2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::namewords2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::name') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::payload') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::phone2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::phoneb2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::ssn2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::stnameb2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::stname') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::zipb2') +
			checkkey('~thor_data400::key::bankruptcy::' + filedate + '::autokey::zip') +
			checkkey('~thor_data400::key::bankruptcyv2::' + filedate + '::bdid') +
			checkkey('~thor_data400::key::bankruptcyv2::' + filedate + '::case_number') +
			checkkey('~thor_data400::key::bankruptcyv2::' + filedate + '::did') +
			checkkey('~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid') +
			checkkey('~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid') +
			checkkey('~thor_data400::key::bankruptcyv2::' + filedate + '::ssn') +
			checkkey('~thor_data400::key::bankruptcyv3::' + filedate + '::bocashell_did') +
			checkkey('~thor_data400::key::bankruptcyv3::' + filedate + '::bocashell') +
			checkkey('~thor_data400::key::bankruptcyv3::' + filedate + '::main::tmsid') +
			checkkey('~thor_data400::key::bankruptcyv3::' + filedate + '::search::tmsid') +
			checkkey('~thor_data400::key::bankruptcyv3::' + filedate + '::ssnmatch') +
			checkkey('~thor_data400::key::bankruptcyv3::' + filedate + '::ssn4st');

	// Set column mappings
	// setcitycode := fileservices.setcolumnmapping('~thor_data400::key::bankruptcy::'+filedate+'::autokey::citystname','city_code{set(doxie.Make_CityCode),displayname(city)}');
	

	// If all the keys are available, add relationships. If not send an email
	
	bdid_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::bdid',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	bdid_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::bdid',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	did_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::did',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	did_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::did',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	cno_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::case_number',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	cno_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::case_number',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	ssn_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::ssn',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	ssn_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::ssn',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	ssnm_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv3::' + filedate + '::ssnmatch',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	ssnm_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv3::' + filedate + '::ssnmatch',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	search_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	main_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv2::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv2::' + filedate + '::search::tmsid',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	search_to_main1 := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv3::' + filedate + '::main::tmsid',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	main_to_search1 := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv3::' + filedate + '::search::tmsid',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	main_to_supp := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv3::'+filedate+'::main::supplemental',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	search_to_supp := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv3::'+filedate+'::main::supplemental',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	ssn4_to_main := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::main::tmsid',
						'~thor_data400::key::bankruptcyv3::' + filedate + '::ssn4st',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	ssn4_to_search := fileServices.AddFileRelationship
						(
						'~thor_data400::key::bankruptcyv3::' + filedate + '::search::tmsid',
						'~thor_data400::key::bankruptcyv3::' + filedate + '::ssn4st',
						'tmsid', 'tmsid', 'link', '1:M', true
						);
	retval := if(keylist = '',
					sequential(
						//set column mappings
						// setcitycode,
						//add relationships
						bdid_to_main,bdid_to_search,
						did_to_main,did_to_search,
						ssn_to_main,ssn_to_search,
						ssnm_to_main,ssnm_to_search,
						cno_to_main,cno_to_search,
						search_to_main,main_to_search,
						search_to_main1,main_to_search1,
						ssn4_to_main,ssn4_to_search
						),
					FileServices.sendemail
						(
						emaillist, 
						'BankruptcyV2 Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
	
end;
