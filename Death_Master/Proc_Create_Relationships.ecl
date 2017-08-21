import ut;
export Proc_Create_Relationships(string filedate) := function
		
	checkkey(string keyname) := function
		return if ( ~fileservices.fileexists(keyname),
					keyname + '\n','');
	end;
	
	// Set column mappings on dph_lname
	
	dob_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::death_masterV2::'+filedate+'::dob',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	dod_set_dphlname := fileservices.setcolumnmapping('~thor_data400::key::death_masterV2::'+filedate+'::dod',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	// Check if all the indexes are available if not 
	
	string keylist := 
	            checkkey('~thor_data400::key::death_masterv2::'+filedate+'::death_id')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::did')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::dob')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::dod')   +
				checkkey('~thor_data400::key::death_supplemental::'+filedate+'::death_id')   + 
				checkkey('~thor_data400::key::death_master::'+filedate+'::did')   + 

			/*	checkkey('~thor_data400::key::death_master::'+filedate+'::address_table_v4')   + 
				checkkey('~thor_data400::key::death_master::'+filedate+'::address_table_v4_filtered')   + 
				checkkey('~thor_data400::key::death_master::'+filedate+'::adl_risk_table_v4')   + 
				checkkey('~thor_data400::key::death_master::'+filedate+'::adl_risk_table_v4_filtered')   + 
				checkkey('~thor_data400::key::death_master::'+filedate+'::ssn_table_v4')   + 
				checkkey('~thor_data400::key::death_master::'+filedate+'::ssn_table_v4_filtered')   + */

				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::address')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::citystname')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::name')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::ssn2')   + 
			    checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::stname')   + 
				checkkey('~thor_data400::key::death_masterv2::'+filedate+'::autokey::zip')   ; 
	
	// If all the keys are available, add relationships. If not send an email
	// create the relationships for roxie keys with death payload key

	dob_to_parent:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::death_id',
						'~thor_data400::key::death_masterv2::'+filedate+'::dob',
						'state_death_id', 'state_death_id', 'link', '1:1', true
						);

	dod_to_parent:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::death_id',
						'~thor_data400::key::death_masterv2::'+filedate+'::dod',
						'state_death_id', 'state_death_id', 'link', '1:1', true
						);
	
	Supp_to_parent:= fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::death_id',
						'~thor_data400::key::death_supplemental::'+filedate+'::death_id',
						'state_death_id', 'state_death_id', 'link', '1:1', true
						);
	// Auto keys 
	
		// Create column mapping for dph_lname
	colMapAutokeyName	:=	FileServices.setcolumnmapping(	'~thor_data400::key::death_masterv2::'+filedate+'::autokey::name',
															'dph_lname{set(metaphonelib.DMetaPhone1),displayname(dph_lname)}'
															);
	address_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload',
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::address',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	citystname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload',
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::citystname',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	name_to_paylaod := fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload',
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::name',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	ssn2_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload',
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::ssn2',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	stname_to_payload := fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload',
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::stname',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	zip_to_payload :=  fileServices.AddFileRelationship
						(
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::payload',
						'~thor_data400::key::death_masterv2::'+filedate+'::autokey::zip',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	retval := if(keylist = '',
					sequential(
					//set columnMapping
					dob_set_dphlname,dod_set_dphlname,colMapAutokeyName,
					 //create relationships
					    dob_to_parent,dod_to_parent,Supp_to_parent,address_to_payload
						,citystname_to_payload,name_to_paylaod,ssn2_to_payload,
						stname_to_payload,zip_to_payload
						),
					FileServices.sendemail
						(
						'akayttala@seisint.com', 
						'Death Master Add Key Relationship - FAILED:'+filedate,
						'Following indexes are not available on thor \n' + keylist
						)
				);
			
return retval;
	
	
end;
