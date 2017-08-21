import ut;
export Proc_Create_Relationships_SSA(string filedate) := function
		
	checkkey(string keyname) := function
		return if ( ~fileservices.fileexists(keyname),
					keyname + '\n','');
	end;
	
	// Set column mappings on dph_lname
	
	dob_set_dphlname := fileservices.setcolumnmapping(constants.KeyName_death_master + 'death_masterV2_ssa::'+filedate+'::dob',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	dod_set_dphlname := fileservices.setcolumnmapping(constants.KeyName_death_master + 'death_masterV2_ssa::'+filedate+'::dod',
	'dph_lname{set(metaphonelib.DMetaPhone1),displayname(lname_for_dph_lname)}');
	
	dob_to_parent:= fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::death_id',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::dob',
						'state_death_id', 'state_death_id', 'link', '1:1', true
						);

	dod_to_parent:= fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::death_id',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::dod',
						'state_death_id', 'state_death_id', 'link', '1:1', true
						);
	
	Supp_to_parent:= fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::death_id',
						constants.KeyName_death_master + 'death_supplemental_ssa::'+filedate+'::death_id',
						'state_death_id', 'state_death_id', 'link', '1:1', true
						);

	colMapAutokeyName	:=	FileServices.setcolumnmapping(	constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::name',
															'dph_lname{set(metaphonelib.DMetaPhone1),displayname(dph_lname)}'
															);
	address_to_payload := fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::payload',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::address',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	citystname_to_payload := fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::payload',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::citystname',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	name_to_paylaod := fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::payload',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::name',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	ssn2_to_payload := fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::payload',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::ssn2',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	stname_to_payload := fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::payload',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::stname',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	zip_to_payload :=  fileServices.AddFileRelationship
						(
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::payload',
						constants.KeyName_death_master + 'death_masterv2_ssa::'+filedate+'::autokey::zip',
						'fakeid', 'did', 'link', '1:M', true
						);
	
	retval := 			sequential(	dob_set_dphlname,dod_set_dphlname,colMapAutokeyName,
					    dob_to_parent,dod_to_parent,Supp_to_parent,address_to_payload
						,citystname_to_payload,name_to_paylaod,ssn2_to_payload,
						stname_to_payload,zip_to_payload
						);
			
return retval;
	
	
end;
