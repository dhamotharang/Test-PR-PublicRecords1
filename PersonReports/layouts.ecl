// In this first pass, we're trying to replicate the structure and even the
// fieldnames of the existing asset services.  The next pass needs to change
// all those fieldnames and their types to reflect those of the data -- the
// existing structure should be preserved, however.

import iesp, doxie_LN, risk_indicators, doxie_crs, Gong, doxie, FFD; //TODO: remove doxie_ln

export layouts := module

	// -----------------------------------------
	// Constants
	// -----------------------------------------
	export max_dl							:= 10;
	export max_akas						:= 20;
	export max_imp						:= 20;
	export max_addr						:= 25;
	export max_addr_residents	:= 1;			// STUB - this doesn't seem right... asking Lisa
	export max_addr_phones		:= 6;
	export max_rel						:= 25;
	export max_assoc					:= 25;
	export max_deed						:= 50;
	export max_assmnt					:= 50;
	export max_vehicle				:= 50;
	export max_vehicle_own		:= 2;
	export max_vehicle_reg		:= 2;
	export max_vehicle_lh			:= 3;
	export max_vessel					:= 50;
	export max_wtrCrft				:= 50;
	export max_wtrCrft_owners	:= 20;
	export max_ucc						:= 50;
	export max_ucc_collateral	:= 230;		// Seems crazy, but I actually counted in W20070523-073530
	export max_faaCert				:= 50;
	export max_faaCrft				:= 50;
	export max_hri						:= 20;
	
	
	// -----------------------------------------
	// Common
	// -----------------------------------------
	export t_yesNo := string3;
	export t_yesNo yesNo(boolean b) := if(b,'YES','NO');
	
	export name := module
		export fml := record
			string20 first;
			string30 middle;
			string20 last;
		end;
	end;

	export date := module
		export ym := record
			unsigned2 year;
			unsigned1 month;
		end;
		export ymd := record
			ym;
			unsigned1 day;
		end;
	end;
	
	export addr := module
		export summary := record
			string10	street_number						{ xpath('street-number') };
			string28	street_name							{ xpath('street-name') };
			string4		street_suffix						{ xpath('street-suffix') };
			string25	city;
			string2		state;
			string5		zip;
			string4		zip4;
		end;
		export summary_co := record
			summary;
			string18	county;
		end;
	end;

	
	export dl := record
		string9		ssn;
		string20	name_first								{ xpath('name-first') };
		string20	name_middle								{ xpath('name-middle') };
		string20	name_last									{ xpath('name-last') };
		string2		name_prefix								{ xpath('name-prefix') };
		string3		age;
		date.ymd	dob;
		addr.summary_co;
		string1		sex;
		string1		race;
		string330	license_type							{ xpath('license-type') };
		date.ymd	expiration_date						{ xpath('expiration-date') };
		date.ymd	lic_issue_date						{ xpath('lic-issue-date') };
		string14	dl_number									{ xpath('dl-number') };
		string3		height;
		string1		history;
		string20	state_name								{ xpath('state-name') };
		string2		src												{ xpath('src') };
	end;
	
	export identity:= record
		name.fml		name;
		string9			ssn;
		t_yesNo			ssn_valid								{ xpath('ssn-valid')	};
		string32		ssn_issued_location			{ xpath('ssn-issued-location')	};
		date.ymd		ssn_issued_start_date		{ xpath('ssn-issued-start-date')	};
		date.ymd		ssn_issued_end_date			{ xpath('ssn-issued-end-date')	};
		DATASET(risk_indicators.layout_desc) hri_ssn {maxcount(max_hri)};
		date.ymd		dob;	
		date.ymd		dod;
		unsigned1		age_at_death						{ xpath('age-at-death')	};
		string1			death_verification_code	{ xpath('death-verification-code')	};
		string3			age;
		dataset(dl)	drivers_licenses				{ xpath('drivers-licenses/drivers-license'),	maxcount(max_dl)	}; // stub
	end;

	export indiv_imposter := record
		dataset(identity) akas							{ xpath('akas/identity'),	maxcount(max_akas)	};
	end;

  export t_AddressTimeLine := RECORD (iesp.share.t_Address)
    iesp.share.t_Date DateLastSeen;
    iesp.share.t_Date DateFirstSeen;
  end;

  export t_CentralRecordsIndividual := record
    iesp.bpsreport.t_BpsReportIndividual and not [
      HasCriminalConviction, CriminalConvictionId, IsSexualOffender, SexualOffenderId, //those are fields in CRS
      Vehicles, Vehicles2, SexualOffenses, CriminalRecords, CriminalHistories, Sources];  //CRS datasets
  end;

  export  t_CentralRecordsResponse := record
	  iesp.share.t_ResponseHeader _Header {xpath('Header')};
  	t_CentralRecordsIndividual Individual {xpath('Individual')};
  end;
		
  export t_CentralRecordsRequest := iesp.bpsreport.t_BpsReportRequest;//record (iesp.share.t_BaseRequest)
	  // iesp.bpsreport.t_BpsReportOption Options {xpath('Options')};
  	// iesp.bpsreport.t_BpsReportBy ReportBy {xpath('ReportBy')};
  // end;

  export royalties := doxie_LN.layout_royalties;

  export comp_names := record
    integer3 address_seq_no;
    doxie_crs.layout_comp_names; //[did; fname; mname; lname; ssn; ssn_unmasked; dob; age;]
  end;
  export layout_comp_names := record
    integer3 address_seq_no;
    doxie_crs.layout_comp_names; //[did; fname; mname; lname; ssn; ssn_unmasked; dob; age;]
  end;

export phones_rec := record (doxie_crs.layout_phone_records)
  typeof (Gong.Key_address_current.st) st;   // only for mac_AddHRIPhone call
  typeof (Gong.Key_address_current.lname) lname;  // only for mac_AddHRIPhone call
  typeof (Gong.Key_address_current.omit_phone) omit_phone; // in addition to 'unpub'
end;

export rec_wide := record
  doxie.layout_comp_addresses and not [title, fname, mname, lname, phone, Feedback, listed_phone];
  doxie_crs.layout_phone_records and not [prim_range, prim_name, zip, sec_range, predir];
  typeof (phones_rec.sec_range) phone_sec_range;
  boolean name_matched;
  integer sequence_verified;
  boolean is_subject_verified;
end;

export slim_addr_rec := record 
  iesp.bpsreport.t_BpsReportAddressSlim and not [Residents];
  // these are for linking...
  rec_wide.did;
  rec_wide.address_seq_no;

  // and need these to get census, if required
  rec_wide.county; //county "number"
  rec_wide.geo_blk;
end;

  // slim version of compreport identity
  export identity_slim := record, MAXLENGTH (4096)
    unsigned6 did; 
    integer3 address_seq_no;
    iesp.bpsreport.t_BpsReportIdentitySlim;
		FFD.Layouts.CommonRawRecordElements;
  END;

  export identity_slim_rolled := record
    unsigned6 did;
    integer3 address_seq_no;
    dataset (iesp.bpsreport.t_BpsReportIdentitySlim) akas {maxcount(iesp.Constants.BR.MaxAKA)};
  END;
	

  // most comprehensive identity as defined in compreport
  export identity_bps := record, MAXLENGTH (4096)
    unsigned6 did; 
    integer3 address_seq_no;
    iesp.bps_share.t_BpsReportIdentity;
  END;
	
  export identity_bps_rolled := record
    unsigned6 did;
    integer3 address_seq_no;
    dataset (iesp.bps_share.t_BpsReportIdentity) akas {maxcount(iesp.Constants.BR.MaxAKA)};
  END;
	
	
  export address_slim := record
    unsigned6 did; 
    integer3 address_seq_no;
    // and need these to get census, if required
    rec_wide.county; //county "number"
    rec_wide.geo_blk;
    iesp.bpsreport.t_BpsReportAddressSlim;
  end;

  export address_bps := record
    unsigned6 did; 
    integer3 address_seq_no;
    // and need these to get census, if required
    rec_wide.county; //county "number"
    rec_wide.geo_blk;
    iesp.bpsreport.t_BpsReportAddress;
  end;

  export address_bps_rolled := record
    unsigned6 did; 
    // integer3 address_seq_no;
    dataset (iesp.bpsreport.t_BpsReportAddress) addresses {maxcount(iesp.Constants.BR.MaxAddress)};
  end;

  export address_slim_rolled := record
    unsigned6 did; 
    // integer3 address_seq_no;
    dataset (iesp.bpsreport.t_BpsReportAddressSlim) addresses {maxcount(iesp.Constants.BR.MaxAddress)};
  end;

	export ssn_hri_rec := RECORD
		STRING9   ssn;
		UNSIGNED6 did;	
		STRING1   valid_ssn;
		UNSIGNED  cnt;
		UNSIGNED4 ssn_issue_early;
		UNSIGNED4 ssn_issue_last;
		STRING2   ssn_issue_place;
		DATASET(risk_indicators.layout_desc) hri_ssn {MAXCOUNT(max_hri)};
	END;

	export CommonAssetReportIdentity := record(iesp.share_fcra.t_FcraIdentity)
		iesp.assetreport.t_AssetReportIdentity.IsCurrentName;
		iesp.assetreport.t_AssetReportIdentity.IsCorrectDOB;
		iesp.assetreport.t_AssetReportIdentity.SubjectSSNIndicator; 
		dataset(iesp.bps_share.t_BpsReportDriverLicense) DriverLicenses;
	end;

	export CommonAssetReportIndividual := record(iesp.assetreport_fcra.t_FcraAssetReportIndividual and not AKAs)
		iesp.assetreport.t_AssetReportAlsoFound AlsoFound {xpath('AlsoFound')};//hidden[internal]
		dataset(iesp.bpsreport.t_BpsReportRelative) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.constants.BR.MaxRelatives)};//hidden[internal]
		dataset(iesp.bpsreport.t_BpsReportAssociate) Associates {xpath('Associates/Associate'), MAXCOUNT(iesp.constants.BR.MaxAssociates)};//hidden[internal]
		dataset(iesp.dirassistwireless.t_PhonesPlusRecord) PhonesPluses {xpath('PhonesPluses/PhonesPlus'), MAXCOUNT(iesp.constants.BR.MaxPhonesPlus)};//hidden[internal]
		dataset(iesp.proflicense.t_ProfessionalLicenseRecord) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(iesp.constants.BR.MaxProfLicenses)};//hidden[internal]
		dataset(iesp.motorvehicle.t_MVReportRecord) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(iesp.constants.BR.MaxVehicles)};
		dataset(iesp.ucc.t_UCCReport2Record) UCCFilings {xpath('UCCFilings/UCCFiling'), MAXCOUNT(iesp.constants.BR.MaxUCCFilings)};
		dataset(iesp.bps_share.t_BpsReportImposter) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(iesp.constants.BR.MaxImposters)};
		dataset(iesp.bpsreport.t_BpsReportAddressSlim) BpsReportAddresses2 {xpath('BpsReportAddresses2/BpsReportAddress'), MAXCOUNT(iesp.constants.BR.MaxAddress)};
		dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) PeopleAtWorks {xpath('PeopleAtWorks/PeopleAtWork'), MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
		dataset(CommonAssetReportIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.BR.MaxAKA)};
	end;



   export CommonPreLitigationReportIdentity := record(iesp.share_fcra.t_FcraIdentity)
		iesp.bps_share.t_BpsReportIdentity.HasConcealedWeapon;
		iesp.bps_share.t_BpsReportIdentity.ConcealedWeaponId;
		iesp.bps_share.t_BpsReportIdentity.HasCriminalConviction;
		iesp.bps_share.t_BpsReportIdentity.CriminalConvictionId;
		iesp.bps_share.t_BpsReportIdentity.IsSexualOffender;
		iesp.bps_share.t_BpsReportIdentity.SexualOffenderId;
		iesp.bps_share.t_BpsReportIdentity.HasCorporateAffiliation;
		dataset(iesp.bps_share.t_BpsReportDriverLicense) DriverLicenses;
		dataset(iesp.driverlicense2.t_DLEmbeddedReport2Record) DriverLicenses2;
		dataset(iesp.matrix.t_MatrixCrimReportRecord) CriminalHistories;
		iesp.bps_share.t_BpsReportIdentity.IsCurrentName;
		iesp.bps_share.t_BpsReportIdentity.IsCorrectDOB;
		iesp.bps_share.t_BpsReportIdentity.SubjectSSNIndicator;
   end;
   
   
   export CommonPreLitigationReportIndividual := record, MAXLENGTH (300000001)
   	string12 UniqueId {xpath('UniqueId')};
   	string3 Probability {xpath('Probability')};
   	boolean HasBankruptcy {xpath('HasBankruptcy')};
   	boolean HasProperty {xpath('HasProperty')};
   	boolean HasCorporateAffiliation {xpath('HasCorporateAffiliation')};
   	iesp.prelitigationreport.t_PreLitigationReportAlsoFound AlsoFound {xpath('AlsoFound')};
   	dataset(iesp.bpsreport.t_BpsReportRelativeSlim) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.constants.BR.MaxRelatives)};
   	dataset(iesp.bpsreport.t_BpsReportAssociateSlim) Associates {xpath('Associates/Associate'), MAXCOUNT(iesp.constants.BR.MaxAssociates)};
   	dataset(iesp.dirassistwireless.t_PhonesPlusRecord) PhonesPluses {xpath('PhonesPluses/PhonesPlus'), MAXCOUNT(iesp.constants.BR.MaxPhonesPlus)};
   	dataset(iesp.motorvehicle.t_MVReportRecord) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(iesp.constants.BR.MaxVehicles)};
   	dataset(iesp.ucc.t_UCCReport2Record) UCCFilings {xpath('UCCFilings/UCCFiling'), MAXCOUNT(iesp.constants.BR.MaxUCCFilings)};
   	dataset(iesp.bps_share.t_BpsReportImposter) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(iesp.constants.BR.MaxImposters)};
   	//dataset(bps_share.t_BpsReportIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.BR.MaxAKA)};
   	dataset(iesp.bpsreport.t_BpsReportAddressSlim) BpsReportAddresses2 {xpath('BpsReportAddresses2/BpsReportAddress'), MAXCOUNT(iesp.constants.BR.MaxAddress)};
   	//dataset(watercraft.t_WaterCraftReportRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.constants.BR.MaxWatercrafts)};
   	//dataset(propassess.t_AssessReportRecord) AssessRecords {xpath('AssessRecords/AssessRecord'), MAXCOUNT(iesp.constants.BR.MaxAssessments)};
   	//dataset(propdeed.t_DeedReportRecord) DeedRecords {xpath('DeedRecords/DeedRecord'), MAXCOUNT(iesp.constants.BR.MaxDeeds)};
   	dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) PeopleAtWorks {xpath('PeopleAtWorks/PeopleAtWork'), MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
   	dataset(iesp.bankruptcy.t_BankruptcyReportRecord) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.constants.BR.MaxBankruptcies)};
   	dataset(iesp.proflicense.t_ProfessionalLicenseRecord) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(iesp.constants.BR.MaxProfLicenses)};
   	dataset(iesp.bpsreport.t_BpsReportLienJudgment) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.constants.BR.MaxLiensJudgments)};
   	
   	dataset(iesp.watercraft_fcra.t_FcraWaterCraftReportRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.constants.BR.MaxWatercrafts)};
   	dataset(iesp.propassess_fcra.t_FcraAssessReportRecord) AssessRecords {xpath('AssessRecords/AssessRecord'), MAXCOUNT(iesp.constants.BR.MaxAssessments)};
   	dataset(iesp.propdeed_fcra.t_FcraDeedReportRecord) DeedRecords {xpath('DeedRecords/DeedRecord'), MAXCOUNT(iesp.constants.BR.MaxDeeds)};
   	//dataset(iesp.lienjudgement.t_LienJudgmentReportRecord) LiensJudgments2 {xpath('LiensJudgments2/LienJudgment'), MAXCOUNT(iesp.constants.BR.MaxLiensJudgments)};
   	//dataset(iesp.bankruptcy.t_Bankruptcy3BpsRecord) Bankruptcies3 {xpath('Bankruptcies3/Bankruptcy'), MAXCOUNT(iesp.constants.BR.MaxBankruptcies)};
		dataset(iesp.lienjudgement_fcra.t_FcraLienJudgmentReportRecord) LiensJudgments2 {xpath('LiensJudgments2/LienJudgment'), MAXCOUNT(iesp.constants.BR.MaxLiensJudgments)};
		dataset(iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord) Bankruptcies3 {xpath('Bankruptcies3/Bankruptcy'), MAXCOUNT(iesp.constants.BR.MaxBankruptcies)};
   	//dataset(share_fcra.t_FcraIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.BR.MaxAKA)};
   	dataset(CommonPreLitigationReportIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.BR.MaxAKA)};
   	
   end;

end;