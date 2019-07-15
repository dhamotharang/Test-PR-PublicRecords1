IMPORT ut, data_services, _control;

EXPORT CustTest_Files(STRING fileVersion) := MODULE

  export location := Data_Services.Data_Location.Prefix('IDL_Header');
	// EXPORT location := '';
	// Common key name components
	SHARED prefix    := KeyPrefix + 'key::InsuranceHeader_xLink';
	SHARED buildDate := fileVersion;
	SHARED prtePrefix := location + 'prte::' + 'key::InsuranceHeader_xLink';
	EXPORT keyFather := 'father';

	// Specific key names superfile
	EXPORT header_super		:= prefix + '::' + KeySuperfile + '::' + 'header';
	EXPORT refs_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs';
	EXPORT words_super		:= prefix + '::' + KeySuperfile + '::' + 'DID::Words';	
	EXPORT name_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::NAME';
	EXPORT address_super	:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::ADDRESS';
	EXPORT ssn_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::SSN';
	EXPORT ssn4_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::SSN4';
	EXPORT dob_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::DOB';
	EXPORT dobf_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::DOBF';
	EXPORT zip_pr_super		:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::ZIP_PR';
	EXPORT src_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::SRC_RID';
	EXPORT dln_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::DLN';
	EXPORT rid_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::RID';
	EXPORT ph_super				:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::PH';
	EXPORT lfz_super			:= prefix + '::' + KeySuperfile + '::' + 'DID::Refs::LFZ';
	EXPORT relative_super := prefix + '::' + KeySuperfile + '::' + 'DID::Refs::RELATIVE';
	EXPORT seg_super			:= prefix + 'key::insuranceheader_segmentation::did_ind_' + KeySuperfile ;
	EXPORT id_history_super := prefix + '::' + KeySuperfile + '::' + 'DID::sup::RID';
	
	// Specific key names father file
	EXPORT header_father  := prefix + '::' + keyFather + '::' + 'header';
	EXPORT refs_father		:= prefix + '::' + keyFather + '::' + 'DID::Refs';
	EXPORT words_father		:= prefix + '::' + keyFather + '::' + 'DID::Words';
	EXPORT name_father		:= prefix + '::' + keyFather + '::' + 'DID::Refs::NAME';
	EXPORT address_father	:= prefix + '::' + keyFather + '::' + 'DID::Refs::ADDRESS';
	EXPORT ssn_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::SSN';
	EXPORT ssn4_father		:= prefix + '::' + keyFather + '::' + 'DID::Refs::SSN4';
	EXPORT dob_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::DOB';
	EXPORT dobf_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::DOBF';
	EXPORT zip_pr_father	:= prefix + '::' + keyFather + '::' + 'DID::Refs::ZIP_PR';
	EXPORT src_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::SRC_RID';
	EXPORT dln_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::DLN';
	EXPORT rid_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::RID';
	EXPORT ph_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::PH';
	EXPORT lfz_father			:= prefix + '::' + keyFather + '::' + 'DID::Refs::LFZ';
	EXPORT relative_father:= prefix + '::' + Keyfather + '::' + 'DID::Refs::RELATIVE';
	EXPORT seg_father			:= KeyPrefix + 'key::insuranceheader_segmentation::did_ind_' + keyFather ;
 EXPORT id_history_father := prefix + '::' + Keyfather + '::' + 'DID::sup::RID';
 
	// Specific key names logical file
	EXPORT header_logical 	:= prtePrefix + '::' + buildDate + '::' + 'IDL';
	EXPORT refs_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs';
	EXPORT words_logical		:= prtePrefix + '::' + buildDate + '::' + 'DID::Words';
	EXPORT name_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::NAME';
	EXPORT address_logical	:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::ADDRESS';
	EXPORT ssn_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::SSN';
	EXPORT ssn4_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::SSN4';
	EXPORT dob_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::DOB';
	EXPORT dobf_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::DOBF';
	EXPORT zip_pr_logical		:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::ZIP_PR';
	EXPORT src_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::SRC_RID';
	EXPORT dln_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::DLN';
	EXPORT rid_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::RID';
	EXPORT ph_logical				:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::PH';
	EXPORT lfz_logical			:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::LFZ';
	EXPORT relative_logical	:= prtePrefix + '::' + buildDate + '::' + 'DID::Refs::RELATIVE';
	EXPORT seg_logical			:= location + 'prte::' + 'key::insuranceheader_segmentation'+ '::' + buildDate + '::did_ind';
	EXPORT id_history_logical := prtePrefix + '::' + buildDate + '::' + 'DID::sup::RID';
	 
END;