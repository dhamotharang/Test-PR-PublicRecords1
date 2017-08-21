import ut;
export Foreclosure_Proc_Create_Relationships(string filedate, string emaillist) := function
		
	checkkey(string keyname) := function
		return if ( ~fileservices.fileexists(keyname),
					keyname + '\n','');
	end;
	
	// Check if all the indexes are available if not 
	
	string keylist :=  
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::address')				+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::addressb2')			+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::citystname')		+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::citystnameb2')	+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::name')					+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::nameb2')				+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::payload')				+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::ssn2')					+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::stname')				+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::stnameb2')			+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::zip')						+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::autokey::zipb2')					+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::address')								+
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::bdid')										+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::did')										+ 
					checkkey('~thor_data400::key::foreclosure::'+filedate+'::fid')
				;
	
	// If all the keys are available, add relationships. If not send an email
	// create the relationships for roxie keys with death payload key

	address_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::address',
						'fakeid', 'did', 'link', '1:1', true
						);

	addressb2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::addressb2',
						'fakeid', 'bdid', 'link', '1:1', true
						);
						
	citystname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::citystname',
						'fakeid', 'did', 'link', '1:1', true
						);
						
	citystnameb2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::citystnameb2',
						'fakeid', 'bdid', 'link', '1:1', true
						);
						
	name_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::name',
						'fakeid', 'did', 'link', '1:1', true
						);
						
	nameb2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::nameb2',
						'fakeid', 'bdid', 'link', '1:1', true
						);
	
	ssn2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::ssn2',
						'fakeid', 'did', 'link', '1:1', true
						);
						
	stname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::stname',
						'fakeid', 'did', 'link', '1:1', true
						);
						
	stnameb2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::stnameb2',
						'fakeid', 'bdid', 'link', '1:1', true
						);
						
	zip_to_payload :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::zip',
						'fakeid', 'did', 'link', '1:1', true
						);
						
	zipb2_to_payload :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::payload',
						'~thor_data400::key::foreclosure::'+filedate+'::autokey::zipb2',
						'fakeid', 'bdid', 'link', '1:1', true
						);
						
	address_to_fid :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::fid',
						'~thor_data400::key::foreclosure::'+filedate+'::address',
						'fid', 'foreclosure_id', 'link', '1:M', true
						);
						
	bdid_to_fid :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::fid',
						'~thor_data400::key::foreclosure::'+filedate+'::bdid',
						'fid', 'fid', 'link', '1:M', true
						);
						
	did_to_fid :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::foreclosure::'+filedate+'::fid',
						'~thor_data400::key::foreclosure::'+filedate+'::did',
						'fid', 'fid', 'link', '1:M', true
						);
						
	retval := if(keylist = '',
					sequential(
					 //create relationships
						address_to_payload,
						addressb2_to_payload,
						citystname_to_payload,
						citystnameb2_to_payload,
						name_to_payload,
						nameb2_to_payload,
						ssn2_to_payload,
						stname_to_payload,
						stnameb2_to_payload,
						zip_to_payload,
						zipb2_to_payload,
						address_to_fid,
						bdid_to_fid,
						did_to_fid
						),
					FileServices.sendemail
						(
						emaillist, 
						'Foreclosure Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
end;