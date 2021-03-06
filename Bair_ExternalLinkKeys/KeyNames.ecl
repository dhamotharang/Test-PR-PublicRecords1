EXPORT KeyNames(string pversion, boolean pUseDelta = false) := MODULE

	// Common key name components
	SHARED prefix    := KeyPrefix + '::key::bair_externallinkkeys';
	SHARED buildDate := If(pUseDelta,pversion +'_Delta',pversion);
	EXPORT keyFather := 'father';

	// Specific key names superfile
	EXPORT refs_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs';
	EXPORT words_super			:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Words';	
	EXPORT spec_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::debug::specificities_debug';
	EXPORT meow_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Meow';	
	EXPORT name_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::NAME';
	EXPORT address_super		:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::ADDRESS';
	EXPORT dob_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::DOB';
	EXPORT zip_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::ZIP_PR';
	EXPORT dln_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::DLN';
	EXPORT ph_super					:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::PH';
	EXPORT lfz_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::LFZ';
	EXPORT vin_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::VIN';
	EXPORT lexid_super			:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::LEXID';
	EXPORT ssn_super				:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::SSN';
	EXPORT latlong_super		:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::LATLONG';
	EXPORT plate_super			:= prefix + '::' + KeySuperfile + '::' + 'EID_HASH::Refs::PLATE';
	
	// Specific key names father file
	EXPORT refs_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs';
	EXPORT words_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::Words';	
	EXPORT spec_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::debug::specificities_debug';
	EXPORT meow_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::Meow';	
	EXPORT name_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::NAME';
	EXPORT address_father		:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::ADDRESS';
	EXPORT dob_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::DOB';
	EXPORT zip_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::ZIP_PR';
	EXPORT dln_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::DLN';
	EXPORT ph_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::PH';
	EXPORT lfz_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::LFZ';
	EXPORT vin_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::VIN';
	EXPORT lexid_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::LEXID';
	EXPORT ssn_father				:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::SSN';
	EXPORT latlong_father		:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::LATLONG';
	EXPORT plate_father			:= prefix + '::' + keyFather + '::' + 'EID_HASH::Refs::PLATE';
	
	// Specific key names logical file
	EXPORT refs_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs';
	EXPORT words_logical		:= prefix + '::' + buildDate + '::' + 'EID_HASH::Words';	
	EXPORT spec_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::debug::specificities_debug';
	EXPORT meow_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Meow';	
	EXPORT name_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::NAME';
	EXPORT address_logical	:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::ADDRESS';
	EXPORT dob_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::DOB';
	EXPORT zip_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::ZIP_PR';
	EXPORT dln_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::DLN';
	EXPORT ph_logical				:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::PH';
	EXPORT lfz_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::LFZ';
	EXPORT vin_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::VIN';
	EXPORT lexid_logical		:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::LEXID';
	EXPORT ssn_logical			:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::SSN';
	EXPORT latlong_logical	:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::LATLONG';
	EXPORT plate_logical		:= prefix + '::' + buildDate + '::' + 'EID_HASH::Refs::PLATE';
	
END;