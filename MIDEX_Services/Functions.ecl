IMPORT AutoKeyI, AutoStandardI, census_data, iesp,
       lib_stringlib, liensv2_services, LN_PropertyV2_Services, 
       Midex_Services, Prof_License_Mari, SANCTN, SANCTN_Mari, 
       Suppress, ut;

EXPORT Functions := 
  MODULE
  
    EXPORT getPenalty(MIDEX_Services.Iparam.searchrecords in_mod) :=
      FUNCTION
        // Because Midex is a derogitory database, the penalty needs to be a little 
        // looser than with a typical service due to compliance regulations to NOT
        // miss a company/person that may be trying a allude being found.
        //   This funciton was created for Midex 2.0 and sets the penalty threshold based 
        // on whether or not the user entered only one or more than on search field.
        //   The penalty for a single search term has been set/defined by the customer's 
        // compliance needs. Currently US Bank and Chase.
        //   When there is more than one search field entered, the penalty is cumulative
        // and must be less than 15 to be output.
        // NOTE: Any piece (or all three pieces) of a persons name is considered 1 search field
        // The same is true for the address
        
        nameSearchedCalc := 
          AutoStandardI.InterfaceTranslator.fname_value.val(in_mod) != '' OR  
          AutoStandardI.InterfaceTranslator.mname_value.val(in_mod) != '' OR
          AutoStandardI.InterfaceTranslator.lname_value.val(in_mod) != '';

        addrSearchedCalc := 
          AutoStandardI.InterfaceTranslator.prange_value.val(in_mod)      != '' OR
          AutoStandardI.InterfaceTranslator.predir_value.val(in_mod)      != '' OR
          AutoStandardI.InterfaceTranslator.pname_value.val(in_mod)       != '' OR
          AutoStandardI.InterfaceTranslator.postdir_value.val(in_mod)     != '' OR
          AutoStandardI.InterfaceTranslator.addr_suffix_value.val(in_mod) != '' OR
          AutoStandardI.InterfaceTranslator.sec_range_value.val(in_mod)   != '' OR
          AutoStandardI.InterfaceTranslator.city_value.val(in_mod)        != '' OR
          AutoStandardI.InterfaceTranslator.state_value.val(in_mod)       != '' OR
          AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod) != '';

        // fields that are used in the penalization process (ie: phone and license state are searchable
        // input fields, but because they are eiither sparcely populated or potentially inaccurate they 
        // do not contribute to the penalty 
        addrSearched        := (UNSIGNED)addrSearchedCalc;
        compNameSearched    := IF(AutoStandardI.InterfaceTranslator.company_name_value.val(in_mod) != '',1,0);
        didSearched         := IF(in_mod.did != '',1,0);
        licSeached          := IF(TRIM(StringLib.StringToUpperCase(in_mod.license_number)) != '',1,0);
        MidexRptNbrSearched := IF(in_mod.midex_rpt_num != '',1,0);
        nameSearched        := (UNSIGNED)nameSearchedCalc;
        nmlsIdSearched      := IF(in_mod.nmls_id != '',1,0);
        ssnSearched         := IF(in_mod.ssn != '',1,0);
        ssnLast4Searched    := IF(in_mod.ssn_last4 != '',1,0);
        tinSearched         := IF(in_mod.tin != '',1,0); 
        
        NumPenalizedInputFields := addrSearched + compNameSearched + didSearched + licSeached + MidexRptNbrSearched + 
                                   nameSearched + nmlsIdSearched + ssnSearched + ssnLast4Searched + tinSearched; 

        searchPenalty := 
          IF(NumPenalizedInputFields = 1,
             MIDEX_Services.Constants.PENALTY_SINGLE_INPUT_SEARCH,
             MIDEX_Services.Constants.PENALTYTHRESHOLD);

        RETURN searchPenalty;
      END;


    // Function to check if the results had changes for the same input criteria since the last time run
    SHARED BOOLEAN IsResultsChanged(DATASET(Midex_Services.Layouts.hash_layout) dInHashes,
                                    DATASET(Midex_Services.Layouts.hash_layout) dSearchResultsHashes,
                                    UNSIGNED pAlertVersion) :=
    FUNCTION
      Midex_Services.Layouts.hash_changes tCheckResultsChanged(Midex_Services.Layouts.hash_layout le, Midex_Services.Layouts.hash_layout ri) :=
      TRANSFORM
        SELF.all_hash    := IF(le.all_hash != 0,le.all_hash,ri.all_hash);
        SELF.isInputHash := le.all_hash != 0;
      END;
      
      dResultsChanged_AllHash := JOIN(dInHashes,
                                      dSearchResultsHashes,
                                      LEFT.all_hash = RIGHT.all_hash,
                                      tCheckResultsChanged(LEFT,RIGHT),
                                      FULL ONLY);
      
      // Account for case when the hash logic had changed
      // need to compare the hash value sent by ESP with the hash value calculated before the logic change so that alerts would not be triggered
      dResultsChanged_PrevAllHash := JOIN(dInHashes,
                                          dSearchResultsHashes,
                                          LEFT.all_hash = RIGHT.prev_all_hash,
                                          tCheckResultsChanged(LEFT,RIGHT),
                                          FULL ONLY);
      
      dResultsChanged := IF(pAlertVersion = Midex_Services.Constants.AlertVersion.Current,
                            dResultsChanged_AllHash,
                            dResultsChanged_PrevAllHash);
      
      // Debug
      // t_MIDEXLicenseReportResponse(dResultsChanged,NAMED('dResultsChanged'));
      
      RETURN pAlertVersion != Midex_Services.Constants.AlertVersion.None AND EXISTS(dResultsChanged);
    END;

    EXPORT iesp.midexrecordsearch.t_AddressWithDates fn_SetAddressWithDates(STRING primname, STRING primrange, 
                                                                            STRING predir, STRING postdir, 
                                                                            STRING suffix, STRING unitdesig, 
                                                                            STRING secrange, STRING cityname, 
                                                                            STRING st, STRING zip, STRING zip4, 
                                                                            STRING countyname, STRING postalcode = '', 
                                                                            STRING addr1 = '', STRING addr2 = '', 
                                                                            STRING stcityzip = '',
                                                                            STRING DateFirstSeen = '',
                                                                            STRING DateLastSeen = ''  ) := 
      FUNCTION
        iesp.midexrecordsearch.t_AddressWithDates xfm_searchServiceAddr () := 
          TRANSFORM
            SELF.Address.StreetNumber := primrange;
            SELF.Address.StreetPreDirection := predir;
            SELF.Address.StreetName := primname;
            SELF.Address.StreetSuffix := suffix;
            SELF.Address.StreetPostDirection := postdir;
            SELF.Address.UnitDesignation := unitdesig;
            SELF.Address.UnitNumber := secrange;
            SELF.Address.City := cityname;
            SELF.Address.State := st;
            SELF.Address.Zip5 := zip;
            SELF.Address.Zip4 := zip4;
            SELF.Address.County := countyname;
            SELF.Address.PostalCode := postalcode;
            SELF.Address.StreetAddress1 := addr1;
            SELF.Address.StreetAddress2 := addr2;
            SELF.Address.StateCityZip := stcityzip,
            SELF.DateFirstSeen := iesp.ECL2ESP.toDate ( (UNSIGNED6)DateFirstSeen );
            SELF.DateLastSeen  := iesp.ECL2ESP.toDate ( (UNSIGNED6)DateLastSeen );
          END;
        
        RETURN ROW (xfm_searchServiceAddr ());
      END;

    EXPORT iesp.midex_share.t_MIDEXLicenseInfo fn_SetLicenseInfo( STRING licenseNumber = '', STRING licenseType = '', 
                                                                  STRING licenseState = '', STRING licenseStatus = '' ,
                                                                  STRING licenseExpireDate = '', BOOLEAN licenseIsCurrent) := 
      FUNCTION
        iesp.midex_share.t_MIDEXLicenseInfo xfm_LicenseInfo () := 
          TRANSFORM
            SELF._Type      := licenseType;
            SELF.Number     := licenseNumber;
            SELF.Status     := licenseStatus;
            SELF.IssueState := licenseState;
            SELF.ExpireDate := iesp.ECL2ESP.toDate((UNSIGNED4)licenseExpireDate); //Expiration Date
            SELF.IsCurrent  := licenseIsCurrent;
          END;
        
        RETURN ROW (xfm_LicenseInfo ());
      END;

    EXPORT fn_GetNonPubDataSources (STRING in_dataPermissionMask) :=
      FUNCTION
        dataPermissionTempMod := MODULE( AutoStandardI.DataPermissionI.params )
                                   EXPORT dataPermissionMask := in_dataPermissionMask;
		                             END;
        
        set_nonPubAccess  := MAP( AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_MidexFreddieMac AND 
                                  AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_MidexNonPublic      => [MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB, MIDEX_Services.Constants.DATASOURCE_CODE_FREDDIE],
                                  AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_MidexFreddieMac     => [MIDEX_Services.Constants.DATASOURCE_CODE_FREDDIE],
                                  AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_MidexNonPublic      => [MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB],
                                                    /* default */                                                     [] 
                                );
        RETURN set_nonPubAccess;
      END;			
      
	         
    EXPORT fn_dobMask ( STRING8 dob, STRING dobMask) := 
      FUNCTION
        UNSIGNED1 dobMaskUnsigned := suppress.date_mask_math.MaskIndicator(dobMask);
        dob_in_tDateFormat := iesp.ECL2ESP.toDatestring8(dob);
        masked             := IF( dob = '',
                                  dob_in_tDateFormat,
                                  iesp.ECL2ESP.ApplyDateMask(dob_in_tDateFormat, dobMaskUnsigned)
                                );
       
        RETURN masked;
      END;

   EXPORT fn_pubSanctSsnMask ( STRING11  SSNUMBER, STRING9 ssn_appended, STRING ssnMask ) :=
  
     FUNCTION
       ssnRaw     := IF( ssn_appended != '', 
										 		 ssn_appended, 
											   lib_stringlib.stringlib.StringFilterOut( SSNUMBER, '-') 
                       );
       ssnMasked  := Suppress.ssn_Mask( ssnRaw, ssnMask);
      
       ssn        := IF( (UNSIGNED) ssnMasked = 0,
                          '',
                          ssnMasked
                       );
      RETURN ssn;
     END;
     
   
   
   // Format License Search result into iesp layout.
   EXPORT iesp.midexlicensesearch.t_MIDEXLicenseSearchResponse Format_licenseSearch_iesp(DATASET(MIDEX_Services.Layouts.license_srch_layout) recs,
																																						             DATASET(MIDEX_Services.Layouts.hash_layout) Alerthashes,
                                                                                         Midex_Services.Iparam.searchrecords inMod) := FUNCTION
                      
			records := PROJECT(recs,TRANSFORM(iesp.midexlicensesearch.t_MIDEXLicenseSearchRecord,
											
                      SELF.Licensee.First := LEFT.licensee_FirstName,
											SELF.Licensee.Middle := LEFT.licensee_MidName,
											SELF.Licensee.Last := LEFT.licensee_LastName,
											SELF.CompanyName := LEFT.licensee_companyName,
											SELF.UniqueId := (STRING) LEFT.did,
											SELF.BusinessId := (STRING) LEFT.bdid,
											SELF.Address := iesp.ecl2esp.SetAddress (LEFT.prim_name, LEFT.prim_range, LEFT.predir, LEFT.postdir,
                                                               LEFT.addr_suffix, LEFT.unit_desig, LEFT.sec_range, LEFT.city,
                                                               LEFT.st, LEFT.zip5, '', LEFT.county),
											SELF.License.Number := LEFT.lic_number,
											SELF.License._Type := LEFT.lic_type,
											SELF.License.Status := LEFT.lic_status,
                      SELF.License.ExpireDate := iesp.ECL2ESP.toDate((UNSIGNED4)LEFT.lic_expir_date),
											SELF.DataSource := LEFT.data_source,
											SELF.MIDEXReportNumber := LEFT.midex_rpt_nbr,
											SELF.MariRid := (STRING) LEFT.mari_rid,
											SELF.NMLSs := PROJECT(CHOOSEN(LEFT.nmls_info,iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS),
																						TRANSFORM(iesp.midex_share.t_NMLSInfo,
																											SELF.NMLSId := IF(LEFT.nmlsId != '0',LEFT.nmlsId,''),
																											SELF.NMLSType := LEFT.nmlsType));
											SELF.phone := LEFT.phone,
											SELF.License.IssueState := LEFT.lic_state,
                      SELF.License.IsCurrent := LEFT.isCurrent,
											Self.licensee := []));
			
			iesp.midexlicensesearch.t_MIDEXLicenseSearchAlertResult xfm_alert(INTEGER numRecsRequested, INTEGER starting_record) := 
        TRANSFORM
          SELF.Hashes := PROJECT(CHOOSEN(Alerthashes,numRecsRequested, starting_record),
                              TRANSFORM(iesp.midex_share.t_AlertHash,
                                    SELF.HashValue := (STRING) LEFT.all_hash)),
          SELF.AlertVersion  := IF(inMod.EnableAlert,Midex_Services.Constants.AlertVersion.Current,Midex_Services.Constants.AlertVersion.None);
          SELF.ResultChanged := IsResultsChanged(inMod.searchHashes,CHOOSEN(Alerthashes,numRecsRequested,starting_record),inMod.alertVersion);
				END;
        
			iesp.midexlicensesearch.t_MIDEXLicenseSearchResponse format() := 
        TRANSFORM
          INTEGER return_count		 := 10	: STORED('ReturnCount');		// records per page
		      INTEGER starting_record	 := 1	  : STORED('StartingRecord');	// which record page starts with
		      INTEGER numRecsRequested := ut.Min2( return_count, iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS );
      
					SELF._Header         := iesp.ECL2ESP.GetHeaderRow();
					SELF.RecordCount     := COUNT(recs);
					SELF.Records  			 := CHOOSEN(records, numRecsRequested, starting_record);
					SELF.AlertResult 		 := IF(inMod.EnableAlert,ROW(xfm_alert(numRecsRequested, starting_record)));
			END;
			
			results := DATASET([format()]);
			RETURN results;
		END;
	  
		SHARED iesp.midex_share.t_MIDEXLicenseInfoEx Format_licenseRec_iesp(MIDEX_Services.Layouts.LicenseInfo_Layout L) := TRANSFORM
				SELF._TYPE 			    := L.lic_type;
				SELF.Number 		    := L.lic_number;
				SELF.Status 		    := L.lic_status;
				SELF.IssueState     := L.lic_state;
				SELF.IssuedDate     := iesp.ECL2ESP.toDate((integer4) L.lic_issue_date);
				SELF.OrigIssuedDate := iesp.ECL2ESP.toDate((integer4) L.orig_issue_date);
				SELF.ExpireDate     := iesp.ECL2ESP.toDate((integer4) L.lic_expir_date);
				SELF.NmlsID			    := IF(L.nmls_id != 0,(STRING) L.nmls_id,'');
				SELF.BusinessType   := L.business_type;
				SELF.Charter 			  := L.charter;
        SELF.IsCurrent      := L.isCurrent;
				SELF := [];
		END;

		SHARED iesp.midexlicensereport.t_MIDEXOfficeLocation Format_locationRec_iesp(Layouts.Location_Layout L) := TRANSFORM
				SELF.CompanyName 	:= L.company_name;
				SELF.NmlsID 			:= IF(L.comp_nmls_id != 0,(STRING) L.comp_nmls_id,'');
				SELF.Phone 				:= L.phone;
				SELF.LocationType := L.location_type;
				SELF.StartDate := iesp.ECL2ESP.toDate((integer4) L.start_date);
				SELF.Address := iesp.ecl2esp.SetAddress (L.prim_name, L.prim_range,L.predir,  L.postdir,
                                                 L.addr_suffix, L.unit_desig, L.sec_range, L.city,
                                                 L.st, L.zip5, '', L.county);
				SELF := [];
		END;
		
		SHARED iesp.midexlicensereport.t_MIDEXRepresent Format_RepresentRec_iesp(Layouts.Represent_Registration_Layout L) := TRANSFORM
				SELF.CompanyName 	:= L.company_name;
				SELF.NmlsID 			:= IF(L.comp_nmls_id != 0,(STRING) L.comp_nmls_id,'');
				SELF.StartDate := iesp.ECL2ESP.toDate((integer4) L.start_date);
				SELF.EndDate := iesp.ECL2ESP.toDate((integer4) L.end_date);
		END;
		
		SHARED iesp.midexlicensereport.t_MIDEXRegistration Format_RegistraionRec_iesp(Layouts.Represent_Registration_Layout L) := TRANSFORM
				SELF.LicenseNumber 		:= L.lic_number; 
				SELF.NmlsID 					:= IF(L.comp_nmls_id != 0,(STRING) L.comp_nmls_id,'');
				SELF.Status						:= L.reg_status;
				SELF.OrginalIssueDate := iesp.ECL2ESP.toDate((integer4) L.org_issue_date);
				SELF.StatusDate 			:= iesp.ECL2ESP.toDate((integer4) L.status_date);
				SELF.RenewedThrough		:= L.renewed_thru;
		END;
			
		SHARED iesp.midexlicensereport.t_MIDEXRegulator Format_RegulatorRec_iesp(Layouts.Regulator_Layout L) := TRANSFORM
				SELF.Regulator 					:= L.regulator_name;
				SELF.RegistrationName 	:= L.registration_name;
				SELF.Authorized					:= IF(Stringlib.StringContains(L.authorized,'YES',true),'Y',
																				IF(Stringlib.StringContains(L.authorized,'NO',true),'N','U'));
																				
				SELF.Registrations			:= PROJECT(CHOOSEN(L.Registrations,iesp.Constants.MIDEX.MAX_COUNT_REGISTRATIONS),Format_RegistraionRec_iesp(LEFT));
		END;
		
		SHARED iesp.midexlicensereport.t_MIDEXAction Format_actionRec_iesp(Layouts.Action_Layout L) := TRANSFORM
				SELF.Regulator 			:= L.regulator_name;
				SELF.AuthorityName 	:= L.authority_name;
				SELF.AuthorityType	:= L.authority_type;
				SELF.ActionDate 		:= iesp.ECL2ESP.toDate((integer4) L.action_date);
				SELF.ActionType			:= L.action_type;
				SELF.AssociatedDoc	:= L.assoc_doc;
				SELF.ActionDetail		:= L.action_detail;
		END;
		
		SHARED iesp.midexlicensereport.t_MIDEXLicenseReportRecord Format_licenseReport_iesp(MIDEX_Services.Layouts.LicenseReport_Layout L) := TRANSFORM
				SELF.DataSource := L.data_source;
				SELF.DataSourceDate := iesp.ECL2ESP.toDate ((integer4) L.last_upd_date);
				SELF.UniqueId := (STRING) L.did;
				SELF.BusinessId := (STRING) L.bdid;
				SELF.BusinessIds := L;
				SELF.phone := L.phone;
				SELF.Licensee := iesp.ecl2esp.SetName (L.FirstName, L.MiddleName, L.LastName, L.SuffixName, L.TitleName);
				SELF.CompanyName := L.companyName;
        SELF.DBAName := L.dbaname;
				SELF.NMLSDBAs.NMLSId := (STRING)L.NMLS_DBAs.NMLSId;
        SELF.NMLSDBAs.DBANames := PROJECT(L.NMLS_DBAs.DBANames, 
                                          TRANSFORM(iesp.share.t_StringArrayItem,
                                                    SELF.value := LEFT.DBAName));
				SELF.Address := iesp.ecl2esp.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                                                 L.addr_suffix, L.unit_desig, L.sec_range, L.city,
                                                 L.st, L.zip5, '', L.county);
				SELF.CompanyAddress := iesp.ecl2esp.SetAddress (L.company_prim_name, L.company_prim_range, L.company_predir, L.company_postdir,
                                                 L.company_addr_suffix, L.company_unit_desig, L.company_sec_range, L.company_city,
                                                 L.company_st, L.company_zip5, '', L.company_county);
				SELF.Licenses := PROJECT(CHOOSEN(SORT(L.Licenses,-isCurrent, -lic_issue_date),iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES),Format_licenseRec_iesp(LEFT));
				SELF.OfficeLocations := PROJECT(CHOOSEN(L.Locations,iesp.Constants.MIDEX.MAX_COUNT_OFFICE_LOCATIONS),Format_LocationRec_iesp(LEFT));
				SELF.AuthRepresents := PROJECT(CHOOSEN(L.Represents(stringlib.StringToUpperCase(authorized)='YES'),iesp.Constants.MIDEX.MAX_COUNT_REPRESENT),Format_RepresentRec_iesp(LEFT));
				SELF.PrevAuthRepresents := PROJECT(CHOOSEN(L.Represents(authorized!='YES'),iesp.Constants.MIDEX.MAX_COUNT_REPRESENT),Format_RepresentRec_iesp(LEFT));
				SELF.Regulators := PROJECT(CHOOSEN(L.Regulators,iesp.Constants.MIDEX.MAX_COUNT_REGULATORS),Format_RegulatorRec_iesp(LEFT));
				SELF.DisciplinaryActions := PROJECT(CHOOSEN(L.Disc_Actions,iesp.Constants.MIDEX.MAX_COUNT_REG_ACTIONS),Format_actionRec_iesp(LEFT));
				SELF.RegulatoryActions := PROJECT(CHOOSEN(L.Reg_Actions,iesp.Constants.MIDEX.MAX_COUNT_REG_ACTIONS),Format_actionRec_iesp(LEFT));
				SELF.MIDEXReportNo := L.report_number;
				SELF.LicenseeReportNo := L.report_number;
				SELF := [];
		END;
		
    EXPORT Layouts.LicenseReport_Layout fn_rollHashes (DATASET(Layouts.LicenseReport_Layout) l) :=
      FUNCTION
        hashesRolled :=
          ROLLUP(l, 
                 TRUE,
                 TRANSFORM( Layouts.LicenseReport_Layout,
                            SELF.name_hash := LEFT.name_hash + RIGHT.name_hash,
				                    SELF.address_hash := LEFT.address_hash + RIGHT.address_hash,
				                    SELF.license_status_hash := LEFT.license_status_hash + RIGHT.license_status_hash,
				                    SELF.nmls_Id_hash := LEFT.nmls_Id_hash + RIGHT.nmls_Id_hash,
				                    SELF.Represent_hash := LEFT.Represent_hash + RIGHT.Represent_hash,
				                    SELF.Disciplinary_hash := LEFT.Disciplinary_hash + RIGHT.Disciplinary_hash,
				                    SELF.Registration_hash := LEFT.Registration_hash + RIGHT.Registration_hash,
				                    SELF.phone_hash := LEFT.phone_hash + RIGHT.phone_hash,
				                    SELF.AKA_and_name_variation_hash	:= LEFT.AKA_and_name_variation_hash + RIGHT.AKA_and_name_variation_hash,
				                    SELF := LEFT));
        RETURN hashesRolled;  
      END;
      
		EXPORT iesp.midexlicensereport.t_MIDEXLicenseReportResponse Format_licenseReport_iespResponse(DATASET(Layouts.LicenseReport_Layout) l) :=
    FUNCTION
			results := PROJECT(l,TRANSFORM(iesp.midexlicensereport.t_MIDEXLicenseReportResponse,
															SELF._Header := iesp.ECL2ESP.GetHeaderRow(),
															SELF.RecordCount := 1,
															SELF.Records := PROJECT(CHOOSEN(l,iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_LICENSES),
																										Format_licenseReport_iesp(LEFT)),
															Macros.mac_IespHashTransfer()
                              SELF.AlertResult.AlertVersion := Midex_Services.Constants.AlertVersion.Current,
															SELF.AlertResult := []));
			RETURN results;
		END;


    EXPORT fn_setMIDEXSearchRecordDetail (MIDEX_Services.Layouts.rec_temp_layout rw_inDataset ) := 
      FUNCTION
        iesp.midexrecordsearch.t_MIDEXSearchRecordDetail xfm_Data () := 
          TRANSFORM               
            SELF.CompanyName  := rw_inDataset.companyName;
            SELF.TIN          := rw_inDataset.TIN;
            SELF.Name         := iesp.ECL2ESP.setName( rw_inDataset.firstname, rw_inDataset.middlename, rw_inDataset.lastname, rw_inDataset.suffixname, rw_inDataset.prefixname);
            SELF.SSN          := rw_inDataset.SSN;
            SELF.ReportNumber := rw_inDataset.midex_rpt_nbr;
            SELF.RecordType   := rw_inDataset.RecordType;
            SELF.Address      := fn_SetAddressWithDates( rw_inDataset.prim_name, 
                                                         rw_inDataset.prim_range, 
                                                         rw_inDataset.predir,
                                                         rw_inDataset.postdir,
                                                         rw_inDataset.addr_suffix, 
                                                         rw_inDataset.unit_desig,
                                                         rw_inDataset.sec_range,
                                                         rw_inDataset.city,
                                                         rw_inDataset.st,
                                                         rw_inDataset.zip5, 
                                                         rw_inDataset.zip4, 
                                                         rw_inDataset.county,,,,,
                                                         rw_inDataset.DateFirstSeen,
                                                         rw_inDataset.DateLastSeen ); 
            SELF.License      := fn_SetLicenseInfo( rw_inDataset.licensenumber, rw_inDataset.licensetype, rw_inDataset.licenseissuestate, '', '', rw_inDataset.isLicenseCurrent);                                          
            SELF.NMLSs        := PROJECT(CHOOSEN(DEDUP(SORT(rw_inDataset.nmlsInfo,nmlsid),nmlsid),iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS),iesp.midex_share.t_NMLSInfo);
            SELF.AKAs         := IF( rw_inDataset.companyAKA != '',
                                     rw_inDataset.akas +
                                     DATASET([{'', '', '', '', '', '', rw_inDataset.companyAKA}],iesp.share.t_NameAndCompany ),
                                     rw_inDataset.akas
                                   );
            SELF.LoadDate     := iesp.ECL2ESP.toDatestring8(rw_inDataset.LoadDate);
            SELF              := [];  
        END;
      RETURN ROW(xfm_Data ());
    END;

		// Format Midex Search result into iesp layout.
		EXPORT iesp.midexrecordsearch.t_MIDEXRecordSearchResponse Format_midexSearch_iesp(DATASET(iesp.midexrecordsearch.t_MIDEXRecordSearchRecord) recs,
																																						          DATASET(Midex_Services.Layouts.hash_layout) Alerthashes,
                                                                                      MIDEX_Services.Iparam.searchrecords inMod) := FUNCTION
			
			INTEGER return_count		 := 10	: STORED('ReturnCount');		// records per page
		  INTEGER starting_record	 := 1	  : STORED('StartingRecord');	// which record page starts with
		  INTEGER numRecsRequested := ut.Min2( return_count, iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS );
      
      iesp.midexrecordsearch.t_MIDEXRecordSearchAlertResult xfm_alert() := TRANSFORM
					SELF.Hashes := PROJECT(CHOOSEN(Alerthashes,numRecsRequested, starting_record),
																			 TRANSFORM(iesp.midex_share.t_AlertHash,
																								SELF.HashValue := (STRING) LEFT.all_hash));
					SELF.AlertVersion  := IF(inMod.EnableAlert,Midex_Services.Constants.AlertVersion.Current,Midex_Services.Constants.AlertVersion.None);
					SELF.ResultChanged := IsResultsChanged(inMod.searchHashes,CHOOSEN(Alerthashes,numRecsRequested, starting_record),inMod.alertVersion);
			END;	
			
			iesp.midexrecordsearch.t_MIDEXRecordSearchResponse format() := TRANSFORM
					SELF._Header         := iesp.ECL2ESP.GetHeaderRow();
					SELF.RecordCount     := COUNT(recs);
					SELF.Records  			 := CHOOSEN(recs,numRecsRequested, starting_record);
					SELF.AlertResult 		 := ROW(xfm_alert());
			END;
			
			results := dataset([format()]);

			RETURN results;
		END;

      // In the keys when there is a dataset of text, ie: Incident text, Data fabrication has 
      // used a blank/empty row in the keys to indicate that a paragraph separator (blank line 
      // between previous and next rows) is needed when displayingthe data. The ESP automatically 
      // strips out blank lines from the xml. Per Jiafu's suggestion, any time this type of data 
      // is gleaned from the keys, the field is checked to see if it's blank. If it is, the 
      // following text is inserted where there is a blank/empty row: &#xd;
      // Added the inText[1] check because I discovered that at times there are multiple returns 
      // in the field and that was failing to put the '$#xd;' in the t_stringArrayItem dataset.
      EXPORT fn_setStringArray ( STRING inText ) :=
        FUNCTION
          inTextTrim := StringLib.StringFilterOut(TRIM(inText, ALL),'\r');
          isBlankLine := LENGTH(inTextTrim) = 0;
          stringValue := IF(isBlankLine,
                            DATASET([{'&#xd;'}],iesp.share.t_StringArrayItem),
                            DATASET ([{inText[1..8192]}],iesp.share.t_StringArrayItem)
                          ); 
          RETURN stringValue;   
        END;
   

    EXPORT fn_formatMidexCompReport_iespResponse( DATASET(iesp.midexcompreport.t_MIDEXCompReportRecord) ds_inMidexCompResults,
                                                  MIDEX_Services.Layouts.Monitor_layout ds_hashVals,
                                                  INTEGER pAlertVersion) := 
      FUNCTION
      
        results := 
          PROJECT( ds_inMidexCompResults,
                   TRANSFORM( iesp.midexcompreport.t_MIDEXCompReportResponse,
                              SELF._Header                                        := iesp.ECL2ESP.GetHeaderRow(),
                              SELF.RecordCount                                    := IF(EXISTS(ds_inMidexCompResults.PublicRecords) OR
                                                                                        EXISTS(ds_inMidexCompResults.NonPublicRecords) OR
                                                                                        EXISTS(ds_inMidexCompResults[1].NonPublicExRecords) OR
                                                                                        EXISTS(ds_inMidexCompResults.Licenses)OR
                                                                                        ds_inMidexCompResults[1].BusinessSmartLinxRecord.BestInformation.BusinessId[1]<>'' OR
                                                                                        ds_inMidexCompResults[1].PersonSmartLinxRecord.UniqueId[1]<>'' OR
                                                                                        ds_inMidexCompResults[1].TopBusinessRecord.BestSection.BusinessIds.SeleID[1] <> '0',
                                                                                      1,0),
                              SELF.Records                                        := ds_inMidexCompResults,
                              SELF.AlertResult.RecordDeleted                      := ds_hashVals.deleted,
                              SELF.AlertResult.AlertVersion                       := pAlertVersion,
				                      SELF.AlertResult.Hashes.Name.HashValue              := (STRING) ds_hashVals.name_hash,
				                      SELF.AlertResult.Hashes.Address.HashValue           := (STRING) ds_hashVals.address_hash,
				                      SELF.AlertResult.Hashes.Phone.HashValue             := (STRING) ds_hashVals.phone_hash,
				                      SELF.AlertResult.Hashes.Incident.HashValue          := (STRING) ds_hashVals.incident_hash,
				                      SELF.AlertResult.Hashes.LicenseStatus.HashValue     := (STRING) ds_hashVals.license_status_hash,
                              SELF.AlertResult.Hashes.Bankruptcy.HashValue        := (STRING) ds_hashVals.Bankruptcy_hash,       
                              SELF.AlertResult.Hashes.Criminal.HashValue          := (STRING) ds_hashVals.Criminal_hash,                 
                              SELF.AlertResult.Hashes.LienJudgment.HashValue      := (STRING) ds_hashVals.Lien_Judgment_hash,              
                              SELF.AlertResult.Hashes.NMLSId.HashValue            := (STRING) ds_hashVals.NMLS_Id_hash,                    
                              SELF.AlertResult.Hashes.NMLSRepresents.HashValue    := (STRING) ds_hashVals.represent_hash,                  
                              SELF.AlertResult.Hashes.NMLSRegistration.HashValue  := (STRING) ds_hashVals.registration_hash,               
                              SELF.AlertResult.Hashes.NMLSDisciplinary.HashValue  := (STRING) ds_hashVals.disciplinary_hash, 
															SELF.AlertResult.Hashes.Email.HashValue							:= (STRING) ds_hashVals.email_hash,
															SELF.AlertResult.Hashes.Property.HashValue					:= (STRING) ds_hashVals.property_hash,
															SELF.AlertResult.Hashes.Relative.HashValue					:= (STRING) ds_hashVals.relative_hash,
															SELF.AlertResult.Hashes.BusinessAssociate.HashValue	:= (STRING) ds_hashVals.bus_associate_hash,
															SELF.AlertResult.Hashes.Employer.HashValue					:= (STRING) ds_hashVals.employer_hash,
															SELF.AlertResult.Hashes.NameVariation.HashValue			:= (STRING) ds_hashVals.name_variation_hash,
															SELF.AlertResult.Hashes.Executive.HashValue					:= (STRING) ds_hashVals.executive_hash,
															SELF.AlertResult.Hashes.SecretaryOfStateFiling.HashValue:= (STRING) ds_hashVals.SOS_hash,
				                      SELF.AlertResult.Changes.NMLSRepresentsChanged      := ds_hashVals.RepresentChanged,
				                      SELF.AlertResult.Changes.NMLSRegistrationChanged    := ds_hashVals.RegistrationChanged,
				                      SELF.AlertResult.Changes.NMLSDisciplinaryChanged    := ds_hashVals.DisciplinaryChanged, 
				                      SELF.AlertResult.Changes                            := ds_hashVals, // all remaining fields from recName
                              self.AlertResult                                    := [],
                            ));
        
        RETURN results;
      END;

   EXPORT iesp.midexcompreport.t_MidexCompPersonSmartlinxRecord fn_setSmartLinxPersonFormat ( MIDEX_Services.Layouts.rec_SmartLinxPersonWithSources ds_Person_in, STRING dobMask, MIDEX_Services.Iparam.smartLinxPersonIncludeOptions options ) :=
      FUNCTION 
        // The smartlinx report does not mask the dob (2/12/2014). DOB masking is needed for 
        // the Midex XML users. Per Krishna T. we are masking the smartlinx sections here in the 
        // midex code and a new project will be created to mask the DOB in each of the smarlinx 
        // sections at some point in the future.
        UNSIGNED1 dobMaskUnsigned := suppress.date_mask_math.MaskIndicator(dobMask);
                          
        bestInfoDobMask := 
          ROW( TRANSFORM( iesp.smartlinxreport.t_SLRBestInfo, 
                          SELF.DOB        := iesp.ECL2ESP.ApplyDateMask(ds_Person_in.BestInfo.DOB, dobMaskUnsigned  ),
                          SELF.Name       := ds_Person_in.BestInfo.Name;
                          SELF.Gender     := ds_Person_in.BestInfo.Gender;
                          SELF.Address    := ds_Person_in.BestInfo.Address;
                          SELF.DOD        := ds_Person_in.BestInfo.DOD;
                          SELF.Deceased   := ds_Person_in.BestInfo.Deceased;     //values['U','Y','N','']
                          SELF.AgeAtDeath := ds_Person_in.BestInfo.AgeAtDeath;
                          SELF.Age        := ds_Person_in.BestInfo.Age;
                          SELF.Attributes := ds_Person_in.BestInfo.Attributes;
                          SELF.SSN        := ds_Person_in.BestInfo.SSN;
                          SELF.AddressCDS := ds_Person_in.BestInfo.AddressCDS;
                          SELF.Phones     := ds_Person_in.BestInfo.Phones;
                          SELF.PhonesV2   := ds_Person_in.BestInfo.PhonesV2;
                        ));
                        
                        
        maskDob_EmailAddresses :=
          PROJECT( ds_Person_in.EmailAddresses,
                   TRANSFORM( iesp.emailsearch.t_EmailSearchRecord,
                              SELF.DOB := iesp.ECL2ESP.ApplyDateMask(LEFT.DOB, dobMaskUnsigned ),
                              SELF     := LEFT;
                            ));
                            
                        
        iesp.share.t_Date xfm_maskDob ( iesp.share.t_Date DOB ):= 
          TRANSFORM
            maskedDOB  := iesp.ECL2ESP.ApplyDateMask ( DOB, dobMaskUnsigned );
            SELF.Year  := maskedDOB.Year;
            SELF.Month := maskedDOB.Month;
            SELF.Day   := maskedDOB.Day;
          END;                    
        
        maskDob_AkaEntities := 
          PROJECT( ds_Person_in.AKAEntities, 
                   TRANSFORM( iesp.smartlinxreport.t_SLREntities,
                              SELF.DOBs := PROJECT( LEFT.DOBs, xfm_maskDob( LEFT )),
                              SELF      := LEFT,
                             )); 
                              
        maskDob_ImposterEntities :=
          PROJECT( ds_Person_in.ImposterEntities,
                   TRANSFORM( iesp.smartlinxreport.t_SLREntities,
                              SELF.DOBs := PROJECT(LEFT.DOBs, xfm_maskDOB( LEFT )),
                              SELF      := LEFT,
                             ));
        
        //--------------------------------------------------------------------------------------
        // start imposters child dataset
        
        iesp.bps_share.t_BpsReportDriverLicense xfm_maskDob_ImposterDL ( iesp.bps_share.t_BpsReportDriverLicense ImposterDL ) := 
          TRANSFORM
            SELF.DOB := iesp.ECL2ESP.ApplyDateMask ( ImposterDL.DOB, dobMaskUnsigned );
            SELF     := ImposterDL;
          END;
        
        iesp.driverlicense2.t_DLEmbeddedReport2Record xfm_maskDob_ImposterDL2 ( iesp.driverlicense2.t_DLEmbeddedReport2Record ImposterDL2 ):= 
          TRANSFORM
            SELF.DOB  := iesp.ECL2ESP.ApplyDateMask ( ImposterDL2.DOB, dobMaskUnsigned );
            SELF.DOB2 := iesp.ECL2ESP.ApplyDateStringMask( ImposterDL2.DOB2, dobMaskUnsigned , TRUE );
            SELF      := ImposterDL2;
          END;
        
        // imposters-> Criminal Histories -- begin  --------------------------------------
        iesp.matrix.t_MatrixCrimReportAppend xfm_maskDob_ImposterCrimHist_Appends( iesp.matrix.t_MatrixCrimReportAppend imposterCrimHisAppend ) :=
          TRANSFORM
            SELF.DOBs := PROJECT( imposterCrimHisAppend.DOBs, xfm_maskDob( LEFT )),
            SELF      := imposterCrimHisAppend,
          END; 
        
        iesp.matrix.t_MatrixCrimReportIdentity xfm_maskDob_ImposterCrimHist_Identity( iesp.matrix.t_MatrixCrimReportIdentity imposterCrimHisIdentity )  :=
          TRANSFORM
            SELF.DOB := iesp.ECL2ESP.ApplyDateMask ( imposterCrimHisIdentity.DOB, dobMaskUnsigned );
            SELF     := imposterCrimHisIdentity,
          END; 
        
        iesp.matrix.t_MatrixCrimReportRecord xfm_maskDob_ImposterCrimHist ( iesp.matrix.t_MatrixCrimReportRecord imposterCrimHis ):= 
          TRANSFORM
            SELF.Appends    := PROJECT( imposterCrimHis.Appends, xfm_maskDob_ImposterCrimHist_Appends( LEFT ));
            SELF.Identities := PROJECT( imposterCrimHis.Identities, xfm_maskDob_ImposterCrimHist_Identity( LEFT ));
            SELF            := imposterCrimHis;
          END;


        iesp.bps_share.t_BpsReportIdentity xfm_maskDob_ImposterAka( iesp.bps_share.t_BpsReportIdentity imposterIdentityAka ) :=
          TRANSFORM
            SELF.DOB               := iesp.ECL2ESP.ApplyDateMask ( imposterIdentityAka.DOB, dobMaskUnsigned ),
            SELF.DriverLicenses    := PROJECT( imposterIdentityAka.DriverLicenses,    xfm_maskDob_ImposterDL( LEFT ));
            SELF.DriverLicenses2   := PROJECT( imposterIdentityAka.DriverLicenses2,   xfm_maskDob_ImposterDL2( LEFT ));
            SELF.CriminalHistories := PROJECT( imposterIdentityAka.CriminalHistories, xfm_maskDob_ImposterCrimHist( LEFT ));
            SELF                   := imposterIdentityAka;
          END;                    
                             

        maskDob_Imposters :=
          PROJECT( ds_Person_in.Imposters,
                   TRANSFORM( iesp.bps_share.t_BpsReportImposter,
                              SELF.AKAs := PROJECT( LEFT.AKAs, xfm_maskDob_ImposterAka( LEFT )),
                            ));
	
        // End imposters child dataset
        //--------------------------------------------------------------------------------------
                
        // Report Addresses
        iesp.bpsreport.t_BpsReportIdentitySlim xfm_maskDob_ReportAddressResident ( iesp.bpsreport.t_BpsReportIdentitySlim reportAddressResident ) :=
          TRANSFORM
            SELF.DOB := iesp.ECL2ESP.ApplyDateMask ( reportAddressResident.DOB, dobMaskUnsigned );
            SELF     := reportAddressResident;
          END;
        
        iesp.smartlinxreport.t_SLRAddress xfm_maskDob_ReportAddresses( iesp.smartlinxreport.t_SLRAddress reportAddress ) :=
          TRANSFORM
            SELF.Residents := PROJECT( reportAddress.Residents, xfm_maskDob_ReportAddressResident( LEFT )); 
	          SELF           := reportAddress;
          END;
          
        maskDob_ReportAddresses :=
          PROJECT( ds_Person_in.ReportAddresses,
                   TRANSFORM( iesp.smartlinxreport.t_SLRAddresses,
                              SELF.CurrentAddresses := PROJECT( LEFT.CurrentAddresses, xfm_maskDob_ReportAddresses( LEFT )),
                              SELF.PriorAddresses   := PROJECT( LEFT.PriorAddresses,   xfm_maskDob_ReportAddresses( LEFT )),
                            )); 
                            
        // End ReportAddresses dataset
        //--------------------------------------------------------------------------------------
                
        // Associates
        iesp.bpsreport.t_BpsReportIdentitySlim xfm_maskDob_Relative_AssociateAKAs( iesp.bpsreport.t_BpsReportIdentitySlim AssociateAKA ) :=
          TRANSFORM
            SELF.DOB := iesp.ECL2ESP.ApplyDateMask ( AssociateAKA.DOB, dobMaskUnsigned );
            SELF     := AssociateAKA;
          END;

        iesp.bpsreport.t_BpsReportAddressSlim xfm_maskDob_Relative_AssociateAddresses( iesp.bpsreport.t_BpsReportAddressSlim AssociateAddress ) :=
          TRANSFORM
            SELF.Residents := PROJECT( AssociateAddress.Residents, xfm_maskDob_ReportAddressResident( LEFT )); 
            SELF           := AssociateAddress;
          END;

        maskDob_Associates := 
          PROJECT( ds_Person_in.associates,
                   TRANSFORM( iesp.smartlinxreport.t_SLRAssociate,
                              SELF.AKAs      := PROJECT( LEFT.AKAs, xfm_maskDob_Relative_AssociateAKAs(LEFT)),
                              SELF.Addresses := PROJECT( LEFT.Addresses, xfm_maskDob_Relative_AssociateAddresses(LEFT)),
                              SELF           := LEFT,
                            ));
				
				maskDob_Relatives := 
          PROJECT( ds_Person_in.relatives,
                   TRANSFORM( iesp.smartlinxreport.t_SLRRelative,
                              SELF.AKAs      := PROJECT( LEFT.AKAs, xfm_maskDob_Relative_AssociateAKAs(LEFT)),
                              SELF.Addresses := PROJECT( LEFT.Addresses, xfm_maskDob_Relative_AssociateAddresses(LEFT)),
                              SELF           := LEFT,
                            ));
														
        // End Associates dataset
        //--------------------------------------------------------------------------------------
				
        iesp.criminal.t_CrimReportParoleEx xfm_maskDob_CrimParoleSentencesEx ( iesp.criminal.t_CrimReportParoleEx CrimParoleEx ) :=
          TRANSFORM
            SELF.DOB := iesp.ECL2ESP.ApplyDateMask ( CrimParoleEx.DOB, dobMaskUnsigned ),
            SELF     := CrimParoleEx;
          END;

        maskDob_Criminals := 
          PROJECT( ds_Person_in.Criminals,
                   TRANSFORM( iesp.criminal.t_CrimReportRecord,
                              SELF.DOB               := iesp.ECL2ESP.ApplyDateMask ( LEFT.DOB, dobMaskUnsigned ),
                              SELF.ParoleSentencesEx := PROJECT( LEFT.ParoleSentencesEx, xfm_maskDob_CrimParoleSentencesEx(LEFT)),
                              SELF                   := LEFT,
                            ));

        // End Criminals dataset
        //--------------------------------------------------------------------------------------
        
        maskDob_SexOffenses := 
          PROJECT( ds_Person_in.SexualOffenses,
                   TRANSFORM( iesp.sexualoffender.t_SexOffReportRecord,
                              SELF.DOB               := iesp.ECL2ESP.ApplyDateMask ( LEFT.DOB, dobMaskUnsigned ),
                              SELF.DOB2              := iesp.ECL2ESP.ApplyDateMask ( LEFT.DOB2, dobMaskUnsigned ),
                              SELF                   := LEFT,
                            ));

        // End Sex Offenses dataset
        //--------------------------------------------------------------------------------------

        iesp.midexcompreport.t_MidexCompPersonSmartlinxRecord xfm_setSmartLinxPersonFormat () :=
          TRANSFORM
            SELF.UniqueId         					:= ds_Person_in.UniqueId;
            SELF.BestInformation  					:= bestInfoDobMask; 
            SELF.AKAEntities      					:= maskDob_AkaEntities;
            SELF.Imposters        					:= maskDob_Imposters;
            SELF.ImposterEntities 					:= maskDob_ImposterEntities;
            SELF.Properties       					:= ds_Person_in.Properties;
						SELF.NoticesOfDefault						:= if(options.IncludeNoticeOfDefault, ds_Person_in.NoticesOfDefault);
						SELF.Foreclosures								:= if(options.IncludeForeclosures, ds_Person_in.Foreclosures);
            SELF.EmailAddresses   					:= maskDob_EmailAddresses;
            SELF.Bankruptcies     					:= ds_Person_in.Bankruptcies;
            SELF.LiensJudgments   					:= ds_Person_in.LiensJudgments;
            SELF.ReportAddresses  					:= maskDob_ReportAddresses;
            SELF.Associates       					:= maskDob_Associates;
						SELF.Relatives									:= if(options.IncludeRelatives, maskDob_Relatives);
            SELF.Criminals        					:= maskDob_Criminals;
						SELF.SexualOffenses							:= if(options.IncludeSexualOffenses, maskDob_SexOffenses);
            SELF.PeopleAtWorks    					:= ds_Person_in.PeopleAtWorks;
						SELF.CorporateAffiliations			:= if(options.IncludeCorporateAffiliations, ds_Person_in.CorporateAffiliations);
						SELF.OtherAssociatedBusinesses	:= if(options.IncludePersonBusinessAssociates, ds_Person_in.OtherAssociatedBusinesses);
          END;
                             
       RETURN ROW(xfm_setSmartLinxPersonFormat ());
    END;

    EXPORT fn_SubjectReported  ( MIDEX_Services.Layouts.CompReport_TempLayout ds_midexRptNumberPayloadRecs, STRING dobMask ) := 
      FUNCTION
        iesp.midexcompreport.t_MIDEXCompSubject xfm_SubjectReported () :=
          TRANSFORM

            SELF.IndividualName  := iesp.ECL2ESP.setName( ds_midexRptNumberPayloadRecs.firstname, ds_midexRptNumberPayloadRecs.middlename, 
                                                          ds_midexRptNumberPayloadRecs.lastname, ds_midexRptNumberPayloadRecs.suffixname, 
                                                          ds_midexRptNumberPayloadRecs.prefixname);
            SELF.dob             := fn_dobMask ( ds_midexRptNumberPayloadRecs.dob, dobMask);
            SELF.CompanyAddress  := iesp.ECL2ESP.SetAddress (ds_midexRptNumberPayloadRecs.prim_name, ds_midexRptNumberPayloadRecs.prim_range, ds_midexRptNumberPayloadRecs.predir, 
                                                             ds_midexRptNumberPayloadRecs.postdir, ds_midexRptNumberPayloadRecs.addr_suffix, ds_midexRptNumberPayloadRecs.unit_desig, 
                                                             ds_midexRptNumberPayloadRecs.sec_range, ds_midexRptNumberPayloadRecs.city,ds_midexRptNumberPayloadRecs.st, 
                                                             ds_midexRptNumberPayloadRecs.zip5, ds_midexRptNumberPayloadRecs.zip4, ds_midexRptNumberPayloadRecs.county, '', '', '', '');
            SELF.PropertyAddress := iesp.ECL2ESP.SetAddress ('', '', '', '', '', '', '', ds_midexRptNumberPayloadRecs.propertyCity,ds_midexRptNumberPayloadRecs.propertyState, 
                                                             ds_midexRptNumberPayloadRecs.propertyZip, '', '', '', ds_midexRptNumberPayloadRecs.propertyAddr, '', '');
            SELF.nmlsInfo        := ROW({ds_midexRptNumberPayloadRecs.nmlsId, ds_midexRptNumberPayloadRecs.nmlsType},iesp.midex_share.t_nmlsInfo);
            SELF.Professions     :=ds_midexRptNumberPayloadRecs.Professions;
            SELF.otherIdentifyingReferences := ds_midexRptNumberPayloadRecs.otherIdentifyingRef;
            SELF                 := ds_midexRptNumberPayloadRecs;  // SSN, TIN, UniqueID, BusinessID, BusinessIds, CompanyAKS, Profession, Job Title, DataSource, licenses
				 END;
        RETURN ROW( xfm_SubjectReported() );   
      END;  // fn_SubjectReported 

     EXPORT fn_SourceInfo ( MIDEX_Services.Layouts.CompReport_TempLayout ds_midexRptNumberPayloadRecs ) := 
       FUNCTION
         iesp.midexcompreport.t_MIDEXCompSource xfm_SourceInfo  () := 
           TRANSFORM   
             SELF.SourceDocument  := ds_midexRptNumberPayloadRecs.sourceDocument;
             SELF.DataSource      := ds_midexRptNumberPayloadRecs.DataSource;
             SELF.IncidentDate    := iesp.ECL2ESP.toDatestring8 ( ds_midexRptNumberPayloadRecs.incidentDate );
             SELF.DateOfInclusion := iesp.ECL2ESP.toDatestring8 ( ds_midexRptNumberPayloadRecs.DateOfInclusion );
             SELF.Jurisdiction    := ds_midexRptNumberPayloadRecs.jurisdiction;
             SELF.CaseNumber      := ds_midexRptNumberPayloadRecs.CaseNumber;
             SELF.AdditionalInfo  := ds_midexRptNumberPayloadRecs.AdditionalInfo;      
           END;
       RETURN ROW( xfm_SourceInfo());
     END;  // fn_SourceInfo

    EXPORT MIDEX_Services.Layouts.rec_temp_layout xfm_addPopulationPenalt ( MIDEX_Services.Layouts.rec_temp_layout l, STRING searchType  ) := 
      TRANSFORM
        popPen_midexRptNbr    := IF( l.midex_rpt_nbr = '', 0, 1 );
        popPen_RecType        := IF( l.RecordType = '', 0, 1);
        popPen_fname          := IF( l.FirstName = '', 0, 1);
        popPen_mname          := IF( l.MiddleName = '', 0, 1);
        popPen_lname          := IF( l.LastName = '', 0, 1);
        popPen_sufname        := IF( l.SuffixName = '', 0, 1);
        popPen_prefname       := IF( l.PrefixName = '', 0, 1);
	      popPen_akas           := COUNT( l.AKAs );
        popPen_nmlsInfo       := COUNT( l.nmlsInfo );
        popPen_cname          := IF( l.CompanyName = '', 0, 1);
        popPen_cAka           := IF( l.CompanyAka  = '', 0, 1);
        // weight the DID if the search type is individual so put DIDed records at top of the sort
        popPen_UniqId         := MAP( l.DID != 0 AND searchType  = MIDEX_SERVICES.Constants.PERSON_REPORT => 1000, 
                                      l.DID != 0 AND searchType != MIDEX_SERVICES.Constants.PERSON_REPORT => 1, 
                                                                                                          0);
        // weight the BDID if the search type is company so put BDIDed records at top of the sort                                                                                                  0 );  
        popPen_BizId          := MAP( l.BDID != 0 AND searchType  = MIDEX_SERVICES.Constants.BUSINESS_REPORT => 1000, 
                                      l.BDID != 0 AND searchType != MIDEX_SERVICES.Constants.BUSINESS_REPORT => 1, 
                                                                                                             0);  
        popPen_ssn            := IF( (UNSIGNED)l.SSN = 0, 0, 1);
        popPen_dob            := IF( (UNSIGNED)l.DOB = 0, 0, 1);
        popPen_primRange      := IF( l.prim_range = '', 0, 1);
        popPen_perdir         := IF( l.predir = '', 0, 1);
        popPen_primName       := IF( l.prim_name = '', 0, 1);
        popPen_addrSuff       := IF( l.addr_suffix = '', 0, 1);
        popPen_postdir        := IF( l.postdir = '', 0, 1);
        popPen_unitDesig      := IF( l.unit_desig = '', 0, 1);
        popPen_secRange       := IF( l.sec_range = '', 0, 1);
        popPen_city           := IF( l.city = '', 0, 1);
        popPen_st             := IF( l.st = '', 0, 1);
        popPen_zip5           := IF( (UNSIGNED)l.Zip5 = 0, 0, 1);
        popPen_zip4           := IF( (UNSIGNED)l.Zip4 = 0, 0, 1);
        popPen_county         := IF( l.county = '', 0, 1);
        popPen_dtFstSeen      := IF( (UNSIGNED)l.DateFirstSeen = 0, 0, 1);
        popPen_dtLstSeen      := IF( (UNSIGNED)l.DateLastSeen  = 0, 0, 1);
        popPen_phone          := IF( (UNSIGNED)l.phone = 0, 0, 1);  
        popPen_tin            := IF( (UNSIGNED)l.tin = 0, 0, 1);
        popPen_licType        := IF( l.licenseType = '', 0, 1);
        popPen_licNbr         := IF( (UNSIGNED)l.licenseNumber = 0, 0, 1);   
        popPen_LicIssState    := IF( l.licenseIssueState = '', 0, 1);
        popPen_nmlsId         := IF( l.nmls_id = 0, 0, 1);
        SELF.populationPenalt := popPen_midexRptNbr + popPen_RecType + popPen_fname + popPen_mname + popPen_lname + popPen_sufname  + 
                                 popPen_prefname + popPen_akas + popPen_nmlsInfo + popPen_cname + popPen_cAka + popPen_UniqId + 
                                 popPen_BizId + popPen_ssn + popPen_dob + popPen_primRange + popPen_perdir + popPen_primName + 
                                 popPen_addrSuff + popPen_postdir + popPen_unitDesig + popPen_secRange + popPen_city + popPen_st +
                                 popPen_zip5 + popPen_zip4 + popPen_county + popPen_dtFstSeen + popPen_dtLstSeen + popPen_phone +
                                 popPen_tin + popPen_licType + popPen_licNbr + popPen_LicIssState + popPen_nmlsId;
        SELF                  := l;                                 
      END;  

    EXPORT MIDEX_Services.Layouts.rec_NMLSWithDBAsAndMariRid fn_GetAdditional_NMLS_MariRids(MIDEX_Services.IParam.reportrecords in_mod) :=
      FUNCTION
        ds_nonpubSanNMLS := 
          JOIN(in_mod.MidexReportNumbers, SANCTN_Mari.key_nmls_midex,
               KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
               (UNSIGNED)RIGHT.nmls_id != 0 AND
               IF(in_mod.searchType = MIDEX_Services.Constants.COMP_SEARCH, 
                  RIGHT.license_type = MIDEX_Services.Constants.NMLS_COMP OR
                  RIGHT.license_type = MIDEX_Services.Constants.NMLS_BR OR
                  RIGHT.license_type = MIDEX_Services.Constants.NMLS,
                  IF(in_mod.searchType = MIDEX_Services.Constants.INDIV_SEARCH, 
                     RIGHT.license_type = MIDEX_Services.Constants.NMLS_INDIV OR
                     RIGHT.license_type = MIDEX_Services.Constants.NMLS,                     
                  FALSE)),
               TRANSFORM(MIDEX_Services.Layouts.rec_NMLSIds, 
                         SELF.NMLSId := (UNSIGNED6)RIGHT.nmls_id), 
               LIMIT(MIDEX_Services.Constants.JOIN_LIMIT, SKIP));
        
        ds_pubSanNMLS := 
          JOIN(in_mod.MidexReportNumbers, SANCTN.key_nmls_midex,
               KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr) AND
               (UNSIGNED)RIGHT.nmls_id != 0 AND
               IF(in_mod.searchType = MIDEX_Services.Constants.COMP_SEARCH, 
                  RIGHT.license_type = MIDEX_Services.Constants.NMLS_COMP OR
                  RIGHT.license_type = MIDEX_Services.Constants.NMLS_BR OR
                  RIGHT.license_type = MIDEX_Services.Constants.NMLS,
                  IF(in_mod.searchType = MIDEX_Services.Constants.INDIV_SEARCH, 
                     RIGHT.license_type = MIDEX_Services.Constants.NMLS_INDIV OR
                     RIGHT.license_type = MIDEX_Services.Constants.NMLS,
                  FALSE)),   
               TRANSFORM(MIDEX_Services.Layouts.rec_NMLSIds, 
                         SELF.NMLSId := (UNSIGNED6)RIGHT.nmls_id), 
               LIMIT(MIDEX_Services.Constants.JOIN_LIMIT, SKIP));
               
        ds_profLicNMLS := 
          JOIN(in_mod.MariRidNumbers, Prof_License_Mari.key_mari_payload,
               KEYED(LEFT.mari_rid = RIGHT.mari_rid) AND
               RIGHT.nmls_id != 0 AND
							 RIGHT.result_cd_1 = Midex_Services.Constants.RECORD_STATUS.LatestRecordUpdatingSource AND
               IF(in_mod.searchType = MIDEX_Services.Constants.COMP_SEARCH, 
                  RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.COMPANY OR
                  RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.BRANCH,
                  IF(in_mod.searchType = MIDEX_Services.Constants.INDIV_SEARCH, 
                     RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.INDIVIDUAL,                     
                  FALSE)),
               TRANSFORM(MIDEX_Services.Layouts.rec_NMLSIds, 
                         SELF.NMLSId := RIGHT.nmls_id), 
               LIMIT(MIDEX_Services.Constants.JOIN_LIMIT, SKIP));
        
        ds_all_nmlsIds := 
          DEDUP(SORT(ds_nonpubSanNMLS + ds_pubSanNMLS + ds_profLicNMLS, NMLSId), NMLSId);
        
        ds_MariRids_all := 
          JOIN(ds_all_nmlsIds, Prof_License_Mari.key_nmls_id,
               KEYED((UNSIGNED)LEFT.NMLSId = RIGHT.nmls_id),
               TRANSFORM(MIDEX_Services.Layouts.rec_NMLSWithDBAsAndMariRid,
                         SELF.NMLSId   := RIGHT.NMLS_Id,
                         SELF.MariRids := DATASET([{RIGHT.mari_rid}],MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField),
                         SELF.DBANames := DATASET([{RIGHT.name_dba}],MIDEX_Services.Layouts.rec_DBAName)),
               LIMIT(MIDEX_Services.Constants.JOIN_LIMIT, SKIP));

        RETURN ds_MariRids_all;
      END;
      
     EXPORT set_nmlsLicenseType (STRING in_search_type) := FUNCTION
				 nmls_type := MAP(in_search_type = 'I' => Constants.NMLS_INDIV,
													in_search_type = 'C' => Constants.NMLS_COMP,
													'UNKNOWN');
				 RETURN nmls_type;		
		 END;

			// Function to add nmls_info to the license report
		 EXPORT MIDEX_Services.Layouts.LicenseReport_Layout add_nmls_info(DATASET(MIDEX_Services.Layouts.LicenseReport_Layout) in_recs) := FUNCTION
						// Bug 192775 - Memory exceeded error
            in_recs_deduped := DEDUP( SORT( in_recs(nmls_id != 0), nmls_id ), nmls_id );

            // get nmls records
						nmls_recs_raw := JOIN(in_recs_deduped,Prof_License_Mari.key_nmls_id,
                                  KEYED(LEFT.nmls_id = RIGHT.nmls_id) AND
                                  // Bug 192775 - Memory exceeded error
                                  RIGHT.result_cd_1 = Midex_Services.Constants.RECORD_STATUS.LatestRecordUpdatingSource,
                                  TRANSFORM(RIGHT),
                                  LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
						
            // Bug 192775 - Memory exceeded error
            nmls_recs := DEDUP( SORT( nmls_recs_raw, nmls_id ), nmls_id );
            
            //Nmls Ids sometimes have more than the one lic# attached to a mari rid.
						//Additional licenses are pulled and then appended to the mari rid license record.
						nmls_lic_recs := PROJECT(nmls_recs,TRANSFORM(MIDEX_Services.Layouts.LicenseInfo_Layout,
																				SELF.lic_number := LEFT.cln_license_nbr,
																				SELF.lic_type := LEFT.std_license_desc,
																				SELF.lic_status := LEFT.std_status_desc,
																				SELF.lic_state := LEFT.license_state,
																				SELF.lic_issue_date := LEFT.curr_issue_dte,
																				SELF.orig_issue_date := LEFT.orig_issue_dte,
																				SELF.lic_expir_date := LEFT.expire_dte,
																				SELF.nmls_id := LEFT.nmls_id,
																				SELF.business_type := LEFT.business_type,
																				SELF.charter := IF(LEFT.charter != '0',LEFT.charter,''),
																				SELF := []));
																				
					  nmls_lic_recs_dedup := DEDUP(nmls_lic_recs,ALL);	
						
						loc_recsRaw := PROJECT(nmls_recs,TRANSFORM(MIDEX_Services.Layouts.Location_Layout,
																					// If the affil_type is for a company (CO or BR) set location from affil value
																					// otherwise it is an individual and use the location type value.
																				 SELF.location_type := MAP (LEFT.affil_type_cd = 'CO' => 'MAIN',
																																		LEFT.affil_type_cd = 'BR' => 'BRANCH',
																																		LEFT.location_type);
																				 SELF.nmls_id := LEFT.nmls_id,
																				 SELF.comp_nmls_id := LEFT.foreign_nmls_id,
																				 SELF.start_date := LEFT.start_dte,
																				 SELF.predir := LEFT.bus_predir,
																				 SELF.prim_range := LEFT.bus_prim_range,
																				 SELF.prim_name := LEFT.bus_prim_name,
																				 SELF.addr_suffix := LEFT.bus_addr_suffix,
																				 SELF.postdir := LEFT.bus_postdir,
																				 SELF.unit_desig := LEFT.bus_unit_desig,
																				 SELF.sec_range := LEFT.bus_sec_range,
																				 SELF.city := LEFT.bus_v_city_name,
																				 SELF.st := LEFT.bus_state,
																				 SELF.zip5 := LEFT.bus_zip5,
																				 SELF.fips_county := LEFT.bus_county,
																				 SELF.company_name := LEFT.name_company,
																				 SELF := []));
						
						census_data.MAC_Fips2County_Keyed(loc_recsRaw,st,fips_county,county,loc_recs);
            
						loc_recs_dedup := DEDUP(loc_recs,ALL);

						rep_reg_recs := JOIN(nmls_recs,Prof_License_Mari.key_indv_detail,
															KEYED(LEFT.nmls_id = RIGHT.individual_nmls_id),
															TRANSFORM(MIDEX_Services.Layouts.Represent_Registration_Layout,
																				 SELF.nmls_id := LEFT.nmls_id,
																				 SELF.lic_number := LEFT.cln_license_nbr,
																				 SELF.org_issue_date := LEFT.orig_issue_dte,
																				 SELF.renewed_thru := LEFT.renewal_dte,
																				 SELF.status_date := LEFT.curr_issue_dte,
																				 SELF.comp_nmls_id := RIGHT.instit_nmls_id,
																				 SELF.reg_status := RIGHT.reg_status,
																				 SELF.lic_type := RIGHT.std_license_desc,
																				 SELF.regulator_name := RIGHT.regulator,
																				 SELF.registration_name := RIGHT.name_registration,
																				 SELF.authorized := RIGHT.is_authorized_conduct,
																				 SELF.company_name := RIGHT.name_company,
																				 SELF.start_date := RIGHT.cln_start_dte,
																				 SELF.end_date := RIGHT.cln_end_dte,
																				 SELF := []),
															LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPRESENT,SKIP));
						rep_recs := DEDUP(SORT(rep_reg_recs,nmls_id,company_name,start_date,end_date),nmls_id,company_name,start_date,end_date);

						// Get bus registration records from the nmls_records, with an affil type of 'CO' or 'BR'
						bus_reg_recs := PROJECT(nmls_recs(affil_type_cd = 'CO' or affil_type_cd = 'BR'),TRANSFORM(MIDEX_Services.Layouts.Represent_Registration_Layout,
																				 SELF.nmls_id := LEFT.nmls_id,
																				 SELF.lic_number := LEFT.cln_license_nbr,
																				 SELF.org_issue_date := LEFT.orig_issue_dte,
																				 SELF.renewed_thru := LEFT.renewal_dte,
																				 SELF.status_date := LEFT.curr_issue_dte,
																				 SELF.reg_status := LEFT.std_status_desc,
																				 SELF.regulator_name := LEFT.regulator,
																				 SELF.registration_name := LEFT.std_license_desc,
																				 SELF.authorized := LEFT.is_authorized_license,
																				 SELF := []));
						
						// Keep unique registrations by nmlsid,regulator, authorized, status_date, org_issue_date and status.
						reg_sorted := DEDUP(SORT(rep_reg_recs+bus_reg_recs,nmls_id,regulator_name,authorized,-status_date,-org_issue_date,reg_status)
																,nmls_id,regulator_name,authorized,status_date,org_issue_date,reg_status);
						
						reg_group := GROUP(reg_sorted,nmls_id,regulator_name,authorized);
						bus_reg_recs_dedup := DEDUP(bus_reg_recs,ALL);
						
						MIDEX_Services.Layouts.Regulator_Layout Roll_Regs(MIDEX_Services.Layouts.Represent_Registration_Layout l, dataset(MIDEX_Services.Layouts.Represent_Registration_Layout) allRows) := TRANSFORM
								SELF.Registrations := allRows;
								SELF := l;
								SELF := [];
						END;
						
						reg_recs := ROLLUP(reg_group,GROUP,Roll_Regs(LEFT,ROWS(LEFT)));
						
						discAction_recs := JOIN(nmls_recs,Prof_License_Mari.key_disciplinary,
																	KEYED(LEFT.nmls_id = RIGHT.individual_nmls_id),
																	TRANSFORM(MIDEX_Services.Layouts.Action_Layout,
																				 SELF.nmls_id := LEFT.nmls_id,
																				 SELF.regulator_name := '',
																				 SELF.authority_name := RIGHT.authority_name,
																				 SELF.authority_type := RIGHT.authority_type,
																				 SELF.action_type := RIGHT.action_type,
																				 SELF.action_date := RIGHT.cln_action_dte,
																				 SELF.assoc_doc := RIGHT.url,
																				 SELF.action_detail := RIGHT.action_detail,
																				 SELF := []),
															LIMIT(iesp.Constants.MIDEX.MAX_COUNT_DISC_ACTIONS,SKIP));
						discAction_recs_dedup := DEDUP(discAction_recs,ALL);
						
						regAction_recs := JOIN(nmls_recs,Prof_License_Mari.key_regulatory,
																	KEYED(LEFT.nmls_id = RIGHT.nmls_id),
																	TRANSFORM(MIDEX_Services.Layouts.Action_Layout,
																				 SELF.nmls_id := LEFT.nmls_id,
																				 SELF.regulator_name := RIGHT.regulator,
																				 SELF.authority_name := '',
																				 SELF.authority_type := '',
																				 SELF.action_type := RIGHT.action_type,
																				 SELF.action_date := RIGHT.cln_action_dte,
																				 SELF.assoc_doc := RIGHT.url,
																				 SELF.action_detail := '',
																				 SELF := []),
															LIMIT(iesp.Constants.MIDEX.MAX_COUNT_DISC_ACTIONS,SKIP));
						regAction_recs_dedup := DEDUP(regAction_recs,ALL);
						
						//Begin attaching nmls info
						MIDEX_Services.Layouts.LicenseReport_Layout Denorm_Lic(MIDEX_Services.Layouts.LicenseReport_Layout l, dataset(MIDEX_Services.Layouts.LicenseInfo_Layout) allRows) := TRANSFORM
								// Dedup but exculde nmls_id since the mari_rid license record won't have an nmlsid
								lic_recs := DEDUP(l.Licenses + allRows,ALL,EXCEPT nmls_id);
								SELF.Licenses := CHOOSEN(lic_recs,iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES); 
								SELF := l;
						END;
						nmls_lic := DENORMALIZE(in_recs,nmls_lic_recs_dedup,LEFT.nmls_id = RIGHT.nmls_id,
																			GROUP,Denorm_Lic(LEFT,ROWS(RIGHT)));
																			
						// Attach location recs
						MIDEX_Services.Layouts.LicenseReport_Layout Denorm_Loc(MIDEX_Services.Layouts.LicenseReport_Layout l, dataset(MIDEX_Services.Layouts.Location_Layout) allRows) := TRANSFORM
								SELF.Locations := CHOOSEN(allRows,iesp.Constants.MIDEX.MAX_COUNT_OFFICE_LOCATIONS);
								SELF := l;
						END;
						nmls_loc := DENORMALIZE(nmls_lic,loc_recs_dedup,LEFT.nmls_id = RIGHT.nmls_id,
																			GROUP,Denorm_Loc(LEFT,ROWS(RIGHT)));
						
						// Attach represent recs
						MIDEX_Services.Layouts.LicenseReport_Layout Denorm_Rep(MIDEX_Services.Layouts.LicenseReport_Layout l, dataset(MIDEX_Services.Layouts.Represent_Registration_Layout) allRows) := TRANSFORM
								SELF.Represents := CHOOSEN(allRows, iesp.Constants.MIDEX.MAX_COUNT_REPRESENT);
								SELF := l;
						END;
						nmls_loc_rep := DENORMALIZE(nmls_loc,rep_recs,LEFT.nmls_id = RIGHT.nmls_id,
																			GROUP,Denorm_Rep(LEFT,ROWS(RIGHT)));
						
						// Attach regulator recs
						MIDEX_Services.Layouts.LicenseReport_Layout Denorm_Reg(MIDEX_Services.Layouts.LicenseReport_Layout l, dataset(MIDEX_Services.Layouts.Regulator_Layout) allRows) := TRANSFORM
								SELF.Regulators := CHOOSEN(allRows,iesp.Constants.MIDEX.MAX_COUNT_REGULATORS);
								SELF := l;
						END;
						nmls_loc_rep_reg := DENORMALIZE(nmls_loc_rep,reg_recs,LEFT.nmls_id = RIGHT.nmls_id,
																			GROUP,Denorm_Reg(LEFT,ROWS(RIGHT)));
						
						// Attach disc action recs
						MIDEX_Services.Layouts.LicenseReport_Layout Denorm_DisAction(MIDEX_Services.Layouts.LicenseReport_Layout l, dataset(MIDEX_Services.Layouts.Action_Layout) allRows) := TRANSFORM
								SELF.Disc_Actions := CHOOSEN(allRows,iesp.Constants.MIDEX.MAX_COUNT_DISC_ACTIONS);
								SELF := l;
						END;
						nmls_loc_rep_reg_dis := DENORMALIZE(nmls_loc_rep_reg,discAction_recs_dedup,LEFT.nmls_id = RIGHT.nmls_id,
																			GROUP,Denorm_DisAction(LEFT,ROWS(RIGHT)));
            
						// Attach reg action recs 
						MIDEX_Services.Layouts.LicenseReport_Layout Denorm_RegAction(MIDEX_Services.Layouts.LicenseReport_Layout l, dataset(MIDEX_Services.Layouts.Action_Layout) allRows) := TRANSFORM
								SELF.Reg_Actions := CHOOSEN(allRows,iesp.Constants.MIDEX.MAX_COUNT_REG_ACTIONS);
								SELF := l;
						END;
						nmls_final := DENORMALIZE(nmls_loc_rep_reg_dis,regAction_recs_dedup,LEFT.nmls_id = RIGHT.nmls_id,
																			GROUP,Denorm_RegAction(LEFT,ROWS(RIGHT)));

					RETURN nmls_final;
				END;

  EXPORT fn_setMatchedParty ( LiensV2_Services.assorted_layouts.matched_party_rec ds_inMatchedParty ) :=
    FUNCTION
      ds_out_tMatchedParty :=
        PROJECT( ds_inMatchedParty, 
                 TRANSFORM(iesp.share.t_MatchedParty,
                           SELF.PartyType    := LEFT.party_type,
                           SELF.OriginName   := '',
                           SELF.ParsedParty  := [],
                           SELF.ParsedParty2 := iesp.ECL2ESP.SetNameAndCompany (LEFT.parsed_party.fname, LEFT.parsed_party.mname, LEFT.parsed_party.lname, 
                                                                                LEFT.parsed_party.name_suffix, LEFT.parsed_party.title, '', LEFT.parsed_party.cname),
                           SELF.Address      := iesp.ECL2ESP.SetAddress (LEFT.address.prim_name, LEFT.address.prim_range, LEFT.address.predir, 
                                                                         LEFT.address.postdir, LEFT.address.addr_suffix, LEFT.address.unit_desig, 
                                                                         LEFT.address.sec_range, LEFT.address.v_city_name,LEFT.address.st, 
                                                                         LEFT.address.zip, LEFT.address.zip4, '', '', LEFT.address.orig_address1, 
                                                                         LEFT.address.orig_address2, ''),
                         ));
      RETURN ds_out_tMatchedParty;
    
    END;
    
    EXPORT fn_setBusinessIds ( UNSIGNED6 dotId_in, UNSIGNED6 empId_in,
                                                              UNSIGNED6 powId_in, UNSIGNED6 proxId_in, 
                                                              UNSIGNED6 seleId_in, UNSIGNED6 orgId_in, 
                                                              UNSIGNED6 ultId_in ) :=
      FUNCTION
        iesp.share.t_BusinessIdentity xfm_setBusinessIds () :=
          TRANSFORM
            SELF.DotID  := dotId_in;
            SELF.EmpID  := empId_in;
            SELF.POWID  := powId_in;
            SELF.ProxID := proxId_in;
            SELF.SeleID := seleId_in;
            SELF.OrgID  := orgId_in;
            SELF.UltID  := ultId_in;
          END;
        RETURN ROW(xfm_setBusinessIds());
      END;
      
      
    EXPORT fn_setParsedParty ( DATASET(liensv2_services.layout_lien_party_parsed) rec_parsedPartyIn, UNSIGNED maxParsedParties ) := 
      FUNCTION
        ds_parsedParty := 
          PROJECT( rec_parsedPartyIn, 
                   TRANSFORM( iesp.lienjudgement.t_LienJudgmentParty,
                              SELF.HasCriminalConviction := LEFT.hascriminalconviction,
                              SELF.IsSexualOffender      := LEFT.issexualoffender,
	                            SELF.BusinessIds           := fn_setBusinessIds(LEFT.DotID, LEFT.EmpID, LEFT.POWID, LEFT.ProxID, LEFT.SeleID, LEFT.OrgID, LEFT.UltID);
	                            SELF.IdValue               := '',
	                            SELF.Name                  := iesp.ECL2ESP.setName(LEFT.fname, LEFT.mname, LEFT.lname, LEFT.name_suffix, LEFT.title, '');
	                            SELF.CompanyName           := LEFT.cname,
	                            SELF.UniqueId              := (STRING12)LEFT.did,
	                            SELF.BusinessId            := (STRING12)LEFT.bdid,
	                            SELF.SSN                   := LEFT.ssn,
	                            SELF.FEIN                  := '',
	                            SELF.PersonFilterId        := LEFT.person_filter_id,
	                            SELF.TaxId                 := LEFT.tax_id,
                            ));
      RETURN CHOOSEN(ds_parsedParty,maxParsedParties);
    END;
    
    EXPORT fn_setPhoneTimeZone (DATASET(liensv2_services.layout_lien_party_phone) ds_lienJudgPhonesIn, UNSIGNED maxPhones) := 
      FUNCTION
        ds_out_phones :=
          PROJECT( ds_lienJudgPhonesIn, 
                   TRANSFORM( iesp.share.t_PhoneTimeZone,
                              SELF.Phone10  := LEFT.phone,
                              SELF.TimeZone := '',
                            ));
        RETURN CHOOSEN(ds_out_phones,maxPhones);
      END;
                        
     
    
  EXPORT fn_setLienJudgDebtor ( DATASET(LiensV2_Services.layout_lien_party) ds_lienJudgIn, UNSIGNED maxDebtors ) :=
    FUNCTION
      ds_out_LienJudgDebtor := 
        PROJECT( ds_lienJudgIn, 
                 TRANSFORM( iesp.lienjudgement.t_LienJudgmentDebtor,
                            SELF.OriginName    := LEFT.orig_name,
	                          SELF.Addresses     := MIDEX_Services.Macros.fnMac_setAddrs(LEFT.addresses, iesp.Constants.Liens.MAX_ADDRESSES),
	                          SELF.ParsedParties := fn_setParsedParty(LEFT.parsed_parties, iesp.Constants.Liens.MAX_PARTIES),
	                          SELF.Phones        := fn_setPhoneTimeZone(LEFT.addresses[1].phones, 1),
                            SELF               := [],
                          ));
      RETURN CHOOSEN(ds_out_LienJudgDebtor,maxDebtors);
    END; // fn_setLienJudgDebtor


    EXPORT fn_setLienJudgThirdParty ( DATASET(LiensV2_Services.layout_lien_party) ds_lienJudgIn, UNSIGNED maxThirdParties = 1) := 
      FUNCTION
        ds_out_LienJudgThirdParty :=
          PROJECT( ds_lienJudgIn, 
                   TRANSFORM( iesp.lienjudgement.t_LienJudgmentThirdParty, 
                              SELF.OriginName    := LEFT.orig_name,
                              SELF.ParsedParties := fn_setParsedParty( LEFT.parsed_parties, iesp.Constants.Liens.MAX_PARTIES ),
	                            SELF.Addresses     := MIDEX_Services.Macros.fnMac_setAddrs(LEFT.addresses, iesp.Constants.Liens.MAX_ADDRESSES),
	                            SELF.Phones        := fn_setPhoneTimeZone(LEFT.addresses.phones, 1),
                              SELF               := [],
                          ));

      
      RETURN CHOOSEN(ds_out_LienJudgThirdParty,maxThirdParties);
    END; // ds_out_LienJudgThirdParty

    EXPORT fn_setLienJudgCreditors ( DATASET(LiensV2_Services.layout_lien_party) ds_lienJudgIn, Unsigned maxCreditors ) := 
      FUNCTION
        ds_out_LienJudgCreditor :=
          PROJECT( ds_lienJudgIn,
                   TRANSFORM( iesp.lienjudgement.t_LienJudgmentCreditor, 
	                            SELF.ParsedParties := fn_setParsedParty(LEFT.parsed_parties, iesp.Constants.Liens.MAX_PARTIES),
	                            SELF.Addresses     := MIDEX_Services.Macros.fnMac_setAddrs(LEFT.addresses, iesp.Constants.Liens.MAX_ADDRESSES),
	                            SELF.Phones        := fn_setPhoneTimeZone(LEFT.addresses.phones, 1),
                             SELF                := [],
                          ));

      
      RETURN CHOOSEN(ds_out_LienJudgCreditor,maxCreditors);
    END; // fn_setLienJudgCreditors

    EXPORT fn_setLienJudgAttorneys (DATASET(LiensV2_Services.layout_lien_party) ds_lienJudgIn, Unsigned maxAttorneys ) := 
      FUNCTION
        ds_out_LienJudgAttorneys :=
          PROJECT( ds_lienJudgIn,
                   TRANSFORM( iesp.lienjudgement.t_LienJudgmentDebtorAttorney,
                              SELF.ParsedParties := fn_setParsedParty(LEFT.parsed_parties, iesp.Constants.Liens.MAX_PARTIES),
	                            SELF.Addresses     := MIDEX_Services.Macros.fnMac_setAddrs(LEFT.addresses, 1),
	                            SELF.Phones        := fn_setPhoneTimeZone(LEFT.addresses.phones, 1),
                              SELF               := [],
                          ));

      
      RETURN CHOOSEN(ds_out_LienJudgAttorneys,maxAttorneys);
    END; // fn_setLienJudgAttorneys

    EXPORT  fn_setLienJudgFilings ( DATASET(liensv2_services.layout_lien_history) ds_lienJudgIn, Unsigned maxFilings ) := 
      FUNCTION
        ds_out_LienJudgfilings :=
          PROJECT( ds_lienJudgIn,
                   TRANSFORM( iesp.lienjudgement.t_LienJudgmentFiling,
	                            SELF.Number            := LEFT.filing_number,
	                            SELF._Type             := LEFT.filing_type_desc,
                              SELF.Date              := iesp.ECL2ESP.toDatestring8(LEFT.filing_date),
                              SELF.OriginFilingDate  := iesp.ECL2ESP.toDatestring8(LEFT.orig_filing_date),
                              SELF.Book              := LEFT.filing_book,
                              SELF.Page              := LEFT.filing_page,
                              SELF.Agency            := LEFT.agency,
                              SELF.AgencyCity        := LEFT.agency_city,
                              SELF.AgencyState       := LEFT.agency_state,
                              SELF.AgencyCounty      := LEFT.agency_county,
                              SELF.FilingStatus      := [],
                              SELF.FilingDescription := LEFT.filing_type_desc,
                              SELF.FilingTime        := LEFT.filing_time,
                           ));
        RETURN CHOOSEN(ds_out_LienJudgfilings,maxFilings);
      END; // fn_setLienJudgFilings
    
    EXPORT fn_setContactCompanyTitles ( DATASET( MIDEX_Services.Layouts.company_title_rec)ds_contactCompTitles_In, UNSIGNED maxCompTitles ) :=
      FUNCTION
        ds_out_ContactCompanyTitles :=
          PROJECT( ds_contactCompTitles_In, 
                   TRANSFORM( iesp.share.t_StringArrayItem, 
                              SELF.value := LEFT.company_title,
                            ));

        ds_out_contactCompanyTitles_sorted := DEDUP( SORT( ds_out_contactCompanyTitles, value), value);
        
        RETURN CHOOSEN(ds_out_contactCompanyTitles_sorted,maxCompTitles);
      END; // fn_setContacCompanyTitles
    

      EXPORT iesp.bankruptcy.t_Bankruptcy2Meeting fn_SetMeetingInfo ( STRING inMeetingDate, STRING inMeetingTime, STRING inAddr ) := 
      FUNCTION
        
         iesp.bankruptcy.t_Bankruptcy2Meeting xfm_SetMeetingInfo () :=
           TRANSFORM
        	   SELF.Date    := iesp.ECL2ESP.toDatestring8(inMeetingDate);
             SELF.Time    := inMeetingTime;
	           SELF.Address := inAddr;
           END;
        RETURN ROW(xfm_setMeetingInfo());
      END;
 
 

    EXPORT iesp.property.t_PropertyAssessment fn_setPropertyAssessment (LN_PropertyV2_Services.layouts.assess.result.wider rw_dsPropertyAssessments_in) :=
      FUNCTION
        // the assignments that start with [1.. are not datasets, they are defined as variable length string
        // with a maxlength. 
        iesp.property.t_PropertyAssessment xfm_setPropertyAssessment () := 
          TRANSFORM
            SELF.StateCode               := rw_dsPropertyAssessments_in.state_code;
            SELF.County                  := rw_dsPropertyAssessments_in.county_name;
            SELF.ParcelId                := rw_dsPropertyAssessments_in.apna_or_pin_number;
            SELF.FipsCode                := rw_dsPropertyAssessments_in.fips_code;
            SELF.DuplicateApnMultipleAddressId := rw_dsPropertyAssessments_in.duplicate_apn_multiple_address_id;
            SELF.AssesseeOwnershipRights := rw_dsPropertyAssessments_in.assessee_ownership_rights_desc[1..47];   
            SELF.AssesseeRelationship    := rw_dsPropertyAssessments_in.assessee_relationship_desc[1..47];
            SELF.OwnerOccupied           := rw_dsPropertyAssessments_in.owner_occupied;
            SELF.RecordingDate           := iesp.ECL2ESP.ToDateString8(rw_dsPropertyAssessments_in.recording_date);
            SELF.PriorRecordingDate      := iesp.ECL2ESP.ToDateString8(rw_dsPropertyAssessments_in.prior_recording_date);
	          SELF.LandUseCode             := rw_dsPropertyAssessments_in.standardized_land_use_code;
            SELF.LandUse                 := rw_dsPropertyAssessments_in.standardized_land_use_desc[1..76];
            SELF.RecorderBookNumber      := rw_dsPropertyAssessments_in.recorder_book_number;
            SELF.RecorderPageNumber      := rw_dsPropertyAssessments_in.recorder_page_number;
            SELF.LegalLotNumber          := rw_dsPropertyAssessments_in.legal_lot_number;
            SELF.LegalSubdivision        := rw_dsPropertyAssessments_in.legal_subdivision_name[1..40];
            SELF.LegalBriefDescription   := rw_dsPropertyAssessments_in.legal_brief_description[1..250];
            SELF.SaleDate                := iesp.ECL2ESP.ToDateString8(rw_dsPropertyAssessments_in.sale_date);
	          SELF.SalesPrice              := rw_dsPropertyAssessments_in.sales_price;
	          SELF.MortgageLoanAmount      := rw_dsPropertyAssessments_in.mortgage_loan_amount;
	          SELF.MortgageLoanType        := rw_dsPropertyAssessments_in.mortgage_loan_type_desc[1..31];
	          SELF.MortgageLender          := rw_dsPropertyAssessments_in.mortgage_lender_name[1..60];
	          SELF.AssessedTotalValue      := rw_dsPropertyAssessments_in.assessed_total_value;
	          SELF.HomesteadHomeownerExemption := rw_dsPropertyAssessments_in.homestead_homeowner_exemption;
	          SELF.AssessedImprovementValue    := rw_dsPropertyAssessments_in.assessed_improvement_value;
	          SELF.MarketLandValue          := rw_dsPropertyAssessments_in.market_land_value;
	          SELF.MarketImprovementValue   := rw_dsPropertyAssessments_in.market_improvement_value;
	          SELF.MarketTotalValue         := rw_dsPropertyAssessments_in.market_total_value;
	          SELF.MarketValueYear          := rw_dsPropertyAssessments_in.market_value_year;
	          SELF.AssessedValueYear        := rw_dsPropertyAssessments_in.assessed_value_year;
	          SELF.TaxYear                  := rw_dsPropertyAssessments_in.tax_year;
	          SELF.TaxAmount                := rw_dsPropertyAssessments_in.tax_amount;
	          SELF.LandSquareFootage        := rw_dsPropertyAssessments_in.land_square_footage;
	          SELF.YearBuilt                := rw_dsPropertyAssessments_in.year_built;
	          SELF.NoOfStories              := rw_dsPropertyAssessments_in.no_of_stories;
	          SELF.NoOfStoriesDesc          := rw_dsPropertyAssessments_in.no_of_stories_desc;
	          SELF.NoOfBedrooms             := rw_dsPropertyAssessments_in.no_of_bedrooms;
	          SELF.NoOfBaths                := rw_dsPropertyAssessments_in.no_of_baths;
	          SELF.NoOfPartialBaths         := rw_dsPropertyAssessments_in.no_of_partial_baths;
	          SELF.GarageType               := rw_dsPropertyAssessments_in.garage_type_desc;
	          SELF.Pool                     := rw_dsPropertyAssessments_in.pool_desc;
	          SELF.ExteriorWalls            := rw_dsPropertyAssessments_in.exterior_walls_desc;
	          SELF.RoofType                 := rw_dsPropertyAssessments_in.roof_type_desc;
	          SELF.Heating                  := rw_dsPropertyAssessments_in.heating_desc;
	          SELF.HeatingFuelTypeDesc      := rw_dsPropertyAssessments_in.heating_fuel_type_desc;
	          SELF.AirConditioning          := rw_dsPropertyAssessments_in.air_conditioning_desc;
	          SELF.AirConditioningType      := rw_dsPropertyAssessments_in.air_conditioning_type_desc;
	          SELF.HeatingFuelTypeCode      := rw_dsPropertyAssessments_in.heating_fuel_type_code;
	          SELF                          := []; 
          END;  //xfm_setPropertyAssessment
        RETURN ROW(xfm_setPropertyAssessment ());
      END;   //fn_setPropertyAssessment
      
    EXPORT iesp.property.t_PropertyDeed fn_setPropertyDeed ( LN_PropertyV2_Services.layouts.deeds.result.wider2 rw_dsPropertyDeeds_in ) :=
      FUNCTION
        // the assignments that start with [1.. are not datasets, they are defined as variable length string
        // with a maxlength.
        iesp.property.t_PropertyDeed xfm_setPropertyDeeds () :=
          TRANSFORM
            SELF.County                    := rw_dsPropertyDeeds_in.county_name;
            SELF.ParcelId                  := rw_dsPropertyDeeds_in.apnt_or_pin_number[1..45];
            SELF.DeedType                  := rw_dsPropertyDeeds_in.document_type_code;
            SELF.DeedTypeDesc              := rw_dsPropertyDeeds_in.document_type_desc[1..70];
            SELF.DocumentNumber            := rw_dsPropertyDeeds_in.document_number;
            SELF.RecorderBookNumber        := rw_dsPropertyDeeds_in.recorder_book_number;
            SELF.RecorderPageNumber        := rw_dsPropertyDeeds_in.recorder_page_number;
            SELF.LandLotSize               := rw_dsPropertyDeeds_in.land_lot_size;
            SELF.LegalBriefDescription     := rw_dsPropertyDeeds_in.legal_brief_description[1..100];
            SELF.SalesPrice                := rw_dsPropertyDeeds_in.sales_price;
            SELF.CityTransferTax           := rw_dsPropertyDeeds_in.city_transfer_tax;
            SELF.CountyTransferTax         := rw_dsPropertyDeeds_in.county_transfer_tax;
            SELF.TotalTransferTax          := rw_dsPropertyDeeds_in.total_transfer_tax;
            SELF.PropertyUseCode           := rw_dsPropertyDeeds_in.property_use_code;
            SELF.PropertyUseDesc           := rw_dsPropertyDeeds_in.property_use_desc[1..41];
            SELF.FirstTdLoanAmount         := rw_dsPropertyDeeds_in.first_td_loan_amount;
            SELF.FirstTdLoanType           := rw_dsPropertyDeeds_in.first_td_loan_type_desc[1..39];
            SELF.TypeFinancing             := rw_dsPropertyDeeds_in.type_financing;
            SELF.TypeFinancingDesc         := rw_dsPropertyDeeds_in.type_financing_desc;
            SELF.FirstTdDueDate            := iesp.ECL2ESP.ToDateString8(rw_dsPropertyDeeds_in.first_td_due_date);
            SELF.TitleCompany              := rw_dsPropertyDeeds_in.title_company_name[1..60];
            SELF.FaresTransactionType      := rw_dsPropertyDeeds_in.fares_transaction_type;
            SELF.FaresTransactionTypeDesc  := rw_dsPropertyDeeds_in.fares_transaction_type_desc[1..33];
            SELF.FaresMortgageDeedType     := rw_dsPropertyDeeds_in.fares_mortgage_deed_type;
            SELF.FaresMortgageDeedTypeDesc := rw_dsPropertyDeeds_in.fares_mortgage_deed_type_desc[1..69];
            SELF.FaresMortgageTermCode     := rw_dsPropertyDeeds_in.fares_mortgage_term_code;
            SELF.FaresMortgageTermCodeDesc := rw_dsPropertyDeeds_in.fares_mortgage_term_code_desc;
            SELF.FaresMortgageTerm         := rw_dsPropertyDeeds_in.fares_mortgage_term;
            SELF.FaresIrisApn              := rw_dsPropertyDeeds_in.fares_iris_apn[1..60];
            SELF                           := [];
          END;
        RETURN ROW(xfm_setPropertyDeeds());
      END;
    
    EXPORT fn_setPropertyNames (DATASET(LN_PropertyV2_Services.layouts.parties.entity) ds_propertyEntity_in, UNSIGNED maxPropertyEntities ) :=
      FUNCTION
        ds_out_propertyEntities :=
          PROJECT( ds_propertyEntity_in, 
                   TRANSFORM( iesp.property.t_Property2Name, 
                              SELF.First       := LEFT.fname,
                              SELF.Middle      := LEFT.mname,
                              SELF.Last        := LEFT.lname,
                              SELF.Suffix      := LEFT.name_suffix,
                              SELF.Prefix      := LEFT.title,
                              SELF.CompanyName := LEFT.cname,
                              SELF.BusinessIds := fn_setBusinessIds ( LEFT.dotId, LEFT.empId,
                                                                      LEFT.powId, LEFT.proxId, 
                                                                      LEFT.seleId, LEFT.orgId, 
                                                                      LEFT.ultId ),
                              SELF.UniqueId    := (STRING12)LEFT.did,
                              SELF.BusinessId  := (STRING12)LEFT.bdid,
                              SELF.AppendedSSN := LEFT.app_ssn,
                              SELF             := [],
                            ));
        RETURN CHOOSEN(ds_out_propertyEntities,maxPropertyEntities);
      END;
      
      
    EXPORT fn_setPropertyOriginalNames2 ( DATASET( LN_PropertyV2_Services.layouts.parties.orig) ds_propertyOrigNames_in, UNSIGNED maxOrigNames ) :=
      FUNCTION
        ds_out_propertyOrigNames2 :=
          PROJECT( ds_propertyOrigNames_in, 
                   TRANSFORM( iesp.property.t_OriginalName, 
                              SELF.NameSeq       := (STRING)LEFT.name_seq,
                              SELF.Name          := LEFT.orig_name[1..120],
                              SELF.IdDescription := LEFT.id_desc[1..54],
                            ));
        RETURN CHOOSEN(ds_out_propertyOrigNames2,maxOrigNames);
      END; //fn_setPropertyOriginalNames
      
      
    EXPORT fn_setPropertyEntities ( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) ds_propertyPParties_in, UNSIGNED maxPropertyEntities) :=
      FUNCTION
        ds_out_propertyEntities :=
          PROJECT( ds_propertyPParties_in, 
                   TRANSFORM( iesp.property.t_Property2Entity,
                              SELF.Names    := fn_setPropertyNames( LEFT.entity, iesp.Constants.Prop.MaxNames),
                              SELF.Address  := iesp.ECL2ESP.SetAddress( LEFT.prim_name, LEFT.prim_range, LEFT.predir, 
                                                                        LEFT.postdir, LEFT.suffix, LEFT.unit_desig, 
                                                                        LEFT.sec_range, LEFT.v_city_name,LEFT.st, 
                                                                        LEFT.zip, LEFT.zip4, ''),
	                            SELF.Phone           := iesp.ECL2ESP.setPhoneInfo( LEFT.phone_number ),
	                            SELF.EntityTypeCode  := LEFT.party_type,
	                            SELF.EntityType      := LEFT.party_type_name,
	                            SELF.OriginalNames2  := fn_setPropertyOriginalNames2( LEFT.orig_names, iesp.Constants.Prop.MaxOriginalNames ),
	                            SELF.OriginalAddress := iesp.ECL2ESP.SetAddress ( '', '', '', '', '', '', '', '', '', '', '', '', '', 
                                                                                LEFT.orig_addr, LEFT.orig_unit, LEFT.orig_csz ), 
 	                            SELF.Lot             := LEFT.lot,
	                            SELF.LotOrder        := LEFT.lot_order,
                              self.originalnames := [],
                           ));
        RETURN CHOOSEN(ds_out_propertyEntities,maxPropertyEntities);
      END; // fn_setPropertyEntities
      

    EXPORT iesp.rollupbizreport.t_BizReportFor xfm_setBusinessBest( iesp.rollupbizreport.t_BizReportFor bestinfo) := 
      TRANSFORM
        SELF.BusinessId     := bestinfo.BusinessId;
        SELF.CompanyName    := bestinfo.CompanyName;
        SELF.FEIN           := bestinfo.FEIN;
        SELF.Address        := bestinfo.Address;
        SELF.PhoneInfo      := bestinfo.PhoneInfo;
        SELF.ReportId       := bestinfo.ReportId;
        SELF.MsaNumber      := bestinfo.MsaNumber;
        SELF.MsaDescription := bestinfo.MsaDescription;
      END;  

    EXPORT iesp.midexcompreport.t_MidexCompBusinessSmartLinxRecord xfm_setSmartLinxBusinessFormat ( MIDEX_Services.Layouts.rec_SmartLinxBusinessPlusSources ds_Business_in ) :=
      TRANSFORM
        SELF.BestInformation    := PROJECT( ds_Business_in.BestInformation, xfm_setBusinessBest(LEFT) );
        SELF.NameVariations     := ds_Business_in.NameVariations;
        SELF.AddressVariations  := ds_Business_in.AddressVariations;
        SELF.Bankruptcies       := ds_Business_in.Bankruptcies;
        SELF.LiensJudgments     := ds_Business_in.LiensJudgments;
        SELF.Contacts           := ds_Business_in.Contacts;
        SELF.Properties         := ds_Business_in.Properties;
        SELF.BusinessAssociates := ds_Business_in.BusinessAssociates;
        SELF.PhoneVariations    := ds_Business_in.PhoneVariations;
        SELF                    := ds_Business_in;
      END;
                             
    // --------------------------------------------------------------------------------------------------------------
    //     END: SmartLinx Business Functions
    // --------------------------------------------------------------------------------------------------------------
        

  END; // end of Functions module