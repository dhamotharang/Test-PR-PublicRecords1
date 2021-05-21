  IMPORT $, Address, Autokey_batch, Doxie, iesp, MDR, Phones, PhoneFinder_Services, std, ut;

  pfLayouts     := PhoneFinder_Services.Layouts;
  lBatchInAcctno:= pfLayouts.BatchInAppendAcctno;
  lBatchInDID   := pfLayouts.BatchInAppendDID;
  lFinal        := pfLayouts.PhoneFinder.Final;
  lIdentitySlim := pfLayouts.PhoneFinder.IdentitySlim;
  lIdentityIesp := pfLayouts.PhoneFinder.IdentityIesp;
  lPhoneSlim    := pfLayouts.PhoneFinder.PhoneSlim;

  EXPORT Functions :=
  MODULE

  EXPORT ValidateDate(UNSIGNED4 pDate) :=
  FUNCTION
    INTEGER year  := pDate DIV 10000;
    INTEGER month := (pDate % 10000) DIV 100;
    INTEGER day   := pDate % 100;

    validatedDate := MAP( year < 1900 => 0,
                          year > 1900 AND month NOT BETWEEN 1 AND 12 => year * 10000,
                          year > 1900 AND month BETWEEN 1 AND 12 AND day NOT BETWEEN 1 AND 31 => (pDate DIV 100) * 100,
                          pDate);

    RETURN validatedDate;
  END;

  EXPORT GetSubjectInfo(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dInRecs,
                                PhoneFinder_Services.iParam.SearchParams        inMod) := FUNCTION
    // phone searches do not generate other phones related to the subject, hence all phone searches are subject related.
    dNeedPortingInfo := IF(inMod.SubjectMetadataOnly, dInRecs(isprimaryphone), dInRecs);

    // reduce layout by selecting necessary fields
    PhoneFinder_Services.Layouts.SubjectPhone getSubjectPhone(dNeedPortingInfo l) := TRANSFORM
      SELF.acctno := l.acctno;
      SELF.did := l.did;
      SELF.phone := l.phone;
      //If phone record occurs after first_seen minus 5 days the date field in the port/spoof table will associate active with subject.
      SELF.FirstSeenDate := IF((UNSIGNED)l.dt_first_seen<> 0, (UNSIGNED)ut.date_math(l.dt_first_seen, -PhoneFinder_Services.Constants.PortingMarginOfError), 0);
      SELF.LastSeenDate  := IF((UNSIGNED)l.dt_last_seen <> 0, (UNSIGNED)ut.date_math(l.dt_last_seen, PhoneFinder_Services.Constants.PortingMarginOfError), 0);
    END;

    dsSubjects := PROJECT(dNeedPortingInfo, getSubjectPhone(LEFT));

    // rollup to get comprehensive port period
    PhoneFinder_Services.Layouts.SubjectPhone rollSubject(PhoneFinder_Services.Layouts.SubjectPhone l, PhoneFinder_Services.Layouts.SubjectPhone r) := TRANSFORM
      SELF.FirstSeenDate := ut.Min2(l.FirstSeenDate, r.FirstSeenDate);
      SELF               := l;
    END;

    dSubjectInfo := ROLLUP(SORT(dsSubjects, acctno, did, phone, -LastSeenDate, FirstSeenDate),
                            LEFT.acctno=RIGHT.acctno AND
                            LEFT.did=RIGHT.did AND
                            LEFT.phone=RIGHT.phone,
                            rollSubject(LEFT, RIGHT));

    RETURN dSubjectInfo;

  END;

  EXPORT STRING ServiceClassDesc(STRING pServiceClass, STRING pLineClass = '') := MAP(pServiceClass = '0' AND (pLineClass = '0' OR pLineClass = '') => $.Constants.PhoneType.LANDLINE,
                                                                                       pServiceClass = '0' AND (pLineClass = '2' ) => $.Constants.PhoneType.CABLE,
                                                                                       pServiceClass = '1' AND (pLineClass = '1' OR pLineClass = '') => $.Constants.PhoneType.WIRELESS,
                                                                                       pServiceClass = '2' AND (pLineClass = '2' OR pLineClass = '') => $.Constants.PhoneType.VOIP,
                                                                                       pServiceClass = '3' AND (pLineClass = '3' OR pLineClass = '') => $.Constants.PhoneType.Other,
                                                                                    PhoneFinder_Services.Constants.PhoneType.Other);

  EXPORT STRING PhoneStatusDesc(INTEGER pPhoneStatus):= MAP(pPhoneStatus IN [10, 11, 12, 13, 20, 21, 22, 23] => PhoneFinder_Services.Constants.PhoneStatus.Active,
                                                            pPhoneStatus IN [30, 31, 32, 33]             => PhoneFinder_Services.Constants.PhoneStatus.Inactive,
                                                            PhoneFinder_Services.Constants.PhoneStatus.NotAvailable);

  EXPORT STRING AddressTypeDesc(STRING pAddressType) := CASE(pAddressType,
                                                              'F' => 'FIRM',
                                                              'G' => 'GENERAL DELIVERY',
                                                              'H' => 'MULTI-DWELLING RESIDENTIAL OR OFFICE BUILDING',
                                                              'M' => 'MILITARY',
                                                              'P' => 'POST OFFICE BOX',
                                                              'R' => 'RURAL ROUTE OR HIGHWAY CONTRACT',
                                                              'S' => 'STREET ADDRESS',
                                                              'U' => 'UNKNOWN',
                                                              '');
  EXPORT STRING CallForwardingDesc(INTEGER pCallFwd) := CASE(pCallFwd,
                                                              0 => 'NOT FORWARDED',
                                                              1 => 'FORWARDED',
                                                              '');
  // Best info
  EXPORT GetBestInfo(DATASET(lBatchInDID) dIn, doxie.IDataAccess mod_access) :=
  FUNCTION

    dids := DEDUP(SORT(PROJECT(dIn, doxie.layout_references), did), did);

    dBestRecs := Doxie.best_records(dids, includeDOD:=true, modAccess := mod_access);

    lBatchInDID tGetBestInfo(dIn le, dBestRecs ri) :=
    TRANSFORM
      SELF.acctno      := le.acctno;
      SELF.name_first  := ri.fname;
      SELF.name_middle := ri.mname;
      SELF.name_last   := ri.lname;
      SELF.addr_suffix := ri.suffix;
      SELF.p_city_name := ri.city_name;
      SELF.z5          := ri.zip;
      SELF.ssn         := (STRING)ri.ssn;
      SELF.dob         := (STRING)ri.dob;
      SELF             := ri;
      SELF             := le;
    END;

    dBestInfo := JOIN(dIn,
                      dBestRecs,
                      LEFT.did = RIGHT.did,
                      tGetBestInfo(LEFT, RIGHT),
                      LEFT OUTER,
                      LIMIT(0), keep(1));

    RETURN dBestInfo;
  END;

  // Function to check IF name is populated
  EXPORT isNamePopulated(iesp.share.t_Name pName) := pName.Full != '' or pName.Last != '';

  // Function to check IF address is populated
  EXPORT isAddrPopulated(iesp.share.t_Address pAddr) :=
  FUNCTION
    STRING vStreetAddress     := Address.Addr1FromComponents(pAddr.StreetNumber,
                                                              pAddr.StreetPreDirection,
                                                              pAddr.StreetName,
                                                              pAddr.StreetSuffix,
                                                              pAddr.StreetPostDirection,
                                                              pAddr.UnitDesignation,
                                                              pAddr.UnitNumber
                                                            );
    STRING vStreetAddressl    := IF(pAddr.StreetAddress1 = '', vStreetAddress, pAddr.StreetAddress1);
    STRING vStreetAddressFull := STRINGlib.STRINGcleanspaces(vStreetAddressl + ' ' + pAddr.StreetAddress2);
    STRING vCityStateZip      := IF(pAddr.StatecityZip != '',
                                    pAddr.StateCityZip,
                                    Address.Addr2FromComponents(pAddr.city, pAddr.state, pAddr.zip5)
                                    );

    BOOLEAN vAddrPopulated    := vStreetAddressFull != '' and vCityStateZip != '';

    RETURN vAddrPopulated;
  END;

  // Function to append carrier information
  EXPORT GetPhoneCarrierInfo(dIn) :=
  FUNCTIONMACRO
    IMPORT risk_indicators;

    rAppendCarrierInfo :=
    RECORD
      RECORDOF(dIn);
      PhoneFinder_Services.Layouts.CarrierInfo.Base;
    END;

    dTelcoridaTPM := JOIN(dIn,
                          risk_indicators.Key_Telcordia_tpm,
                              KEYED(LEFT.phone[1..3] = RIGHT.npa)
                          and KEYED(LEFT.phone[4..6] = RIGHT.nxx)
                          and KEYED(LEFT.phone[7]    = RIGHT.tb),
                          LEFT OUTER,
                          KEEP(1), LIMIT(0));

    dTelcorida    := JOIN(dTelcoridaTPM,
                          risk_indicators.Key_Telcordia_tds,
                              KEYED(LEFT.phone[1..3] = RIGHT.npa)
                          and KEYED(LEFT.phone[4..6] = RIGHT.nxx)
                          and LEFT.phone[7] = RIGHT.tb,
                          LEFT OUTER,
                          KEEP(1), LIMIT(0));

    rAppendCarrierInfo tFormat(dTelcorida pInput) :=
    TRANSFORM
      vCOCTypeUpper := STRINGlib.STRINGtouppercase(pInput.COCType);
      vSSCTypeUpper := STRINGlib.STRINGtouppercase(pInput.SSC);

      BOOLEAN vCell :=      (vCOCTypeUpper in ['EOC', 'PMC', 'RCC', 'SP1', 'SP2', 'VOI'])
                        and (     stringlib.stringfind(vSSCTypeUpper, 'C', 1) > 0
                              or  stringlib.stringfind(vSSCTypeUpper, 'R', 1) > 0
                              or  stringlib.stringfind(vSSCTypeUpper, 'S', 1) > 0
                            );

      BOOLEAN vPage :=      vCOCTypeUpper in ['EOC', 'PMC', 'RCC', 'SP1', 'SP2', 'VOI']
                        and stringlib.stringfind(vSSCTypeUpper, 'B', 1) > 0;

      BOOLEAN vVOIP := vCOCTypeUpper = 'VOI' or stringlib.stringfind(vSSCTypeUpper, 'V', 1) > 0;

      STRING vTypeDesc := MAP(vCell                 => PhoneFinder_Services.Constants.PhoneType.Wireless,
                              vPage                 => PhoneFinder_Services.Constants.PhoneType.Pager,
                              vVOIP                 => PhoneFinder_Services.Constants.PhoneType.VoIP,
                              vCOCTypeUpper = 'EOC' => PhoneFinder_Services.Constants.PhoneType.LandLine,
                              PhoneFinder_Services.Constants.PhoneType.Other);

      SELF.carrier_name    := pInput.ocn;
      SELF.carrier_city    := pInput.city;
      SELF.carrier_state   := pInput.state;
      SELF.carrier_type    := pInput.COCType;
      SELF.coc_description := vTypeDesc;
      SELF.ssc_description := CASE(pInput.ssc,
                                    'A' => 'INTRALATA USE ONLY',
                                    'B' => 'PAGING SERVICES',
                                    'C' => 'CELLULAR SERVICES',
                                    'I' => 'PSEUDO 800 SERVICE CODE',
                                    'J' => 'EXTENDED/EXPANDED CALLING SCOPE',
                                    'M' => 'LOCAL MASS CALLING CODE',
                                    'N' => 'N/A',
                                    'O' => 'OTHER',
                                    'R' => 'TWO-WAY CONVENTIONAL MOBILE RADIO',
                                    'S' => 'MISCELLANEOUS SERVICES',
                                    'T' => 'TIME',
                                    'W' => 'WEATHER',
                                    'X' => 'LOCAL EXCHANGE INTRALATA SPECIAL BILLING OPTION',
                                    'Z' => 'SELECTIVE LOCAL EXCHANGE INTRALATA SPECIAL BILLING OPTION',
                                    '8' => 'PUERTO RICO and U.S. VIRGIN ISLANDS CODES',
                                    '');
      SELF                 := pInput;
    END;

    dCarrierInfo := PROJECT(dTelcorida, tFormat(LEFT));

    RETURN dCarrierInfo;
  ENDMACRO;

  // Listing Type
  EXPORT GetListingType(STRING pListingType, STRING pListingTypeBus, STRING pListingTypeGov, STRING pListingTypeRes) :=
  FUNCTION
    RETURN MAP( pListingType = 'BR'                                                       => PhoneFinder_Services.Constants.ListingType.BusGovRes,
                pListingType = 'BG'                                                       => PhoneFinder_Services.Constants.ListingType.BusGov,
                pListingType = 'RS'                                                       => PhoneFinder_Services.Constants.ListingType.Residential,
                pListingTypeBus = 'B' and pListingTypeGov = 'G' and pListingTypeRes = 'R' => PhoneFinder_Services.Constants.ListingType.BusGovRes,   // ListingType for TU takes preference over in-house
                pListingTypeBus = 'B' and pListingTypeGov = 'G'                           => PhoneFinder_Services.Constants.ListingType.BusGov,      // ListingType for TU takes preference over in-house
                pListingTypeBus = 'B'                                                     => PhoneFinder_Services.Constants.ListingType.Business,
                pListingTypeGov = 'G'                                                     => PhoneFinder_Services.Constants.ListingType.Government,
                pListingTypeRes = 'R'                                                     => PhoneFinder_Services.Constants.ListingType.Residential, // ListingType for TU takes preference over in-house
                '');
  END;

  // Clean and uppercase the fields
  SHARED UppercaseFields(dIn, dOut)	:=
  MACRO
    LOADXML('<xml/>');

    #EXPORTXML(doCleanFieldMetaInfo, RECORDOF(dIn));

    #UNIQUENAME(fnClean)
    %fnClean%(string x) := ut.CleanSpacesAndUpper(x);

    #UNIQUENAME(tCleanFields)
    RECORDOF(dIn)	%tCleanFields%(dIn pInput) :=
    TRANSFORM
      #IF(%'doCleanFieldText'% = '')
        #DECLARE(doCleanField)
        #DECLARE(doCleanFieldText)
        #DECLARE(datasetStartCount)
        #DECLARE(datasetEndCount)
      #END

      #SET(doCleanField, TRUE)
      #SET(doCleanFieldText, FALSE)
      #SET(datasetStartCount, 0)
      #SET(datasetEndCount, 0)

      #FOR(doCleanFieldMetaInfo)
        #FOR(Field)
          #IF(stringlib.stringfind(%'@isDataset'%, '1', 1) != 0 or stringlib.stringfind(%'@isRecord'%, '1', 1) != 0)
            #SET(doCleanField, FALSE)
            #APPEND(doCleanFieldText, '')
            #SET(datasetStartCount, %datasetStartCount% + 1)
          #ELSEIF(stringlib.stringfind(%'@isEnd'%, '1', 1) != 0)
            #SET(datasetEndCount, %datasetEndCount% + 1)
            #IF(%datasetEndCount% = %datasetStartCount%)
              #SET(doCleanField, TRUE)
            #END
            #APPEND(doCleanFieldText, '')
          #ELSEIF(%doCleanField%	and	%'@type'% = 'string')
            #SET(doCleanFieldText, 'SELF.' + %'@name'%)
            #APPEND(doCleanFieldText, ' := ' + %'fnClean'% + '(pInput.')
            #APPEND(doCleanFieldText, %'@name'%)
            #APPEND(doCleanFieldText, ')')
            %doCleanFieldText%;
          #ELSE
            #APPEND(doCleanFieldText, '')
          #END
        #END
      #END
      SELF := pInput;
    END;

    dOut := PROJECT(dIn, %tCleanFields%(LEFT));
  ENDMACRO;

  // Is minimum info populated to get a DID
  SHARED noDIDWithMinInfo(UNSIGNED did,
                          STRING lname, STRING fname,
                          STRING ssn,
                          STRING prim_range, STRING prim_name, STRING zip, STRING city, STRING st) :=
  FUNCTION
    RETURN (did = 0) and (ssn != '' or
            (lname != '' and fname != '' and prim_range != '' and prim_name != '' and (zip != '' or (city != '' and st != ''))));
    END;

  // Append DIDs to the search results which didn't have a DID
  EXPORT AppendDIDs(DATASET(lFinal) dIn, BOOLEAN getBest = FALSE) :=
  FUNCTION
    dInSeq := UNGROUP(PROJECT(GROUP(dIn, acctno, ALL), TRANSFORM(lFinal, SELF.seq := COUNTER, SELF := LEFT)));

    // Convert fields to uppercase
    UppercaseFields(dInSeq, dInUppercase);

    // Get DIDs for records that have enough information
    dInNoDIDs := dInUppercase(noDIDWithMinInfo(did, lname, fname, ssn, prim_range, prim_name, zip, city_name, st));

    Autokey_batch.Layouts.rec_inBatchMaster tFormat2DIDReady(dInNoDIDs pInput) :=
    TRANSFORM
      SELF.name_first  := pInput.fname;
      SELF.name_middle := pInput.mname;
      SELF.name_last   := pInput.lname;
      SELF.addr_suffix := pInput.suffix;
      SELF.homephone   := pInput.phone;
      SELF.p_city_name := pInput.city_name;
      SELF.z5          := pInput.zip;
      SELF.dob         := (STRING)pInput.dob;
      SELF             := pInput;
      SELF             := [];
    END;

    dFormat2DIDReady := PROJECT(dInNoDIDs, tFormat2DIDReady(LEFT));

    dGetDIDs := PhoneFinder_Services.GetDIDs(dFormat2DIDReady, getBest)(did_count = 1); //Filter out records which got multiple DIDs

    lFinal tAppendDID(dInUppercase le, dGetDIDs ri) :=
    TRANSFORM
      SELF.did := IF(le.did != 0, le.did, ri.did);
      SELF     := le;
    END;

    dAppendDIDs := JOIN(dInUppercase,
                        dGetDIDs,
                        LEFT.acctno = RIGHT.acctno and
                        LEFT.seq    = RIGHT.seq,
                        tAppendDID(LEFT, RIGHT),
                        LEFT OUTER,
                        LIMIT(0), KEEP(1)); //only one DID per acctno

    #IF(PhoneFinder_Services.Constants.Debug.Intermediate)
      OUTPUT(dInSeq, NAMED('dInSeq'), EXTEND);
      OUTPUT(dInUppercase, NAMED('dInUppercase'), EXTEND);
      OUTPUT(dInNoDIDs, NAMED('dInNoDIDs'), EXTEND);
      OUTPUT(dFormat2DIDReady, NAMED('dFormat2DIDReady'), EXTEND);
      OUTPUT(dGetDIDs, NAMED('dGetDIDs'), EXTEND);
    #END

    RETURN dAppendDIDs;
  END;

   EXPORT getSourceTypeByCode (DATASET($.Layouts.PhoneFinder.src_rec) dIn) := FUNCTION

      $.Layouts.PhoneFinder._type type_it($.Layouts.PhoneFinder.src_rec l) := TRANSFORM
        SELF._Type := $.Constants.MapSourceTypeDCT(l.Src);
      end;

      dsType := PROJECT(dIn, type_it(LEFT));

    return DEDUP(SORT(dsType, _Type), _Type);
  END;

  // Format search results to IESP layout
  EXPORT FormatResults2IESP(DATASET(lFinal) dIn, PhoneFinder_Services.iParam.SearchParams inMod) :=
  FUNCTION
    today := STD.Date.Today();
  
    // Identities section
    $.Layouts.log_identities tFormat2IespIdentity(lFinal pInput) :=
    TRANSFORM
      dt_first_seen := ValidateDate((INTEGER)pInput.dt_first_seen);
      dt_last_seen  := ValidateDate((INTEGER)pInput.dt_last_seen);

      vFullName      := pInput.full_name;
      vStreetAddress := Address.Addr1FromComponents(pInput.prim_range, pInput.predir, pInput.prim_name, pInput.suffix,
                                                    pInput.postdir, pInput.unit_desig, pInput.sec_range);
      vCityStZip     := Address.Addr2FromComponentsWithZip4(pInput.city_name, pInput.st, pInput.zip, pInput.zip4);

      SELF.UniqueId                          := (STRING)pInput.did;
      SELF.Deceased                          := pInput.deceased;
      SELF.Name                              := iesp.ECL2ESP.SetName( pInput.fname,
                                                                      pInput.mname,
                                                                      pInput.lname,
                                                                      pInput.name_suffix,
                                                                      '',
                                                                      vFullName);
      SELF.RecentAddress                     := iesp.ECL2ESP.SetAddress(pInput.prim_name, pInput.prim_range,
                                                                        pInput.predir, pInput.postdir, pInput.suffix,
                                                                        pInput.unit_desig, pInput.sec_range,
                                                                        pInput.city_name, pInput.st, pInput.zip,
                                                                        pInput.zip4, pInput.county_name, '',
                                                                        vStreetAddress[1..60], vStreetAddress[61..],
                                                                        vCityStZip);
      SELF.PrimaryAddressType                := pInput.primary_address_type;
      SELF.RecordType                        := pInput.TNT;
      SELF.FirstSeenWithPrimaryPhone         := iesp.ECL2ESP.toDate(dt_first_seen);
      SELF.LastSeenWithPrimaryPhone          := iesp.ECL2ESP.toDate(dt_last_seen);
      SELF.TimeWithPrimaryPhone              := IF(dt_first_seen != 0 AND dt_last_seen != 0,
                                                    (STRING)STD.Date.MonthsBetween(dt_first_seen, dt_last_seen),
                                                    '');
      SELF.TimeSinceLastSeenWithPrimaryPhone := IF(dt_last_seen != 0,
                                                    (STRING)STD.Date.MonthsBetween(dt_last_seen, today),
                                                    '');
      SELF.PhoneOwnershipIndicator           := pInput.PhoneOwnershipIndicator;
      // Source details will be populated in Identities  only in a Phone Search.
      SELF.SourceDetails                     := IF(~inMod.isPrimarySearchPII, PROJECT(pInput.sourceinfo, TRANSFORM(iesp.phonefinder.t_PhoneFinderSourceIndicator, SELF := LEFT)));
      SELF.TotalSourceCount                  := IF(~inMod.isPrimarySearchPII, pInput.TotalSourceCount, 0);
      SELF.SelfReportedSourcesOnly           := IF(~inMod.isPrimarySearchPII, pInput.SelfReportedSourcesOnly, FALSE);
      SELF                                   := pInput;
    END;

    dIdentities := IF(inMod.isPrimarySearchPII, dIn(isPrimaryIdentity), dIn);

    dIdentitiesIesp := PROJECT(SORT(dIdentities(fname != '' OR lname != '' OR listed_name != ''),
                                    IF(PhoneOwnershipIndicator, 0, 1), IF(did != 0, 0, 1), IF(TNT = Phones.Constants.TNT.Current, 0, 1), -dt_last_seen, dt_first_seen, IF(deceased = 'N', 0, 1)),
                                tFormat2IespIdentity(LEFT));
    dOtherIdentitiesIesp := PROJECT(SORT(dIn(~isPrimaryIdentity AND isPrimaryPhone AND (fname != '' OR lname != '')),
                                          IF(PhoneOwnershipIndicator, 0, 1), IF(did != 0, 0, 1), IF(TNT = Phones.Constants.TNT.Current, 0, 1), -dt_last_seen, dt_first_seen, IF(deceased = 'N', 0, 1)),
                                    tFormat2IespIdentity(LEFT));

    // Primary phone section
    $.Layouts.log_primary tFormat2IespPrimaryPhone(lFinal pInput) :=
    TRANSFORM
      doVerify := inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress OR inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneLastName;

      vVerificationDesc := IF(doVerify AND ~pInput.is_verified AND pInput.verification_desc = '', $.Constants.VerifyMessage.PhoneCannotBeVerified, pInput.verification_desc);

      SELF.Number                           := pInput.phone;
      SELF._Type                            := pInput.coc_description;
      SELF.Carrier                          := pInput.carrier_name;
      SELF.CarrierCity                      := pInput.phone_region_city;
      SELF.CarrierState                     := pInput.phone_region_st;
      SELF.ListingName                      := pInput.listed_name;
      SELF.FirstPortedDate                  := IF(inMod.IncludePortingDetails, iesp.ECL2ESP.toDate(ValidateDate(pInput.FirstPortedDate)));
      SELF.LastPortedDate                   := IF(inMod.IncludePortingDetails, iesp.ECL2ESP.toDate(ValidateDate(pInput.LastPortedDate)));
      Phone_Status                          := pInput.PhoneStatus;
      SELF.ActivationDate                   := IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.Active, iesp.ECL2ESP.toDate(pInput.ActivationDate));
      SELF.DisconnectDate                   := IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.INACTIVE, iesp.ECL2ESP.toDate(pInput.DisconnectDate));
      SELF.PortingHistory                   := IF(inMod.IncludePortingDetails, CHOOSEN(PROJECT(pInput.PortingHistory,
                                                                TRANSFORM(iesp.phonefinder.t_PortingHistory,
                                                                          SELF.PortStartDate := iesp.ECL2ESP.toDate(ValidateDate(LEFT.PortStartDate)),
                                                                          SELF.PortEndDate   := iesp.ECL2ESP.toDate(ValidateDate(LEFT.PortEndDate)),
                                                                          // v---- Added next 13 lines for the 2021-06-02 Phone Porting for LE project
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.Id                     := LEFT.ServiceProviderInfo.id,
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.Company                := LEFT.ServiceProviderInfo.company,
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.Contact                := LEFT.ServiceProviderInfo.contact,
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.ContactPhone           := LEFT.ServiceProviderInfo.contact_phone,
                                                                          SELF.PortValidationInfo.DateOfChange                               := iesp.ECL2ESP.toDate(ValidateDate(LEFT.DateOfChange)),
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.Id                  := LEFT.AltServiceProviderInfo.id,
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.Company             := LEFT.AltServiceProviderInfo.company,
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.Contact             := LEFT.AltServiceProviderInfo.contact,
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.ContactPhone        := LEFT.AltServiceProviderInfo.contact_phone,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.Id              := LEFT.LastAltServiceProviderInfo.id,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.Company         := LEFT.LastAltServiceProviderInfo.company,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.Contact         := LEFT.LastAltServiceProviderInfo.contact,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.ContactPhone    := LEFT.LastAltServiceProviderInfo.contact_phone,
                                                                          SELF               := LEFT)),
                                                        iesp.Constants.Phone_Finder.MaxPorts));
      SELF.PortingCount                     := pInput.PortingCount;
      SELF.PortingCode                      := pInput.PortingCode;
      // v---- Added next 13 lines for the 2021-06-02 Phone Porting for LE project
      SELF.PortValidationInfo.ServiceProviderInfo.Id                  := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.id,'');
      SELF.PortValidationInfo.ServiceProviderInfo.Company             := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.company,'');
      SELF.PortValidationInfo.ServiceProviderInfo.Contact             := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.contact,'');
      SELF.PortValidationInfo.ServiceProviderInfo.ContactPhone        := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.contact_phone,'');
      SELF.PortValidationInfo.DateOfChange                            := IF(inMod.IncludePortingDetails, iesp.ECL2ESP.toDate(ValidateDate(pInput.DateOfChange)));
      SELF.PortValidationInfo.AltServiceProviderInfo.Id               := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.id,'');,
      SELF.PortValidationInfo.AltServiceProviderInfo.Company          := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.company,'');
      SELF.PortValidationInfo.AltServiceProviderInfo.Contact          := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.contact,'');
      SELF.PortValidationInfo.AltServiceProviderInfo.ContactPhone     := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.contact_phone,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.Id           := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.id,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.Company      := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.company,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.Contact      := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.contact,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.ContactPhone := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.contact_phone,'');
      SELF.PortingStatus                    := pInput.PortingStatus;
      SELF.SpoofingData.Spoof               := PROJECT(pInput.Spoof,
                                                        TRANSFORM(iesp.phonefinder.t_SpoofCommon,
                                                                  SELF.FirstSpoofedDate := iesp.ECL2ESP.toDate(ValidateDate(LEFT.FirstSpoofedDate)),
                                                                  SELF.LastSpoofedDate  := iesp.ECL2ESP.toDate(ValidateDate(LEFT.LastSpoofedDate)),
                                                                  SELF                  := LEFT));
      SELF.SpoofingData.Destination         := PROJECT(pInput.Destination,
                                                        TRANSFORM(iesp.phonefinder.t_SpoofCommon,
                                                                  SELF.FirstSpoofedDate := iesp.ECL2ESP.toDate(ValidateDate(LEFT.FirstSpoofedDate)),
                                                                  SELF.LastSpoofedDate  := iesp.ECL2ESP.toDate(ValidateDate(LEFT.LastSpoofedDate)),
                                                                  SELF                  := LEFT));
      SELF.SpoofingData.Source              := PROJECT(pInput.Source,
                                                        TRANSFORM(iesp.phonefinder.t_SpoofCommon,
                                                                  SELF.FirstSpoofedDate 	:= iesp.ECL2ESP.toDate(ValidateDate(LEFT.FirstSpoofedDate)),
                                                                  SELF.LastSpoofedDate  	:= iesp.ECL2ESP.toDate(ValidateDate(LEFT.LastSpoofedDate)),
                                                                  SELF:=LEFT));
      SELF.SpoofingData.FirstEventSpoofedDate := iesp.ECL2ESP.toDate(ValidateDate(pInput.FirstEventSpoofedDate));
      SELF.SpoofingData.LastEventSpoofedDate  := iesp.ECL2ESP.toDate(ValidateDate(pInput.LastEventSpoofedDate));
      SELF.SpoofingData.TotalSpoofedCount     := pInput.TotalSpoofedCount;
      SELF.SpoofingData.SpoofingHistory       := CHOOSEN(PROJECT(pInput.SpoofingHistory,
                                                                  TRANSFORM(iesp.phonefinder.t_SpoofHistory,
                                                                            SELF.EventDate := iesp.ECL2ESP.toDate(ValidateDate((INTEGER)LEFT.EventDate)),
                                                                            SELF           := LEFT)),
                                                          iesp.Constants.Phone_Finder.MaxSpoofs);
      SELF.OneTimePassword.FirstOTPDate     := iesp.ECL2ESP.toDate(ValidateDate(pInput.FirstOTPDate));
      SELF.OneTimePassword.LastOTPDate      := iesp.ECL2ESP.toDate(ValidateDate(pInput.LastOTPDate));
      SELF.OneTimePassword.OTP              := pInput.OTP;
      SELF.OneTimePassword.OTPCount         := pInput.OTPCount;
      SELF.OneTimePassword.LastOTPStatus    := pInput.LastOTPStatus;
      SELF.OneTimePassword.OTPHistory       := CHOOSEN(PROJECT(pInput.OTPHistory,
                                                                TRANSFORM(iesp.phonefinder.t_OTPHistory,
                                                                          SELF.EventDate := iesp.ECL2ESP.toDate(ValidateDate((INTEGER)LEFT.EventDate)),
                                                                          SELF           := LEFT)),
                                                        iesp.Constants.Phone_Finder.MaxOTPs);
      SELF.PhoneStatus                      := Phone_Status;
      SELF.MSA                              := pInput.RealTimePhone_Ext.MetroStatAreaCode;
      SELF.CMSA                             := pInput.RealTimePhone_Ext.ConsMetroStatAreaCode;
      SELF.FIPS                             := pInput.RealTimePhone_Ext.CountyCode;
      SELF.CarrierRouteZoneCode             := pInput.RealTimePhone_Ext.SortZone;
      SELF.GeoLocation                      := ROW({pInput.RealTimePhone_Ext.Latitude, pInput.RealTimePhone_Ext.Longitude}, iesp.share.t_GeoLocation);
      SELF.AddressType                      := AddressTypeDesc(pInput.RealTimePhone_Ext.AddressType);
      SELF.CallerID                         := pInput.RealTimePhone_Ext.GenericName;
      SELF.OperatingCompany.CompanyNumber   := IF(inMod.IncludePortingDetails, pInput.RealTimePhone_Ext.OperatingCompany.Number, '');
      SELF.OperatingCompany.Name            := pInput.RealTimePhone_Ext.OperatingCompany.Name;
      SELF.OperatingCompany.Address         := PROJECT(pInput.RealTimePhone_Ext.OperatingCompany.Address,
                                                        TRANSFORM(iesp.share.t_Address, SELF := LEFT, SELF := []));
      SELF.OperatingCompany.AffiliatedTo    := pInput.RealTimePhone_Ext.OperatingCompany.AffiliatedTo;
      SELF.OperatingCompany.ContactName     := PROJECT(pInput.RealTimePhone_Ext.OperatingCompany.Contact.Name,
                                                        TRANSFORM(iesp.share.t_Name,
                                                                  SELF.Full   := LEFT.fullname,
                                                                  SELF.First  := LEFT.fname,
                                                                  SELF.Middle := LEFT.mname,
                                                                  SELF.Last   := LEFT.lname,
                                                                  SELF.Suffix := LEFT.name_suffix,
                                                                  SELF.Prefix := LEFT.name_prefix));
      SELF.OperatingCompany.ContactAddress  := PROJECT(pInput.RealTimePhone_Ext.OperatingCompany.Contact.Address,
                                                        TRANSFORM(iesp.share.t_Address, SELF := LEFT, SELF := []));
      SELF.OperatingCompany.Email           := pInput.RealTimePhone_Ext.OperatingCompany.Contact.Email;
      SELF.OperatingCompany.ContactPhone    :=  pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNPA
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNXX
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneLine;
      SELF.OperatingCompany.ContactPhoneExt := pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneExt;
      SELF.OperatingCompany.Fax             :=  pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNPA
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNXX
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxLine;
      SELF.VerificationStatus               := ROW({vVerificationDesc, pInput.is_verified}, iesp.phonefinder.t_PhoneFinderVerificationStatus);
      SELF.PhoneAddressState                := '';
      SELF.source                           := MAP( inmod.IsPrimarySearchPII and pinput.phone_source IN PhoneFinder_Services.Constants.GatewaySources => PhoneFinder_Services.Constants.SOURCES.Gateway,
                                                    inmod.IsPrimarySearchPII => PhoneFinder_Services.Constants.SOURCES.Internal,
                                                    '');
      SELF                                  := pInput.RealTimePhone_Ext;
      // Source details will be populated in Primary Phone Details  in a PII Search.
      SELF.SourceDetails                    := IF(inMod.isPrimarySearchPII, PROJECT(pInput.sourceinfo, TRANSFORM(iesp.phonefinder.t_PhoneFinderSourceIndicator, SELF := LEFT)));
      SELF.TotalSourceCount                 := IF(inMod.isPrimarySearchPII, pInput.TotalSourceCount, 0);
      SELF.SelfReportedSourcesOnly          := IF(inMod.isPrimarySearchPII, pInput.SelfReportedSourcesOnly, FALSE);
      SELF.Identity_count                   := pInput.Identity_count;
      SELF.PhoneStarRating                  := pInput.Phone_StarRating;
      SELF.ZumigoDeviceDetails.SimMinDays   := pInput.sim_Tenure_MinDays;
      SELF.ZumigoDeviceDetails.SimMaxDays   := pInput.sim_Tenure_MaxDays;
      SELF.ZumigoDeviceDetails.DeviceMinDays:= pInput.imei_Tenure_MinDays;
      SELF.ZumigoDeviceDetails.DeviceMaxDays:= pInput.imei_Tenure_MaxDays;

      SELF                                  := pInput;

      // Below two fields are not being used currently
      SELF.InquiryDetails                   := [];
      SELF.ZumigoDeviceDetails              := [];
    END;

    dPrimaryPhoneIesp := PROJECT(dIn(isPrimaryPhone AND isPrimaryIdentity), tFormat2IespPrimaryPhone(LEFT));

    // Other phones
    $.Layouts.log_other tFormat2IespOtherPhones(lFinal pInput) :=
    TRANSFORM
      dt_first_seen := ValidateDate((INTEGER)pInput.dt_first_seen);
      dt_last_seen  := ValidateDate((INTEGER)pInput.dt_last_seen);

      SELF.Number                  := pInput.phone;
      SELF._Type                   := pInput.coc_description;
      SELF.Carrier                 := pInput.carrier_name;
      SELF.CarrierCity             := pInput.phone_region_city;
      SELF.CarrierState            := pInput.phone_region_st;
      SELF.ListingName             := pInput.listed_name;
      SELF.PortingCode             := pInput.PortingCode;
      SELF.LastPortedDate          := IF(inMod.IncludePortingDetails,iesp.ECL2ESP.toDate(ValidateDate(pInput.LastPortedDate)));
      SELF.PhoneRiskIndicator      := pInput.PhoneRiskIndicator;
      SELF.OTPRIFailed             := pInput.OTPRIFailed;
      SELF.PhoneStatus             := pInput.PhoneStatus,
      SELF.Prepaid                 := pInput.Prepaid,
      SELF.Address                 := iesp.ECL2ESP.SetAddress(pInput.prim_name, pInput.prim_range,
                                                              pInput.predir, pInput.postdir, pInput.suffix,
                                                              pInput.unit_desig, pInput.sec_range,
                                                              pInput.city_name, pInput.st, pInput.zip,
                                                              pInput.zip4, pInput.county_name);
      SELF.DateFirstSeen           := iesp.ECL2ESP.toDate(dt_first_seen);
      SELF.DateLastSeen            := iesp.ECL2ESP.toDate(dt_last_seen);
      SELF.MonthsWithPhone         := IF(dt_first_seen != 0 AND dt_last_seen != 0,
                                        (STRING)STD.Date.MonthsBetween(dt_first_seen, dt_last_seen),
                                        '');
      SELF.MonthsSinceLastSeen     := IF( dt_last_seen != 0,
                                          (STRING)STD.Date.MonthsBetween(dt_last_seen, today),
                                          '');
      SELF.PhoneOwnershipIndicator := pInput.PhoneOwnershipIndicator;
      SELF.CallForwardingIndicator := pInput.CallForwardingIndicator;
      SELF.source                  := MAP(inmod.IsPrimarySearchPII and pinput.phone_source IN PhoneFinder_Services.Constants.GatewaySources => PhoneFinder_Services.Constants.SOURCES.Gateway,
                                          inmod.IsPrimarySearchPII => PhoneFinder_Services.Constants.SOURCES.Internal,
                                          '');
      // Source details will be populated in OtherPhones in a PII Search.
      SELF.SourceDetails           := PROJECT(pInput.sourceinfo, TRANSFORM(iesp.phonefinder.t_PhoneFinderSourceIndicator, SELF := LEFT));
      SELF.identity_count          := pInput.identity_count;
      SELF.PhoneStarRating         := pInput.Phone_StarRating;
      SELF                         := pInput;
      SELF.PhoneAddressState       := '';

      // Below two fieldss are not being used currently
      SELF.InquiryDetails          := [];
      SELF.ZumigoDeviceDetails     := [];
    END;

    dOtherPhonesIesp := PROJECT(SORT(dIn(~isPrimaryPhone AND ~isPrimaryIdentity AND phone != ''), acctno, -phone_score, -dt_last_seen, dt_first_seen), tFormat2IespOtherPhones(LEFT));

   //Sourcing Deltabase
  //In a PIISearch sourcedetails are reported in OtherPhones and PrimaryPhone.
   dsFinalSrcRecs := IF(~inMod.isPrimarySearchPII, dIn(fname != '' OR lname != '' OR listed_name != ''),
                                                   dIn(isPrimaryPhone AND isPrimaryIdentity) & dIn(~isPrimaryPhone AND ~isPrimaryIdentity AND phone != ''));

   $.Layouts.delta_phones_rpt_sources xfm_src(PhoneFinder_Services.Layouts.PhoneFinder.Final l,  $.Layouts.PhoneFinder.Src_Rec r, INTEGER C) := TRANSFORM
       SELF.transaction_id      := inMod.TransactionId;
       SELF.sequence_number     := C;
       SELF.lexid               := l.did;
       SELF.phone_id            := IF(inMod.IsPrimarySearchPII, l.phone_id, 0); //PII 
       SELF.identity_id         := IF(~inMod.IsPrimarySearchPII, l.identity_id, 0); //Phone
       SELF.totalsourcecount    := l.totalsourcecount;
       SELF.Category            := $.Constants.MapCategoryDCT(r.Src);
       SELF.source_type         := $.Constants.MapSourceTypeDCT(r.src);
       SELF.phonenumber         := l.phone;
       SELF.Source              := r.src;
       SELF                     := [];
   END;

   Src_Recs := NORMALIZE(dsFinalSrcRecs, LEFT.phn_src_all, xfm_src(LEFT, RIGHT, COUNTER));
    
    // Format to final iesp layout
    $.Layouts.log_PhoneFinderSearchRecord tFormat2PhoneFinderSearch() :=
    TRANSFORM
      // Check if the IF statement is needed
      SELF.Identities          := CHOOSEN(dIdentitiesIesp, iesp.Constants.Phone_Finder.MaxIdentities);
      SELF.PrimaryPhoneDetails := IF(EXISTS(dPrimaryPhoneIesp), dPrimaryPhoneIesp[1]);
      SELF.PhonesHistory       := IF(inMod.isPrimarySearchPII,
                                      CHOOSEN(PROJECT(dIdentitiesIesp & dOtherIdentitiesIesp,
                                                      TRANSFORM(iesp.phonefinder.t_PhoneFinderHistory,
                                                                SELF.Address   := LEFT.RecentAddress,
                                                                SELF.FirstSeen := LEFT.FirstSeenWithPrimaryPhone,
                                                                SELF.LastSeen  := LEFT.LastSeenWithPrimaryPhone,
                                                                SELF           := LEFT)),
                                              iesp.Constants.Phone_Finder.MaxPhoneHistory));
      SELF.OtherPhones         := IF(inMod.isPrimarySearchPII, CHOOSEN(dOtherPhonesIesp, iesp.Constants.Phone_Finder.MaxOtherPhones));
      SELF.log_source          := Src_Recs;
    END;

    dFormat2PhoneFinderSearch := DATASET([tFormat2PhoneFinderSearch()]);

    // Debug
    #IF(PhoneFinder_Services.Constants.Debug.Main)
      OUTPUT(dIdentitiesIesp, NAMED('dIdentitiesIesp'));
      OUTPUT(dPrimaryPhoneIesp, NAMED('dPrimaryPhoneIesp'));
      IF(inMod.isPrimarySearchPII, OUTPUT(dOtherPhonesIesp, NAMED('dOtherPhonesIesp')));
    #END

    RETURN dFormat2PhoneFinderSearch;
  END;

  // Format search results to batch layout
  EXPORT FormatResults2Batch(dIn, dSearchIn, inMod, isPhoneSearch = FALSE) :=
  FUNCTIONMACRO
    IMPORT $, iesp, MDR;

    today := STD.Date.Today();

    pf := $.Layouts;

    lFinal := pf.PhoneFinder.Final;

    pf.PhoneFinder.TempOut tFormat2Denorm(pf.BatchInAppendDID pInput) :=
    TRANSFORM
      SELF.phone := pInput.homephone;
      SELF.z4    := pInput.zip4;
      SELF       := pInput;
      SELF       := [];
    END;

    dFormat2Denorm := PROJECT(dSearchIn, tFormat2Denorm(LEFT));


    pf.PhoneFinder.IdentityIesp tFormat2IespIdentity(lFinal pInput) :=
    TRANSFORM
      dt_first_seen := $.Functions.ValidateDate((INTEGER)pInput.dt_first_seen);
      dt_last_seen  := $.Functions.ValidateDate((INTEGER)pInput.dt_last_seen);

      vFullName      := pInput.full_name;
      vStreetAddress := Address.Addr1FromComponents(pInput.prim_range, pInput.predir, pInput.prim_name, pInput.suffix,
                                                    pInput.postdir, pInput.unit_desig, pInput.sec_range);
      vCityStZip     := Address.Addr2FromComponentsWithZip4(pInput.city_name, pInput.st, pInput.zip, pInput.zip4);

      SELF.UniqueId                          := (STRING)pInput.did;
      SELF.Deceased                          := pInput.deceased;
      SELF.Name                              := iesp.ECL2ESP.SetName( pInput.fname,
                                                                      pInput.mname,
                                                                      pInput.lname,
                                                                      pInput.name_suffix,
                                                                      '',
                                                                      vFullName);
      SELF.RecentAddress                     := iesp.ECL2ESP.SetAddress(pInput.prim_name, pInput.prim_range,
                                                                        pInput.predir, pInput.postdir, pInput.suffix,
                                                                        pInput.unit_desig, pInput.sec_range,
                                                                        pInput.city_name, pInput.st, pInput.zip,
                                                                        pInput.zip4, pInput.county_name, '',
                                                                        vStreetAddress[1..60], vStreetAddress[61..],
                                                                        vCityStZip);
      SELF.PrimaryAddressType                := pInput.primary_address_type;
      SELF.RecordType                        := pInput.TNT;
      SELF.FirstSeenWithPrimaryPhone         := iesp.ECL2ESP.toDate(dt_first_seen);
      SELF.LastSeenWithPrimaryPhone          := iesp.ECL2ESP.toDate(dt_last_seen);
      SELF.TimeWithPrimaryPhone              := IF(dt_first_seen != 0 AND dt_last_seen != 0,
                                                    (STRING)STD.Date.MonthsBetween(dt_first_seen, dt_last_seen),
                                                    '');
      SELF.TimeSinceLastSeenWithPrimaryPhone := IF(dt_last_seen != 0,
                                                    (STRING)STD.Date.MonthsBetween(dt_last_seen, today),
                                                    '');
      SELF.PhoneOwnershipIndicator           := pInput.PhoneOwnershipIndicator;
      SELF.SourceDetails                     := [];
      SELF                                   := pInput;
    END;

    dIdentities := IF(inMod.isPrimarySearchPII, dIn(isPrimaryIdentity), dIn);

    dPrimaryIdentityInfo := PROJECT(dIdentities(fname != '' OR lname != '' OR listed_name != ''), tFormat2IespIdentity(LEFT));
    dOtherIdentitiesInfo := PROJECT(dIn(~isPrimaryIdentity AND isPrimaryPhone AND (fname != '' OR lname != '')), tFormat2IespIdentity(LEFT));

    pf.PhoneFinder.TempOut tPrimaryIdentity(pf.PhoneFinder.TempOut le, pf.PhoneFinder.IdentityIesp ri) :=
    TRANSFORM
      SELF.acctno                                             := le.acctno;
      SELF.primary_identity.UniqueID                          := ri.UniqueID;
      SELF.primary_identity.Name                              := ri.Name;
      SELF.primary_identity.RecentAddress                     := ri.RecentAddress;
      SELF.primary_identity.PrimaryAddressType                := ri.PrimaryAddressType;
      SELF.primary_identity.RecordType                        := ri.RecordType;
      SELF.primary_identity.Deceased                          := ri.Deceased;
      SELF.primary_identity.FirstSeenWithPrimaryPhone         := ri.FirstSeenWithPrimaryPhone;
      SELF.primary_identity.LastSeenWithPrimaryPhone          := ri.LastSeenWithPrimaryPhone;
      SELF.primary_identity.TimeWithPrimaryPhone              := ri.TimeWithPrimaryPhone;
      SELF.primary_identity.TimeSinceLastSeenWithPrimaryPhone := ri.TimeSinceLastSeenWithPrimaryPhone;
      SELF.primary_identity.PhoneOwnershipIndicator           := ri.PhoneOwnershipIndicator;
      SELF.primary_identity.ssn                               := ri.ssn;
      SELF                                                    := le;
    END;

    dPrimaryIdentity := JOIN( dFormat2Denorm,
                              dPrimaryIdentityInfo,
                              LEFT.acctno = RIGHT.acctno,
                              tPrimaryIdentity(LEFT, RIGHT),
                              LEFT OUTER,
                              LIMIT(0), KEEP(1));

    // Denormalize identities
    dIdentitiesInfo := IF(inMod.isPrimarySearchPII, dOtherIdentitiesInfo, dPrimaryIdentityInfo);

    pf.PhoneFinder.TempOut tDenormIdentity(pf.PhoneFinder.TempOut le, pf.PhoneFinder.IdentityIesp ri) :=
    TRANSFORM
      SELF.identity_info := le.identity_info +
                            ROW({ ri.UniqueID, ri.Deceased,
                                  {ri.Name.Full, ri.Name.First, ri.Name.Middle, ri.Name.Last, ri.Name.Suffix, ri.Name.Prefix},
                                  { ri.RecentAddress.StreetNumber, ri.RecentAddress.StreetPreDirection, ri.RecentAddress.StreetName,
                                    ri.RecentAddress.StreetSuffix, ri.RecentAddress.StreetPostDirection, ri.RecentAddress.UnitDesignation,
                                    ri.RecentAddress.UnitNumber, ri.RecentAddress.StreetAddress1, ri.RecentAddress.StreetAddress2,
                                    ri.RecentAddress.City, ri.RecentAddress.State, ri.RecentAddress.Zip5, ri.RecentAddress.Zip4,
                                    ri.RecentAddress.County, ri.RecentAddress.PostalCode, ri.RecentAddress.StateCityZip},
                                  {ri.FirstSeenWithPrimaryPhone.Year, ri.FirstSeenWithPrimaryPhone.Month, ri.FirstSeenWithPrimaryPhone.Day},
                                  {ri.LastSeenWithPrimaryPhone.Year, ri.LastSeenWithPrimaryPhone.Month, ri.LastSeenWithPrimaryPhone.Day},
                                  ri.TimeWithPrimaryPhone, ri.TimeSinceLastSeenWithPrimaryPhone, ri.PrimaryAddressType, ri.RecordType, ri.phoneownershipindicator, ri.SSN, ri.SourceDetails, ri.selfreportedsourcesonly, ri.totalsourcecount},
                                iesp.phonefinder.t_PhoneIdentityInfo);
      SELF               := le;
      SELF               := [];
    END;

    dIdentityDenorm := DENORMALIZE( dPrimaryIdentity,
                                    dIdentitiesInfo,
                                    LEFT.acctno = RIGHT.acctno,
                                    tDenormIdentity(LEFT, RIGHT));

    // Denormalize other phones
    pf.PhoneFinder.OtherPhoneIesp tFormat2IespOtherPhones(lFinal pInput) :=
    TRANSFORM
      dt_first_seen := $.Functions.ValidateDate((INTEGER)pInput.dt_first_seen);
      dt_last_seen  := $.Functions.ValidateDate((INTEGER)pInput.dt_last_seen);

      SELF.Number                  := pInput.phone;
      SELF._Type                   := pInput.coc_description;
      SELF.Carrier                 := pInput.carrier_name;
      SELF.CarrierCity             := pInput.phone_region_city;
      SELF.CarrierState            := pInput.phone_region_st;
      SELF.ListingName             := pInput.listed_name;
      SELF.PortingCode             := pInput.PortingCode;
      SELF.LastPortedDate          := IF(inMod.IncludePortingDetails, iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.LastPortedDate)));
      SELF.PhoneRiskIndicator      := pInput.PhoneRiskIndicator;
      SELF.OTPRIFailed	           := pInput.OTPRIFailed;
      SELF.PhoneStatus             := pInput.PhoneStatus,
      SELF.Address                 := iesp.ECL2ESP.SetAddress(pInput.prim_name, pInput.prim_range,
                                                              pInput.predir, pInput.postdir, pInput.suffix,
                                                              pInput.unit_desig, pInput.sec_range,
                                                              pInput.city_name, pInput.st, pInput.zip,
                                                              pInput.zip4, pInput.county_name);
      SELF.DateFirstSeen           := iesp.ECL2ESP.toDate(dt_first_seen);
      SELF.DateLastSeen            := iesp.ECL2ESP.toDate(dt_last_seen);
      SELF.MonthsWithPhone         := IF(dt_first_seen != 0 AND dt_last_seen != 0,
                                        (STRING)STD.Date.MonthsBetween(dt_first_seen, dt_last_seen),
                                        '');
      SELF.MonthsSinceLastSeen     := IF( dt_last_seen != 0,
                                          (STRING)STD.Date.MonthsBetween(dt_last_seen, today),
                                          '');
      SELF.PhoneOwnershipIndicator := pInput.PhoneOwnershipIndicator;
      SELF.CallForwardingIndicator := pInput.CallForwardingIndicator;
      SELF.source                  := MAP(inmod.IsPrimarySearchPII and pinput.phone_source IN PhoneFinder_Services.Constants.GatewaySources => PhoneFinder_Services.Constants.SOURCES.Gateway,
                                          inmod.IsPrimarySearchPII                                                                          => PhoneFinder_Services.Constants.SOURCES.Internal,
                                          '');
      SELF.PhoneStarRating         := pInput.Phone_StarRating;                                    
      SELF                         := pInput;
      SELF.PhoneAddressState       := '';

      // Below two fieldss are not being used currently
      SELF.InquiryDetails          := [];
      SELF.ZumigoDeviceDetails     := [];
      SELF.SourceDetails           := [];
    END;

    dOtherPhoneInfo := PROJECT(SORT(dIn(~isPrimaryPhone AND ~isPrimaryIdentity AND phone != ''), acctno, -phone_score), tFormat2IespOtherPhones(LEFT));

    pf.PhoneFinder.TempOut tDenormPhones( pf.PhoneFinder.TempOut le, pf.PhoneFinder.OtherPhoneIesp ri) :=
    TRANSFORM
      SELF.other_phones := le.other_phones +
                            ROW(transform (iesp.phonefinder.t_PhoneFinderInfo, Self := ri));
      SELF              := le;
      SELF              := [];
    END;

    dOtherPhonesDenorm := DENORMALIZE(dIdentityDenorm,
                                      dOtherPhoneInfo,
                                      LEFT.acctno = RIGHT.acctno,
                                      tDenormPhones(LEFT, RIGHT));

    dDenormAll := IF(inMod.isPrimarySearchPII, dOtherPhonesDenorm, dIdentityDenorm);

    // Primary phone info
    pf.PhoneFinder.PhoneIesp tFormat2IespPrimaryPhone(lFinal pInput) :=
    TRANSFORM
      doVerify := inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress OR inMod.VerifyPhoneIsActive;

      vVerificationDesc := IF(doVerify AND ~pInput.is_verified AND pInput.verification_desc = '', $.Constants.VerifyMessage.PhoneCannotBeVerified, pInput.verification_desc);

      SELF.Number                           := pInput.phone;
      SELF._Type                            := pInput.coc_description;
      SELF.Carrier                          := pInput.carrier_name;
      SELF.CarrierCity                      := pInput.phone_region_city;
      SELF.CarrierState                     := pInput.phone_region_st;
      SELF.ListingName                      := pInput.listed_name;
      SELF.FirstPortedDate                  := IF(inMod.IncludePortingDetails, iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.FirstPortedDate)));
      SELF.LastPortedDate                   := IF(inMod.IncludePortingDetails,iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.LastPortedDate)));
      SELF.PortingCount                     := pInput.PortingCount;
      SELF.PortingCode                      := pInput.PortingCode;
      // v---- Added next 13 lines for the 2021-06-02 Phone Porting for LE project
      SELF.PortValidationInfo.ServiceProviderInfo.Id                  := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.id,'');
      SELF.PortValidationInfo.ServiceProviderInfo.Company             := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.company,''); 
      SELF.PortValidationInfo.ServiceProviderInfo.Contact             := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.contact,'');
      SELF.PortValidationInfo.ServiceProviderInfo.ContactPhone        := IF(inMod.IncludePortingDetails, pInput.ServiceProviderInfo.contact_phone,'');
      SELF.PortValidationInfo.DateOfChange                            := IF(inMod.IncludePortingDetails, iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.DateOfChange)));
      SELF.PortValidationInfo.AltServiceProviderInfo.Id               := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.id,'');,
      SELF.PortValidationInfo.AltServiceProviderInfo.Company          := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.company,'');
      SELF.PortValidationInfo.AltServiceProviderInfo.Contact          := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.contact,'');
      SELF.PortValidationInfo.AltServiceProviderInfo.ContactPhone     := IF(inMod.IncludePortingDetails, pInput.AltServiceProviderInfo.contact_phone,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.Id           := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.id,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.Company      := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.company,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.Contact      := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.contact,'');
      SELF.PortValidationInfo.LastAltServiceProviderInfo.ContactPhone := IF(inMod.IncludePortingDetails, pInput.LastAltServiceProviderInfo.contact_phone,'');
      Phone_Status                          := pInput.PhoneStatus;
      SELF.ActivationDate                   := IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.Active, iesp.ECL2ESP.toDate(pInput.ActivationDate));
      SELF.DisconnectDate                   := IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.INACTIVE, iesp.ECL2ESP.toDate(pInput.DisconnectDate));
      SELF.PortingHistory                   := IF(inMod.IncludePortingDetails, CHOOSEN(PROJECT(pInput.PortingHistory,
                                                                TRANSFORM(iesp.phonefinder.t_PortingHistory,
                                                                          SELF.PortStartDate := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.PortStartDate)),
                                                                          SELF.PortEndDate   := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.PortEndDate)),
                                                                          // v---- Added next 13 lines for the 2021-06-02 Phone Porting for LE project
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.Id                     := LEFT.ServiceProviderInfo.id,
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.Company                := LEFT.ServiceProviderInfo.company,
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.Contact                := LEFT.ServiceProviderInfo.contact,
                                                                          SELF.PortValidationInfo.ServiceProviderInfo.ContactPhone           := LEFT.ServiceProviderInfo.contact_phone,
                                                                          SELF.PortValidationInfo.DateOfChange                               := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.DateOfChange)),
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.Id                  := LEFT.AltServiceProviderInfo.id,
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.Company             := LEFT.AltServiceProviderInfo.company,
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.Contact             := LEFT.AltServiceProviderInfo.contact,
                                                                          SELF.PortValidationInfo.AltServiceProviderInfo.ContactPhone        := LEFT.AltServiceProviderInfo.contact_phone,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.Id              := LEFT.LastAltServiceProviderInfo.id,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.Company         := LEFT.LastAltServiceProviderInfo.company,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.Contact         := LEFT.LastAltServiceProviderInfo.contact,
                                                                          SELF.PortValidationInfo.LastAltServiceProviderInfo.ContactPhone    := LEFT.LastAltServiceProviderInfo.contact_phone,
                                                                          SELF               := LEFT)),
                                                        iesp.Constants.Phone_Finder.MaxPorts));
      SELF.SpoofingData.Spoof               := PROJECT(pInput.Spoof,
                                                        TRANSFORM(iesp.phonefinder.t_SpoofCommon,
                                                                  SELF.FirstSpoofedDate := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.FirstSpoofedDate)),
                                                                  SELF.LastSpoofedDate  := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.LastSpoofedDate)),
                                                                  SELF                  := LEFT));
      SELF.SpoofingData.Destination         := PROJECT(pInput.Destination,
                                                        TRANSFORM(iesp.phonefinder.t_SpoofCommon,
                                                                  SELF.FirstSpoofedDate := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.FirstSpoofedDate)),
                                                                  SELF.LastSpoofedDate  := iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.LastSpoofedDate)),
                                                                  SELF                  := LEFT));
      SELF.SpoofingData.Source                := PROJECT(pInput.Source,
                                                        TRANSFORM(iesp.phonefinder.t_SpoofCommon,
                                                                  SELF.FirstSpoofedDate 	:= iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.FirstSpoofedDate)),
                                                                  SELF.LastSpoofedDate  	:= iesp.ECL2ESP.toDate($.Functions.ValidateDate(LEFT.LastSpoofedDate)),
                                                                  SELF:=LEFT));
      SELF.SpoofingData.FirstEventSpoofedDate := iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.FirstEventSpoofedDate));
      SELF.SpoofingData.LastEventSpoofedDate  := iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.LastEventSpoofedDate));
      SELF.SpoofingData.TotalSpoofedCount     := pInput.TotalSpoofedCount;
      SELF.SpoofingData.SpoofingHistory       := CHOOSEN(PROJECT(pInput.SpoofingHistory,
                                                                  TRANSFORM(iesp.phonefinder.t_SpoofHistory,
                                                                            SELF.EventDate := iesp.ECL2ESP.toDate($.Functions.ValidateDate((INTEGER)LEFT.EventDate)),
                                                                            SELF           := LEFT)),
                                                          iesp.Constants.Phone_Finder.MaxSpoofs);
      SELF.OneTimePassword.FirstOTPDate     := iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.FirstOTPDate));
      SELF.OneTimePassword.LastOTPDate      := iesp.ECL2ESP.toDate($.Functions.ValidateDate(pInput.LastOTPDate));
      SELF.OneTimePassword.OTP              := pInput.OTP;
      SELF.OneTimePassword.OTPCount         := pInput.OTPCount;
      SELF.OneTimePassword.LastOTPStatus    := pInput.LastOTPStatus;
      SELF.OneTimePassword.OTPHistory       := CHOOSEN(PROJECT(pInput.OTPHistory,
                                                                TRANSFORM(iesp.phonefinder.t_OTPHistory,
                                                                          SELF.EventDate := iesp.ECL2ESP.toDate($.Functions.ValidateDate((INTEGER)LEFT.EventDate)),
                                                                          SELF           := LEFT)),
                                                        iesp.Constants.Phone_Finder.MaxOTPs);
      SELF.PhoneStatus                      := Phone_Status;
      SELF.MSA                              := pInput.RealTimePhone_Ext.MetroStatAreaCode;
      SELF.CMSA                             := pInput.RealTimePhone_Ext.ConsMetroStatAreaCode;
      SELF.FIPS                             := pInput.RealTimePhone_Ext.CountyCode;
      SELF.CarrierRouteZoneCode             := pInput.RealTimePhone_Ext.SortZone;
      SELF.GeoLocation                      := ROW({pInput.RealTimePhone_Ext.Latitude, pInput.RealTimePhone_Ext.Longitude}, iesp.share.t_GeoLocation);
      SELF.AddressType                      := $.Functions.AddressTypeDesc(pInput.RealTimePhone_Ext.AddressType);
      SELF.CallerID                         := pInput.RealTimePhone_Ext.GenericName;
      SELF.OperatingCompany.CompanyNumber   := IF(inMod.IncludePortingDetails, pInput.RealTimePhone_Ext.OperatingCompany.Number, '');
      SELF.OperatingCompany.Name            := pInput.RealTimePhone_Ext.OperatingCompany.Name;
      SELF.OperatingCompany.Address         := PROJECT(pInput.RealTimePhone_Ext.OperatingCompany.Address,
                                                        TRANSFORM(iesp.share.t_Address, SELF := LEFT, SELF := []));
      SELF.OperatingCompany.AffiliatedTo    := pInput.RealTimePhone_Ext.OperatingCompany.AffiliatedTo;
      SELF.OperatingCompany.ContactName     := PROJECT(pInput.RealTimePhone_Ext.OperatingCompany.Contact.Name,
                                                        TRANSFORM(iesp.share.t_Name,
                                                                  SELF.Full   := LEFT.fullname,
                                                                  SELF.First  := LEFT.fname,
                                                                  SELF.Middle := LEFT.mname,
                                                                  SELF.Last   := LEFT.lname,
                                                                  SELF.Suffix := LEFT.name_suffix,
                                                                  SELF.Prefix := LEFT.name_prefix));
      SELF.OperatingCompany.ContactAddress  := PROJECT(pInput.RealTimePhone_Ext.OperatingCompany.Contact.Address,
                                                        TRANSFORM(iesp.share.t_Address, SELF := LEFT, SELF := []));
      SELF.OperatingCompany.Email           := pInput.RealTimePhone_Ext.OperatingCompany.Contact.Email;
      SELF.OperatingCompany.ContactPhone    :=  pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNPA
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNXX
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneLine;
      SELF.OperatingCompany.ContactPhoneExt := pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneExt;
      SELF.OperatingCompany.Fax             :=  pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNPA
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNXX
                                              + pInput.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxLine;
      SELF.VerificationStatus               := ROW({vVerificationDesc, pInput.is_verified}, iesp.phonefinder.t_PhoneFinderVerificationStatus);
      SELF.PhoneAddressState                := '';
      SELF.source                           := MAP( inmod.IsPrimarySearchPII and pinput.phone_source IN PhoneFinder_Services.Constants.GatewaySources => PhoneFinder_Services.Constants.SOURCES.Gateway,
                                                    inmod.IsPrimarySearchPII                                                                          => PhoneFinder_Services.Constants.SOURCES.Internal,
                                                    '');
      SELF.PhoneStarRating                  := pInput.Phone_StarRating;
      SELF                                  := pInput.RealTimePhone_Ext;
      SELF                                  := pInput;

      // Below two fields are not being used currently
      SELF.InquiryDetails                   := [];
      SELF.ZumigoDeviceDetails              := [];
      SELF.SourceDetails                     := [];
     END;

    dPrimaryPhoneInfo := PROJECT(dIn(isPrimaryPhone AND isPrimaryIdentity), tFormat2IespPrimaryPhone(LEFT));

    pf.PhoneFinder.TempOut tPhoneInfo(pf.PhoneFinder.TempOut le, pf.PhoneFinder.PhoneIesp ri) :=
    TRANSFORM
      SELF.identity_info := SORT(le.identity_info, IF(PhoneOwnershipIndicator, 0, 1), -iesp.ECL2ESP.DateToInteger(LastSeenWithPrimaryPhone));
      SELF.phone_info    := ri;
      SELF               := le;
    END;

    dFormat2BatchReady := JOIN( dDenormAll,
                                dPrimaryPhoneInfo,
                                LEFT.acctno = RIGHT.acctno,
                                tPhoneInfo(LEFT, RIGHT),
                                LEFT OUTER,
                                LIMIT(0), KEEP(1)); //Only one record per acctno exists on the left and right


    LOADXML('<xml/>');
    #EXPORTXML(dFileMetaInfo, pf.PhoneFinder.BatchOut)
    #DECLARE(i)
    #DECLARE(j)
    #DECLARE(p)
    #DECLARE(s)
    #DECLARE(o)
    #DECLARE(a)
    #DECLARE(IdentityInfo)
    #DECLARE(OtherPhones)
    #DECLARE(PortingHistory)
    #DECLARE(SpoofingHistory)
    #DECLARE(OTPHistory)
    #DECLARE(Alerts)

    #SET(i, 1)
    #SET(j, 1)
    #SET(p, 1)
    #SET(s, 1)
    #SET(o, 1)
    #SET(a, 1)
    #SET(IdentityInfo, '')
    #SET(OtherPhones, '')
    #SET(PortingHistory, '')
    #SET(SpoofingHistory, '')
    #SET(OTPHistory, '')
    #SET(Alerts, '')

    #IF(isPhoneSearch)
      #LOOP
        #IF(%i% > iesp.Constants.Phone_Finder.MaxIdentities)
          #BREAK
        #ELSE
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_DID := IF((UNSIGNED)pInput.identity_info[' + %'i'% + '].UniqueID != 0, INTFORMAT((UNSIGNED)pInput.identity_info[' + %'i'% + '].UniqueID, 12, 1), \'\');\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Full := pInput.identity_info[' + %'i'% + '].Name.Full;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_First := pInput.identity_info[' + %'i'% + '].Name.First;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Middle := pInput.identity_info[' + %'i'% + '].Name.Middle;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Last := pInput.identity_info[' + %'i'% + '].Name.Last;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Suffix := pInput.identity_info[' + %'i'% + '].Name.Suffix;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_SSN:= pInput.identity_info[' + %'i'% + '].SSN;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Deceased := pInput.identity_info[' + %'i'% + '].Deceased;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_StreetNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetNumber;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_StreetPreDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPreDirection;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_StreetName := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetName;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_StreetSuffix := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetSuffix;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_StreetPostDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPostDirection;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_UnitDesignation := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitDesignation;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_UnitNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitNumber;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_City := pInput.identity_info[' + %'i'% + '].RecentAddress.City;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_State := pInput.identity_info[' + %'i'% + '].RecentAddress.State;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Zip5 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip5;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_Zip4 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip4;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_County := pInput.identity_info[' + %'i'% + '].RecentAddress.County;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_PrimaryAddressType := pInput.identity_info[' + %'i'% + '].PrimaryAddressType;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_RecordType := pInput.identity_info[' + %'i'% + '].RecordType;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_FirstSeenWithPrimaryPhone := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].FirstSeenWithPrimaryPhone);\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_LastSeenWithPrimaryPhone := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].LastSeenWithPrimaryPhone);\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_TimeWithPrimaryPhone := pInput.identity_info[' + %'i'% + '].TimeWithPrimaryPhone;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_TimeSinceLastSeenWithPrimaryPhone := pInput.identity_info[' + %'i'% + '].TimeSinceLastSeenWithPrimaryPhone;\n')
          #APPEND(IdentityInfo, 'SELF.Identity' + %'i'% + '_PhoneOwnershipIndicator := pInput.identity_info[' + %'i'% + '].PhoneOwnershipIndicator;\n')

          #SET(i, %i% + 1)
        #END
      #END

    #ELSE
      #LOOP
        #IF(%i% > iesp.Constants.Phone_Finder.MaxPhoneHistory)
          #BREAK
        #ELSE
          // Loop for populating the phone history section
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_Full := pInput.identity_info[' + %'i'% + '].Name.Full;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_First := pInput.identity_info[' + %'i'% + '].Name.First;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_Middle := pInput.identity_info[' + %'i'% + '].Name.Middle;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_Last := pInput.identity_info[' + %'i'% + '].Name.Last;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_Suffix := pInput.identity_info[' + %'i'% + '].Name.Suffix;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_StreetNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetNumber;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_StreetPreDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPreDirection;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_StreetName := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetName;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_StreetSuffix := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetSuffix;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_StreetPostDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPostDirection;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_UnitDesignation := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitDesignation;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_UnitNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitNumber;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_City := pInput.identity_info[' + %'i'% + '].RecentAddress.City;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_State := pInput.identity_info[' + %'i'% + '].RecentAddress.State;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_Zip5 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip5;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_Zip4 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip4;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_County := pInput.identity_info[' + %'i'% + '].RecentAddress.County;\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_FirstSeen := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].FirstSeenWithPrimaryPhone);\n')
          #APPEND(IdentityInfo, 'SELF.PhoneHist' + %'i'% + '_LastSeen := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].LastSeenWithPrimaryPhone);\n')

          #SET(i, %i% + 1)
        #END
      #END

      // Loop for populating other phones section
      #LOOP
        #IF(%j% > iesp.Constants.Phone_Finder.MaxOtherPhones)
          #BREAK
        #ELSE
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneNumber := pInput.other_phones[' + %'j'% + '].Number;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneType := pInput.other_phones[' + %'j'% + ']._Type;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Carrier := pInput.other_phones[' + %'j'% + '].Carrier;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_CarrierCity := pInput.other_phones[' + %'j'% + '].CarrierCity;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_CarrierState := pInput.other_phones[' + %'j'% + '].CarrierState;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneStatus := pInput.other_phones[' + %'j'% + '].PhoneStatus;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Source := pInput.other_phones[' + %'j'% + '].Source;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PortCode := pInput.other_phones[' + %'j'% + '].PortingCode;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneRiskIndicator := pInput.other_phones[' + %'j'% + '].PhoneRiskIndicator;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_OTPRIFailed := pInput.other_phones[' + %'j'% + '].OTPRIFailed;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_LastPortedDate := iesp.ECL2ESP.t_DateToString8(pInput.other_phones[' + %'j'% + '].LastPortedDate);\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_ListingName := pInput.other_phones[' + %'j'% + '].ListingName;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetNumber := pInput.other_phones[' + %'j'% + '].Address.StreetNumber;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetPreDirection := pInput.other_phones[' + %'j'% + '].Address.StreetPreDirection;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetName := pInput.other_phones[' + %'j'% + '].Address.StreetName;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetSuffix := pInput.other_phones[' + %'j'% + '].Address.StreetSuffix;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetPostDirection := pInput.other_phones[' + %'j'% + '].Address.StreetPostDirection;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_UnitDesignation := pInput.other_phones[' + %'j'% + '].Address.UnitDesignation;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_UnitNumber := pInput.other_phones[' + %'j'% + '].Address.UnitNumber;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_City := pInput.other_phones[' + %'j'% + '].Address.City;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_State := pInput.other_phones[' + %'j'% + '].Address.State;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Zip5 := pInput.other_phones[' + %'j'% + '].Address.Zip5;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Zip4 := pInput.other_phones[' + %'j'% + '].Address.Zip4;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_County := pInput.other_phones[' + %'j'% + '].Address.County;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_DateFirstSeen := iesp.ECL2ESP.t_DateToString8(pInput.other_phones[' + %'j'% + '].DateFirstSeen);\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_DateLastSeen := iesp.ECL2ESP.t_DateToString8(pInput.other_phones[' + %'j'% + '].DateLastSeen);\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_MonthsWithPhone := pInput.other_phones[' + %'j'% + '].MonthsWithPhone;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_MonthsSinceLastSeen := pInput.other_phones[' + %'j'% + '].MonthsSinceLastSeen;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneOwnershipIndicator := pInput.other_phones[' + %'j'% + '].PhoneOwnershipIndicator;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_CallForwardingIndicator := pInput.other_phones[' + %'j'% + '].CallForwardingIndicator;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneStarRating := pInput.other_phones[' + %'j'% + '].PhoneStarRating;\n')
          #SET(j, %j% + 1)
        #END
      #END

    #END

    #LOOP
      #IF(%p% > iesp.Constants.Phone_Finder.MaxPorts)
        #BREAK
      #ELSE
        // Loop for populating the porting history section
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_ServiceProvider := pInput.phone_info.PortingHistory[' + %'p'% + '].ServiceProvider;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_PortStartDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.PortingHistory[' + %'p'% + '].PortStartDate);\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_PortEndDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.PortingHistory[' + %'p'% + '].PortEndDate);\n')
        // Added next 13 lines for 2021-06-02 Phone Porting Data for LE project
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_ServiceProviderId := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.ServiceProviderInfo.Id;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_ServiceProviderCompany := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.ServiceProviderInfo.Company;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_ServiceProviderContact := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.ServiceProviderInfo.Contact;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_ServiceProviderContactPhone := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.ServiceProviderInfo.ContactPhone;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_DateOfChange := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.DateOfChange);\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_AltServiceProviderId := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.AltServiceProviderInfo.Id;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_AltServiceProviderCompany := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.AltServiceProviderInfo.Company;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_AltServiceProviderContact := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.AltServiceProviderInfo.Contact;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_AltServiceProviderContactPhone := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.AltServiceProviderInfo.ContactPhone;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_LastAltServiceProviderId := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.LastAltServiceProviderInfo.Id;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_LastAltServiceProviderCompany := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.LastAltServiceProviderInfo.Company;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_LastAltServiceProviderContact := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.LastAltServiceProviderInfo.Contact;\n')
        #APPEND(PortingHistory, 'SELF.PortingHistory' + %'p'% + '_LastAltServiceProviderContactPhone := pInput.phone_info.PortingHistory[' + %'p'% + '].PortValidationInfo.LastAltServiceProviderInfo.ContactPhone;\n')
        #SET(p, %p% + 1)
      #END
    #END

    #LOOP
      #IF(%s% > iesp.Constants.Phone_Finder.MaxSpoofs)
        #BREAK
      #ELSE
        // Loop for populating the Spoofing history section
        #APPEND(SpoofingHistory, 'SELF.SpoofingHistory' + %'s'% + '_PhoneOrigin := pInput.phone_info.SpoofingData.SpoofingHistory[' + %'s'% + '].PhoneOrigin;\n')
        #APPEND(SpoofingHistory, 'SELF.SpoofingHistory' + %'s'% + '_EventDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.SpoofingData.SpoofingHistory[' + %'s'% + '].EventDate);\n')

        #SET(s, %s% + 1)
      #END
    #END

    #LOOP
      #IF(%o% > PhoneFinder_Services.Constants.MaxOTPBatch)
        #BREAK
      #ELSE
        // Loop for populating the OTP history section
        #APPEND(OTPHistory, 'SELF.OTPHistory' + %'o'% + '_OTPStatus := pInput.phone_info.OneTimePassword.OTPHistory[' + %'o'% + '].OTPStatus;\n')
        #APPEND(OTPHistory, 'SELF.OTPHistory' + %'o'% + '_EventDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.OneTimePassword.OTPHistory[' + %'o'% + '].EventDate);\n')

        #SET(o, %o% + 1)
      #END
    #END

    #LOOP
      #IF(%a% > PhoneFinder_Services.Constants.MaxAlertCategories)
        #BREAK
      #ELSE
        // Loop for populating the Spoofing history section
        #APPEND(Alerts, 'SELF.Alerts' + %'a'% + '_Flag := pInput.phone_info.Alerts[' + %'a'% + '].Flag;\n')
        #APPEND(Alerts, 'SELF.Alerts' + %'a'% + '_Messages := pInput.phone_info.Alerts[' + %'a'% + '].Messages[1].value + \n'+
                                                            'pInput.phone_info.Alerts[' + %'a'% + '].Messages[2].value + \n'+
                                                            'pInput.phone_info.Alerts[' + %'a'% + '].Messages[3].value + \n'+
                                                            'pInput.phone_info.Alerts[' + %'a'% + '].Messages[4].value + \n'+
                                                            'pInput.phone_info.Alerts[' + %'a'% + '].Messages[5].value;\n')
        #SET(a, %a% + 1)
      #END
    #END

    // Convert to batch out layout
    pf.PhoneFinder.BatchOut tFormat2Batch(dFormat2BatchReady pInput) :=
    TRANSFORM
      phoneInfo := pInput.phone_info;
      porting		:= phoneInfo.PortingHistory;
      spoofing	:= phoneInfo.SpoofingData;
      ocInfo    := phoneInfo.OperatingCompany;

      %IdentityInfo%
      #IF(~isPhoneSearch)
        SELF.Identity1_DID                               := pInput.primary_identity.UniqueID;
        SELF.Identity1_Full                              := pInput.primary_identity.Name.Full;
        SELF.Identity1_First                             := pInput.primary_identity.Name.First;
        SELF.Identity1_Middle                            := pInput.primary_identity.Name.Middle;
        SELF.Identity1_Last                              := pInput.primary_identity.Name.Last;
        SELF.Identity1_Suffix                            := pInput.primary_identity.Name.Suffix;
        SELF.Identity1_SSN                               := pInput.primary_identity.SSN;
        SELF.Identity1_Deceased                          := pInput.primary_identity.Deceased;
        SELF.Identity1_StreetNumber                      := pInput.primary_identity.RecentAddress.StreetNumber;
        SELF.Identity1_StreetPreDirection                := pInput.primary_identity.RecentAddress.StreetPreDirection;
        SELF.Identity1_StreetName                        := pInput.primary_identity.RecentAddress.StreetName;
        SELF.Identity1_StreetSuffix                      := pInput.primary_identity.RecentAddress.StreetSuffix;
        SELF.Identity1_StreetPostDirection               := pInput.primary_identity.RecentAddress.StreetPostDirection;
        SELF.Identity1_UnitDesignation                   := pInput.primary_identity.RecentAddress.UnitDesignation;
        SELF.Identity1_UnitNumber                        := pInput.primary_identity.RecentAddress.UnitNumber;
        SELF.Identity1_City                              := pInput.primary_identity.RecentAddress.City;
        SELF.Identity1_State                             := pInput.primary_identity.RecentAddress.State;
        SELF.Identity1_Zip5                              := pInput.primary_identity.RecentAddress.Zip5;
        SELF.Identity1_Zip4                              := pInput.primary_identity.RecentAddress.Zip4;
        SELF.Identity1_County                            := pInput.primary_identity.RecentAddress.County;
        SELF.Identity1_PrimaryAddressType                := pInput.primary_identity.PrimaryAddressType;
        SELF.Identity1_RecordType	                       := pInput.primary_identity.RecordType;
        SELF.Identity1_FirstSeenWithPrimaryPhone         := iesp.ECL2ESP.t_DateToString8(pInput.primary_identity.FirstSeenWithPrimaryPhone);
        SELF.Identity1_LastSeenWithPrimaryPhone          := iesp.ECL2ESP.t_DateToString8(pInput.primary_identity.LastSeenWithPrimaryPhone);
        SELF.Identity1_TimeWithPrimaryPhone              := pInput.primary_identity.TimeWithPrimaryPhone;
        SELF.Identity1_TimeSinceLastSeenWithPrimaryPhone := pInput.primary_identity.TimeSinceLastSeenWithPrimaryPhone;
        SELF.Identity1_PhoneOwnershipIndicator           := pInput.primary_identity.PhoneOwnershipIndicator;
        %OtherPhones%
      #END
      %PortingHistory%
      %SpoofingHistory%
      %OTPHistory%
      %Alerts%
      SELF.ContactName_Full                   := ocInfo.ContactName.Full;
      SELF.ContactName_First                  := ocInfo.ContactName.First;
      SELF.ContactName_Middle                 := ocInfo.ContactName.Middle;
      SELF.ContactName_Last                   := ocInfo.ContactName.Last;
      SELF.ContactName_Suffix                 := ocInfo.ContactName.Suffix;
      SELF.ContactName_Prefix                 := ocInfo.ContactName.Prefix;
      SELF.ContactAddress_StreetNumber        := ocInfo.ContactAddress.StreetNumber;
      SELF.ContactAddress_StreetPreDirection  := ocInfo.ContactAddress.StreetPreDirection;
      SELF.ContactAddress_StreetName          := ocInfo.ContactAddress.StreetName;
      SELF.ContactAddress_StreetSuffix        := ocInfo.ContactAddress.StreetSuffix;
      SELF.ContactAddress_StreetPostDirection := ocInfo.ContactAddress.StreetPostDirection;
      SELF.ContactAddress_UnitDesignation     := ocInfo.ContactAddress.UnitDesignation;
      SELF.ContactAddress_UnitNumber          := ocInfo.ContactAddress.UnitNumber;
      SELF.ContactAddress_StreetAddress1      := ocInfo.ContactAddress.StreetAddress1;
      SELF.ContactAddress_StreetAddress2      := ocInfo.ContactAddress.StreetAddress2;
      SELF.ContactAddress_City                := ocInfo.ContactAddress.City;
      SELF.ContactAddress_State               := ocInfo.ContactAddress.State;
      SELF.ContactAddress_Zip5                := ocInfo.ContactAddress.Zip5;
      SELF.ContactAddress_Zip4                := ocInfo.ContactAddress.Zip4;
      SELF.ContactAddress_County              := ocInfo.ContactAddress.County;
      SELF.ContactAddress_PostalCode          := ocInfo.ContactAddress.PostalCode;
      SELF.ContactAddress_StateCityZip        := ocInfo.ContactAddress.StateCityZip;
      SELF.Source                             := IF(~isPhoneSearch, phoneInfo.Source, '');
      SELF.FirstPortedDate                    := iesp.ECL2ESP.DateToInteger(phoneInfo.FirstPortedDate);
      SELF.LastPortedDate                     := iesp.ECL2ESP.DateToInteger(phoneInfo.LastPortedDate);
      SELF.ActivationDate                     := iesp.ECL2ESP.DateToInteger(phoneInfo.ActivationDate);
      SELF.DisconnectDate                     := iesp.ECL2ESP.DateToInteger(phoneInfo.DisconnectDate);
      SELF.Spoof_Spoofed                      := spoofing.Spoof.Spoofed;
      SELF.Spoof_SpoofedCount                 := spoofing.Spoof.SpoofedCount;
      SELF.Spoof_FirstSpoofedDate             := iesp.ECL2ESP.DateToInteger(spoofing.Spoof.FirstSpoofedDate);
      SELF.Spoof_LastSpoofedDate              := iesp.ECL2ESP.DateToInteger(spoofing.Spoof.LastSpoofedDate);
      SELF.Destination_Spoofed                := spoofing.Destination.Spoofed;
      SELF.Destination_SpoofedCount           := spoofing.Destination.SpoofedCount;
      SELF.Destination_FirstSpoofedDate       := iesp.ECL2ESP.DateToInteger(spoofing.Destination.FirstSpoofedDate);
      SELF.Destination_LastSpoofedDate        := iesp.ECL2ESP.DateToInteger(spoofing.Destination.LastSpoofedDate);
      SELF.Source_Spoofed                	    := spoofing.Source.Spoofed;
      SELF.Source_SpoofedCount           	    := spoofing.Source.SpoofedCount;
      SELF.Source_FirstSpoofedDate       	    := iesp.ECL2ESP.DateToInteger(spoofing.Source.FirstSpoofedDate);
      SELF.Source_LastSpoofedDate        	    := iesp.ECL2ESP.DateToInteger(spoofing.Source.LastSpoofedDate);
      SELF.FirstEventSpoofedDate              := iesp.ECL2ESP.DateToInteger(spoofing.FirstEventSpoofedDate);
      SELF.LastEventSpoofedDate               := iesp.ECL2ESP.DateToInteger(spoofing.LastEventSpoofedDate);
      SELF.TotalSpoofedCount                  := spoofing.TotalSpoofedCount;
      SELF.OTPMatch                           := phoneInfo.OneTimePassword.OTP;
      SELF.OTPCount                           := phoneInfo.OneTimePassword.OTPCount;
      SELF.LastOTPStatus                      := phoneInfo.OneTimePassword.LastOTPStatus;
      SELF.FirstOTPDate                       := iesp.ECL2ESP.DateToInteger(phoneInfo.OneTimePassword.FirstOTPDate);
      SELF.LastOTPDate                        := iesp.ECL2ESP.DateToInteger(phoneInfo.OneTimePassword.LastOTPDate);
      SELF.PhoneRiskIndicator                 := phoneInfo.PhoneRiskIndicator;
      SELF.OTPRIFailed                        := phoneInfo.OTPRIFailed;
      SELF.CallForwardingIndicator            := phoneInfo.CallForwardingIndicator;
      SELF.PhoneVerificationDescription       := phoneInfo.VerificationStatus.PhoneVerificationDescription;
      SELF.PhoneVerified                      := phoneInfo.VerificationStatus.PhoneVerified;
      // Added next 13 lines for 2021-06-02 Phone Porting Data for LE project
      SELF.ServiceProvider.id                   := phoneInfo.PortValidationInfo.ServiceProviderInfo.Id;
      SELF.ServiceProvider.company              := phoneInfo.PortValidationInfo.ServiceProviderInfo.Company;
      SELF.ServiceProvider.contact              := phoneInfo.PortValidationInfo.ServiceProviderInfo.Contact;
      SELF.ServiceProvider.contact_phone        := phoneInfo.PortValidationInfo.ServiceProviderInfo.ContactPhone;
      SELF.DateOfChange                         := iesp.ECL2ESP.DateToInteger(phoneInfo.PortValidationInfo.DateofChange); 
      SELF.AltServiceProvider.id                := phoneInfo.PortValidationInfo.AltServiceProviderInfo.Id;
      SELF.AltServiceProvider.company           := phoneInfo.PortValidationInfo.AltServiceProviderInfo.Company;
      SELF.AltServiceProvider.contact           := phoneInfo.PortValidationInfo.AltServiceProviderInfo.Contact;
      SELF.AltServiceProvider.contact_phone     := phoneInfo.PortValidationInfo.AltServiceProviderInfo.ContactPhone;
      SELF.LastAltServiceProvider.id            := phoneInfo.PortValidationInfo.LastAltServiceProviderInfo.Id;
      SELF.LastAltServiceProvider.company       := phoneInfo.PortValidationInfo.LastAltServiceProviderInfo.Company;
      SELF.LastAltServiceProvider.contact       := phoneInfo.PortValidationInfo.LastAltServiceProviderInfo.Contact;
      SELF.LastAltServiceProvider.contact_phone := phoneInfo.PortValidationInfo.LastAltServiceProviderInfo.ContactPhone;
      SELF                                    := phoneInfo.GeoLocation;
      SELF                                    := ocInfo.Address;
      SELF                                    := ocInfo;
      SELF                                    := phoneInfo;
      SELF                                    := spoofing;
      SELF                                    := pInput;
      SELF                                    := [];
    END;

    dFormat2BatchOut := PROJECT(dFormat2BatchReady, tFormat2Batch(LEFT));

    //Debug
    #IF(PhoneFinder_Services.Constants.Debug.Main)
      #IF(isPhoneSearch)
        OUTPUT(dIdentities, NAMED('dIdentities_PhoneSearch'));
        OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo_PhoneSearch'));
        OUTPUT(dPrimaryPhoneInfo, NAMED('dPrimaryPhoneInfo_PhoneSearch'));
        OUTPUT(dIdentityDenorm, NAMED('dIdentityDenorm_PhoneSearch'));
        OUTPUT(dDenormAll, NAMED('dDenormAll_PhoneSearch'));
        OUTPUT(dFormat2BatchReady, NAMED('dFormat2BatchReady_PhoneSearch'));
      #ELSE
        OUTPUT(dIdentities, NAMED('dIdentities_PIISearch'));
        OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo_PIISearch'));
        OUTPUT(dPrimaryIdentity, NAMED('dPrimaryIdentity_PIISearch'));
        OUTPUT(dIdentityDenorm, NAMED('dIdentityDenorm_PIISearch'));
        OUTPUT(dOtherPhoneInfo, NAMED('dOtherPhoneInfo_PIISearch'));
        OUTPUT(dOtherPhonesDenorm, NAMED('dOtherPhonesDenorm_PIISearch'));
        OUTPUT(dPrimaryPhoneInfo, NAMED('dPrimaryPhoneInfo_PIISearch'));
        OUTPUT(dDenormAll, NAMED('dDenormAll_PIISearch'));
        OUTPUT(dFormat2BatchReady, NAMED('dFormat2BatchReady_PIISearch'));
        OUTPUT(dFormat2BatchOut, NAMED('dFormat2BatchOut_PIISearch'));
      #END
    #END

    RETURN dFormat2BatchOut;
  ENDMACRO;
  END;
