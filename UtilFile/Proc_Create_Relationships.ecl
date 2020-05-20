import ut;
export Proc_Create_Relationships(string filedate) := function
		
	checkkey(string keyname) := function
		return if ( ~fileservices.fileexists(keyname),
					keyname + '\n','');
	end;
	
	// Check if all the indexes are available if not 
	
	string keylist := 
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload')   +
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::addressb2')   +
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::citystnameb2')   + 
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::nameb2' )   +
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::namewords2')   + 
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::phoneb2' )   +
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::stnameb2')   + 
			checkkey('~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::zipb2' )   +

			checkkey('~thor_data400::key::utility::bus::'+filedate+'::address')   + 
			checkkey('~thor_data400::key::utility::'+filedate+'::daily::bus::bdid' )   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily::bus::id') +
			
			checkkey('~thor_data400::key::utility::'+filedate+'::address')   + 
			checkkey('~thor_data400::key::utility::'+filedate+'::did')   + 
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.did')   + 
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.id')   +
            
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.fid')   + 
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.address' )   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.citystname' )   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.name' )   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.phone' )   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.ssn')   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.stname')   + 
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.zipprlname' )   +
			checkkey('~thor_data400::key::utility::'+filedate+'::daily.zip') ; 
	
	// If all the keys are available, add relationships. If not send an email
	
// person Autokeys relationships 
   
   // Create column mapping for dph_lname
	colMapAutokeyName	:=	FileServices.setcolumnmapping(	'~thor_data400::key::utility::'+filedate+'::daily.name',
															'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}'
															);
   address_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.address',
						'fdid', 'did', 'link', '1:M', true
						);
	
	citystname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.citystname',
						'fdid', 'did', 'link', '1:M', true
						);
	
	name_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.name',
						'fdid', 'did', 'link', '1:M', true
						);
	
	ssn_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.ssn',
						'fdid', 'did', 'link', '1:M', true
						);
	
	stname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.stname',
						'fdid', 'did', 'link', '1:M', true
						);
	
	zip_to_payload :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.zip',
						'fdid', 'did', 'link', '1:M', true
						);
	zipprlname_to_payload :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::'+filedate+'::daily.fid',
						'~thor_data400::key::utility::'+filedate+'::daily.zipprlname',
						'fdid', 'did', 'link', '1:M', true
						);					
	
	// Business autokeys relationships 
	
	baddress_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::addressb2',
						'fakeid', 'bdid', 'link', '1:M', true
						);
	
	bcitystname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::citystnameb2',
						'fakeid', 'bdid', 'link', '1:M', true
						);
	
	bname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::nameb2',
						'fakeid', 'bdid', 'link', '1:M', true
						);
	
	bnamewords2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::namewords2',
						'fakeid', 'bdid', 'link', '1:M', true
						);
	bphone2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::phoneb2', 
						'fakeid', 'bdid', 'link', '1:M', true
						);
	
	bstname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::stnameb2' ,
						'fakeid', 'bdid', 'link', '1:M', true
						);
	
	bzip_to_payload :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::payload',
						'~thor_data400::key::utility::daily::bus::'+filedate+'::autokey::zipb2',
						'fakeid', 'bdid', 'link', '1:M', true
						);

	retval := if(keylist = '',
					sequential(colMapAutokeyName,
                       //create relationships
					    address_to_payload, citystname_to_payload, name_to_payload, ssn_to_payload,
                        stname_to_payload,zip_to_payload, zipprlname_to_payload,
						baddress_to_payload, bcitystname_to_payload, bname_to_payload 
                        ,bnamewords2_to_payload,bphone2_to_payload,bstname_to_payload, bzip_to_payload
						),
					FileServices.sendemail
						(
						'akayttala@seisint.com', 
						'Utility Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
	
end;
