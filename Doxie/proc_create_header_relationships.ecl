import ut;
export proc_create_header_relationships(string filedate) := function
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
	
	// Set column mappings on dph_lname
	
	address_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::pname.prange.st.city.sec_range.lname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	zip_lname_fname_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::zip.lname.fname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	zip_did_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::zip_did_full',
	'p_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	ssn_did_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::ssn.did',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	phone_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::phone',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	stlnamefname_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::st.fname.lname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	stcitylfname_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::st.city.fname.lname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	lnamefname_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::lname.fname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
		
	lnamefname_alt_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::lname.fname_alt',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');				
	
	StreetZipName_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::pname.zip.name.range',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	DTS_StreetZipName_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::dts::'+filedate+'::pname.zip.name.range',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	Dobname_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::dobname',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	ssn4_v2_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::header::'+filedate+'::ssn4_v2.did',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	// Check if all the indexes are available if not 
	
	string keylist := 
	        checkkey('~thor_data400::key::header::'+filedate+'::data')   +
			checkkey('~thor_data400::key::header::'+filedate+'::ssn.did') +
			// checkkey('~thor_data400::key::header::'+filedate+'::rid') +
			checkkey('~thor_data400::key::header::'+filedate+'::phone') +
			checkkey('~thor_data400::key::header::'+filedate+'::st.fname.lname') +
			checkkey('~thor_data400::key::header::'+filedate+'::st.city.fname.lname') +
			checkkey('~thor_data400::key::header::'+filedate+'::lname.fname') +
			checkkey('~thor_data400::key::header::'+filedate+'::lname.fname_alt') +
			checkkey('~thor_data400::key::header::'+filedate+'::zip.lname.fname') +
			checkkey('~thor_data400::key::header::'+filedate+'::da') +
			checkkey('~thor_data400::key::header::'+filedate+'::pname.prange.st.city.sec_range.lname') +			
			checkkey('~thor_data400::key::header::'+filedate+'::pname.zip.name.range') +
			checkkey('~thor_data400::key::header::'+filedate+'::lookups') +
			checkkey('~thor_data400::key::header::'+filedate+'::nbr_address') +
			checkkey('~thor_data400::key::header::'+filedate+'::rid_did') +
			checkkey('~thor_data400::key::header::'+filedate+'::rid_did2') +
			checkkey('~thor_data400::key::header::'+filedate+'::county') +			
			checkkey('~thor_data400::key::header::'+filedate+'::fname_small') +
			checkkey('~thor_data400::key::header::dts::'+filedate+'::pname.prange.st.city.sec_range.lname') +
			checkkey('~thor_data400::key::header::dts::'+filedate+'::pname.zip.name.range') +
			checkkey('~thor_data400::key::header::dts::'+filedate+'::fname_small') +			
			checkkey('~thor_data400::key::header::'+filedate+'::ssn4.did') +
			checkkey('~thor_data400::key::header::'+filedate+'::ssn5.did') +
			checkkey('~thor_data400::key::header::'+filedate+'::address') +
			//checkkey('~thor_data400::key::header::'+filedate+'::dob') +
			//checkkey('~thor_data400::key::header::'+filedate+'::parentlnames') +
			checkkey('~thor_data400::key::header::'+filedate+'::zipprlname') +
			checkkey('~thor_data400::key::header::'+filedate+'::dobname')+
			checkkey('~thor_data400::key::header::'+filedate+'::ssn4_v2.did');

	// If all the keys are available, add relationships. If not send an email
	// create the relationships for roxie keys with header payload keys on DID

	ssn_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::ssn.did',
						's_did', 'did', 'link', '1:M', true
						);

	phone_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::phone',
						's_did', 'did', 'link', '1:M', true
						);
	stfnamelname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::st.fname.lname',
						's_did', 'did', 'link', '1:M', true
						);
	stcityLFname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::st.city.fname.lname',
						's_did', 'did', 'link', '1:M', true
						);
	lnamefname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::lname.fname',
						's_did', 'did', 'link', '1:M', true
						);				
	lnamefname_alt_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::lname.fname_alt',
						's_did', 'did', 'link', '1:M', true
						);					
	zip_lname_fname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::zip.lname.fname',
						's_did', 'did', 'link', '1:M', true
						);
	da_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::da',
						's_did', 'did', 'link', '1:M', true
						);
	address_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::pname.prange.st.city.sec_range.lname',
						's_did', 'did', 'link', '1:M', true
						);
						
	streetzipname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::pname.zip.name.range',
						's_did', 'did', 'link', '1:M', true
						);
		
	did_lookups_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::lookups',
						's_did', 'did', 'link', '1:M', true
						);
	nbr_address_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::nbr_address',
						's_did', 'did', 'link', '1:M', true
						);
						
	rid_did_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::rid_did',
						's_did', 'did', 'link', '1:M', true
						);
						
	rid_did2_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::rid_did2',
						's_did', 'did', 'link', '1:M', true
						);
						
	countyname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::county',
						's_did', 'did', 'link', '1:M', true
						);
						
	fnamesmall_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::fname_small',
						's_did', 'did', 'link', '1:M', true
						);
						
	DTS_Address_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::dts::'+filedate+'::pname.prange.st.city.sec_range.lname',
						's_did', 'did', 'link', '1:M', true
						);
						
	DTS_StreetZipName_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::dts::'+filedate+'::pname.zip.name.range',
						's_did', 'did', 'link', '1:M', true
						);
						
	DTS_FnameSmall_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::dts::'+filedate+'::fname_small',
						's_did', 'did', 'link', '1:M', true
						);					
											
	ssn4_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::ssn4.did',
						's_did', 'did', 'link', '1:M', true
						);					
											
						
	ssn5_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::ssn5.did',
						's_did', 'did', 'link', '1:M', true
						);					
																
	header_address_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::address',
						's_did', 'did', 'link', '1:M', true
						);					
						
						
	ZipPRLName_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::zipprlname',
						's_did', 'did', 'link', '1:M', true
						);	
											
	dobname_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::dobname',
						's_did', 'did', 'link', '1:M', true
						);	
						
	ssn4_v2_to_header:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::header::'+filedate+'::data',
						'~thor_data400::key::header::'+filedate+'::ssn4_v2.did',
						's_did', 'did', 'link', '1:M', true
						);	
	
	retval := if(keylist = '',
					sequential(
					//set columnMapping
					address_set_dphlname,zip_lname_fname_set_dphlname,
					zip_did_set_dphlname,ssn_did_set_dphlname,
	                phone_set_dphlname,stlnamefname_set_dphlname,
	                stcitylfname_set_dphlname,lnamefname_alt_set_dphlname,
                    StreetZipName_set_dphlname,DTS_StreetZipName_set_dphlname,
					Dobname_set_dphlname,ssn4_v2_set_dphlname,lnamefname_set_dphlname,
					//create relationships
					    ssn_to_header,
						phone_to_header,stfnamelname_to_header,
					    stcityLFname_to_header,lnamefname_to_header,
						lnamefname_alt_to_header,zip_lname_fname_to_header,
					    da_to_header,address_to_header,
					    streetzipname_to_header,did_lookups_to_header,
					    nbr_address_to_header, rid_did_to_header,
						rid_did2_to_header,countyname_to_header,
						fnamesmall_to_header,DTS_Address_to_header,
						DTS_StreetZipName_to_header,DTS_FnameSmall_to_header,
						ssn4_to_header,ssn5_to_header,
						header_address_to_header,
						ZipPRLName_to_header,
						dobname_to_header,ssn4_v2_to_header
						),
					FileServices.sendemail
						(
						'jose.bello@lexisnexisrisk.com,gabriel.marcan@lexisnexisrisk.com',
						'Header Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
	
end;
