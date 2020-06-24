/*--SOAP--
<message name="BestAddress and Progressive Phones Search_Service">

  <part name="AcctNo" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>

  <part name="SSN" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Suffix" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="DateLastSeen" type="xsd:string"/>

  <separator/>
  <part name="addr1" type="xsd:string"/>
  <part name="addr1_2" type="xsd:string"/>
  <part name="city_name1" type="xsd:string"/>
  <part name="st1" type="xsd:string"/>
  <part name="zip1" type="xsd:string"/>
  <part name="addr2" type="xsd:string"/>
  <part name="addr2_2" type="xsd:string"/>
  <part name="city_name2" type="xsd:string"/>
  <part name="st2" type="xsd:string"/>
  <part name="zip2" type="xsd:string"/>
  <part name="addr3" type="xsd:string"/>
  <part name="addr3_2" type="xsd:string"/>
  <part name="city_name3" type="xsd:string"/>
  <part name="st3" type="xsd:string"/>
  <part name="zip3" type="xsd:string"/>
  <part name="addr4" type="xsd:string"/>
  <part name="addr4_2" type="xsd:string"/>
  <part name="city_name4" type="xsd:string"/>
  <part name="st4" type="xsd:string"/>
  <part name="zip4" type="xsd:string"/>
  <part name="addr5" type="xsd:string"/>
  <part name="addr5_2" type="xsd:string"/>
  <part name="city_name5" type="xsd:string"/>
  <part name="st5" type="xsd:string"/>
  <part name="zip5" type="xsd:string"/>
  <part name="addr6" type="xsd:string"/>
  <part name="addr6_2" type="xsd:string"/>
  <part name="city_name6" type="xsd:string"/>
  <part name="st6" type="xsd:string"/>
  <part name="zip6" type="xsd:string"/>
  <part name="addr7" type="xsd:string"/>
  <part name="addr7_2" type="xsd:string"/>
  <part name="city_name7" type="xsd:string"/>
  <part name="st7" type="xsd:string"/>
  <part name="zip7" type="xsd:string"/>
  <part name="addr8" type="xsd:string"/>
  <part name="addr8_2" type="xsd:string"/>
  <part name="city_name8" type="xsd:string"/>
  <part name="st8" type="xsd:string"/>
  <part name="zip8" type="xsd:string"/>
  <part name="addr9" type="xsd:string"/>
  <part name="addr9_2" type="xsd:string"/>
  <part name="city_name9" type="xsd:string"/>
  <part name="st9" type="xsd:string"/>
  <part name="zip9" type="xsd:string"/>
  <part name="addr10" type="xsd:string"/>
  <part name="addr10_2" type="xsd:string"/>
  <part name="city_name10" type="xsd:string"/>
  <part name="st10" type="xsd:string"/>
  <part name="zip10" type="xsd:string"/>

  <separator/>
  <part name="phoneno_1" type="xsd:string"/>
  <part name="phoneno_2" type="xsd:string"/>
  <part name="phoneno_3" type="xsd:string"/>
  <part name="phoneno_4" type="xsd:string"/>
  <part name="phoneno_5" type="xsd:string"/>
  <part name="phoneno_6" type="xsd:string"/>
  <part name="phoneno_7" type="xsd:string"/>
  <part name="phoneno_8" type="xsd:string"/>
  <part name="phoneno_9" type="xsd:string"/>
  <part name="phoneno_10" type="xsd:string"/>

  <separator/>
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="UseNameUniqueDID" type="xsd:boolean"/>
  <part name="PartialAddressDedup" type="xsd:boolean"/>
  <part name="InputAddressDedup" type="xsd:boolean"/>
  <part name="StartWithNextMostCurrent" type="xsd:boolean"/>
  <part name="EndWithNextMostCurrent" type="xsd:boolean"/>
  <part name="FirstNameLastNameMatch" type="xsd:boolean"/>
  <part name="FirstNameMatch" type="xsd:boolean"/>
  <part name="LastNameMatch" type="xsd:boolean"/>
  <part name="FullNameMatch" type="xsd:boolean"/>
  <part name="FirstInitialLastNameMatch" type="xsd:boolean"/>
  <part name="ReturnDedupFlag" type="xsd:boolean"/>
  <separator/>
  <part name="KeepSamePhoneInDiffLevels" type="xsd:boolean"/>
  <part name="DedupAgainstInputPhones" type="xsd:boolean"/>
  <separator/>
  <part name="MaxPhoneCount" type="xsd:unsignedInt"/>
  <part name="CountType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
  <part name="CountType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
  <part name="CountType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
  <part name="CountType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
  <part name="CountType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
  <part name="CountType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
  <part name="CountType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
  <part name="CountType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
  <part name="CountType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
  <part name="CountType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
  <part name="CountType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
  <part name="CountType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
  <part name="CountType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
  <separator/>
  <part name="DynamicOrdering" type="xsd:boolean"/>
  <part name="OrderType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
  <part name="OrderType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
  <part name="OrderType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
  <part name="OrderType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
  <part name="OrderType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
  <part name="OrderType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
  <part name="OrderType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
  <part name="OrderType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
  <part name="OrderType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
  <part name="OrderType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
  <part name="OrderType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
  <part name="OrderType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
  <part name="OrderType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
  <part name="IncludeBusinessPhone" type="xsd:boolean"/>
  <part name="IncludeLandlordPhone" type="xsd:boolean"/>
  <part name="IncludeAllPhonesPlusData" type="xsd:boolean"/>
  <part name="StrictAPSXMatch" type="xsd:boolean"/>
  <part name="BestAddressAndPhoneSearchRequest" type = "tns:XmlDataSet" cols="80" rows="30"
  default="insert XML here" />

</message>
*/
/*--INFO-- This service returns best addresses and progressive phones */


IMPORT iesp, AddrBest, AutoStandardI, Address, Doxie, WSInput;

EXPORT SearchService := MACRO
    #onwarning(4207, ignore);
    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BestAddressAndPhone_Services_SearchService();

    rec_in := iesp.bestaddressandphone.t_BestAddressAndPhoneSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('BestAddressAndPhoneSearchRequest', FEW);
    first_row := ds_in[1] : independent;


    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    //set main search criteria:
    search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    iesp.ECL2ESP.SetInputDate (search_by.DOB,'DOB');
    iesp.ECL2ESP.SetInputDate (search_by.DateLastSeen,'DateLastSeen');
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    search_opt := global (first_row.options);
    count_opt := global (search_opt.MaxPhoneCounts);
    sort_opt := global (search_opt.CustomSortOrder);

    // Search options Translation
    #stored('MaxRecordsToReturn' ,search_opt.MaxAddressCount);
    #stored('ReturnDedupFlag' ,search_opt.IncludeDedupFlag);
    #stored('PartialAddressDedup' ,search_opt.DedupPartialAddress);
    #stored('InputAddressDedup' ,search_opt.DedupInputAddress);
    #stored('DedupAgainstInputPhones' ,search_opt.DedupInputPhone);
    #stored('DynamicOrdering' ,search_opt.UseCustomSortOrder);
    #stored('IncludeAllPhonesPlusData' ,search_opt.IncludePhones);
    #stored('StrictAPSXMatch' ,search_opt.StrictMatch);

    // Count options Translation
    #stored('CountType1_Es_EDASEARCH' ,count_opt.EDA);
    #stored('CountType2_Se_SKIPTRACESEARCH' ,count_opt.SkipTrace);
    #stored('CountType3_Ap_PROGRESSIVEADDRESSSEARCH' ,count_opt.ProgressiveAddress);
    #stored('CountType4_Sp_POSSIBLESPOUSE' ,count_opt.PossibleSpouse);
    #stored('CountType4_Md_POSSIBLEPARENTS' ,count_opt.PossibleParrents);
    #stored('CountType4_Cl_CLOSESTRELATIVE' ,count_opt.ClosestRelative);
    #stored('CountType4_Cr_CORESIDENT' ,count_opt.Coresident);
    #stored('CountType5_Sx_EXPANDEDSKIPTRACESEARCH' ,count_opt.ExpandedSkipTrace);
    #stored('CountType6_Pp_PHONESPLUSSEARCH' ,count_opt.PhonesPlus);
    #stored('CountType7_UNVERIFIEDPHONE' ,count_opt.UnverifiedPhone);
    #stored('CountType_Ne_CLOSESTNEIGHBOR' ,count_opt.ClosestNeighbor);
    #stored('CountType_Wk_PEOPLEATWORK' ,count_opt.PeopleAtWork);
    #stored('CountType_Rl_POSSIBLERELOCATION' ,count_opt.PossibleRelocation);

    // Sort order options Translation
    #stored('OrderType1_Es_EDASEARCH' ,sort_opt.EDA);
    #stored('OrderType2_Se_SKIPTRACESEARCH' ,sort_opt.SkipTrace);
    #stored('OrderType3_Ap_PROGRESSIVEADDRESSSEARCH' ,sort_opt.ProgressiveAddress);
    #stored('OrderType4_Sp_POSSIBLESPOUSE' ,sort_opt.PossibleSpouse);
    #stored('OrderType4_Md_POSSIBLEPARENTS' ,sort_opt.PossibleParrents);
    #stored('OrderType4_Cl_CLOSESTRELATIVE' ,sort_opt.ClosestRelative);
    #stored('OrderType4_Cr_CORESIDENT' ,sort_opt.Coresident);
    #stored('OrderType5_Sx_EXPANDEDSKIPTRACESEARCH' ,sort_opt.ExpandedSkipTrace);
    #stored('OrderType6_Pp_PHONESPLUSSEARCH' ,sort_opt.PhonesPlus);
    #stored('OrderType7_UNVERIFIEDPHONE' ,sort_opt.UnverifiedPhone);
    #stored('OrderType_Ne_CLOSESTNEIGHBOR' ,sort_opt.ClosestNeighbor);
    #stored('OrderType_Wk_PEOPLEATWORK' ,sort_opt.PeopleAtWork);
    #stored('OrderType_Rl_POSSIBLERELOCATION' ,sort_opt.PossibleRelocation);

    #stored ('SSN', search_by.SSN);
    #stored ('Phone', search_by.Phone10);
    #stored ('phoneno_1', search_by.DedupPhones[1].value);
    #stored ('phoneno_2', search_by.DedupPhones[2].value);
    #stored ('phoneno_3', search_by.DedupPhones[3].value);
    #stored ('phoneno_4', search_by.DedupPhones[4].value);
    #stored ('phoneno_5', search_by.DedupPhones[5].value);
    #stored ('phoneno_6', search_by.DedupPhones[6].value);
    #stored ('phoneno_7', search_by.DedupPhones[7].value);
    #stored ('phoneno_8', search_by.DedupPhones[8].value);
    #stored ('phoneno_9', search_by.DedupPhones[9].value);
    #stored ('phoneno_10', search_by.DedupPhones[10].value);

    #stored('addr1',search_by.DedupAddresses[1].StreetAddress1);
    #stored('addr1_2',search_by.DedupAddresses[1].StreetAddress2);
    #stored('city_name1',search_by.DedupAddresses[1].City);
    #stored('st1',search_by.DedupAddresses[1].State);
    #stored('zip1',search_by.DedupAddresses[1].Zip5);

    #stored('addr2',search_by.DedupAddresses[2].StreetAddress1);
    #stored('addr2_2',search_by.DedupAddresses[2].StreetAddress2);
    #stored('city_name2',search_by.DedupAddresses[2].City);
    #stored('st2',search_by.DedupAddresses[2].State);
    #stored('zip2',search_by.DedupAddresses[2].Zip5);

    #stored('addr3',search_by.DedupAddresses[3].StreetAddress1);
    #stored('addr3_2',search_by.DedupAddresses[3].StreetAddress2);
    #stored('city_name3',search_by.DedupAddresses[3].City);
    #stored('st3',search_by.DedupAddresses[3].State);
    #stored('zip3',search_by.DedupAddresses[3].Zip5);

    #stored('addr4',search_by.DedupAddresses[4].StreetAddress1);
    #stored('addr4_2',search_by.DedupAddresses[4].StreetAddress2);
    #stored('city_name4',search_by.DedupAddresses[4].City);
    #stored('st4',search_by.DedupAddresses[4].State);
    #stored('zip4',search_by.DedupAddresses[4].Zip5);

    #stored('addr5',search_by.DedupAddresses[5].StreetAddress1);
    #stored('addr5_2',search_by.DedupAddresses[5].StreetAddress2);
    #stored('city_name5',search_by.DedupAddresses[5].City);
    #stored('st5',search_by.DedupAddresses[5].State);
    #stored('zip5',search_by.DedupAddresses[5].Zip5);

    #stored('addr6',search_by.DedupAddresses[6].StreetAddress1);
    #stored('addr6_2',search_by.DedupAddresses[6].StreetAddress2);
    #stored('city_name6',search_by.DedupAddresses[6].City);
    #stored('st6',search_by.DedupAddresses[6].State);
    #stored('zip6',search_by.DedupAddresses[6].Zip5);

    #stored('addr7',search_by.DedupAddresses[7].StreetAddress1);
    #stored('addr7_2',search_by.DedupAddresses[7].StreetAddress2);
    #stored('city_name7',search_by.DedupAddresses[7].City);
    #stored('st7',search_by.DedupAddresses[7].State);
    #stored('zip7',search_by.DedupAddresses[7].Zip5);

    #stored('addr8',search_by.DedupAddresses[8].StreetAddress1);
    #stored('addr8_2',search_by.DedupAddresses[8].StreetAddress2);
    #stored('city_name8',search_by.DedupAddresses[8].City);
    #stored('st8',search_by.DedupAddresses[8].State);
    #stored('zip8',search_by.DedupAddresses[8].Zip5);

    #stored('addr9',search_by.DedupAddresses[9].StreetAddress1);
    #stored('addr9_2',search_by.DedupAddresses[9].StreetAddress2);
    #stored('city_name9',search_by.DedupAddresses[9].City);
    #stored('st9',search_by.DedupAddresses[9].State);
    #stored('zip9',search_by.DedupAddresses[9].Zip5);

    #stored('addr10',search_by.DedupAddresses[10].StreetAddress1);
    #stored('addr10_2',search_by.DedupAddresses[10].StreetAddress2);
    #stored('city_name10',search_by.DedupAddresses[10].City);
    #stored('st10',search_by.DedupAddresses[10].State);
    #stored('zip10',search_by.DedupAddresses[10].Zip5);

    tempmod := AutoStandardI.GlobalModule();
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(tempmod);

    AddrBest.Layout_BestAddr.Batch_in_both xform ():=transform
    // self.p_city_name:=tempmod.city;
    // self.st:=tempmod.state;
    // self.z5:=tempmod.zip;

    Clean_Addr := Address.CleanAddress182(tempmod.Addr,
                 tempmod.city + ' ' + tempmod.state+' '+ tempmod.zip);
    string AcctNo := '' : stored('AcctNo');
    string addr1 := '' : stored('Addr1');
    string addr1_2 := '' : stored('Addr1_2');
    string city_name1 := '' : stored('city_name1');
    string st1 := '' : stored('st1');
    string zip1 := '' : stored('zip1');

    string addr2 := '' : stored('Addr2');
    string addr2_2 := '' : stored('Addr2_2');
    string city_name2 := '' : stored('city_name2');
    string st2 := '' : stored('st2');
    string zip2 := '' : stored('zip2');

    string addr3 := '' : stored('Addr3');
    string addr3_2 := '' : stored('Addr3_2');
    string city_name3 := '' : stored('city_name3');
    string st3 := '' : stored('st3');
    string zip3 := '' : stored('zip3');

    string addr4 := '' : stored('Addr4');
    string addr4_2 := '' : stored('Addr4_2');
    string city_name4 := '' : stored('city_name4');
    string st4 := '' : stored('st4');
    string zip4 := '' : stored('zip4');

    string addr5 := '' : stored('Addr5');
    string addr5_2 := '' : stored('Addr5_2');
    string city_name5 := '' : stored('city_name5');
    string st5 := '' : stored('st5');
    string zip5 := '' : stored('zip5');

    string addr6 := '' : stored('Addr6');
    string addr6_2 := '' : stored('Addr6_2');
    string city_name6 := '' : stored('city_name6');
    string st6 := '' : stored('st6');
    string zip6 := '' : stored('zip6');

    string addr7 := '' : stored('Addr7');
    string addr7_2 := '' : stored('Addr7_2');
    string city_name7 := '' : stored('city_name7');
    string st7 := '' : stored('st7');
    string zip7 := '' : stored('zip7');

    string addr8 := '' : stored('Addr8');
    string addr8_2 := '' : stored('Addr8_2');
    string city_name8 := '' : stored('city_name8');
    string st8 := '' : stored('st8');
    string zip8 := '' : stored('zip8');

    string addr9 := '' : stored('Addr9');
    string addr9_2 := '' : stored('Addr9_2');
    string city_name9 := '' : stored('city_name9');
    string st9 := '' : stored('st9');
    string zip9 := '' : stored('zip9');

    string addr10 := '' : stored('Addr10');
    string addr10_2 := '' : stored('Addr10_2');
    string city_name10 := '' : stored('city_name10');
    string st10 := '' : stored('st10');
    string zip10 := '' : stored('zip10');

    string phoneno_1 := '' : stored('phoneno_1');
    string phoneno_2 := '' : stored('phoneno_2');
    string phoneno_3 := '' : stored('phoneno_3');
    string phoneno_4 := '' : stored('phoneno_4');
    string phoneno_5 := '' : stored('phoneno_5');
    string phoneno_6 := '' : stored('phoneno_6');
    string phoneno_7 := '' : stored('phoneno_7');
    string phoneno_8 := '' : stored('phoneno_8');
    string phoneno_9 := '' : stored('phoneno_9');
    string phoneno_10 := '' : stored('phoneno_10');

    self.AcctNo := AcctNo;
    self.name_first := tempmod.firstname;
    self.name_last := tempmod.lastname;
    self.name_middle:= tempmod.middlename;
    self.name_suffix:= tempmod.Suffix;
    self.prim_range := clean_addr [1..10];
    self.predir := clean_addr [11..12];
    self.prim_name := clean_addr [13..40];
    self.suffix := clean_addr [41..44];
    self.postdir := clean_addr [45..46];
    self.unit_desig := clean_addr [47..56];
    self.sec_range := clean_addr [57..64];
    self.p_city_name:= clean_addr [90..114];//tempmod.city;
    self.st := clean_addr [115..116];
    self.z5 := clean_addr [117..121];
    self.z4 := clean_addr [122..125];
    self.phoneno := tempmod.phone;
    self.ssn := tempmod.ssn;
    self.dob :=(string) tempmod.dob;
    self.addr1 := addr1;
    self.addr1_2 := addr1_2;
    self.city_name1 := city_name1;
    self.st1 := st1;
    self.zip1 := zip1;
    self.addr2 := addr2;
    self.addr2_2 := addr2_2;
    self.city_name2 := city_name2;
    self.st2 := st2;
    self.zip2 := zip2;
    self.addr3 := addr3;
    self.addr3_2 := addr3_2;
    self.city_name3 := city_name3;
    self.st3 := st3;
    self.zip3 := zip3;
    self.addr4 := addr4;
    self.addr4_2 := addr4_2;
    self.city_name4 := city_name4;
    self.st4 := st4;
    self.zip4 := zip4;
    self.addr5 := addr5;
    self.addr5_2 := addr5_2;
    self.city_name5 := city_name5;
    self.st5 := st5;
    self.zip5 := zip5;
    self.addr6 := addr6;
    self.addr6_2 := addr6_2;
    self.city_name6 := city_name6;
    self.st6 := st6;
    self.zip6 := zip6;
    self.addr7 := addr7;
    self.addr7_2 := addr7_2;
    self.city_name7 := city_name7;
    self.st7 := st7;
    self.zip7 := zip7;
    self.addr8 := addr8;
    self.addr8_2 := addr8_2;
    self.city_name8 := city_name8;
    self.st8 := st8;
    self.zip8 := zip8;
    self.addr9 := addr9;
    self.addr9_2 := addr9_2;
    self.city_name9 := city_name9;
    self.st9 := st9;
    self.zip9 := zip9;
    self.addr10 := addr10;
    self.addr10_2 := addr10_2;
    self.city_name10:= city_name10;
    self.st10 := st10;
    self.zip10 := zip10;
    self.phoneno_1 := phoneno_1;
    self.phoneno_2 := phoneno_2;
    self.phoneno_3 := phoneno_3;
    self.phoneno_4 := phoneno_4;
    self.phoneno_5 := phoneno_5;
    self.phoneno_6 := phoneno_6;
    self.phoneno_7 := phoneno_7;
    self.phoneno_8 := phoneno_8;
    self.phoneno_9 := phoneno_9;
    self.phoneno_10 := phoneno_10;
    end;

    f_in_raw:=DATASET ([xform ()]);

    tmp := BestAddressAndPhone_Services.Records(f_in_raw, mod_access);
    iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, results, iesp.bestaddressandphone.t_BestAddressAndPhoneSearchResponse,,true);
    output(results, named('Results'));

ENDMACRO;

// Searchservice();

/*
<BestAddressAndPhoneSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<Options>
  <UseNicknames></UseNicknames>
  <IncludeAlsoFound></IncludeAlsoFound>
  <UsePhonetics></UsePhonetics>
   <MaxAddressCount></MaxAddressCount>
  <MaxPhoneCount></MaxPhoneCount>
  <IncludePhones></IncludePhones>
  <UseNameUniqueID></UseNameUniqueID>
  <IncludeDedupFlag></IncludeDedupFlag>
  <IncludeBusinessPhone></IncludeBusinessPhone>
  <IncludeLandlordPhone></IncludeLandlordPhone>
  <MatchFirstAndLastName></MatchFirstAndLastName>
  <MatchFirstName></MatchFirstName>
  <MatchLastName></MatchLastName>
  <MatchFullName></MatchFullName>
  <MatchFirstInitialLastName></MatchFirstInitialLastName>
  <DedupPartialAddress></DedupPartialAddress>
  <DedupInputAddress></DedupInputAddress>
  <DedupInputPhone></DedupInputPhone>
  <StartWithNextMostCurrent></StartWithNextMostCurrent>
  <EndWithNextMostCurrent></EndWithNextMostCurrent>
  <KeepSamePhoneInDiffLevels></KeepSamePhoneInDiffLevels>
  <UseCustomSortOrder></UseCustomSortOrder>
  <MaxPhoneCounts>
  <EDA></EDA>
  <SkipTrace></SkipTrace>
  <ProgressiveAddress></ProgressiveAddress>
  <PossibleSpouse></PossibleSpouse>
  <PossibleParrents></PossibleParrents>
  <ClosestRelative></ClosestRelative>
  <Coresident></Coresident>
  <ExpandedSkipTrace></ExpandedSkipTrace>
  <PhonesPlus></PhonesPlus>
  <UnverifiedPhone></UnverifiedPhone>
  <ClosestNeighbor></ClosestNeighbor>
  <PeopleAtWork></PeopleAtWork>
  <PossibleRelocation></PossibleRelocation>
  </MaxPhoneCounts>
  <CustomSortOrder>
  <EDA></EDA>
  <SkipTrace></SkipTrace>
  <ProgressiveAddress></ProgressiveAddress>
  <PossibleSpouse></PossibleSpouse>
  <PossibleParrents></PossibleParrents>
  <ClosestRelative></ClosestRelative>
  <Coresident></Coresident>
  <ExpandedSkipTrace></ExpandedSkipTrace>
  <PhonesPlus></PhonesPlus>
  <UnverifiedPhone></UnverifiedPhone>
  <ClosestNeighbor></ClosestNeighbor>
  <PeopleAtWork></PeopleAtWork>
  <PossibleRelocation></PossibleRelocation>
  </CustomSortOrder>
</Options>
<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetAddress1></StreetAddress1>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
  </Address>
<DedupAddresses>
  <Address>
    <StreetAddress1></StreetAddress1>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
  </Address>
</DedupAddresses>
  <SSN></SSN>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
   </DOB>
<DateLastSeen>
    <Year></Year>
    <Month></Month>
    <Day></Day>
</DateLastSeen>
  <Phone10></Phone10>
 <DedupPhones>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
<Phone10></Phone10>
</DedupPhones>
</SearchBy>
</row>
</BestAddressAndPhoneSearchRequest>
*/
