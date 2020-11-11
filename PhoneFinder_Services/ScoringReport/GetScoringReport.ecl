       
EXPORT GetScoringReport (dInputReq,
                         ds_config,
                         isPhoneSearch = FALSE) := FUNCTIONMACRO
                      
IMPORT iesp, PhoneFinder_Services, Risk_Indicators;                      
            

RiskRules := PhoneFinder_Services.ScoringReport.GetRiskIndicators();  

iesp.phonefinder.t_PhoneFinderSearchRequest request_format(PhoneFinder_Services.ScoringReport.Layouts.Input_layout dInputReq) := TRANSFORM
    SELF.User.BillingId := '1513012';
    SELF.User.CompanyId := '1513012';
    SELF.Options.IncludePhoneMetadata := true ;
    SELF.Options.UseInHousePhoneMetadata := true ; 
    SELF.Options.IncludeInhousePhones := true ; 
    SELF.Options.IncludeZumigoOptions.NameAddressValidation := false ;    
    SELF.Options.IncludeOtherPhoneRiskIndicators := true;    
    SELF.Options.IncludeRiskIndicators := true;    
    SELF.Options.PrimarySearchCriteria := '';
    SELF.Options.UseDeltabase := true;
    SELF.Options.LineIdentityConsentLevel := 2;
    SELF.Options.MaxResults := 6;
    SELF.User.accountnumber := dInputReq.Account;
    SELF.User.QueryId := dInputReq.Account;//Transaction ID is String 16, this is to get account number in output
    SELF.User.GLBPurpose := ds_config[1].GLBPurpose;
    SELF.User.DLPurpose := ds_config[1].DLPurpose;
    SELF.User.DataRestrictionMask := ds_config[1].DRM;;
    SELF.User.DataPermissionMask  := ds_config[1].DPM;
    // SELF.User.DataPermissionMask  := '1011111111111111111111111111111111111111';// Use for Insurance, Transunion is restricted
    SELF.SearchBy.UniqueId := dInputReq.lexId;
    SELF.Options._Type := ds_config[1].PFType;
    SELF.SearchBy.PhoneNumber := dInputReq.homephone;
    SELF.SearchBy.Name.First :=  dInputReq.First;
    SELF.SearchBy.Name.Middle :=  dInputReq.Middle;
    SELF.SearchBy.Name.Last := dInputReq.last;
    SELF.SearchBy.SSN :=  dInputReq.ssn;
    SELF.SearchBy.Address.StreetAddress1 := dInputReq.StreetAddress;
    SELF.SearchBy.Address.City :=  dInputReq.City;
    SELF.SearchBy.Address.State :=  dInputReq.State;
    SELF.SearchBy.Address.Zip5 :=  dInputReq.Zip;
    SELF.Options.VerificationOptions.VerifyPhoneName := ds_config[1].VerifyPhoneName;  
    SELF.Options.VerificationOptions.VerifyPhoneLastName := ds_config[1].VerifyPhoneLastName;
    SELF.Options.VerificationOptions.VerifyPhoneNameAddress := ds_config[1].VerifyPhoneNameAddress;   
    SELF.Options.RiskIndicators := RiskRules;   
    SELF := [];
END; 

ds_Inreq := PROJECT(dInputReq, request_format(LEFT));

roxieIP  :=  PhoneFinder_Services.ScoringReport.Constants.roxieIP;

dGWIn := PhoneFinder_Services.ScoringReport.GetGateways();

// Wrap request so that we create the root xml reqeust tag

Request_Layout  := RECORD
  DATASET(iesp.phonefinder.t_PhoneFinderSearchRequest) phonefindersearchRequest;
  DATASET(risk_indicators.Layout_Gateways_In) gateways;
  STRING50 account_number;
END;

Request_Layout  tRequest(iesp.phonefinder.t_PhoneFinderSearchRequest Inreq) := TRANSFORM
  SELF.phonefindersearchRequest := Inreq;
  SELF.gateways := dGWIn;
  SELF.account_number := Inreq.User.QueryID;
END;     


dSoapRequest := project(ds_Inreq,tRequest(LEFT));


iesp.phonefinder.t_PhoneFinderSearchResponse myFail(Request_Layout l) := TRANSFORM
  
  SELF._Header.QueryID := l.account_number;
  SELF._Header.Status := failcode;
  SELF._Header.Message := if(failcode=0,'success',failmessage);	
  SELF          :=  [];
END; 
       
dSoapResponse  :=  soapcall(dSoapRequest,
              roxieIP,
              'phonefinder_services.phonefinderreportservice',
              {dSoapRequest},
              DATASET(iesp.phonefinder.t_PhoneFinderSearchResponse),
                            xpath('phonefinder_services.phonefinderreportserviceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
              PARALLEL(30),
              onFail(myFail(LEFT)));
//Layout for flattening multiple rows of Identities and other phones
LOADXML('<xml/>');
    #DECLARE(Identities);
    #DECLARE(cntIdentity);
    #SET(Identities,'');
    #SET(cntIdentity,1);

    #LOOP
      #IF(%cntIdentity% > 6)
        #BREAK;
      #ELSE
        #APPEND(Identities,
                'STRING   Identity' + %'cntIdentity'% + '_DID;' +
                'STRING62 Identity' + %'cntIdentity'% + '_Full;' +
                'STRING20 Identity' + %'cntIdentity'% + '_First;' +
                'STRING20 Identity' + %'cntIdentity'% + '_Middle;' +
                'STRING20 Identity' + %'cntIdentity'% + '_Last;' +
                'STRING5  Identity' + %'cntIdentity'% + '_Suffix;' +
                'STRING1  Identity' + %'cntIdentity'% + '_Deceased;' +
                'STRING10 Identity' + %'cntIdentity'% + '_StreetNumber;' +
                'STRING2  Identity' + %'cntIdentity'% + '_StreetPreDirection;' +
                'STRING28 Identity' + %'cntIdentity'% + '_StreetName;' +
                'STRING4  Identity' + %'cntIdentity'% + '_StreetSuffix;' +
                'STRING2  Identity' + %'cntIdentity'% + '_StreetPostDirection;' +
                'STRING10 Identity' + %'cntIdentity'% + '_UnitDesignation;' +
                'STRING8  Identity' + %'cntIdentity'% + '_UnitNumber;' +
                'STRING25 Identity' + %'cntIdentity'% + '_City;' +
                'STRING2  Identity' + %'cntIdentity'% + '_State;' +
                'STRING5  Identity' + %'cntIdentity'% + '_Zip5;' +
                'STRING4  Identity' + %'cntIdentity'% + '_Zip4;' +
                'STRING18 Identity' + %'cntIdentity'% + '_County;' +
                'STRING40 Identity' + %'cntIdentity'% + '_PrimaryAddressType;' +
                'STRING1  Identity' + %'cntIdentity'% + '_RECORDType;' +
                'STRING8  Identity' + %'cntIdentity'% + '_FirstSeenWithPrimaryPhone;' +
                'STRING8  Identity' + %'cntIdentity'% + '_LastSeenWithPrimaryPhone;' +
                'STRING8  Identity' + %'cntIdentity'% + '_TimeWithPrimaryPhone;' +
                'STRING8  Identity' + %'cntIdentity'% + '_TimeSinceLastSeenWithPrimaryPhone;' +
                'BOOLEAN  Identity' + %'cntIdentity'% + '_PhoneOwnershipIndicator;');
        #SET(cntIdentity,%cntIdentity% + 1)
      #END
    #END

    #DECLARE(OtherPhones);
    #DECLARE(cntPhone);
    #SET(OtherPhones,'');
    #SET(cntPhone,1);

    #LOOP
      #IF(%cntPhone% > 6)
        #BREAK;
      #ELSE
        #APPEND(OtherPhones,
                'STRING OtherPhone' + %'cntPhone'% + '_Number;' +
                'STRING OtherPhone' + %'cntPhone'% + '_Type;' +
                'STRING OtherPhone' + %'cntPhone'% + '_ListingName;' +
                'STRING OtherPhone' + %'cntPhone'% + '_Carrier;' +
                'STRING OtherPhone' + %'cntPhone'% + '_CarrierCity;' +
                'STRING OtherPhone' + %'cntPhone'% + '_CarrierState;' +
                'STRING OtherPhone' + %'cntPhone'% + '_PhoneStatus;' +
                'STRING OtherPhone' + %'cntPhone'% + '_Source;' +
                'STRING OtherPhone' + %'cntPhone'% + '_PhoneRiskIndicator;' +
                'BOOLEAN OtherPhone' + %'cntPhone'% + '_OTPRIFailed;' +
                'STRING10 OtherPhone' + %'cntPhone'% + '_StreetNumber;' +
                'STRING2  OtherPhone' + %'cntPhone'% + '_StreetPreDirection;' +
                'STRING28 OtherPhone' + %'cntPhone'% + '_StreetName;' +
                'STRING4  OtherPhone' + %'cntPhone'% + '_StreetSuffix;' +
                'STRING2  OtherPhone' + %'cntPhone'% + '_StreetPostDirection;' +
                'STRING10 OtherPhone' + %'cntPhone'% + '_UnitDesignation;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_UnitNumber;' +
                'STRING25 OtherPhone' + %'cntPhone'% + '_City;' +
                'STRING2  OtherPhone' + %'cntPhone'% + '_State;' +
                'STRING5  OtherPhone' + %'cntPhone'% + '_Zip5;' +
                'STRING4  OtherPhone' + %'cntPhone'% + '_Zip4;' +
                'STRING18 OtherPhone' + %'cntPhone'% + '_County;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_DateFirstSeen;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_DateLastSeen;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_MonthsWithPhone;' +
                'STRING8  OtherPhone' + %'cntPhone'% + '_MonthsSinceLastSeen;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_PhoneOwnershipIndicator;' +
                'STRING15  OtherPhone' + %'cntPhone'% + '_CallForwardingIndicator;'+
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI1;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI2;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI3;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI5;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI6;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI7;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI8;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI9;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI15;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI16;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI17;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI18;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI19;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI20;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI22;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI23;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI24;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI25;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI26;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI27;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI28;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI29;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI30;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI31;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI32;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI33;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI34;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI35;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI36;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI37;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI38;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI39;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI40;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI41;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI42;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI43;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI44;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI45;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI46;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI47;' +
                'BOOLEAN  OtherPhone' + %'cntPhone'% + '_RI48;');
        #SET(cntPhone,%cntPhone% + 1)
      #END
    #END

Layout_out := RECORD 
INTEGER Status;
STRING256 Message;
STRING50 QueryId;
STRING16 TransactionId;
%Identities%
BOOLEAN  PrimaryPhone_RI1;
BOOLEAN  PrimaryPhone_RI2;
BOOLEAN  PrimaryPhone_RI3;
BOOLEAN  PrimaryPhone_RI5;
BOOLEAN  PrimaryPhone_RI6;
BOOLEAN  PrimaryPhone_RI7;
BOOLEAN  PrimaryPhone_RI8;
BOOLEAN  PrimaryPhone_RI9;
BOOLEAN  PrimaryPhone_RI15;
BOOLEAN  PrimaryPhone_RI16;
BOOLEAN  PrimaryPhone_RI17;
BOOLEAN  PrimaryPhone_RI18;
BOOLEAN  PrimaryPhone_RI19;
BOOLEAN  PrimaryPhone_RI20;
BOOLEAN  PrimaryPhone_RI22;
BOOLEAN  PrimaryPhone_RI23;
BOOLEAN  PrimaryPhone_RI24;
BOOLEAN  PrimaryPhone_RI25;
BOOLEAN  PrimaryPhone_RI26;
BOOLEAN  PrimaryPhone_RI27;
BOOLEAN  PrimaryPhone_RI28;
BOOLEAN  PrimaryPhone_RI29;
BOOLEAN  PrimaryPhone_RI30;
BOOLEAN  PrimaryPhone_RI31;
BOOLEAN  PrimaryPhone_RI32;
BOOLEAN  PrimaryPhone_RI33;
BOOLEAN  PrimaryPhone_RI34;
BOOLEAN  PrimaryPhone_RI35;
BOOLEAN  PrimaryPhone_RI36;
BOOLEAN  PrimaryPhone_RI37;
BOOLEAN  PrimaryPhone_RI38;
BOOLEAN  PrimaryPhone_RI39;
BOOLEAN  PrimaryPhone_RI40;
BOOLEAN  PrimaryPhone_RI41;
BOOLEAN  PrimaryPhone_RI42;
BOOLEAN  PrimaryPhone_RI43;
BOOLEAN  PrimaryPhone_RI44;
BOOLEAN  PrimaryPhone_RI45;
BOOLEAN  PrimaryPhone_RI46;
BOOLEAN  PrimaryPhone_RI47;
BOOLEAN  PrimaryPhone_RI48;
STRING PrimaryPhone;  
STRING PrimaryPhone_Type;  
STRING PrimaryPhone_Carrier;  
STRING PrimaryPhone_Carrier_City;  
STRING PrimaryPhone_Carrier_State;  
STRING PrimaryPhone_Listing_Name;  
STRING PrimaryPhone_Status;  
STRING2 PrimaryPhone_Address_State;
STRING PrimaryPhone_Listing_Type;  
STRING PhoneRiskIndicator;
BOOLEAN OTPRIFailed;
STRING PrimaryPhone_CallForwardingIndicator;
STRING PrimaryPhone_CallerID;
STRING100 PhoneVerificationDescription;
Boolean PhoneVerified; 
%OtherPhones%
STRING PortingHistory_ServiceProvider;
STRING8 PortingHistory_PortStartDate;
STRING8 PortingHistory_PortEndDate;
STRING1 SpoofingHistory_PhoneOrigin;
STRING8 SpoofingHistory_EventDate;
BOOLEAN OTPHistory_OTPStatus;
STRING8 OTPHistory_EventDate;
STRING62 Input_Full;
STRING20 Input_First;
STRING20 Input_Middle;
STRING20 Input_Last;
STRING5 Input_Suffix;
STRING3 Input_Prefix;
STRING10 Input_StreetNumber;
STRING2 Input_StreetPreDirection;
STRING28 Input_StreetName;
STRING4 Input_StreetSuffix;
STRING2 Input_StreetPostDirection;
STRING10 Input_UnitDesignation;
STRING8 Input_UnitNumber;
STRING60 Input_StreetAddress1;
STRING60 Input_StreetAddress2;
STRING25 Input_City;
STRING2 Input_State;
STRING5 Input_Zip5;
STRING4 Input_Zip4;
STRING18 Input_County;
STRING9 Input_PostalCode;
STRING50 Input_StateCityZip;
STRING Input_UniqueId;
STRING Input_SSN;
STRING Input_PhoneNumber;
END;

//Loop for flattening the Identity and otherphone rows
LOADXML('<xml/>');
    #EXPORTXML(dFileMetaInfo, Layout_out)
    #DECLARE(i);
    #DECLARE(j);
    #DECLARE(Identities);
    #DECLARE(OtherPhones);
    #DECLARE(RI_set);
    #SET(i, 1);
    #SET(j, 1);
    #SET(Identities, '');
    #SET(OtherPhones, '');
    #SET(RI_set, '');

#IF(~isPhoneSearch)
#LOOP
   #IF(%j% > 6)
          #BREAK
   #ELSE
          #SET(RI_set, 'SET(pInput.records[1].OtherPhones[' + %'j'% + '].alertindicators, riskid)')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Number := pInput.records[1].OtherPhones[' + %'j'% + '].Number;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI1:= 1 IN '+%'RI_set'%+';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI2:= 2 IN '+%'RI_set'%+';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI3:= 3 IN '+%'RI_set'%+';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI5:= 5 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI6:= 6 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI7:= 7 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI8:=  8 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI9:= 9 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI15:= 15 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI16:= 16 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI17:= 17 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI18:= 18 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI19:= 19 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI20:= 20 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI22:= 22 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI23:= 23 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI24:= 24 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI25:= 25 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI26:= 26 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI27:= 27 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI28:= 28 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI29:= 29 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI30:= 30 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI32:= 32 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI33:= 33 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI34:= 34 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI35:= 35 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI36:= 36 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI37:= 37 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI38:= 38 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI39:= 39 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI40:= 40 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI41:= 41 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI42:= 42 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI43:= 43 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI44:= 44 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI45:= 45 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI46:= 46 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI47:= 47 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_RI48:= 48 IN '+ %'RI_set'% + ';\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Type := pInput.records[1].OtherPhones[' + %'j'% + ']._Type;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Carrier := pInput.records[1].OtherPhones[' + %'j'% + '].Carrier;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_CarrierCity := pInput.records[1].OtherPhones[' + %'j'% + '].CarrierCity;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_CarrierState := pInput.records[1].OtherPhones[' + %'j'% + '].CarrierState;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneStatus := pInput.records[1].OtherPhones[' + %'j'% + '].PhoneStatus;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Source := pInput.records[1].OtherPhones[' + %'j'% + '].Source;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneRiskIndicator := pInput.records[1].OtherPhones[' + %'j'% + '].PhoneRiskIndicator;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_OTPRIFailed := pInput.records[1].OtherPhones[' + %'j'% + '].OTPRIFailed;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_ListingName := pInput.records[1].OtherPhones[' + %'j'% + '].ListingName;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetNumber := pInput.records[1].OtherPhones[' + %'j'% + '].Address.StreetNumber;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetPreDirection := pInput.records[1].OtherPhones[' + %'j'% + '].Address.StreetPreDirection;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetName := pInput.records[1].OtherPhones[' + %'j'% + '].Address.StreetName;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetSuffix := pInput.records[1].OtherPhones[' + %'j'% + '].Address.StreetSuffix;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_StreetPostDirection := pInput.records[1].OtherPhones[' + %'j'% + '].Address.StreetPostDirection;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_UnitDesignation := pInput.records[1].OtherPhones[' + %'j'% + '].Address.UnitDesignation;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_UnitNumber := pInput.records[1].OtherPhones[' + %'j'% + '].Address.UnitNumber;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_City := pInput.records[1].OtherPhones[' + %'j'% + '].Address.City;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_State := pInput.records[1].OtherPhones[' + %'j'% + '].Address.State;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Zip5 := pInput.records[1].OtherPhones[' + %'j'% + '].Address.Zip5;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_Zip4 := pInput.records[1].OtherPhones[' + %'j'% + '].Address.Zip4;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_County := pInput.records[1].OtherPhones[' + %'j'% + '].Address.County;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_DateFirstSeen := iesp.ECL2ESP.DateToString(pInput.records[1].OtherPhones[' + %'j'% + '].DateFirstSeen);\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_DateLastSeen := iesp.ECL2ESP.DateToString(pInput.records[1].OtherPhones[' + %'j'% + '].DateLastSeen);\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_MonthsWithPhone := pInput.records[1].OtherPhones[' + %'j'% + '].MonthsWithPhone;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_MonthsSinceLastSeen := pInput.records[1].OtherPhones[' + %'j'% + '].MonthsSinceLastSeen;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_PhoneOwnershipIndicator := pInput.records[1].OtherPhones[' + %'j'% + '].PhoneOwnershipIndicator;\n')
          #APPEND(OtherPhones, 'SELF.OtherPhone' + %'j'% + '_CallForwardingIndicator := pInput.records[1].OtherPhones[' + %'j'% + '].CallForwardingIndicator;\n')
          #SET(j, %j% + 1)
        #END
      #END
  
#ELSE
     #LOOP
        #IF(%i% > 6)
          #BREAK
        #ELSE
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_DID := pInput.records[1].Identities[' + %'i'% + '].UniqueID;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Full := pInput.records[1].Identities[' + %'i'% + '].Name.Full;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_First := pInput.records[1].Identities[' + %'i'% + '].Name.First;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Middle := pInput.records[1].Identities[' + %'i'% + '].Name.Middle;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Last := pInput.records[1].Identities[' + %'i'% + '].Name.Last;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Suffix := pInput.records[1].Identities[' + %'i'% + '].Name.Suffix;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Deceased := pInput.records[1].Identities[' + %'i'% + '].Deceased;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_StreetNumber := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.StreetNumber;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_StreetPreDirection := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.StreetPreDirection;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_StreetName := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.StreetName;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_StreetSuffix := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.StreetSuffix;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_StreetPostDirection := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.StreetPostDirection;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_UnitDesignation := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.UnitDesignation;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_UnitNumber := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.UnitNumber;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_City := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.City;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_State := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.State;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Zip5 := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.Zip5;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_Zip4 := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.Zip4;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_County := pInput.records[1].Identities[' + %'i'% + '].RecentAddress.County;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_PrimaryAddressType := pInput.records[1].Identities[' + %'i'% + '].PrimaryAddressType;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_RecordType := pInput.records[1].Identities[' + %'i'% + '].RecordType;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_FirstSeenWithPrimaryPhone := iesp.ECL2ESP.DateToString(pInput.records[1].Identities[' + %'i'% + '].FirstSeenWithPrimaryPhone);\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_LastSeenWithPrimaryPhone := iesp.ECL2ESP.DateToString(pInput.records[1].Identities[' + %'i'% + '].LastSeenWithPrimaryPhone);\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_TimeWithPrimaryPhone := pInput.records[1].Identities[' + %'i'% + '].TimeWithPrimaryPhone;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_TimeSinceLastSeenWithPrimaryPhone := pInput.records[1].Identities[' + %'i'% + '].TimeSinceLastSeenWithPrimaryPhone;\n')
          #APPEND(Identities, 'SELF.Identity' + %'i'% + '_PhoneOwnershipIndicator := pInput.records[1].Identities[' + %'i'% + '].PhoneOwnershipIndicator;\n')
          #SET(i, %i% + 1)
        #END
      #END
#END

Layout_out tFormat2CSV(iesp.phonefinder.t_PhoneFinderSearchResponse pInput) := TRANSFORM
      phone_identities := pInput.records[1].identities[1];
      #IF(isPhoneSearch)
        %Identities%  
      #ELSE
       %OtherPhones%
        SELF.Identity1_DID                               := phone_identities.UniqueID;
        SELF.Identity1_Full                              := phone_identities.Name.Full;
        SELF.Identity1_First                             := phone_identities.Name.First;
        SELF.Identity1_Middle                            := phone_identities.Name.Middle;
        SELF.Identity1_Last                              := phone_identities.Name.Last;
        SELF.Identity1_Suffix                            := phone_identities.Name.Suffix;
        SELF.Identity1_Deceased                          := phone_identities.Deceased;
        SELF.Identity1_StreetNumber                      := phone_identities.RecentAddress.StreetNumber;
        SELF.Identity1_StreetPreDirection                := phone_identities.RecentAddress.StreetPreDirection;
        SELF.Identity1_StreetName                        := phone_identities.RecentAddress.StreetName;
        SELF.Identity1_StreetSuffix                      := phone_identities.RecentAddress.StreetSuffix;
        SELF.Identity1_StreetPostDirection               := phone_identities.RecentAddress.StreetPostDirection;
        SELF.Identity1_UnitDesignation                   := phone_identities.RecentAddress.UnitDesignation;
        SELF.Identity1_UnitNumber                        := phone_identities.RecentAddress.UnitNumber;
        SELF.Identity1_City                              := phone_identities.RecentAddress.City;
        SELF.Identity1_State                             := phone_identities.RecentAddress.State;
        SELF.Identity1_Zip5                              := phone_identities.RecentAddress.Zip5;
        SELF.Identity1_Zip4                              := phone_identities.RecentAddress.Zip4;
        SELF.Identity1_County                            := phone_identities.RecentAddress.County;
        SELF.Identity1_PrimaryAddressType                := phone_identities.PrimaryAddressType;
        SELF.Identity1_RecordType                         := phone_identities.RecordType;
        SELF.Identity1_FirstSeenWithPrimaryPhone         := iesp.ECL2ESP.DateToString(phone_identities.FirstSeenWithPrimaryPhone);
        SELF.Identity1_LastSeenWithPrimaryPhone          := iesp.ECL2ESP.DateToString(phone_identities.LastSeenWithPrimaryPhone);
        SELF.Identity1_TimeWithPrimaryPhone              := phone_identities.TimeWithPrimaryPhone;
        SELF.Identity1_TimeSinceLastSeenWithPrimaryPhone := phone_identities.TimeSinceLastSeenWithPrimaryPhone;
        SELF.Identity1_PhoneOwnershipIndicator           := phone_identities.PhoneOwnershipIndicator;
        #END      
        SELF.PrimaryPhone                   := pInput.records[1].primaryphonedetails.Number;
        SELF.PrimaryPhone_Type              := pInput.records[1].primaryphonedetails._Type;
        SELF.PrimaryPhone_Carrier           := pInput.records[1].primaryphonedetails.Carrier;
        SELF.PrimaryPhone_Carrier_City      := pInput.records[1].primaryphonedetails.CarrierCity;
        SELF.PrimaryPhone_Carrier_State     := pInput.records[1].primaryphonedetails.CarrierState;
        SELF.PrimaryPhone_Listing_Name      := pInput.records[1].primaryphonedetails.ListingName;
        SELF.PrimaryPhone_Status            := pInput.records[1].primaryphonedetails.PhoneStatus;
        SELF.PrimaryPhone_Address_State     := pInput.records[1].primaryphonedetails.PhoneAddressState;
        SELF.PrimaryPhone_Listing_Type          := pInput.records[1].primaryphonedetails.ListingType;
        SELF.PhoneRiskIndicator                 := pInput.records[1].primaryphonedetails.PhoneRiskIndicator;
        SELF.PrimaryPhone_CallerID                           := pInput.records[1].primaryphonedetails.CallerID;
        SELF.OTPRIFailed                        := pInput.records[1].primaryphonedetails.OTPRIFailed;
        SELF.PrimaryPhone_CallForwardingIndicator            := pInput.records[1].primaryphonedetails.CallForwardingIndicator;
        SELF.PhoneVerificationDescription       := pInput.records[1].primaryphonedetails.VerificationStatus.PhoneVerificationDescription;
        SELF.PhoneVerified                      := pInput.records[1].primaryphonedetails.VerificationStatus.PhoneVerified;
        latest_porting := SORT(pInput.records[1].primaryphonedetails.PortingHistory, -portenddate);
        SELF.PortingHistory_ServiceProvider := latest_porting[1].serviceprovider;
        SELF.PortingHistory_PortStartDate := iesp.ECL2ESP.DateToString(latest_porting[1].portstartdate);
        SELF.PortingHistory_PortEndDate := iesp.ECL2ESP.DateToString(latest_porting[1].portenddate);
        latest_spoof := SORT(pInput.records[1].primaryphonedetails.spoofingdata.spoofinghistory, -eventdate);
        SELF.SpoofingHistory_PhoneOrigin := latest_spoof[1].phoneorigin;
        SELF.SpoofingHistory_EventDate := iesp.ECL2ESP.DateToString(latest_spoof[1].eventdate);
        latest_otp := SORT(pInput.records[1].primaryphonedetails.onetimepassword.otphistory, -eventdate);
        SELF.OTPHistory_OTPStatus := latest_otp[1].otpstatus;
        SELF.OTPHistory_EventDate := iesp.ECL2ESP.DateToString(latest_otp[1].eventdate);
        SELF.Status := pInput._Header.Status;
        SELF.Message := pInput._Header.Message;
        SELF.QueryId := pInput._Header.QueryId;
        SELF.Input_Full := pInput.InputEcho.name.Full;
        SELF.Input_First := pInput.InputEcho.name.First;
        SELF.Input_Middle := pInput.InputEcho.name.Middle;
        SELF.Input_Last := pInput.InputEcho.name.Last;
        SELF.Input_Suffix := pInput.InputEcho.name.Suffix;
        SELF.Input_Prefix := pInput.InputEcho.name.Prefix;
        SELF.Input_StreetNumber := pInput.InputEcho.address.StreetNumber;
        SELF.Input_StreetPreDirection := pInput.InputEcho.address.StreetPreDirection;
        SELF.Input_StreetName := pInput.InputEcho.address.StreetName;
        SELF.Input_StreetSuffix := pInput.InputEcho.address.StreetSuffix;
        SELF.Input_StreetPostDirection := pInput.InputEcho.address.StreetPostDirection;
        SELF.Input_UnitDesignation := pInput.InputEcho.address.UnitDesignation;
        SELF.Input_UnitNumber := pInput.InputEcho.address.UnitNumber;
        SELF.Input_StreetAddress1 := pInput.InputEcho.address.StreetAddress1;
        SELF.Input_StreetAddress2 := pInput.InputEcho.address.StreetAddress2;
        SELF.Input_City := pInput.InputEcho.address.City;
        SELF.Input_State := pInput.InputEcho.address.State;
        SELF.Input_Zip5 := pInput.InputEcho.address.Zip5;
        SELF.Input_Zip4 := pInput.InputEcho.address.Zip4;
        SELF.Input_County := pInput.InputEcho.address.County;
        SELF.Input_PostalCode := pInput.InputEcho.address.PostalCode;
        SELF.Input_StateCityZip := pInput.InputEcho.address.StateCityZip;
        SELF.Input_UniqueId := pInput.InputEcho.UniqueId;
        SELF.Input_SSN := pInput.InputEcho.SSN;
        SELF.Input_PhoneNumber := pInput.InputEcho.PhoneNumber;
				RI_set := SET(pInput.records[1].primaryphonedetails.alertindicators, riskid);
        SELF.PrimaryPhone_RI1:= 1 IN RI_set;
        SELF.PrimaryPhone_RI2:= 2 IN RI_set;;
        SELF.PrimaryPhone_RI3:= 3 IN RI_set;
        SELF.PrimaryPhone_RI5:=5 IN RI_set;
        SELF.PrimaryPhone_RI6:=6 IN RI_set;
        SELF.PrimaryPhone_RI7:=7 IN RI_set;
        SELF.PrimaryPhone_RI8:=8 IN RI_set;
        SELF.PrimaryPhone_RI9:= 9 IN RI_set;
        SELF.PrimaryPhone_RI15:= 15 IN RI_set;
        SELF.PrimaryPhone_RI16:= 16 IN RI_set;
        SELF.PrimaryPhone_RI17:= 17 IN RI_set;
        SELF.PrimaryPhone_RI18:= 18 IN RI_set;
        SELF.PrimaryPhone_RI19:= 19 IN RI_set;
        SELF.PrimaryPhone_RI20:= 20 IN RI_set;
        SELF.PrimaryPhone_RI22:= 22 IN RI_set;
        SELF.PrimaryPhone_RI23:= 23 IN RI_set;
        SELF.PrimaryPhone_RI24:= 24 IN RI_set;
        SELF.PrimaryPhone_RI25:= 25 IN RI_set;
        SELF.PrimaryPhone_RI26:= 26 IN RI_set;
        SELF.PrimaryPhone_RI27:= 27 IN RI_set;
        SELF.PrimaryPhone_RI28:= 28 IN RI_set;
        SELF.PrimaryPhone_RI29:= 29 IN RI_set;
        SELF.PrimaryPhone_RI30:= 30 IN RI_set;
        SELF.PrimaryPhone_RI31:= 31 IN RI_set;
        SELF.PrimaryPhone_RI32:= 32 IN RI_set;
        SELF.PrimaryPhone_RI33:= 33 IN RI_set;
        SELF.PrimaryPhone_RI34:= 34 IN RI_set;
        SELF.PrimaryPhone_RI35:= 35 IN RI_set;
        SELF.PrimaryPhone_RI36:= 36 IN RI_set;
        SELF.PrimaryPhone_RI37:= 37 IN RI_set;
        SELF.PrimaryPhone_RI38:= 38 IN RI_set;
        SELF.PrimaryPhone_RI39:= 39 IN RI_set;
        SELF.PrimaryPhone_RI40:= 40 IN RI_set;
        SELF.PrimaryPhone_RI41:= 41 IN RI_set;
        SELF.PrimaryPhone_RI42:= 42 IN RI_set;
        SELF.PrimaryPhone_RI43:= 43 IN RI_set;
        SELF.PrimaryPhone_RI44:= 44 IN RI_set;
        SELF.PrimaryPhone_RI45:= 45 IN RI_set;
        SELF.PrimaryPhone_RI46:= 46 IN RI_set;
        SELF.PrimaryPhone_RI47:= 47 IN RI_set;
        SELF.PrimaryPhone_RI48:= 48 IN RI_set;
        SELF                                    := [];
END;                            

dFormat2Out := PROJECT(dSoapResponse, tFormat2CSV(LEFT));  

RETURN dFormat2Out; 
ENDMACRO;  
