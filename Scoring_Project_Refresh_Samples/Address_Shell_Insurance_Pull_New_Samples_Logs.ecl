// EXPORT Address_Shell_Insurance_Pull_New_Samples_Logs := 'todo';
// oldfile := '~scoring_project::in::address_shell_batch_20151022';
oldfile := '~scoring_project::in::address_shell_batch_20170330';
fileout := '~bbraaten::test::address_shell_test';

		import _control, zz_bbraaten, Insurance_iesp, InsuranceContext_iesp, Scoring_Project_Macros, ut;
t_scoreservereditsrecord := RECORD
    string value{xpath(''), maxlength(230)};
   END;

t_scoreserverrequest := RECORD
   DATASET(t_scoreservereditsrecord) records{xpath('Records/Record'), maxcount(3000)};
  END;

t_commoninformation := RECORD
     string14 referencenumber{xpath('ReferenceNumber')};
     string16 transactionid{xpath('TransactionId')};
     string1 operationmode{xpath('OperationMode')};
     string9 customernodeid{xpath('CustomerNodeId')};
     string20 clientid{xpath('ClientId')};
     boolean unrecognizedrecsfound{xpath('UnrecognizedRecsFound')};
     real8 clientversion{xpath('ClientVersion')};
    END;

t_legacyaccount := RECORD
      string6 base{xpath('Base')};
      string3 suffix{xpath('Suffix')};
     END;

t_commonaccountinformation := RECORD
     string11 mbsid{xpath('MBSId')};
     string40 name{xpath('Name')};
     string100 displayname{xpath('DisplayName')};
     string2 accounttype{xpath('AccountType')};
     string11 companyid{xpath('CompanyId')};
     string1 status{xpath('Status')};
     string34 addressline1{xpath('AddressLine1')};
     string34 addressline2{xpath('AddressLine2')};
     string20 city{xpath('City')};
     string2 state{xpath('State')};
     string5 zip{xpath('Zip')};
     string4 zip4{xpath('Zip4')};
     string15 roxiequeryversion{xpath('RoxieQueryVersion')};
     t_legacyaccount legacy{xpath('Legacy')};
    END;

t_gateway := RECORD
     string40 servicename{xpath('ServiceName')};
     string300 url{xpath('URL')};
    END;

t_dmfinformation := RECORD
     string1 dmfflag{xpath('DMFFlag')};
     string20 dmflist{xpath('DMFList')};
    END;

record__3 := RECORD
    t_commoninformation common{xpath('Common')};
    t_commonaccountinformation account{xpath('Account')};
    DATASET(t_gateway) gateways{xpath('Gateways/Gateway'), maxcount(45)};
    t_dmfinformation dmfinfo{xpath('DMFInfo')};
   END;
record__11 := RECORD
      string40 customername{xpath('CustomerName')};
      string11 customernumber{xpath('CustomerNumber')};
      string1 status{xpath('Status')};
     END;
t_stringarrayitem := RECORD
       string value{xpath(''), maxlength(8192)};
      END;

t_insurancescoremodel := RECORD
      string modelid{xpath('ModelId')};
      string status{xpath('Status')};
      string purposecode{xpath('PurposeCode')};
      DATASET(t_stringarrayitem) attributenames{xpath('AttributeNames/AttributeName'), maxcount(10)};
     END;

t_issinformation := RECORD(record__11)
     string ccfcallowed{xpath('CCFCAllowed')};
     string cdscallowed{xpath('CDSCAllowed')};
     DATASET(t_insurancescoremodel) scoremodels{xpath('ScoreModels/ScoreModel'), maxcount(10)};
    END;

t_opaccountclue := RECORD
      boolean accountvalid{xpath('AccountValid')};
      boolean srcnodevalidated{xpath('SrcNodeValidated')};
      string9 accountnumber{xpath('AccountNumber')};
      string100 accountname{xpath('AccountName')};
      string40 customername{xpath('CustomerName')};
      string11 customernumber{xpath('CustomerNumber')};
      string20 returnnode{xpath('ReturnNode')};
      string1 status{xpath('Status')};
     END;

t_clueclaimtype := RECORD
       string5 _type{xpath('Type')};
       string11 amount{xpath('Amount')};
      END;

t_totalclaimthresholdamount := RECORD
      string11 claimamount{xpath('ClaimAmount')};
      DATASET(t_clueclaimtype) claimtypes{xpath('ClaimTypes/ClaimType'), maxcount(37)};
     END;

t_clueautoinformation := RECORD
     t_opaccountclue opaccount{xpath('OPAccount')};
     string1 billas{xpath('BillAS')};
     string1 reportas{xpath('ReportAS')};
     string1 firstpaymentdate{xpath('FirstPaymentDate')};
     string1 returnformat{xpath('ReturnFormat')};
     string1 vindcode{xpath('VINDCode')};
     string3 secondreportthresholddays{xpath('SecondReportThresholdDays')};
     string1 priorinquiry{xpath('PriorInquiry')};
     string2 returnoption{xpath('ReturnOption')};
     string1 typeofbilling{xpath('TypeOfBilling')};
     string1 customatfault{xpath('CustomAtFault')};
     string1 safescan{xpath('SafeScan')};
     string1 onlineflag{xpath('OnlineFlag')};
     string2 clmthresholdreportage{xpath('ClmThresholdReportAge')};
     string1 hovallowed{xpath('HOVAllowed')};
     string1 splbillingidusuage{xpath('SplBillingIDUsuage')};
     string1 clmthresholdreportopt{xpath('ClmThresholdReportOpt')};
     string1 indatfault{xpath('IndAtFault')};
     string2 prcthresholdreportage{xpath('PRCThresholdReportAge')};
     string11 nodeversion{xpath('NodeVersion')};
     string1 addallowed{xpath('ADDAllowed')};
     string1 yddallowed{xpath('YDDAllowed')};
     t_totalclaimthresholdamount totalclaimthresholdamt{xpath('TotalClaimThresholdAmt')};
    END;

t_ddaffidavitid := RECORD
      string2 statecode{xpath('StateCode')};
      string2 flagonfile{xpath('FlagOnFile')};
      string2 marketcode{xpath('MarketCode')};
      string11 accountid{xpath('AccountId')};
      string11 customerid{xpath('CustomerId')};
     END;

t_cluepropertyinformation := RECORD
     t_opaccountclue opaccount{xpath('OPAccount')};
     string1 clmthresholdreportopt{xpath('ClmThresholdReportOpt')};
     string2 clmthresholdreportage{xpath('ClmThresholdReportAge')};
     string3 secondreportthresholddays{xpath('SecondReportThresholdDays')};
     string1 scopetype{xpath('ScopeType')};
     string1 riskaddress{xpath('RiskAddress')};
     string1 identityplus{xpath('IdentityPlus')};
     string1 reportas{xpath('ReportAS')};
     string1 returnformat{xpath('ReturnFormat')};
     string2 handlingreturnopt{xpath('HandlingReturnOpt')};
     string1 accountclass{xpath('AccountClass')};
     string1 onlinevalues{xpath('OnLineValues')};
     string1 priorinquiry{xpath('PriorInquiry')};
     string1 typeofbilling{xpath('TypeOfBilling')};
     string1 excludecwopoption{xpath('ExcludeCWOPOption')};
     string1 splbillingidusuage{xpath('SplBillingIDUsuage')};
     string1 realpropallowed{xpath('RealPropAllowed')};
     t_totalclaimthresholdamount totalclaimthresholdamt{xpath('TotalClaimThresholdAmt')};
     DATASET(t_ddaffidavitid) affidavitids{xpath('AffidavitIds/AffidavitId'), maxcount(51)};
    END;

t_cluecommercialaccountrecord := RECORD
      string accountid{xpath('AccountId')};
      string accountbase{xpath('AccountBase')};
      string accountsuffix{xpath('AccountSuffix')};
      string accountconfigid{xpath('AccountConfigId')};
      string customerid{xpath('CustomerId')};
      string status{xpath('Status')};
      string rptascode{xpath('RptAsCode')};
      string billascode{xpath('BillAsCode')};
      string indordertype{xpath('IndOrderType')};
      string losssummaryrptmonths{xpath('LossSummaryRptMonths')};
      string indposting{xpath('IndPosting')};
      string openclaimsrptmonths{xpath('OpenClaimsRptMonths')};
      string indbiallowed{xpath('IndBiAllowed')};
      string returnnode{xpath('ReturnNode')};
      string driverrptmonths{xpath('DriverRptMonths')};
      string flgcontributorlist{xpath('FlgContributorList')};
     END;

t_cluecommercialcustomerrecord := RECORD
      string customerid{xpath('CustomerId')};
      string customername{xpath('CustomerName')};
      string status{xpath('Status')};
      string indcontributeplayfield{xpath('IndContributePlayfield')};
      string secondrpt{xpath('SecondRpt')};
      string secondrptdays{xpath('SecondRptDays')};
      string customerscorepct{xpath('CustomerScorePct')};
      string indreporttype{xpath('IndReportType')};
      string driversearch{xpath('DriverSearch')};
     END;

t_cluecommercialbusinessrecord := RECORD
      string customerid{xpath('CustomerId')};
      string status{xpath('Status')};
      string customerbusinesslineid{xpath('CustomerBusinessLineId')};
      DATASET(t_stringarrayitem) indlinebizcontributed{xpath('IndLinebizContributed/LineOfBusiness'), maxcount(4)};
     END;

t_cluecommercialproductset := RECORD
     t_cluecommercialaccountrecord accountsettings{xpath('AccountSettings')};
     t_cluecommercialcustomerrecord customersettings{xpath('CustomerSettings')};
     t_cluecommercialbusinessrecord businesssettings{xpath('BusinessSettings')};
    END;

t_opaccountstruct := RECORD
      boolean accountvalid{xpath('AccountValid')};
      boolean srcnodevalidated{xpath('SrcNodeValidated')};
      string100 accountname{xpath('AccountName')};
      string40 customername{xpath('CustomerName')};
      string11 customernumber{xpath('CustomerNumber')};
      string9 companynumber{xpath('CompanyNumber')};
      string1 status{xpath('Status')};
      string20 returnnode{xpath('ReturnNode')};
     END;

t_cdscautoinformation := RECORD
     t_opaccountstruct opaccount{xpath('OPAccount')};
     string1 reportas{xpath('ReportAS')};
     string1 riskprofile{xpath('RiskProfile')};
     string1 priorinquiry{xpath('PriorInquiry')};
     string1 vindcode{xpath('VINDCode')};
     string1 safescan{xpath('SafeScan')};
     string1 hovallowed{xpath('HOVAllowed')};
     string1 cdscaddflag{xpath('CDSCAddFlag')};
     string2 returnoption{xpath('ReturnOption')};
     string1 returnformat{xpath('ReturnFormat')};
     string1 firstpaymentdate{xpath('FirstPaymentDate')};
     string1 developedlic{xpath('DevelopedLic')};
     string1 reportoption{xpath('ReportOption')};
     string3 reportage{xpath('ReportAge')};
     string1 autostatus{xpath('AutoStatus')};
     string1 contributortype{xpath('ContributorType')};
    END;

t_cdscpropertyinformation := RECORD
     t_opaccountstruct opaccount{xpath('OPAccount')};
     string1 reportas{xpath('ReportAS')};
     string1 returnformat{xpath('ReturnFormat')};
     string1 scopetype{xpath('ScopeType')};
     string1 priorinquiry{xpath('PriorInquiry')};
     string1 identityplus{xpath('IdentityPlus')};
     string1 riskaddress{xpath('RiskAddress')};
     string2 propertyallowed{xpath('PropertyAllowed')};
     string1 reportoption{xpath('ReportOption')};
     string3 reportage{xpath('ReportAge')};
     string1 excludecwopoption{xpath('ExcludeCWOPOption')};
     string1 propstatus{xpath('PropStatus')};
     string1 contributortype{xpath('ContributorType')};
     DATASET(t_ddaffidavitid) affidavitids{xpath('AffidavitIds/AffidavitId'), maxcount(51)};
    END;

t_ncfvendorequifax := RECORD
       string40 membercodedecrypted{xpath('MemberCodeDecrypted')};
       string40 membercode{xpath('MemberCode')};
       string40 securitycode{xpath('SecurityCode')};
       string40 customercode{xpath('CustomerCode')};
       string2 beacon{xpath('Beacon')};
       string2 safescan{xpath('SafeScan')};
       string2 generalrisk{xpath('GeneralRisk')};
       string10 riskmodel{xpath('RiskModel')};
       string10 equifaxeucode{xpath('EquifaxEUCode')};
       string80 encryptkeyname{xpath('EncryptKeyName')};
       string10 eqxpermpurpose{xpath('EqxPermPurpose')};
      END;

t_ncfvendortransunion := RECORD
       string40 membercodedecrypted{xpath('MemberCodeDecrypted')};
       string40 membercode{xpath('MemberCode')};
       string40 password{xpath('Password')};
       string40 bureaumarket{xpath('BureauMarket')};
       string40 bureausubmarket{xpath('BureauSubMarket')};
       string40 industrycode{xpath('IndustryCode')};
       string10 hawk{xpath('Hawk')};
       string10 empirica{xpath('Empirica')};
       string80 encryptkeyname{xpath('EncryptKeyName')};
       string10 tupermpurpose{xpath('TUPermPurpose')};
       string2 instandid{xpath('InstandId')};
      END;

t_ncfvendorexperian := RECORD
       string40 preamble{xpath('Preamble')};
       string40 subscribernumberdecrypted{xpath('SubscriberNumberDecrypted')};
       string40 subscribernumber{xpath('SubscriberNumber')};
       string40 password{xpath('Password')};
       string20 fairissacmodel{xpath('FairIssacModel')};
       string10 facs{xpath('Facs')};
       string10 experianeucode{xpath('ExperianEUCode')};
       string80 encryptkeyname{xpath('EncryptKeyName')};
       string10 exppermpurpose{xpath('ExpPermPurpose')};
      END;

t_ncfindicator := RECORD
       string2 scoreinddefault{xpath('ScoreIndDefault')};
       string2 servicetype{xpath('ServiceType')};
       string2 individual{xpath('Individual')};
       string2 ordertype{xpath('OrderType')};
       string2 returnsearchdata{xpath('ReturnSearchData')};
       string2 updateopr{xpath('UpdateOPR')};
       string2 employmentacct{xpath('EmploymentAcct')};
       string2 statespecific{xpath('StateSpecific')};
       string2 stateexception{xpath('StateException')};
       string2 bypassdupecheck{xpath('ByPassDupeCheck')};
       string2 dupecheck{xpath('DupeCheck')};
       string2 expandreasoncodes{xpath('ExpandReasonCodes')};
       string2 suppressssn{xpath('SuppressSSN')};
       string2 testprod{xpath('TestProd')};
      END;

t_ncfmodelcombo := RECORD
          string comboid{xpath(''), maxlength(4)};
         END;

t_ncfstateexception := RECORD
          string statecode{xpath(''), maxlength(2)};
         END;

t_ncfscoremodel := RECORD
         string40 code{xpath('Code')};
         string4 version{xpath('Version')};
         DATASET(t_ncfmodelcombo) modelcombos{xpath('ModelCombos/ComboId'), maxcount(10)};
         DATASET(t_ncfstateexception) stateexceptions{xpath('StateExceptions/StateCode'), maxcount(5)};
        END;

t_ncfscoremodelconfig := RECORD
        string1 vendorcode{xpath('VendorCode')};
        t_ncfscoremodel scoremodel{xpath('ScoreModel')};
       END;

t_ncfswitchmodelconfig := RECORD
       string2 scoreind{xpath('ScoreInd')};
       string2 flagautoswitch{xpath('FlagAutoSwitch')};
       string4 flagswitchpath{xpath('FlagSwitchPath')};
       DATASET(t_ncfscoremodelconfig) scoremodelconfigs{xpath('ScoreModelConfigs/ScoreModelConfig'), maxcount(70)};
      END;

t_ncfreportsection := RECORD
       string40 sectionname{xpath('SectionName')};
       string1 sectionstatus{xpath('SectionStatus')};
      END;

t_ncfaccountfeatures := RECORD
      string1 billingtypeid{xpath('BillingTypeId')};
      string32 inactiveindicator{xpath('InactiveIndicator')};
      string11 typeofbusiness{xpath('TypeOfBusiness')};
      t_ncfvendorequifax vendorequifax{xpath('VendorEquifax')};
      t_ncfvendortransunion vendortransunion{xpath('VendorTransunion')};
      t_ncfvendorexperian vendorexperian{xpath('VendorExperian')};
      t_ncfindicator indicator{xpath('Indicator')};
      integer1 dupethresholddays{xpath('DupeThresholdDays')};
      string1 dupesamedaycount{xpath('DupeSameDayCount')};
      string30 moduleruleplan{xpath('ModuleRulePlan')};
      string30 modulereformat{xpath('ModuleReformat')};
      string3 lienjudgementindicator{xpath('LienJudgementIndicator')};
      DATASET(t_ncfswitchmodelconfig) switchmodelconfigs{xpath('SwitchModelConfigs/SwitchModelConfig'), maxcount(99)};
      DATASET(t_ncfreportsection) reportsections{xpath('ReportSections/ReportSection'), maxcount(15)};
     END;

t_ncfcompanyfeatures := RECORD
      string2 dupe{xpath('Dupe')};
      string2 compid{xpath('CompId')};
      string2 payh{xpath('Payh')};
      string2 vamd{xpath('Vamd')};
      string2 tuin{xpath('Tuin')};
      string2 pfee{xpath('Pfee')};
     END;

t_ncfagencyfeature := RECORD
      string11 accountid{xpath('AccountId')};
      string11 accountnumber{xpath('AccountNumber')};
      string100 accountname{xpath('AccountName')};
      string100 displayname{xpath('DisplayName')};
      string2 accounttype{xpath('AccountType')};
      string11 companyid{xpath('CompanyId')};
      string1 status{xpath('Status')};
     END;

t_ncfcarrierscores := RECORD
       string11 carrieracctid{xpath('CarrierAcctId')};
       string11 accountnumber{xpath('AccountNumber')};
       string11 modelid{xpath('ModelId')};
       string40 modelcode{xpath('ModelCode')};
       string1 modelversion{xpath('ModelVersion')};
      END;

t_ncfcarrierfeatures := RECORD
      string11 carriercustnumber{xpath('CarrierCustNumber')};
      string40 carriercustname{xpath('CarrierCustName')};
      string100 accountname{xpath('AccountName')};
      string11 accountnumber{xpath('AccountNumber')};
      string1 carrierstatus{xpath('CarrierStatus')};
      string40 subscribernumber{xpath('SubscriberNumber')};
      string2 dupecheckflag{xpath('DupeCheckFlag')};
      string4 dupethresholddays{xpath('DupeThresholdDays')};
      string1 relationstatus{xpath('RelationStatus')};
      DATASET(t_ncfcarrierscores) carrierscores{xpath('CarrierScores/Score'), maxcount(50)};
     END;

t_ncfinformation := RECORD
     string40 customername{xpath('CustomerName')};
     string11 customernumber{xpath('CustomerNumber')};
     string20 returnnode{xpath('ReturnNode')};
     boolean srcnodevalidated{xpath('SrcNodeValidated')};
     string10 purposecode{xpath('PurposeCode')};
     t_ncfaccountfeatures accountfeatures{xpath('AccountFeatures')};
     t_ncfcompanyfeatures companyfeatures{xpath('CompanyFeatures')};
     t_ncfagencyfeature agencyfeatures{xpath('AgencyFeatures')};
     DATASET(t_ncfcarrierfeatures) carrierfeatures{xpath('CarrierFeatures/Feature'), maxcount(50)};
    END;

t_contributeprofile := RECORD
      string11 contributenumber{xpath('ContributeNumber')};
      string1 ccaflag{xpath('CCAFlag')};
      string1 ccpflag{xpath('CCPFlag')};
      string1 clueaflag{xpath('CLUEAFlag')};
      string1 cluepflag{xpath('CLUEPFlag')};
      string1 lifeflag{xpath('LifeFlag')};
      string1 fullyrestrictflag{xpath('FullyRestrictFlag')};
      string4 nonglb{xpath('NonGLB')};
      string4 dppa6{xpath('DPPA6')};
      string4 commercialautopolicy{xpath('CommercialAutoPolicy')};
      string4 commercialpopertypolicy{xpath('CommercialPopertyPolicy')};
     END;

t_ddstatesearch := RECORD
        string8 level{xpath('Level')};
        string2 statecode{xpath('StateCode')};
        string5 option{xpath('Option')};
        string5 agehigh{xpath('AgeHigh')};
        string5 agemid{xpath('AgeMid')};
        string5 agelow{xpath('AgeLow')};
       END;

t_ddaccountconfig := RECORD
       string2 anchorclueauto{xpath('AnchorClueAuto')};
       string2 anchorcldsauto{xpath('AnchorCldsAuto')};
       string2 indresulttimeframe{xpath('IndResultTimeFrame')};
       string2 inddriverslicenseoption{xpath('IndDriversLicenseOption')};
       string2 inddriverreturnopt{xpath('IndDriverReturnOpt')};
       DATASET(t_ddstatesearch) stateoptions{xpath('StateOptions/StateOption'), maxcount(51)};
      END;

t_ddaccount := RECORD
      t_ddaccountconfig ddaccountconfig{xpath('DDAccountConfig')};
     END;

t_ddinformation := RECORD
     string10 ddproductcode{xpath('DDProductCode')};
     string40 customername{xpath('CustomerName')};
     string11 customernumber{xpath('CustomerNumber')};
     string11 accountnumber{xpath('AccountNumber')};
     string1 accountstatus{xpath('AccountStatus')};
     string1 accountproductstatus{xpath('AccountProductStatus')};
     string20 returnnode{xpath('ReturnNode')};
     boolean srcnodevalidated{xpath('SrcNodeValidated')};
     t_contributeprofile contribprofile{xpath('ContribProfile')};
     t_ddaccount ddaccount{xpath('DDAccount')};
     DATASET(t_ddaffidavitid) affidavitids{xpath('AffidavitIds/AffidavitId'), maxcount(51)};
    END;

t_ccaccountfeatures := RECORD
       string1 ordertype{xpath('OrderType')};
       string1 billingtypeid{xpath('BillingTypeId')};
       string1 isdefault{xpath('IsDefault')};
       string1 billspecial{xpath('BillSpecial')};
       string1 reportascode{xpath('ReportAsCode')};
       string1 billingascode{xpath('BillingAsCode')};
       string1 billingsecondind{xpath('BillingSecondInd')};
       string1 postingind{xpath('PostingInd')};
       string1 decodenarrative{xpath('DecodeNarrative')};
       string1 flgautoattributeallowed{xpath('FlgAutoAttributeAllowed')};
       string1 flgattributeonly{xpath('FlgAttributeOnly')};
       string4 version{xpath('Version')};
       string1 attributesubject{xpath('AttributeSubject')};
       string1 flgattributecache{xpath('FlgAttributeCache')};
       string2 indicatorattributecachethreshold{xpath('IndicatorAttributeCacheThreshold')};
      END;

t_ccanchor := RECORD
        string1 saq{xpath('Saq')};
        string1 clue{xpath('Clue')};
        string1 ncf{xpath('Ncf')};
        string1 clup{xpath('Clup')};
        string1 vin{xpath('Vin')};
        string1 hhplus{xpath('HHPlus')};
       END;

t_ccindicators := RECORD
        string1 priorpolicy{xpath('PriorPolicy')};
        string1 propchar{xpath('PropChar')};
        string1 piissn{xpath('PiiSSN')};
        string1 customerrel{xpath('CustomerRel')};
        string1 coveragelapse{xpath('CoverageLapse')};
        string1 currentage{xpath('CurrentAge')};
        string1 ambest{xpath('Ambest')};
        string1 piidob{xpath('PiiDOB')};
        string1 vinsearch{xpath('VinSearch')};
        string1 piidl{xpath('PiiDl')};
        string1 piigender{xpath('PiiGender')};
        string1 sortorder{xpath('SortOrder')};
        string1 secondreport{xpath('SecondReport')};
        string2 secondrptthold{xpath('SecondRptThold')};
       END;

t_cccontributor := RECORD
        string1 autorisk{xpath('AutoRisk')};
        string1 autolien{xpath('AutoLien')};
        string1 _type{xpath('Type')};
        string1 proprisk{xpath('PropRisk')};
        string1 proplien{xpath('PropLien')};
       END;

t_cclimitedreporting := RECORD
        string2 reports{xpath('')};
       END;

t_ccstatecodes := RECORD
        string2 statecode{xpath('')};
       END;

t_ccpolicyexclusions := RECORD
        string2 policy{xpath('')};
       END;

t_cccustomerpolicyexclusion := RECORD
        string11 restrictedpolicyviewingambest{xpath('RestrictedPolicyViewingAmbest')};
        string11 restrictedpolicyviewingcustomerid{xpath('RestrictedPolicyViewingCustomerId')};
       END;

t_cccustomervinexclusion := RECORD
        string11 restrictedvinviewingambest{xpath('RestrictedVinViewingAmbest')};
        string11 restrictedvinviewingcustomerid{xpath('RestrictedVinViewingCustomerId')};
       END;

t_ccrelatedcustomers := RECORD
        string11 number{xpath('')};
       END;

t_cccompanyfeatures := RECORD
       string1 custconfigstatus{xpath('CustConfigStatus')};
       integer3 autoreportage{xpath('AutoReportAge')};
       integer3 propreportage{xpath('PropReportAge')};
       integer3 vinsearchmonths{xpath('VinSearchMonths')};
       string1 cocpdeductibleind{xpath('COCPDeductibleInd')};
       string1 umunlimitind{xpath('UMUNLimitInd')};
       integer3 driverrptageadpf{xpath('DriverRptAgeADPF')};
       t_ccanchor anchor{xpath('Anchor')};
       t_ccindicators indicators{xpath('Indicators')};
       t_cccontributor contributor{xpath('Contributor')};
       DATASET(t_cclimitedreporting) limitedreports{xpath('LimitedReports/Reports'), maxcount(20)};
       DATASET(t_ccstatecodes) statecodes{xpath('StateCodes/StateCode'), maxcount(51)};
       DATASET(t_ccpolicyexclusions) policyexclusions{xpath('PolicyExclusions/Policy'), maxcount(20)};
       DATASET(t_cccustomerpolicyexclusion) customerpolicyexclusions{xpath('CustomerPolicyExclusions/CustomerPolicyExclusion'), maxcount(10000)};
       DATASET(t_cccustomervinexclusion) customervinexclusions{xpath('CustomerVinExclusions/CustomerVinExclusion'), maxcount(10000)};
       DATASET(t_ccrelatedcustomers) relatedcustomers{xpath('RelatedCustomers/Number'), maxcount(20)};
       DATASET(t_stringarrayitem) prioralerts{xpath('PriorAlerts/CustomerNumber'), maxcount(12)};
      END;

t_ccproductfeatures := RECORD
      t_ccaccountfeatures accountfeatures{xpath('AccountFeatures')};
      t_cccompanyfeatures companyfeatures{xpath('CompanyFeatures')};
     END;

t_ccinformation := RECORD
     string1 status{xpath('Status')};
     boolean srcnodevalidated{xpath('SrcNodeValidated')};
     integer8 configid{xpath('ConfigId')};
     t_ccproductfeatures features{xpath('Features')};
     string40 returnnode{xpath('ReturnNode')};
     string40 customername{xpath('CustomerName')};
     string11 customernumber{xpath('CustomerNumber')};
    END;

t_tobaccoinformation := RECORD
     string marketcode{xpath('MarketCode')};
     string customerid{xpath('CustomerId')};
     string customername{xpath('CustomerName')};
     string productstatus{xpath('ProductStatus')};
     string flgreturnredgreen{xpath('FlgReturnRedGreen')};
     string flgreturnmodelindicator{xpath('FlgReturnModelIndicator')};
     string flgreturnnumericalscore{xpath('FlgReturnNumericalScore')};
     string redscoremin{xpath('RedScoreMin')};
     string redscoremax{xpath('RedScoreMax')};
     string greenscoremin{xpath('GreenScoreMin')};
     string greenscoremax{xpath('GreenScoreMax')};
     string modelthreshold{xpath('ModelThreshold')};
     string tobaccostatus{xpath('TobaccoStatus')};
    END;

t_fdnriskfactors := RECORD
     string marketcode{xpath('MarketCode')};
     string customerid{xpath('CustomerId')};
     string customername{xpath('CustomerName')};
     string productstatus{xpath('ProductStatus')};
     string returnnode{xpath('ReturnNode')};
     string indscoreattributesdescription{xpath('IndScoreAttributesDescription')};
     string accountconfigid{xpath('AccountConfigId')};
     string indscoreattributes{xpath('IndScoreAttributes')};
     string gcid{xpath('GCId')};
     string fdnproductid{xpath('FDNProductId')};
     string fdnindustrytype{xpath('FDNIndustryType')};
    END;

t_insurancescoreproductsinfo := RECORD
    t_issinformation iss{xpath('ISS')};
    t_clueautoinformation cluea{xpath('CLUEA')};
    t_cluepropertyinformation cluep{xpath('CLUEP')};
    t_cluecommercialproductset cluecomm{xpath('CLUECOMM')};
    t_cdscautoinformation claima{xpath('CLAIMA')};
    t_cdscpropertyinformation claimp{xpath('CLAIMP')};
    t_ncfinformation ncf{xpath('NCF')};
    t_ddinformation dd{xpath('DD')};
    t_ccinformation cc{xpath('CC')};
    t_tobaccoinformation tobacco{xpath('TOBACCO')};
    t_fdnriskfactors fdnrskcl{xpath('FDNRSKCL')};
   END;

t_ffdproduct := RECORD
     string productcode{xpath('ProductCode')};
     string returnconsumerstatement{xpath('ReturnConsumerStatement')};
    END;

t_ffdinsurancecontext := RECORD
    DATASET(t_ffdproduct) products{xpath('Products/Product'), maxcount(999)};
   END;

t_insurancescorecontext := RECORD(record__3)
   t_insurancescoreproductsinfo products{xpath('Products')};
   t_ffdinsurancecontext ffd{xpath('FFD')};
  END;

lay := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  integer3 accountnumber;
  t_scoreserverrequest request_data;
  t_insurancescorecontext insurance_context;
 END;


	
	//alpa dataland  http://10.194.10.2:8010
			// ds_raw_input:=dataset('~foreign::' + _control.IPAddress.adataland_dali + '::' + 'scoringqa::in::nonfcra::scoreserver_mbsi_xml_20160212',lay,thor);
			ds_raw_input:=dataset('~foreign::' + _control.IPAddress.adataland_dali + '::' + 'scoringqa::in::nonfcra::scoreserver_mbsi_xml_p507_20180404',lay,thor);


// scoringqa::in::nonfcra::scoreserver_mbsi_xml_p507_*

output(choosen(ds_raw_input, 15));
output(count(ds_raw_input));

ds_raw_input2 := ds_raw_input(Insurance_Context.account.name <> 'LexisNexis');
output(count(ds_raw_input2));


ds_raw_input1 := ds_raw_input2(Insurance_Context.Products.ISS.ScoreModels[1].ModelId = 'P507');
output(count(ds_raw_input1));


n_lay := record
			 integer accountnumber;
			 integer sno;
			t_ScoreServerEditsRecord Records;
end;
		
n_lay trans(ds_raw_input1 l, 	unsigned c) := TRANSFORM
			self.accountnumber:=l.accountnumber;
			self.sno:=c;
			self.Records:= l.request_data.Records[c];
end;
					
     // Normalize CLUE Property Report 
		 CLUE_Property_Log_Data_Ds_Norm:=normalize(ds_raw_input1,left.request_data.Records,trans(left,counter));

		 // Flatten the Normalized CLUE Property Report 
			zz_bbraaten.Flatten_Scoring_ISS_copy(CLUE_Property_Log_Data_Ds_Norm, Flatten_result_CLUE_Property_Log);
			
		 // ************ Gathering PII info from EDIT's fromat and converting into XML *******
		 
		 info:=Flatten_result_CLUE_Property_Log(records__value[1..17]='001000AL510000LA');	
		
		Layout_InsRequest:=	Insurance_iesp.CLUEPropertyV2Order.t_CluePropertyRequest ;
		Layout_InsContext:=	InsuranceContext_iesp.CLUEInsuranceContext.t_CLUEPInsuranceContext;	 

recinsRequest_lay:=record
			integer accountnumber;
			string StreetName;
			string city;
			string state;
			string zip;
			string zipplus4;
end;
		
		
// output(choosen(info, 15));
// output(count(info));


		info_pjt:=project(info,transform(recinsRequest_lay,self.accountnumber:=left.accountnumber;
													 self.StreetName:=trim(left.records__value[18..46],left,right);
													 self.city:=trim(left.records__value[52..70],left,right);
													 self.state:=trim(left.records__value[72..73],left,right);
													 self.zip:=trim(left.records__value[74..78],left,right);
													 self.zipplus4:=trim(left.records__value[79..82],left,right);						 

													 self:=[];
													 ));

												
output(choosen(info_pjt, 15));
output(count(info_pjt));



eyeball := 50;

inputStructure := RECORD
  integer8 accountnumber;
  string streetname;
  string city;
  string state;
  string zip;
  string zipplus4;
 END;


Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;

OriginalDataRvv3 := DATASET(oldfile, Output_structure, thor);
OUTPUT(CHOOSEN(OriginalDataRvv3, all), NAMED('OriginalDataRvv3'));
output(count(OriginalDataRvv3));



FindMaxAccount := choosen(sort(OriginalDataRvv3, -accountnumber), 5);
MaxAccount := max(FindMaxAccount, accountnumber);
output(MaxAccount, named('max_account_rvv3'));

filteredzip := info_pjt(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));
OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));



goodinfo := filteredzip( streetname != '' and city != ''and state != '' and zip != '');
																						
											
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));

DedupedData := dedup(goodinfo, streetname, city, state, zip, all); 
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));


keepers_1_0 := OriginalDataRvv3(perm_flag = 0);
output(count(keepers_1_0));
keepers_1_1 := OriginalDataRvv3(perm_flag = 1);
output(count(keepers_1_1));
keepers_1_2 := OriginalDataRvv3(perm_flag = 2);
output(count(keepers_1_2));
keepers_1_3 := OriginalDataRvv3(perm_flag = 3);
output(count(keepers_1_3));
keepers_1_4 := OriginalDataRvv3(perm_flag = 4);
output(count(keepers_1_4));


keepers := sort(keepers_1_0+keepers_1_2+keepers_1_3+keepers_1_4, date_added);
output(keepers);
output(count(keepers), named('keepers'));

Output_structure Rearrange(output_structure l, integer c) := TRANSFORM
	// self.Date_added := ut.getdate;

		self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	// self.zip := l.zip[1..5];
	// self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;

Output_structure format_them(inputStructure l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.Customer := 'Generic';
	self.Source_Info := 'P507 Model';
		self.Perm_Flag := 4;  	
		self.zip := l.zip[1..5];
	self.streetaddress :=  l.streetname;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Reflagged_Logs := project(keepers, Rearrange(left, counter));
// new_perm  := keepers;
output(choosen(Reflagged_Logs, eyeball), named('Reflagged_Logs'));
output(count(Reflagged_Logs), named('Reflagged_Logs_count'));


Formatted_New := project(DedupedData, format_them(left, counter));
OUTPUT(CHOOSEN(Formatted_New, eyeball), NAMED('Formatted_New'));
output(count(Formatted_New));



new_large_sample := join(Reflagged_Logs, Formatted_New,  left.streetaddress = right.streetaddress and
																									left.city = right.city and
																									left.state = right.state and 
																									left.zip = right.zip, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sample := Reflagged_Logs + New_right; //add "new_right" to old dataset;
output(choosen(new_large_sample, eyeball), named('new'));

deduped_new := new_large_sample(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupold:= deduped_new(Date_added <> (Integer)ut.getdate);

ut.MAC_Pick_Random(deduped_new,New_5000,5000);   //grabs 5000 of new deduped rocrods;

Output_structure add_acct(Output_structure le, integer c) := Transform
	self.accountnumber := c + (integer)MaxAccount;
	self:= le;
	self:= [];
End;

Formatted_acct_New := project(New_5000, add_acct(left, counter));

new_large_sample_full := Reflagged_Logs + Formatted_acct_New;						


aold0 := new_large_sample_full(perm_flag = 0);
output(count(aold0), named('Formatted_New0'));
aold1 := new_large_sample_full(perm_flag = 1);
output(count(aold1), named('Formatted_New1'));
aold2 := new_large_sample_full(perm_flag = 2);
output(count(aold2), named('Formatted_New2'));
aold3 := new_large_sample_full(perm_flag = 3);
output(count(aold3), named('Formatted_New3'));
aold4 := new_large_sample_full(perm_flag = 4);
output(count(aold4), named('Formatted_New4'));

Sorted_Sample := Sort(new_large_sample_full, AccountNumber);

output(choosen(Sorted_Sample, 25000), named('Sorted_Sample'));
output(count(Sorted_Sample));

OUTPUT(choosen(Sorted_Sample, 25000),,fileout, thor,  overwrite);
