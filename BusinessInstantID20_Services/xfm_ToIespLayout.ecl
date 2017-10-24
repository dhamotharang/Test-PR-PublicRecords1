IMPORT iesp, risk_indicators, ut;

// --------------------[ Components for InputEcho section ]--------------------

fn_NormalizeAuthReps( BusinessInstantID20_Services.Layouts.InputEchoLayout echo ) := 
	FUNCTION
		
		iesp.businessinstantid20.t_BIID20AuthRep xfm_AuthRep1 := 
			TRANSFORM
				SELF.Name                := ROW( {echo.in_rep1_full, echo.in_rep1_first, echo.in_rep1_middle, echo.in_rep1_last,'', echo.in_rep1_title}, iesp.share.t_Name );
				SELF.FormerLastName      := '';
				SELF.UniqueId            := (STRING)echo.rep1_lexid;
				SELF.Address             := ROW( {'', '', '', '', '', '', '', echo.in_rep1_streetaddress1, echo.in_rep1_streetaddress2, echo.in_rep1_city, echo.in_rep1_state, echo.in_rep1_zip, '', '', '', ''}, iesp.share.t_Address );
				SELF.DOB                 := ROW( {(INTEGER2)(echo.in_rep1_dob[1..4]), (INTEGER2)(echo.in_rep1_dob[5..6]), (INTEGER2)(echo.in_rep1_dob[7..8])}, iesp.share.t_Date );
				SELF.Age                 := echo.in_rep1_age;
				SELF.SSN                 := echo.in_rep1_ssn;
				SELF.Phone               := echo.in_rep1_phone10;
				SELF.DriverLicenseNumber := echo.in_rep1_dlnumber;
				SELF.DriverLicenseState  := echo.in_rep1_dlstate;
				SELF.Email               := echo.in_rep1_email;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20AuthRep xfm_AuthRep2 := 
			TRANSFORM
				SELF.Name                := ROW( {echo.in_rep2_full, echo.in_rep2_first, echo.in_rep2_middle, echo.in_rep2_last,'', echo.in_rep2_title}, iesp.share.t_Name );
				SELF.FormerLastName      := '';
				SELF.UniqueId            := (STRING)echo.rep2_lexid;
				SELF.Address             := ROW( {'', '', '', '', '', '', '', echo.in_rep2_streetaddress1, echo.in_rep2_streetaddress2, echo.in_rep2_city, echo.in_rep2_state, echo.in_rep2_zip, '', '', '', ''}, iesp.share.t_Address );
				SELF.DOB                 := ROW( {(INTEGER2)(echo.in_rep2_dob[1..4]), (INTEGER2)(echo.in_rep2_dob[5..6]), (INTEGER2)(echo.in_rep2_dob[7..8])}, iesp.share.t_Date );
				SELF.Age                 := echo.in_rep2_age;
				SELF.SSN                 := echo.in_rep2_ssn;
				SELF.Phone               := echo.in_rep2_phone10;
				SELF.DriverLicenseNumber := echo.in_rep2_dlnumber;
				SELF.DriverLicenseState  := echo.in_rep2_dlstate;
				SELF.Email               := echo.in_rep2_email;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20AuthRep xfm_AuthRep3 := 
			TRANSFORM
				SELF.Name                := ROW( {echo.in_rep3_full, echo.in_rep3_first, echo.in_rep3_middle, echo.in_rep3_last,'', echo.in_rep3_title}, iesp.share.t_Name );
				SELF.FormerLastName      := '';
				SELF.UniqueId            := (STRING)echo.rep3_lexid;
				SELF.Address             := ROW( {'', '', '', '', '', '', '', echo.in_rep3_streetaddress1, echo.in_rep3_streetaddress2, echo.in_rep3_city, echo.in_rep3_state, echo.in_rep3_zip, '', '', '', ''}, iesp.share.t_Address );
				SELF.DOB                 := ROW( {(INTEGER2)(echo.in_rep3_dob[1..4]), (INTEGER2)(echo.in_rep3_dob[5..6]), (INTEGER2)(echo.in_rep3_dob[7..8])}, iesp.share.t_Date );
				SELF.Age                 := echo.in_rep3_age;
				SELF.SSN                 := echo.in_rep3_ssn;
				SELF.Phone               := echo.in_rep3_phone10;
				SELF.DriverLicenseNumber := echo.in_rep3_dlnumber;
				SELF.DriverLicenseState  := echo.in_rep3_dlstate;
				SELF.Email               := echo.in_rep3_email;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20AuthRep xfm_AuthRep4 := 
			TRANSFORM
				SELF.Name                := ROW( {echo.in_rep4_full, echo.in_rep4_first, echo.in_rep4_middle, echo.in_rep4_last,'', echo.in_rep4_title}, iesp.share.t_Name );
				SELF.FormerLastName      := '';
				SELF.UniqueId            := (STRING)echo.rep4_lexid;
				SELF.Address             := ROW( {'', '', '', '', '', '', '', echo.in_rep4_streetaddress1, echo.in_rep4_streetaddress2, echo.in_rep4_city, echo.in_rep4_state, echo.in_rep4_zip, '', '', '', ''}, iesp.share.t_Address );
				SELF.DOB                 := ROW( {(INTEGER2)(echo.in_rep4_dob[1..4]), (INTEGER2)(echo.in_rep4_dob[5..6]), (INTEGER2)(echo.in_rep4_dob[7..8])}, iesp.share.t_Date );
				SELF.Age                 := echo.in_rep4_age;
				SELF.SSN                 := echo.in_rep4_ssn;
				SELF.Phone               := echo.in_rep4_phone10;
				SELF.DriverLicenseNumber := echo.in_rep4_dlnumber;
				SELF.DriverLicenseState  := echo.in_rep4_dlstate;
				SELF.Email               := echo.in_rep4_email;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20AuthRep xfm_AuthRep5 := 
			TRANSFORM
				SELF.Name                := ROW( {echo.in_rep5_full, echo.in_rep5_first, echo.in_rep5_middle, echo.in_rep5_last,'', echo.in_rep5_title}, iesp.share.t_Name );
				SELF.FormerLastName      := '';
				SELF.UniqueId            := (STRING)echo.rep5_lexid;
				SELF.Address             := ROW( {'', '', '', '', '', '', '', echo.in_rep5_streetaddress1, echo.in_rep5_streetaddress2, echo.in_rep5_city, echo.in_rep5_state, echo.in_rep5_zip, '', '', '', ''}, iesp.share.t_Address );
				SELF.DOB                 := ROW( {(INTEGER2)(echo.in_rep5_dob[1..4]), (INTEGER2)(echo.in_rep5_dob[5..6]), (INTEGER2)(echo.in_rep5_dob[7..8])}, iesp.share.t_Date );
				SELF.Age                 := echo.in_rep5_age;
				SELF.SSN                 := echo.in_rep5_ssn;
				SELF.Phone               := echo.in_rep5_phone10;
				SELF.DriverLicenseNumber := echo.in_rep5_dlnumber;
				SELF.DriverLicenseState  := echo.in_rep5_dlstate;
				SELF.Email               := echo.in_rep5_email;
				SELF := [];
			END;
		
		AuthRepsNormalized := DATASET( [xfm_AuthRep1] ) + DATASET( [xfm_AuthRep2] ) + DATASET( [xfm_AuthRep3] ) + DATASET( [xfm_AuthRep4] ) + DATASET( [xfm_AuthRep5] );
		
		RETURN AuthRepsNormalized(Name.Last != '' OR Name.Full != '');
	END;

iesp.businessinstantid20.t_BIID20InputEcho xfm_AddInputEcho(BusinessInstantID20_Services.Layouts.InputEchoLayout le) := 
	TRANSFORM
		SELF.Seq                                 := (STRING)le.seq;
		SELF.Company.CompanyName                 := le.in_bus_name;
		SELF.Company.AlternateCompanyName        := le.in_bus_alternatename;
		SELF.Company.Address.StreetNumber        := '';
		SELF.Company.Address.StreetPreDirection  := '';
		SELF.Company.Address.StreetName          := '';
		SELF.Company.Address.StreetSuffix        := '';
		SELF.Company.Address.StreetPostDirection := '';
		SELF.Company.Address.UnitDesignation     := '';
		SELF.Company.Address.UnitNumber          := '';
		SELF.Company.Address.StreetAddress1      := le.in_bus_streetaddress1;
		SELF.Company.Address.StreetAddress2      := le.in_bus_streetaddress2;
		SELF.Company.Address.City                := le.in_bus_city;
		SELF.Company.Address.State               := le.in_bus_state;
		SELF.Company.Address.Zip5                := le.in_bus_zip;
		SELF.Company.Address.Zip4                := '';
		SELF.Company.Phone                       := le.in_bus_phone10;
		SELF.Company.FEIN                        := le.in_bus_fein;
		SELF.AuthorizedRepresentatives           := fn_NormalizeAuthReps( le );		
		SELF := [];
	END;

// --------------------[ Components for CompanyResults section ]--------------------

//  1. CompanyResults: VerifiedInput 

temp_VerifiedLayout := {BusinessInstantID20_Services.Layouts.VerifiedLayout AND NOT [seq]};

iesp.businessinstantid20.t_BIID20Company xfm_VerifiedInput( temp_VerifiedLayout le ) := 
	TRANSFORM
		SELF.CompanyName                 := le.bus_ver_name;
		SELF.AlternateCompanyName        := le.bus_ver_altname;
		SELF.Address.StreetNumber        := '';
		SELF.Address.StreetPreDirection  := '';
		SELF.Address.StreetName          := '';
		SELF.Address.StreetSuffix        := '';
		SELF.Address.StreetPostDirection := '';
		SELF.Address.UnitDesignation     := '';
		SELF.Address.UnitNumber          := '';
		SELF.Address.StreetAddress1      := le.bus_ver_addr;
		SELF.Address.StreetAddress2      := ''; // TODO?
		SELF.Address.City                := le.bus_ver_city;
		SELF.Address.State               := le.bus_ver_state;
		SELF.Address.Zip5                := le.bus_ver_zip;
		SELF.Address.Zip4                := le.bus_ver_zip4;
		SELF.Phone                       := le.bus_ver_phone;
		SELF.FEIN                        := le.bus_ver_tin;
		SELF := [];
	END;

//  2. CompanyResults: VerificationIndicators 

temp_VerificationLayout := {BusinessInstantID20_Services.Layouts.VerificationLayout AND NOT [seq]};

iesp.businessinstantid20.t_BIID20VerificationIndicators xfm_VerificationIndicators( temp_VerificationLayout le ) := 
	TRANSFORM
		SELF.CompanyName   := IF( le.ver_name_indicator = '1', le.ver_name_indicator, le.ver_altname_indicator );
		SELF.StreetAddress := le.ver_streetaddr_indicator;
		SELF.City          := le.ver_city_indicator;
		SELF.State         := le.ver_state_indicator;
		SELF.Zip           := le.ver_zip_indicator;
		SELF.Phone         := le.ver_phone_indicator;
		SELF.FEIN          := le.ver_tin_indicator;
		SELF := [];
	END;

//  3. CompanyResults: Best Information  

temp_BestInfoLayout := {BusinessInstantID20_Services.Layouts.BestInfoLayout AND NOT [Seq,isactive,isdefunct,dt_first_seen,dt_last_seen,best_bus_county]};
				
iesp.businessinstantid20.t_BIID20Company xfm_BestInformation( temp_BestInfoLayout le ) := 
	TRANSFORM
		SELF.CompanyName                 := le.best_bus_name;
		SELF.AlternateCompanyName        := '';
		SELF.Address.StreetNumber        := le.best_bus_prim_range;
		SELF.Address.StreetPreDirection  := le.best_bus_predir;
		SELF.Address.StreetName          := le.best_bus_prim_name;
		SELF.Address.StreetSuffix        := le.best_bus_addr_suffix;
		SELF.Address.StreetPostDirection := le.best_bus_postdir;
		SELF.Address.UnitDesignation     := le.best_bus_unit_desig;
		SELF.Address.UnitNumber          := le.best_bus_sec_range;
		SELF.Address.StreetAddress1      := le.best_bus_addr;
		SELF.Address.StreetAddress2      := ''; // TODO?
		SELF.Address.City                := le.best_bus_city;
		SELF.Address.State               := le.best_bus_state;
		SELF.Address.Zip5                := le.best_bus_zip;
		SELF.Address.Zip4                := le.best_bus_zip4;
		SELF.Phone                       := le.best_bus_phone;
		SELF.FEIN                        := le.best_bus_fein;
		SELF := [];
	END;

//  4. CompanyResults: NamesAddressesOfPhone (3) 
fn_GetNamesAddressesFromPhone( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le ) := 
	FUNCTION
		iesp.businessinstantid20.t_BIID20NameAddressLinkIDs xfm_Rec1 := TRANSFORM
			SELF.CompanyName                 := le.BusinessByPhone.bus_phone_match_company_1;
			SELF.Address.StreetNumber        := le.BusinessByPhone.bus_phone_match_prim_range_1;
			SELF.Address.StreetPreDirection  := le.BusinessByPhone.bus_phone_match_predir_1;
			SELF.Address.StreetName          := le.BusinessByPhone.bus_phone_match_prim_name_1;
			SELF.Address.StreetSuffix        := le.BusinessByPhone.bus_phone_match_suffix_1;
			SELF.Address.StreetPostDirection := le.BusinessByPhone.bus_phone_match_postdir_1;
			SELF.Address.UnitDesignation     := le.BusinessByPhone.bus_phone_match_unit_desig_1;
			SELF.Address.UnitNumber          := le.BusinessByPhone.bus_phone_match_sec_range_1;
			SELF.Address.StreetAddress1      := le.BusinessByPhone.bus_phone_match_addr_1;
			SELF.Address.StreetAddress2      := '';
			SELF.Address.City                := le.BusinessByPhone.bus_phone_match_city_1;
			SELF.Address.State               := le.BusinessByPhone.bus_phone_match_state_1;
			SELF.Address.Zip5                := le.BusinessByPhone.bus_phone_match_zip_1;
			SELF.Address.Zip4                := le.BusinessByPhone.bus_phone_match_zip4_1;
			SELF.Address.County              := '';
			SELF.Address.PostalCode          := '';
			SELF.Address.StateCityZip 		   := '';
			SELF.BusinessIDs.POWID               := le.BusinessByPhone.bus_phone_match_powid_1;
			SELF.BusinessIDs.ProxID              := le.BusinessByPhone.bus_phone_match_proxid_1;
			SELF.BusinessIDs.SeleID              := le.BusinessByPhone.bus_phone_match_seleid_1;
			SELF.BusinessIDs.OrgID               := le.BusinessByPhone.bus_phone_match_orgid_1;
			SELF.BusinessIDs.UltID               := le.BusinessByPhone.bus_phone_match_ultid_1;
			SELF := [];
		END;

		iesp.businessinstantid20.t_BIID20NameAddressLinkIDs xfm_Rec2 := TRANSFORM
			SELF.CompanyName                 := le.BusinessByPhone.bus_phone_match_company_2;
			SELF.Address.StreetNumber        := le.BusinessByPhone.bus_phone_match_prim_range_2;
			SELF.Address.StreetPreDirection  := le.BusinessByPhone.bus_phone_match_predir_2;
			SELF.Address.StreetName          := le.BusinessByPhone.bus_phone_match_prim_name_2;
			SELF.Address.StreetSuffix        := le.BusinessByPhone.bus_phone_match_suffix_2;
			SELF.Address.StreetPostDirection := le.BusinessByPhone.bus_phone_match_postdir_2;
			SELF.Address.UnitDesignation     := le.BusinessByPhone.bus_phone_match_unit_desig_2;
			SELF.Address.UnitNumber          := le.BusinessByPhone.bus_phone_match_sec_range_2;
			SELF.Address.StreetAddress1      := le.BusinessByPhone.bus_phone_match_addr_2;
			SELF.Address.StreetAddress2      := '';
			SELF.Address.City                := le.BusinessByPhone.bus_phone_match_city_2;
			SELF.Address.State               := le.BusinessByPhone.bus_phone_match_state_2;
			SELF.Address.Zip5                := le.BusinessByPhone.bus_phone_match_zip_2;
			SELF.Address.Zip4                := le.BusinessByPhone.bus_phone_match_zip4_2;
			SELF.Address.County              := '';
			SELF.Address.PostalCode          := '';
			SELF.Address.StateCityZip 		   := '';
			SELF.BusinessIDs.POWID               := le.BusinessByPhone.bus_phone_match_powid_2;
			SELF.BusinessIDs.ProxID              := le.BusinessByPhone.bus_phone_match_proxid_2;
			SELF.BusinessIDs.SeleID              := le.BusinessByPhone.bus_phone_match_seleid_2;
			SELF.BusinessIDs.OrgID               := le.BusinessByPhone.bus_phone_match_orgid_2;
			SELF.BusinessIDs.UltID               := le.BusinessByPhone.bus_phone_match_ultid_2;
			SELF := [];
		END;
	
		iesp.businessinstantid20.t_BIID20NameAddressLinkIDs xfm_Rec3 := TRANSFORM
			SELF.CompanyName                 := le.BusinessByPhone.bus_phone_match_company_3;
			SELF.Address.StreetNumber        := le.BusinessByPhone.bus_phone_match_prim_range_3;
			SELF.Address.StreetPreDirection  := le.BusinessByPhone.bus_phone_match_predir_3;
			SELF.Address.StreetName          := le.BusinessByPhone.bus_phone_match_prim_name_3;
			SELF.Address.StreetSuffix        := le.BusinessByPhone.bus_phone_match_suffix_3;
			SELF.Address.StreetPostDirection := le.BusinessByPhone.bus_phone_match_postdir_3;
			SELF.Address.UnitDesignation     := le.BusinessByPhone.bus_phone_match_unit_desig_3;
			SELF.Address.UnitNumber          := le.BusinessByPhone.bus_phone_match_sec_range_3;
			SELF.Address.StreetAddress1      := le.BusinessByPhone.bus_phone_match_addr_3;
			SELF.Address.StreetAddress2      := '';
			SELF.Address.City                := le.BusinessByPhone.bus_phone_match_city_3;
			SELF.Address.State               := le.BusinessByPhone.bus_phone_match_state_3;
			SELF.Address.Zip5                := le.BusinessByPhone.bus_phone_match_zip_3;
			SELF.Address.Zip4                := le.BusinessByPhone.bus_phone_match_zip4_3;
			SELF.Address.County              := '';
			SELF.Address.PostalCode          := '';
			SELF.Address.StateCityZip 		   := '';
			SELF.BusinessIDs.POWID               := le.BusinessByPhone.bus_phone_match_powid_3;
			SELF.BusinessIDs.ProxID              := le.BusinessByPhone.bus_phone_match_proxid_3;
			SELF.BusinessIDs.SeleID              := le.BusinessByPhone.bus_phone_match_seleid_3;
			SELF.BusinessIDs.OrgID               := le.BusinessByPhone.bus_phone_match_orgid_3;
			SELF.BusinessIDs.UltID               := le.BusinessByPhone.bus_phone_match_ultid_3;
			SELF := [];
		END;
		
		NamesAddressesFromPhone := 
			DATASET( [xfm_Rec1] ) + DATASET( [xfm_Rec2] ) + DATASET( [xfm_Rec3] );
		
		RETURN NamesAddressesFromPhone(CompanyName != '');
	END;
	
//  5. CompanyResults: PhoneOfNameAddress (3) 
fn_GetPhonesFromAddress( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le) := 
	FUNCTION
		PhonesOfNameAddress := 
			DATASET( 
				[
					{le.PhonesByAddress.bus_addr_match_phone_1},
					{le.PhonesByAddress.bus_addr_match_phone_2},
					{le.PhonesByAddress.bus_addr_match_phone_3}
				], 
				iesp.businessinstantid20.t_BIID20PhoneOfNameAddress 
			);
		
		RETURN PhonesOfNameAddress(PhoneOfNameAddress != '');
	END;
	
//  6. CompanyResults: FEINMatchResults (3)
fn_GetNamesAddressesFromFEIN( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le) := 
	FUNCTION
		iesp.businessinstantid20.t_BIID20NameAddressLinkIDs xfm_Rec1 := TRANSFORM
			SELF.CompanyName                 := le.BusinessByFEIN.bus_fein_match_company_1;
			SELF.Address.StreetNumber        := le.BusinessByFEIN.bus_fein_match_prim_range_1;
			SELF.Address.StreetPreDirection  := le.BusinessByFEIN.bus_fein_match_predir_1;
			SELF.Address.StreetName          := le.BusinessByFEIN.bus_fein_match_prim_name_1;
			SELF.Address.StreetSuffix        := le.BusinessByFEIN.bus_fein_match_suffix_1;
			SELF.Address.StreetPostDirection := le.BusinessByFEIN.bus_fein_match_postdir_1;
			SELF.Address.UnitDesignation     := le.BusinessByFEIN.bus_fein_match_unit_desig_1;
			SELF.Address.UnitNumber          := le.BusinessByFEIN.bus_fein_match_sec_range_1;
			SELF.Address.StreetAddress1      := le.BusinessByFEIN.bus_fein_match_addr_1;
			SELF.Address.StreetAddress2      := '';
			SELF.Address.City                := le.BusinessByFEIN.bus_fein_match_city_1;
			SELF.Address.State               := le.BusinessByFEIN.bus_fein_match_state_1;
			SELF.Address.Zip5                := le.BusinessByFEIN.bus_fein_match_zip_1;
			SELF.Address.Zip4                := le.BusinessByFEIN.bus_fein_match_zip4_1;
			SELF.Address.County              := '';
			SELF.Address.PostalCode          := '';
			SELF.Address.StateCityZip 		   := '';
			SELF.BusinessIDs.POWID               := le.BusinessByFEIN.bus_fein_match_powid_1;
			SELF.BusinessIDs.ProxID              := le.BusinessByFEIN.bus_fein_match_proxid_1;
			SELF.BusinessIDs.SeleID              := le.BusinessByFEIN.bus_fein_match_seleid_1;
			SELF.BusinessIDs.OrgID               := le.BusinessByFEIN.bus_fein_match_orgid_1;
			SELF.BusinessIDs.UltID               := le.BusinessByFEIN.bus_fein_match_ultid_1;
			SELF := [];
		END;

		iesp.businessinstantid20.t_BIID20NameAddressLinkIDs xfm_Rec2 := TRANSFORM
			SELF.CompanyName                 := le.BusinessByFEIN.bus_fein_match_company_2;
			SELF.Address.StreetNumber        := le.BusinessByFEIN.bus_fein_match_prim_range_2;
			SELF.Address.StreetPreDirection  := le.BusinessByFEIN.bus_fein_match_predir_2;
			SELF.Address.StreetName          := le.BusinessByFEIN.bus_fein_match_prim_name_2;
			SELF.Address.StreetSuffix        := le.BusinessByFEIN.bus_fein_match_suffix_2;
			SELF.Address.StreetPostDirection := le.BusinessByFEIN.bus_fein_match_postdir_2;
			SELF.Address.UnitDesignation     := le.BusinessByFEIN.bus_fein_match_unit_desig_2;
			SELF.Address.UnitNumber          := le.BusinessByFEIN.bus_fein_match_sec_range_2;
			SELF.Address.StreetAddress1      := le.BusinessByFEIN.bus_fein_match_addr_2;
			SELF.Address.StreetAddress2      := '';
			SELF.Address.City                := le.BusinessByFEIN.bus_fein_match_city_2;
			SELF.Address.State               := le.BusinessByFEIN.bus_fein_match_state_2;
			SELF.Address.Zip5                := le.BusinessByFEIN.bus_fein_match_zip_2;
			SELF.Address.Zip4                := le.BusinessByFEIN.bus_fein_match_zip4_2;
			SELF.Address.County              := '';
			SELF.Address.PostalCode          := '';
			SELF.Address.StateCityZip 		   := '';
			SELF.BusinessIDs.POWID               := le.BusinessByFEIN.bus_fein_match_powid_2;
			SELF.BusinessIDs.ProxID              := le.BusinessByFEIN.bus_fein_match_proxid_2;
			SELF.BusinessIDs.SeleID              := le.BusinessByFEIN.bus_fein_match_seleid_2;
			SELF.BusinessIDs.OrgID               := le.BusinessByFEIN.bus_fein_match_orgid_2;
			SELF.BusinessIDs.UltID               := le.BusinessByFEIN.bus_fein_match_ultid_2;
			SELF := [];
		END;
	
		iesp.businessinstantid20.t_BIID20NameAddressLinkIDs xfm_Rec3 := TRANSFORM
			SELF.CompanyName                 := le.BusinessByFEIN.bus_fein_match_company_3;
			SELF.Address.StreetNumber        := le.BusinessByFEIN.bus_fein_match_prim_range_3;
			SELF.Address.StreetPreDirection  := le.BusinessByFEIN.bus_fein_match_predir_3;
			SELF.Address.StreetName          := le.BusinessByFEIN.bus_fein_match_prim_name_3;
			SELF.Address.StreetSuffix        := le.BusinessByFEIN.bus_fein_match_suffix_3;
			SELF.Address.StreetPostDirection := le.BusinessByFEIN.bus_fein_match_postdir_3;
			SELF.Address.UnitDesignation     := le.BusinessByFEIN.bus_fein_match_unit_desig_3;
			SELF.Address.UnitNumber          := le.BusinessByFEIN.bus_fein_match_sec_range_3;
			SELF.Address.StreetAddress1      := le.BusinessByFEIN.bus_fein_match_addr_3;
			SELF.Address.StreetAddress2      := '';
			SELF.Address.City                := le.BusinessByFEIN.bus_fein_match_city_3;
			SELF.Address.State               := le.BusinessByFEIN.bus_fein_match_state_3;
			SELF.Address.Zip5                := le.BusinessByFEIN.bus_fein_match_zip_3;
			SELF.Address.Zip4                := le.BusinessByFEIN.bus_fein_match_zip4_3;
			SELF.Address.County              := '';
			SELF.Address.PostalCode          := '';
			SELF.Address.StateCityZip 		   := '';
			SELF.BusinessIDs.POWID               := le.BusinessByFEIN.bus_fein_match_powid_3;
			SELF.BusinessIDs.ProxID              := le.BusinessByFEIN.bus_fein_match_proxid_3;
			SELF.BusinessIDs.SeleID              := le.BusinessByFEIN.bus_fein_match_seleid_3;
			SELF.BusinessIDs.OrgID               := le.BusinessByFEIN.bus_fein_match_orgid_3;
			SELF.BusinessIDs.UltID               := le.BusinessByFEIN.bus_fein_match_ultid_3;

			SELF := [];
		END;
		
		NamesAddressesFromFEIN := 
			DATASET( [xfm_Rec1] ) + DATASET( [xfm_Rec2] ) + DATASET( [xfm_Rec3] );
		
		RETURN NamesAddressesFromFEIN(CompanyName != '');
	END;
	
//  7. CompanyResults: LinkIDs
 
iesp.share.t_BusinessIdentity xfm_LinkIDs(BusinessInstantID20_Services.Layouts.InputEchoLayout le) :=
	TRANSFORM
		SELF.DotID  := 0;
		SELF.EmpID  := 0;
		SELF.POWID  := le.powid;
		SELF.ProxID := le.proxid;
		SELF.SeleID := le.seleid;
		SELF.OrgID  := le.orgid;
		SELF.UltID  := le.ultid;
	END;

// 8. CompanyResults: BusinessVerificationIndex

temp_BusinessVerificationLayout := {BusinessInstantID20_Services.Layouts.VerificationSummariesLayout AND NOT [Seq]};

iesp.businessinstantid20.t_BIID20BusinessVerification xfm_BusinessVerification( temp_BusinessVerificationLayout le ) := 
	TRANSFORM
		SELF.Index       := le.bvi;
		SELF.Description := le.bvi_desc;
		SELF := [];
	END;

// 9. CompanyResults: OFACWatchLists (7)
fn_GetOFAC( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le) := 
	FUNCTION

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec1 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_1;
				SELF.Program                := le.OFAC.bus_ofac_program_1;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_1;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_1;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_1;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_1;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_1;
				SELF.Address.City           := le.OFAC.bus_ofac_city_1;
				SELF.Address.State          := le.OFAC.bus_ofac_state_1;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_1;
				SELF.Country                := le.OFAC.bus_ofac_country_1;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_1;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_1;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec2 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_2;
				SELF.Program                := le.OFAC.bus_ofac_program_2;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_2;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_2;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_2;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_2;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_2;
				SELF.Address.City           := le.OFAC.bus_ofac_city_2;
				SELF.Address.State          := le.OFAC.bus_ofac_state_2;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_2;
				SELF.Country                := le.OFAC.bus_ofac_country_2;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_2;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_2;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec3 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_3;
				SELF.Program                := le.OFAC.bus_ofac_program_3;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_3;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_3;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_3;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_3;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_3;
				SELF.Address.City           := le.OFAC.bus_ofac_city_3;
				SELF.Address.State          := le.OFAC.bus_ofac_state_3;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_3;
				SELF.Country                := le.OFAC.bus_ofac_country_3;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_3;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_3;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec4 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_4;
				SELF.Program                := le.OFAC.bus_ofac_program_4;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_4;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_4;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_4;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_4;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_4;
				SELF.Address.City           := le.OFAC.bus_ofac_city_4;
				SELF.Address.State          := le.OFAC.bus_ofac_state_4;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_4;
				SELF.Country                := le.OFAC.bus_ofac_country_4;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_4;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_4;
				SELF := [];
			END;
			
		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec5 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_5;
				SELF.Program                := le.OFAC.bus_ofac_program_5;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_5;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_5;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_5;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_5;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_5;
				SELF.Address.City           := le.OFAC.bus_ofac_city_5;
				SELF.Address.State          := le.OFAC.bus_ofac_state_5;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_5;
				SELF.Country                := le.OFAC.bus_ofac_country_5;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_5;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_5;
				SELF := [];
			END;			

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec6 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_6;
				SELF.Program                := le.OFAC.bus_ofac_program_6;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_6;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_6;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_6;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_6;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_6;
				SELF.Address.City           := le.OFAC.bus_ofac_city_6;
				SELF.Address.State          := le.OFAC.bus_ofac_state_6;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_6;
				SELF.Country                := le.OFAC.bus_ofac_country_6;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_6;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_6;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec7 :=
			TRANSFORM
				SELF.Table                  := le.OFAC.bus_ofac_table_7;
				SELF.Program                := le.OFAC.bus_ofac_program_7;
				SELF.RecordNumber           := le.OFAC.bus_ofac_record_number_7;
				SELF.CompanyName            := le.OFAC.bus_ofac_companyname_7;
				SELF.Name.First             := le.OFAC.bus_ofac_firstname_7;
				SELF.Name.Last              := le.OFAC.bus_ofac_lastname_7;
				SELF.Address.StreetAddress1 := le.OFAC.bus_ofac_address_7;
				SELF.Address.City           := le.OFAC.bus_ofac_city_7;
				SELF.Address.State          := le.OFAC.bus_ofac_state_7;
				SELF.Address.Zip5           := le.OFAC.bus_ofac_zip_7;
				SELF.Country                := le.OFAC.bus_ofac_country_7;
				SELF.EntityName             := le.OFAC.bus_ofac_entity_name_7;
				SELF.Sequence               := le.OFAC.bus_ofac_sequence_7;
				SELF := [];
			END;
			
		ds_OFAC := 
					DATASET( [xfm_Rec1] ) + DATASET( [xfm_Rec2] ) + DATASET( [xfm_Rec3] ) + 
					DATASET( [xfm_Rec4] ) + DATASET( [xfm_Rec5] ) + DATASET( [xfm_Rec6] ) + DATASET( [xfm_Rec7] );
		
		RETURN ds_OFAC(CompanyName != '' OR EntityName != '' OR Name.First != '');
		
	END;

// CompanyResults: Compliance

fn_GetWatchlists( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le) := 
	FUNCTION

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec1 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_1;
				SELF.Program                := le.Watchlists.bus_watchlist_program_1;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_1;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_1;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_1;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_1;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_1;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_1;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_1;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_1;
				SELF.Country                := le.Watchlists.bus_watchlist_country_1;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_1;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_1;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec2 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_2;
				SELF.Program                := le.Watchlists.bus_watchlist_program_2;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_2;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_2;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_2;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_2;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_2;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_2;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_2;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_2;
				SELF.Country                := le.Watchlists.bus_watchlist_country_2;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_2;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_2;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec3 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_3;
				SELF.Program                := le.Watchlists.bus_watchlist_program_3;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_3;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_3;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_3;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_3;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_3;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_3;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_3;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_3;
				SELF.Country                := le.Watchlists.bus_watchlist_country_3;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_3;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_3;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec4 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_4;
				SELF.Program                := le.Watchlists.bus_watchlist_program_4;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_4;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_4;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_4;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_4;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_4;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_4;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_4;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_4;
				SELF.Country                := le.Watchlists.bus_watchlist_country_4;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_4;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_4;
				SELF := [];
			END;
			
		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec5 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_5;
				SELF.Program                := le.Watchlists.bus_watchlist_program_5;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_5;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_5;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_5;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_5;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_5;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_5;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_5;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_5;
				SELF.Country                := le.Watchlists.bus_watchlist_country_5;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_5;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_5;
				SELF := [];
			END;			

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec6 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_6;
				SELF.Program                := le.Watchlists.bus_watchlist_program_6;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_6;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_6;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_6;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_6;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_6;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_6;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_6;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_6;
				SELF.Country                := le.Watchlists.bus_watchlist_country_6;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_6;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_6;
				SELF := [];
			END;

		iesp.businessinstantid20.t_BIID20WatchList xfm_Rec7 :=
			TRANSFORM
				SELF.Table                  := le.Watchlists.bus_watchlist_table_7;
				SELF.Program                := le.Watchlists.bus_watchlist_program_7;
				SELF.RecordNumber           := le.Watchlists.bus_watchlist_record_number_7;
				SELF.CompanyName            := le.Watchlists.bus_watchlist_companyname_7;
				SELF.Name.First             := le.Watchlists.bus_watchlist_firstname_7;
				SELF.Name.Last              := le.Watchlists.bus_watchlist_lastname_7;
				SELF.Address.StreetAddress1 := le.Watchlists.bus_watchlist_address_7;
				SELF.Address.City           := le.Watchlists.bus_watchlist_city_7;
				SELF.Address.State          := le.Watchlists.bus_watchlist_state_7;
				SELF.Address.Zip5           := le.Watchlists.bus_watchlist_zip_7;
				SELF.Country                := le.Watchlists.bus_watchlist_country_7;
				SELF.EntityName             := le.Watchlists.bus_watchlist_entity_name_7;
				SELF.Sequence               := le.Watchlists.bus_watchlist_sequence_7;
				SELF := [];
			END;
			
		ds_Watchlists := 
					DATASET( [xfm_Rec1] ) + DATASET( [xfm_Rec2] ) + DATASET( [xfm_Rec3] ) + 
					DATASET( [xfm_Rec4] ) + DATASET( [xfm_Rec5] ) + DATASET( [xfm_Rec6] ) + DATASET( [xfm_Rec7] );
		
		RETURN ds_Watchlists(CompanyName != '' OR EntityName != '' OR Name.First != '');
		
	END;


temp_ParentLayout := {BusinessInstantID20_Services.Layouts.ParentLayout AND NOT [seq]};

iesp.businessinstantid20.t_BIID20ParentCompany xfm_Parent(temp_ParentLayout le) :=
	TRANSFORM
		SELF.BusinessIDs.SeleID := le.parent_seleid;
		SELF.BusinessIDs.OrgID  := le.parent_orgid;
		SELF.BusinessIDs.UltID  := le.parent_ultid;
		SELF.CompanyName        := le.parent_best_bus_name;
	END;

temp_PersonRoleLayout := {BusinessInstantID20_Services.Layouts.PersonRoleLayout AND NOT [seq]};

iesp.businessinstantid20.t_BIID20PersonRoleAuthorizedRep xfm_AuthRepTitles(temp_PersonRoleLayout le) := 
	TRANSFORM
		SELF.AuthorizedRep1 := le.person_role_rep1;
		SELF.AuthorizedRep2 := le.person_role_rep2;
		SELF.AuthorizedRep3 := le.person_role_rep3;
		SELF.AuthorizedRep4 := le.person_role_rep4;
		SELF.AuthorizedRep5 := le.person_role_rep5;		
	END;

iesp.businessinstantid20.t_BIID20Compliance xfm_Compliance(BusinessInstantID20_Services.Layouts.OutputLayout_intermediate le) := 
	TRANSFORM		
		SELF.GlobalWatchLists         := fn_GetWatchlists(le); 
		SELF.SICCode                  := le.BestEcho.best_sic_code; 
		SELF.SICDescription           := le.BestEcho.best_sic_desc;
		SELF.NAICSCode                := le.BestEcho.best_naics_code;
		SELF.NAICSDescription         := le.BestEcho.best_naics_desc;
		SELF.SOSFilingName            := le.Firmographic.sos_filing_name;
		SELF.TimeOnSOS                := le.Firmographic.time_on_sos;
		SELF.SOSStatus                := le.Firmographic.sos_status;
		SELF.LNStatus                 := le.Firmographic.ln_status;
		SELF.BusinessDescription      := le.Firmographic.bus_description;
		SELF.TimeOnPublicRecord       := le.Firmographic.time_on_publicrecord;
		SELF.County                   := le.Firmographic.bus_county;
		SELF.BusinessFirstSeenYYYY    := le.Firmographic.Bus_firstseen_YYYY;
		SELF.Parent                   := ROW( xfm_Parent(le.parent) );
		SELF.AuthorizedRepTitles      := ROW( xfm_AuthRepTitles(le.PersonRole) );
		SELF := [];
	END;

// 14. CompanyResults: SBFE Verification
temp_SBFEVerificationLayout := {BusinessInstantID20_Services.Layouts.SBFEVerificationLayout AND NOT [seq]};

iesp.businessinstantid20.t_BIID20SBFEVerification xfm_SBFEVerification(temp_SBFEVerificationLayout le) := 
	TRANSFORM
		SELF.TimeOnSBFE    := (STRING)le.time_on_sbfe;
		SELF.LastSeenSBFE  := (STRING)le.last_seen_sbfe; 
		SELF.SBFEOpenCount := (STRING)le.count_of_trades_sbfe; 	
	END;

// 15. CompanyResults: Risk Indicators
fn_GetRiskIndicators( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le ) :=
	FUNCTION
		RiskIndicators := 
			DATASET( 
				[
					{ le.RiskIndicators.bus_ri_1, le.RiskIndicators.bus_ri_desc_1, 1 },
					{ le.RiskIndicators.bus_ri_2, le.RiskIndicators.bus_ri_desc_2, 2 },
					{ le.RiskIndicators.bus_ri_3, le.RiskIndicators.bus_ri_desc_3, 3 },
					{ le.RiskIndicators.bus_ri_4, le.RiskIndicators.bus_ri_desc_4, 4 },
					{ le.RiskIndicators.bus_ri_5, le.RiskIndicators.bus_ri_desc_5, 5 },
					{ le.RiskIndicators.bus_ri_6, le.RiskIndicators.bus_ri_desc_6, 6 },
					{ le.RiskIndicators.bus_ri_7, le.RiskIndicators.bus_ri_desc_7, 7 },
					{ le.RiskIndicators.bus_ri_8, le.RiskIndicators.bus_ri_desc_8, 8 }
				], 
				iesp.share.t_SequencedRiskIndicator 
			);
		
		RETURN RiskIndicators(RiskCode != '');		
	END;

// 16. CompanyResults: Verification Summaries
fn_GetVerificationSummaries( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le ) :=
	FUNCTION
		layout_tempVerificationSummary := RECORD
			string20 _type;
			string3  _index; 
			string60 _desc; 
		END;
		
		VerificationSummaries_pre := 
			DATASET( 
				[
					{ 'PHONESOURCE'        , le.VerificationSummaries.ver_phone_src_index          , le.VerificationSummaries.ver_phone_desc },
					{ 'BUREAU'             , le.VerificationSummaries.ver_bureau_src_index         , le.VerificationSummaries.ver_bureau_desc },
					{ 'GOVTREGISTRATIONS'  , le.VerificationSummaries.ver_govt_reg_src_index       , le.VerificationSummaries.ver_govt_reg_desc },
					{ 'PUBLICRECORDFILINGS', le.VerificationSummaries.ver_pubrec_filing_src_index  , le.VerificationSummaries.ver_pubrec_filing_desc },
					{ 'BUSDIRECTORIES'     , le.VerificationSummaries.ver_bus_directories_src_index, le.VerificationSummaries.ver_bus_directories_desc }
				], 
				layout_tempVerificationSummary
			);
		
		VerificationSummaries := 
			PROJECT(
				VerificationSummaries_pre(_index != ''),
				TRANSFORM( iesp.businessinstantid20.t_BIID20VerificationSummary,
					SELF._Type       := LEFT._type,
					SELF.Index       := LEFT._index,
					SELF.Description := LEFT._desc,
					SELF := []
				)
			);
		
		RETURN VerificationSummaries;		
	END;

// 17. CompanyResults: Residential Business
temp_ResidentialBusLayout := {BusinessInstantID20_Services.Layouts.ResidentialBusLayout AND NOT [Seq]};

iesp.businessinstantid20.t_BIID20ResidentialBusiness xfm_ResidentialBusiness( temp_ResidentialBusLayout le ) :=
	TRANSFORM
		SELF.Indicator   := (STRING)le.residential_bus_indicator;
		SELF.Description := (STRING)le.residential_bus_desc; 	
	END;

// 15. CompanyResults: Risk Indicators
fn_GetBus2ExecIndexes( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le ) :=
	FUNCTION
		printSequenceNumber(STRING index_rep, INTEGER seq) := 
			IF( index_rep != '', (STRING1)seq, '' );

		layout_tempBusinessToAuthorizedRepLinkIndex := RECORD
			STRING1   _seq;
			STRING2   _index;
			STRING150 _desc;
		END;
			
		Bus2ExecIndexes_pre := 
			DATASET( 
				[
					{ printSequenceNumber(le.Bus2Exec.bus2exec_index_rep1, 1), le.Bus2Exec.bus2exec_index_rep1, le.Bus2Exec.bus2exec_desc_rep1 },
					{ printSequenceNumber(le.Bus2Exec.bus2exec_index_rep2, 2), le.Bus2Exec.bus2exec_index_rep2, le.Bus2Exec.bus2exec_desc_rep2 },
					{ printSequenceNumber(le.Bus2Exec.bus2exec_index_rep3, 3), le.Bus2Exec.bus2exec_index_rep3, le.Bus2Exec.bus2exec_desc_rep3 },
					{ printSequenceNumber(le.Bus2Exec.bus2exec_index_rep4, 4), le.Bus2Exec.bus2exec_index_rep4, le.Bus2Exec.bus2exec_desc_rep4 },
					{ printSequenceNumber(le.Bus2Exec.bus2exec_index_rep5, 5), le.Bus2Exec.bus2exec_index_rep5, le.Bus2Exec.bus2exec_desc_rep5 }
				], 
				layout_tempBusinessToAuthorizedRepLinkIndex
			);
		
		Bus2ExecIndexes := 
			PROJECT(
				Bus2ExecIndexes_pre(_index != ''),
				TRANSFORM( iesp.businessinstantid20.t_BIID20BusinessToAuthorizedRepLinkIndex,
					SELF.InputRepNumber := LEFT._seq,
					SELF.Index          := LEFT._index,
					SELF.Description    := LEFT._desc,
					SELF := []
				)
			);
		
		RETURN Bus2ExecIndexes;		
	END;
	
// CompanyResults
iesp.businessinstantid20.t_BIID20CompanyResults xfm_AddCompanyResults(BusinessInstantID20_Services.Layouts.OutputLayout_intermediate le) := 
	TRANSFORM
		SELF.VerifiedInput                      := ROW( xfm_VerifiedInput(le.VerifiedEcho) );
		SELF.VerificationIndicators             := ROW( xfm_VerificationIndicators(le.Verification) );
		SELF.BestInformation                    := ROW( xfm_BestInformation(le.BestEcho) );
		SELF.NamesAddressesOfPhones             := fn_GetNamesAddressesFromPhone(le); 
		SELF.PhonesOfNameAddresses              := fn_GetPhonesFromAddress(le);
		SELF.FEINMatchResults                   := fn_GetNamesAddressesFromFEIN(le);
		SELF.BusinessIDs                        := ROW( xfm_LinkIDs(le.InputEcho) );
		SELF.BusinessVerification               := ROW( xfm_BusinessVerification(le.VerificationSummaries) );
		SELF.RiskIndicators                     := fn_GetRiskIndicators(le);
		SELF.VerificationSummaries              := fn_GetVerificationSummaries(le); 
		SELF.ResidentialBusinesses              := DATASET( [ xfm_ResidentialBusiness(le.ResidentialBus) ] );
		SELF.OFACWatchLists                     := fn_GetOFAC(le);
		SELF.BusinessToAuthorizedRepLinkIndexes := fn_GetBus2ExecIndexes(le); 
		SELF.Compliance                         := ROW( xfm_Compliance(le) );
		SELF.SBFEVerification                   := ROW( xfm_SBFEVerification(le.SBFEVerification) );
		SELF := [];
	END;

// Authorized Rep results 
iesp.businessinstantid20.t_BIID20AuthorizedRepresentativeResults xfm_AddAuthRepResults(BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout le) := 
	TRANSFORM
		SELF.UniqueId := (STRING)le.did;
		
		// Input Echo
		SELF.InputEcho.Sequence                  		  := ''; // (STRING)le.seq; ***** NOTE: Remove this from layout *****
		SELF.InputEcho.Name.Full                 		  := '';
		SELF.InputEcho.Name.First                		  := le.fname;
		SELF.InputEcho.Name.Middle                		:= le.mname;
		SELF.InputEcho.Name.Last                  		:= le.lname;
		SELF.InputEcho.Name.Suffix                		:= le.suffix;
		SELF.InputEcho.Name.Prefix                		:= le.title;
		SELF.InputEcho.FormerLastName              		:= le.lname_prev;
		SELF.InputEcho.Address.StreetNumber	       		:= le.prim_range;
		SELF.InputEcho.Address.StreetPreDirection	 		:= le.predir;
		SELF.InputEcho.Address.StreetName	         		:= le.prim_name;
		SELF.InputEcho.Address.StreetSuffix	       		:= le.addr_suffix;
		SELF.InputEcho.Address.StreetPostDirection 		:= le.postdir;
		SELF.InputEcho.Address.UnitDesignation	   		:= le.unit_desig;
		SELF.InputEcho.Address.UnitNumber	         		:= le.sec_range;
		SELF.InputEcho.Address.StreetAddress1	     		:= le.in_streetAddress;
		SELF.InputEcho.Address.StreetAddress2      		:= '';
		SELF.InputEcho.Address.City	               		:= le.in_city;
		SELF.InputEcho.Address.State	             		:= le.in_state;
		SELF.InputEcho.Address.Zip5	               		:= le.in_zipCode;
		SELF.InputEcho.Address.Zip4	               		:= '';
		SELF.InputEcho.Address.County	             		:= '';
		SELF.InputEcho.Address.PostalCode	         		:= '';
		SELF.InputEcho.Address.StateCityZip        		:= '';
		SELF.InputEcho.AddressType                 		:= le.addr_type;
		SELF.InputEcho.DOB.Year	                   		:= (INTEGER)le.dob[1..4];
		SELF.InputEcho.DOB.Month	                 		:= (INTEGER)le.dob[5..6];
		SELF.InputEcho.DOB.Day                     		:= (INTEGER)le.dob[7..8];
		SELF.InputEcho.Age                         		:= le.age;
		SELF.InputEcho.SSN	                       		:= le.ssn;
		SELF.InputEcho.Phone                       		:= le.phone10;
		SELF.InputEcho.WorkPhone                   		:= le.wphone10;
		SELF.InputEcho.DriverLicenseNumber         		:= le.dl_number;	
		SELF.InputEcho.DriverLicenseState	         		:= le.dl_state;
		SELF.InputEcho.Email                       		:= le.email_address;

		// Verified Input
		SELF.VerifiedInput.Name.Full	                 := '';
		SELF.VerifiedInput.Name.First	                 := le.verfirst;
		SELF.VerifiedInput.Name.Middle	               := '';
		SELF.VerifiedInput.Name.Last	                 := le.verlast;
		SELF.VerifiedInput.Name.Suffix	               := '';
		SELF.VerifiedInput.Name.Prefix                 := '';
		SELF.VerifiedInput.Address.StreetNumber	       := le.VerPrimRange;
		SELF.VerifiedInput.Address.StreetPreDirection	 := le.VerPreDir;
		SELF.VerifiedInput.Address.StreetName	         := le.VerPrimName;
		SELF.VerifiedInput.Address.StreetSuffix	       := le.VerAddrSuffix;
		SELF.VerifiedInput.Address.StreetPostDirection := le.VerPostDir;
		SELF.VerifiedInput.Address.UnitDesignation	   := le.VerUnitDesignation;
		SELF.VerifiedInput.Address.UnitNumber          := le.VerSecRange;
		SELF.VerifiedInput.Address.StreetAddress1	     := le.veraddr;
		SELF.VerifiedInput.Address.StreetAddress2	     := '';
		SELF.VerifiedInput.Address.City	               := le.vercity;
		SELF.VerifiedInput.Address.State               := le.verstate;	
		SELF.VerifiedInput.Address.Zip5	               := le.verzip;
		SELF.VerifiedInput.Address.Zip4	               := le.verzip4;
		SELF.VerifiedInput.Address.County              := le.vercounty;	
		SELF.VerifiedInput.Address.PostalCode          := '';
		SELF.VerifiedInput.Address.StateCityZip        := '';
		SELF.VerifiedInput.SSN                         := le.verssn;
		SELF.VerifiedInput.Phone                       := le.verhphone;
		SELF.VerifiedInput.DOB.Year                    := (INTEGER)le.verdob[1..4];
		SELF.VerifiedInput.DOB.Month                   := (INTEGER)le.verdob[5..6];
		SELF.VerifiedInput.DOB.Day                     := (INTEGER)le.verdob[7..8];
		SELF.VerifiedInput.DriverLicenseNumber         := le.verDL;

		// Some scalar values.
		SELF.SSNFoundForLexID               					 := le.SSNFoundForLexID;
		SELF.DOBMatchLevel                             := le.DOBMatchLevel;
		SELF.NameAddressSSNSummary          					 := le.NAS_Summary;
		SELF.NameAddressPhoneSummary        					 := le.NAP_Summary;
		SELF.NameAddressPhoneType           					 := le.NAP_Type;
		SELF.NameAddressPhoneStatus         					 := le.NAP_Status;
		SELF.ComprehensiveVerificationIndex 					 := (INTEGER1)le.CVI;

		// Risk Indicators
				iesp.share.t_SequencedRiskIndicator xfm_RiskIndicators(risk_indicators.layouts.layout_desc_plus_seq riski_le) := 
					TRANSFORM	
						SELF.RiskCode    := riski_le.hri;
						SELF.Description := riski_le.desc;
						SELF.Sequence    := riski_le.seq;
					END;
						
		SELF.RiskIndicators := PROJECT( le.ri, xfm_RiskIndicators(LEFT) );
		
		// Followup Actions
				iesp.share.t_RiskIndicator xfm_FollowUpActions(risk_indicators.Layout_Desc fua_le) := 
					TRANSFORM	
						SELF.RiskCode    := fua_le.hri;
						SELF.Description := fua_le.desc;
					END;
			
		SELF.PotentialFollowupActions := PROJECT( le.fua, xfm_FollowUpActions(LEFT) );
		
		// Best Information
		SELF.InputCorrected.Name.Full	                  := '';
		SELF.InputCorrected.Name.First	                := '';
		SELF.InputCorrected.Name.Middle	                := '';
		SELF.InputCorrected.Name.Last	                  := le.corrected_lname;
		SELF.InputCorrected.Name.Suffix	                := '';
		SELF.InputCorrected.Name.Prefix                 := '';
		SELF.InputCorrected.Address.StreetNumber	      := le.CorrectedPrimRange;
		SELF.InputCorrected.Address.StreetPreDirection	:= le.CorrectedPreDir;
		SELF.InputCorrected.Address.StreetName	        := le.CorrectedPrimName;
		SELF.InputCorrected.Address.StreetSuffix	      := le.CorrectedAddrSuffix;
		SELF.InputCorrected.Address.StreetPostDirection := le.CorrectedPostDir;
		SELF.InputCorrected.Address.UnitDesignation	    := le.CorrectedUnitDesignation;
		SELF.InputCorrected.Address.UnitNumber          := le.CorrectedSecRange;
		SELF.InputCorrected.Address.StreetAddress1	    := le.corrected_address;
		SELF.InputCorrected.Address.StreetAddress2	    := '';
		SELF.InputCorrected.Address.City	              := '';
		SELF.InputCorrected.Address.State               := '';	
		SELF.InputCorrected.Address.Zip5	              := '';
		SELF.InputCorrected.Address.Zip4	              := '';
		SELF.InputCorrected.Address.County              := '';	
		SELF.InputCorrected.Address.PostalCode          := '';
		SELF.InputCorrected.Address.StateCityZip        := '';
		SELF.InputCorrected.SSN                         := le.corrected_ssn;
		SELF.InputCorrected.Phone                       := le.corrected_phone;
		SELF.InputCorrected.DOB.Year                    := (INTEGER)le.corrected_dob[1..4];
		SELF.InputCorrected.DOB.Month                   := (INTEGER)le.corrected_dob[5..6];
		SELF.InputCorrected.DOB.Day                     := (INTEGER)le.corrected_dob[7..8];
		
		// New Area Code
		SELF.AreaCodeSplitFlag               := IF( le.area_code_split != '', 'Y', 'N' );
		SELF.NewAreaCode.AreaCode            := le.area_code_split;
		SELF.NewAreaCode.EffectiveDate.Year  := (INTEGER)le.area_code_split_date[1..4];
		SELF.NewAreaCode.EffectiveDate.Month := (INTEGER)le.area_code_split_date[5..6];
		SELF.NewAreaCode.EffectiveDate.Day   := (INTEGER)le.area_code_split_date[7..8];

		// Reverse phone 
		SELF.ReversePhone.Name.Full										:= '';
		SELF.ReversePhone.Name.First									:= (STRING20)le.phone_fname;	
		SELF.ReversePhone.Name.Middle									:= '';
		SELF.ReversePhone.Name.Last										:= (STRING20)le.phone_lname;
		SELF.ReversePhone.Name.Suffix									:= '';
		SELF.ReversePhone.Name.Prefix 								:= '';
		SELF.ReversePhone.Address.StreetNumber			 	:= '';
		SELF.ReversePhone.Address.StreetPreDirection	:= '';
		SELF.ReversePhone.Address.StreetName	 				:= '';
		SELF.ReversePhone.Address.StreetSuffix	 			:= '';
		SELF.ReversePhone.Address.StreetPostDirection	:= '';
		SELF.ReversePhone.Address.UnitDesignation	 		:= '';
		SELF.ReversePhone.Address.UnitNumber	 				:= '';
		SELF.ReversePhone.Address.StreetAddress1	 		:= (STRING65)le.phone_address;
		SELF.ReversePhone.Address.StreetAddress2	 		:= '';
		SELF.ReversePhone.Address.City	 							:= '';
		SELF.ReversePhone.Address.State	 							:= '';
		SELF.ReversePhone.Address.Zip5 								:= '';	
		SELF.ReversePhone.Address.Zip4	 							:= '';
		SELF.ReversePhone.Address.County	 						:= '';
		SELF.ReversePhone.Address.PostalCode	 				:= '';
		SELF.ReversePhone.Address.StateCityZip 				:= '';

		// PhoneOfNameAddress 		
		SELF.PhoneOfNameAddress := (STRING10)le.name_addr_phone;
		
		// PhoneAddress                  
		SELF.PhoneAddress.StreetNumber				:= le.PhonePrimRange;	
		SELF.PhoneAddress.StreetPreDirection	:= le.PhonePreDir;
		SELF.PhoneAddress.StreetName					:= le.PhonePrimName;
		SELF.PhoneAddress.StreetSuffix				:= le.PhoneAddrSuffix;
		SELF.PhoneAddress.StreetPostDirection	:= le.PhonePostDir;
		SELF.PhoneAddress.UnitDesignation			:= le.PhoneUnitDesignation;
		SELF.PhoneAddress.UnitNumber					:= le.PhoneSecRange;
		SELF.PhoneAddress.StreetAddress1			:= le.phone_address;
		SELF.PhoneAddress.StreetAddress2			:= '';
		SELF.PhoneAddress.City								:= le.phone_city;
		SELF.PhoneAddress.State								:= le.phone_st;
		SELF.PhoneAddress.Zip5								:= le.phone_zip;
		SELF.PhoneAddress.Zip4								:= '';
		SELF.PhoneAddress.County							:= '';
		SELF.PhoneAddress.PostalCode					:= '';
		SELF.PhoneAddress.StateCityZip 				:= '';
		
		// SSN Info 
		SELF.SSNInfo.SSN                   := le.verssn;
		SELF.SSNInfo.Valid                 := le.valid_ssn;
		SELF.SSNInfo.IssuedStartDate.Year	 := (INTEGER)le.ssa_date_first[1..4];
		SELF.SSNInfo.IssuedStartDate.Month := (INTEGER)le.ssa_date_first[5..6];
		SELF.SSNInfo.IssuedStartDate.Day 	 := (INTEGER)le.ssa_date_first[7..8];
		SELF.SSNInfo.IssuedEndDate.Year		 := (INTEGER)le.ssa_date_last[1..4];
		SELF.SSNInfo.IssuedEndDate.Month 	 := (INTEGER)le.ssa_date_last[5..6];
		SELF.SSNInfo.IssuedEndDate.Day 		 := (INTEGER)le.ssa_date_last[7..8];
		SELF.SSNInfo.IssuedState 					 := (STRING2)le.ssa_state;
		SELF.SSNInfo.IssuedStateName			 := (STRING20)le.ssa_state_name;
					
		// Current Name
		SELF.CurrentName.Full    := '';
		SELF.CurrentName.First	 := le.current_fname;
		SELF.CurrentName.Middle	 := '';
		SELF.CurrentName.Last    := le.current_lname;
		SELF.CurrentName.Suffix	 := '';
		SELF.CurrentName.Prefix	 := '';
	
				// Chronology Histories
				iesp.instantid.t_ChronologyHistory xfm_ChronologyHistory(Risk_Indicators.Layout_AddressHistory chron_le) := TRANSFORM
					SELF.Address.StreetNumber					:= chron_le.primrange;
					SELF.Address.StreetPreDirection		:= chron_le.PreDir;
					SELF.Address.StreetName						:= chron_le.PrimName;
					SELF.Address.StreetSuffix					:= chron_le.AddrSuffix;
					SELF.Address.StreetPostDirection	:= chron_le.PostDir;
					SELF.Address.UnitDesignation			:= chron_le.UnitDesignation;
					SELF.Address.UnitNumber						:= chron_le.SecRange;
					SELF.Address.StreetAddress1				:= chron_le.address;
					SELF.Address.StreetAddress2				:= '';
					SELF.Address.City									:= chron_le.City;
					SELF.Address.State								:= chron_le.St;
					SELF.Address.Zip5									:= chron_le.Zip;
					SELF.Address.Zip4									:= chron_le.Zip4;
					SELF.Address.County								:= '';
					SELF.Address.PostalCode						:= '';
					SELF.Address.StateCityZip					:= '';		
					SELF.Phone 												:= chron_le.phone;
					SELF.DateFirstSeen.Year						:= (INTEGER)chron_le.dt_first_seen[1..4];
					SELF.DateFirstSeen.Month					:= (INTEGER)chron_le.dt_first_seen[5..6];
					SELF.DateFirstSeen.Day						:= (INTEGER)chron_le.dt_first_seen[7..8];
					SELF.DateLastSeen.Year						:= (INTEGER)chron_le.dt_last_seen[1..4];
					SELF.DateLastSeen.Month						:= (INTEGER)chron_le.dt_last_seen[5..6];
					SELF.DateLastSeen.Day							:= (INTEGER)chron_le.dt_last_seen[7..8];
					SELF.IsBestAddress								:= chron_le.isBestMatch;
				END;
	
		SELF.ChronologyHistories := PROJECT( le.Chronology, xfm_ChronologyHistory(LEFT) );
				
		// AKAs		
				iesp.businessinstantid20.t_BIID20ConsumerInstantIDAlternateName xfm_AlternateNames( Risk_Indicators.Layout_LastNames aka_le ) := TRANSFORM
					SELF.Name.Full					:= '';
					SELF.Name.First					:= aka_le.fname1;
					SELF.Name.Middle				:= '';
					SELF.Name.Last					:= aka_le.lname1;
					SELF.Name.Suffix				:= '';
					SELF.Name.Prefix 				:= '';
					SELF.DateLastSeen.Year	:= (INTEGER)aka_le.date_last[1..4];
					SELF.DateLastSeen.Month	:= (INTEGER)aka_le.date_last[5..6];
					SELF.DateLastSeen.Day 	:= (INTEGER)aka_le.date_last[7..8];
				END;
		
		SELF.AKAs := PROJECT( le.Additional_Lname, xfm_AlternateNames(LEFT) );

		// WatchLists
				iesp.instantid.t_WatchList xfm_SingleWatchlistRecord := TRANSFORM
					SELF.Table											 := le.Watchlist_Table;
					SELF.RecordNumber								 := le.Watchlist_Record_Number;
					SELF.Name.Full									 := '';
					SELF.Name.First									 := le.Watchlist_fname;
					SELF.Name.Middle								 := '';
					SELF.Name.Last									 := le.Watchlist_lname;
					SELF.Name.Suffix								 := '';	
					SELF.Name.Prefix								 := '';		
					SELF.Address.StreetNumber				 := le.WatchlistPrimRange;
					SELF.Address.StreetPreDirection	 := le.WatchlistPreDir;
					SELF.Address.StreetName					 := le.WatchlistPrimName;
					SELF.Address.StreetSuffix				 := le.WatchlistAddrSuffix;
					SELF.Address.StreetPostDirection := le.WatchlistPostDir;
					SELF.Address.UnitDesignation		 := le.WatchlistUnitDesignation;
					SELF.Address.UnitNumber					 := le.WatchlistSecRange;
					SELF.Address.StreetAddress1			 := le.Watchlist_address;
					SELF.Address.StreetAddress2			 := '';
					SELF.Address.City								 := le.Watchlist_city;
					SELF.Address.State							 := le.Watchlist_state;
					SELF.Address.Zip5								 := le.Watchlist_zip[1..5];
					SELF.Address.Zip4								 := le.Watchlist_zip[6..9];
					SELF.Address.County							 := '';
					SELF.Address.PostalCode					 := '';
					SELF.Address.StateCityZip				 := '';
					SELF.Country										 := le.Watchlist_contry; 
					SELF.EntityName									 := le.Watchlist_Entity_Name;
					SELF.Sequence										 := 1; 
					// SELF.Program										 := le.Watchlist_Program;
					SELF := [];
				END;
		
				SingleWatchlistRecord := DATASET( [xfm_SingleWatchlistRecord] );

		// WatchLists
				iesp.instantid.t_WatchList xfm_Watchlists( risk_indicators.layouts.layout_watchlists_plus_seq gwl_le) := TRANSFORM
					SELF.Table											 := gwl_le.Watchlist_Table;
					SELF.RecordNumber								 := gwl_le.Watchlist_Record_Number;
					SELF.Name.Full									 := '';
					SELF.Name.First									 := gwl_le.Watchlist_fname;
					SELF.Name.Middle								 := '';
					SELF.Name.Last									 := gwl_le.Watchlist_lname;
					SELF.Name.Suffix								 := '';	
					SELF.Name.Prefix								 := '';		
					SELF.Address.StreetNumber				 := gwl_le.WatchlistPrimRange;
					SELF.Address.StreetPreDirection	 := gwl_le.WatchlistPreDir;
					SELF.Address.StreetName					 := gwl_le.WatchlistPrimName;
					SELF.Address.StreetSuffix				 := gwl_le.WatchlistAddrSuffix;
					SELF.Address.StreetPostDirection := gwl_le.WatchlistPostDir;
					SELF.Address.UnitDesignation		 := gwl_le.WatchlistUnitDesignation;
					SELF.Address.UnitNumber					 := gwl_le.WatchlistSecRange;
					SELF.Address.StreetAddress1			 := gwl_le.Watchlist_address;
					SELF.Address.StreetAddress2			 := '';
					SELF.Address.City								 := gwl_le.Watchlist_city;
					SELF.Address.State							 := gwl_le.Watchlist_state;
					SELF.Address.Zip5								 := gwl_le.Watchlist_zip[1..5];
					SELF.Address.Zip4								 := gwl_le.Watchlist_zip[6..9];
					SELF.Address.County							 := '';
					SELF.Address.PostalCode					 := '';
					SELF.Address.StateCityZip				 := '';
					SELF.Country										 := gwl_le.Watchlist_contry; 
					SELF.EntityName									 := gwl_le.Watchlist_Entity_Name;
					SELF.Sequence										 := gwl_le.seq + 1; 
					// SELF.Program										 := gwl_le.Watchlist_Program;
					SELF := [];
				END;
				
				ds_WatchlistRecords := PROJECT( le.WatchLists, xfm_Watchlists(LEFT) );
		
		SELF.Watchlists := SORT( ( SingleWatchlistRecord + ds_WatchlistRecords ), Sequence );

		// Address Risk 
		SELF.AddressRisk.AddressIsPOBox := le.addressPOBox;
		SELF.AddressRisk.AddressIsCMRA  := le.addressCMRA;

		// Decedent Info
		SELF.DecedentInfo.Name.Full		  :='';
		SELF.DecedentInfo.Name.First	  := le.DeceasedFirst;
		SELF.DecedentInfo.Name.Middle	  :='';
		SELF.DecedentInfo.Name.Last		  := le.DeceasedLast;
		SELF.DecedentInfo.Name.Suffix	  :='';
		SELF.DecedentInfo.Name.Prefix	  :='';
		SELF.DecedentInfo.DOD.Year		  :=(INTEGER)le.deceasedDate[1..4];	
		SELF.DecedentInfo.DOD.Month		  :=(INTEGER)le.deceasedDate[5..6];
		SELF.DecedentInfo.DOD.Day			  :=(INTEGER)le.deceasedDate[7..8];
		SELF.DecedentInfo.DOB.Year		  :=(INTEGER)le.deceasedDOB[1..4];	
		SELF.DecedentInfo.DOB.Month		  :=(INTEGER)le.deceasedDOB[5..6];
		SELF.DecedentInfo.DOB.Day			  :=(INTEGER)le.deceasedDOB[7..8];
		
		SELF := [];
	END;

// --------------------[ Transform to IESP compliant layout ]--------------------

EXPORT iesp.businessinstantid20.t_BIID20Result xfm_ToIespLayout(BusinessInstantID20_Services.Layouts.OutputLayout_intermediate le) := 
	TRANSFORM
		// NumberValidAuthRepsInput must be at least 1, since this field is also used to indicate
		// a hit even if there are no valid Authorized Reps.
		SELF.NumberValidAuthRepsInput := IF( le.InputEcho.NumberValidAuthRepsInput = 0, 1, le.InputEcho.NumberValidAuthRepsInput );
		SELF.InputEcho                := ROW( xfm_AddInputEcho(le.InputEcho) );
		SELF.CompanyResults           := PROJECT( le, xfm_AddCompanyResults(LEFT) );
		SELF.AuthorizedRepresentativeResults := PROJECT( le.ConsumerInstantID, xfm_AddAuthRepResults(LEFT) );
		SELF := [];
	END;

