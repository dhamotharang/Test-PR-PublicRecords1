import ut, PhonesPlus_V2;
export proc_create_phonesplus_relationships(string filedate) := function

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
			
/*
	DF-27472 Establish relationships for source level keys		
*/
			
	checkkey(string keyname) := function
		return if ( ~fileservices.fileexists(keyname),
					keyname + '\n','');
	end;
	
	// Check if all the indexes are available if not 
	
	string keylist := 
	        checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::fdids') + 
					checkkey('~thor_data400::key::phonesplusv2::' +filedate+ '::companyname')+
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::address') +
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::citystname') +
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::name') +
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::phone') +
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::ssn') +
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::stname') +
					checkkey('~thor_data400::key::phonesplusv2::' + filedate + '::zip') +
					checkkey(PhonesPlus_V2.Keynames(false, filedate).source_level_payload.New) + //	DF-27472 
					checkkey(PhonesPlus_V2.Keynames(false, filedate).Source_Level_Did.New) +     //	DF-27472 
					checkkey(PhonesPlus_V2.Keynames(false, filedate).Source_Level_Phone.New) +   //	DF-27472 
					checkkey(PhonesPlus_V2.Keynames(false, filedate).Source_Level_Cellphoneidkey.New);  //	DF-27472 

    // Set column mappings on dph_lname
	
	address_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::address',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	citystname_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::citystname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	name_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::name',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	phone_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::phone',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	ssn_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::ssn',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
		
	stname_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::stname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	zip_dphlname := fileservices.setcolumnmapping('~thor_data400::key::phonesplusv2::' + filedate + '::zip',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');

	// If all the keys are available, add relationships. If not send an email
	// create the relationships for roxie keys with header payload keys on DID
	companyname_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' +filedate+ '::companyname',
						'fdid', 'fdid', 'link', '1:M', true
						);
	address_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::address',
						'fdid', 'did', 'link', '1:M', true
						);
						
	citystname_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::citystname',
						'fdid', 'did', 'link', '1:M', true
						);
						
    name_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::name',
						'fdid', 'did', 'link', '1:M', true
						);
						
	phone_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::phone',
						'fdid', 'did', 'link', '1:M', true
						);

						
	ssn_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::ssn',
						'fdid', 'did', 'link', '1:M', true
						);
	stname_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::stname',
						'fdid', 'did', 'link', '1:M', true
						);				
	zip_to_phonesplus := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						'~thor_data400::key::phonesplusv2::' + filedate + '::zip',
						'fdid', 'did', 'link', '1:M', true
						);					
//DF-27472 Establish relationships for source level keys
	source_level_did_payload := fileServices.AddFileRelationship
						(
						PhonesPlus_V2.Keynames(false, filedate).source_level_payload.New,
						PhonesPlus_V2.Keynames(false, filedate).Source_Level_Did.New,
						'record_sid', 'record_sid', 'link', '1:1', true
						);
		source_level_phone_payload := fileServices.AddFileRelationship
						(
						PhonesPlus_V2.Keynames(false, filedate).source_level_payload.New,
						PhonesPlus_V2.Keynames(false, filedate).Source_Level_Phone.New,
						'record_sid', 'record_sid', 'link', '1:1', true
						);
		source_level_cellphoneidkey_payload := fileServices.AddFileRelationship
						(
						PhonesPlus_V2.Keynames(false, filedate).source_level_payload.New,
						PhonesPlus_V2.Keynames(false, filedate).Source_Level_cellphoneidkey.New,
						'record_sid', 'record_sid', 'link', '1:1', true
						);
		source_level_cellphoneidkey_rollup_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::phonesplusv2::' + filedate + '::fdids',
						PhonesPlus_V2.Keynames(false, filedate).Source_Level_Cellphoneidkey.New,
						'cellphoneidkey', 'cellphoneidkey', 'link', 'M:M', false
						);						

	retval := if(keylist = '',
					sequential(
	                //set columnMapping
					  address_set_dphlname
           ,citystname_set_dphlname
				   ,name_set_dphlname
				   ,phone_dphlname
				   ,ssn_dphlname
				   ,stname_dphlname	
				   ,zip_dphlname
					//create relationships
					,companyname_to_phonesplus
					,address_to_phonesplus
					,citystname_to_phonesplus
					,name_to_phonesplus
					,phone_to_phonesplus
					,ssn_to_phonesplus
					,stname_to_phonesplus
					,zip_to_phonesplus
					//DF-27472 Establish relationships for source level keys
					,source_level_did_payload 
					,source_level_phone_payload 
					,source_level_cellphoneidkey_payload
					,source_level_cellphoneidkey_rollup_payload 
					),
					FileServices.sendemail
						(
						'wma@seisint.com;joseph.lezcano@lexisnexis.com', 
						'Header Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
	
end;





