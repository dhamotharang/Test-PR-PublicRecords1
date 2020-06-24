﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT RiskIntelligenceNetwork_Analytics;
IMPORT B_Event,B_Event_1,B_Event_2,B_Event_3,B_Event_4,B_Event_5,B_Event_6,B_Event_7,B_Event_8,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM RiskIntelligenceNetwork_Analytics;
IMPORT * FROM KEL11.Null;
EXPORT Q_Input_Rin(DATASET(RECORDOF(RiskIntelligenceNetwork_Analytics.Layouts.LayoutInputPII_2)) __PInputPIIDataset) := MODULE
  SHARED E_Address_Params := MODULE(E_Address)
    SHARED __Mapping0 := 'ottoaddressid(DEFAULT:UID),batchin_rec.prim_range(OVERRIDE:Primary_Range_),batchin_rec.predir(OVERRIDE:Predirectional_),batchin_rec.prim_name(OVERRIDE:Primary_Name_),batchin_rec.addr_suffix(OVERRIDE:Suffix_),batchin_rec.postdir(OVERRIDE:Postdirectional_),batchin_rec.unit_desig(OVERRIDE:Unit_Designation_),batchin_rec.sec_range(OVERRIDE:Secondary_Range_),batchin_rec.p_city_name(OVERRIDE:Postal_City_),batchin_rec.st(OVERRIDE:State_),batchin_rec.z5(OVERRIDE:Zip_),batchin_rec.zip4(OVERRIDE:Zip4_),advo_appends.cart(OVERRIDE:Carrier_Route_Number_),advo_appends.cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),advo_appends.lot(OVERRIDE:Line_Of_Travel_),advo_appends.lot_order(OVERRIDE:Line_Of_Travel_Order_),advo_appends.dbpc(OVERRIDE:Delivery_Point_Barcode_),advo_appends.chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),advo_appends.rec_type(OVERRIDE:Type_Code_),advo_appends.fips_county(OVERRIDE:County_),advo_appends.geo_lat(OVERRIDE:Latitude_),advo_appends.geo_long(OVERRIDE:Longitude_),advo_appends.msa(OVERRIDE:Metropolitan_Statistical_Area_),advo_appends.geo_blk(OVERRIDE:Geo_Block_),advo_appends.geo_match(OVERRIDE:Geo_Match_),advo_appends.err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_)';
    SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
      SELF.Vanity_City_ := __CN('');
      SELF._is_Additional_ := __CN(FALSE);
      SELF := __r;
    END;
    EXPORT __d0_KELfiltered := __PInputPIIDataset((STRING28)batchin_rec.prim_name <> '' AND (UNSIGNED3)batchin_rec.z5 <> 0);
    SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)OttoAddressId <> 0);
    SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'),__Mapping0_Transform(LEFT)));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Customer_Params := MODULE(E_Customer)
    SHARED __Mapping0 := 'gc_id(DEFAULT:UID|OVERRIDE:Customer_Id_:0),ind_type(OVERRIDE:Industry_Type_:0),batchin_rec.st(OVERRIDE:Jurisdiction_State_:\'\')';
    SHARED __d0_Prefiltered := __PInputPIIDataset((KEL.typ.uid)gc_id <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Drivers_License_Params := MODULE(E_Drivers_License)
    SHARED __Mapping0 := 'ottodriverslicenseid(DEFAULT:UID|OVERRIDE:Otto_Drivers_License_Id_:\'\'),associatedcustomerfileinfo(DEFAULT:_r_Customer_:0),sourcecustomerfileinfo(DEFAULT:_r_Source_Customer_:0),batchin_rec.dl_number(OVERRIDE:License_Number_:\'\'),batchin_rec.dl_state(OVERRIDE:State_:\'\')';
    EXPORT __d0_KELfiltered := __PInputPIIDataset(TRIM(batchin_rec.dl_number) != '');
    SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)OttoDriversLicenseId <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Email_Params := MODULE(E_Email)
    SHARED __Mapping0 := 'ottoemailid(DEFAULT:UID),batchin_rec.email_address(OVERRIDE:Email_Address_:\'\')';
    SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
      SELF.Host_ := __CN('');
      SELF.Email_Last_Domain_ := __CN('');
      SELF._isdisposableemail_ := __CN(0);
      SELF := __r;
    END;
    EXPORT __d0_KELfiltered := __PInputPIIDataset(batchin_rec.email_address != '');
    SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)OttoEmailId <> 0);
    SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'),__Mapping0_Transform(LEFT)));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Event_Params := MODULE(E_Event)
    SHARED __Trimmed := RECORD, MAXLENGTH(5000)
      STRING KeyVal;
    END;
    SHARED __d0_Trim := PROJECT(__PInputPIIDataset,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.record_id)));
    EXPORT __All_Trim := __d0_Trim;
    SHARED __TabRec := RECORD, MAXLENGTH(5000)
      __All_Trim.KeyVal;
      UNSIGNED4 Cnt := COUNT(GROUP);
      KEL.typ.uid UID := 0;
    END;
    EXPORT NullKeyVal := TRIM((STRING)'');
    SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
    SHARED __SortedTable := SORT(__Table,KeyVal);
    SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
    EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
    SHARED __Mapping0 := 'UID(DEFAULT:UID),gc_id(DEFAULT:_r_Customer_:0|DEFAULT:_r_Source_Customer_:0),lexid(DEFAULT:Subject_:0),ottoaddressid(DEFAULT:Location_:0|OVERRIDE:Otto_Address_Id_:\'\'),ottossnid(DEFAULT:_r_Ssn_:0|OVERRIDE:Otto_S_S_N_Id_:\'\'),phonenumber(DEFAULT:_r_Phone_:0|DEFAULT:Phone_Number_:\'\'),ottoemailid(DEFAULT:_r_Email_:0|OVERRIDE:Otto_Email_Id_:\'\'),ip_address(DEFAULT:_r_Internet_Protocol_:0|OVERRIDE:Ip_Address_:\'\'),ottobankaccountid(DEFAULT:_r_Bank_Account_:0|OVERRIDE:Otto_Bank_Account_Id_:\'\'),ottodriverslicenseid(DEFAULT:_r_Drivers_License_:0|OVERRIDE:Otto_Drivers_License_Id_:\'\'),rin_source(OVERRIDE:_rin__source_:0),batchin_rec.did(OVERRIDE:Lex_Id_:0),ottoipaddressid(OVERRIDE:Otto_Ip_Address_Id_:\'\'),record_id(OVERRIDE:Record_Id_:0),event_date(OVERRIDE:Event_Date_:DATE),pr_best_appends.best_title(OVERRIDE:Title_),batchin_rec.name_first(OVERRIDE:First_Name_),batchin_rec.name_middle(OVERRIDE:Middle_Name_),batchin_rec.name_last(OVERRIDE:Last_Name_),batchin_rec.name_suffix(OVERRIDE:Name_Suffix_),mac_address(OVERRIDE:_mac__address_:\'\'),serial_number(OVERRIDE:_serial__number_:\'\'),device_type(OVERRIDE:_device__type_:\'\'),device_identification_provider(OVERRIDE:_device__identification__provider_:\'\'),batchin_rec.prim_range(OVERRIDE:Primary_Range_),batchin_rec.predir(OVERRIDE:Predirectional_),batchin_rec.prim_name(OVERRIDE:Primary_Name_),batchin_rec.addr_suffix(OVERRIDE:Suffix_),batchin_rec.postdir(OVERRIDE:Postdirectional_),batchin_rec.unit_desig(OVERRIDE:Unit_Designation_),batchin_rec.sec_range(OVERRIDE:Secondary_Range_),batchin_rec.p_city_name(OVERRIDE:Postal_City_),batchin_rec.st(OVERRIDE:State_),batchin_rec.z5(OVERRIDE:Zip_),batchin_rec.zip4(OVERRIDE:Zip4_),advo_appends.cart(OVERRIDE:Carrier_Route_Number_),advo_appends.cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),advo_appends.lot(OVERRIDE:Line_Of_Travel_),advo_appends.lot_order(OVERRIDE:Line_Of_Travel_Order_),advo_appends.dbpc(OVERRIDE:Delivery_Point_Barcode_),advo_appends.chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),advo_appends.rec_type(OVERRIDE:Type_Code_),advo_appends.fips_county(OVERRIDE:County_),advo_appends.geo_lat(OVERRIDE:Latitude_),advo_appends.geo_long(OVERRIDE:Longitude_),advo_appends.msa(OVERRIDE:Metropolitan_Statistical_Area_),advo_appends.geo_blk(OVERRIDE:Geo_Block_),advo_appends.geo_match(OVERRIDE:Geo_Match_),advo_appends.err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),batchin_rec.phoneno(OVERRIDE:Phone_Formatted_:\'\'),batchin_rec.dl_number(OVERRIDE:License_Number_:\'\'),batchin_rec.dl_state(OVERRIDE:License_State_:\'\'),batchin_rec.email_address(OVERRIDE:Email_Address_:\'\'),batchin_rec.ssn(OVERRIDE:Ssn_:\'\'),batchin_rec.bank_routing_number(OVERRIDE:Routing_Number_:\'\'),batchin_rec.bank_account_number(OVERRIDE:Account_Number_:\'\'),confidence_that_activity_was_deceitful_id(OVERRIDE:Confidence__that__activity__was__deceitful__id_:0),name_risk_code(OVERRIDE:_name__risk__code_:0),dob_risk_code(OVERRIDE:_dob__risk__code_:0),ssn_risk_code(OVERRIDE:_ssn__risk__code_:0),drivers_license_risk_code(OVERRIDE:_drivers__license__risk__code_:0),physical_address_risk_code(OVERRIDE:_physical__address__risk__code_:0),phone_risk_code(OVERRIDE:_phone__risk__code_:0),cell_phone_risk_code(OVERRIDE:_cell__phone__risk__code_:0),work_phone_risk_code(OVERRIDE:_work__phone__risk__code_:0),bank_account_1_risk_code(OVERRIDE:_bank__account__1__risk__code_:0),bank_account_2_risk_code(OVERRIDE:_bank__account__2__risk__code_:0),email_address_risk_code(OVERRIDE:_email__address__risk__code_:0),ip_address_fraud_code(OVERRIDE:_ip__address__fraud__code_:0),business_risk_code(OVERRIDE:_business__risk__code_:0),mailing_address_risk_code(OVERRIDE:_mailing__address__risk__code_:0),device_risk_code(OVERRIDE:_device__risk__code_:0),identity_risk_code(OVERRIDE:_identity__risk__code_:0),event_type_1(OVERRIDE:_event__type__1_:0),event_type_2(OVERRIDE:_event__type__2_:0),event_type_3(OVERRIDE:_event__type__3_:0),batchin_rec.dob(OVERRIDE:Date_Of_Birth_:DATE),bocashellhit(OVERRIDE:Bocashell_Hit_),boca_shell_appends.shell_input.did(OVERRIDE:Bocashell_Lex_Id_:0),boca_shell_appends.iid.nap_summary(OVERRIDE:_nap__summary_:0|OVERRIDE:_nas__summary_:0),boca_shell_appends.iid.cvi(OVERRIDE:_cvi_:0),boca_shell_appends.fd_scores.stolenidentityindex_v3(OVERRIDE:_fp3__stolenidentityindex_:0),boca_shell_appends.fd_scores.syntheticidentityindex_v3(OVERRIDE:_syntheticidentityindex__v3_:0),boca_shell_appends.fd_scores.manipulatedidentityindex_v3(OVERRIDE:_manipulatedidentityindex__v3_:0),boca_shell_appends.iid.socsdobflag(OVERRIDE:_socsdobflag_:0),boca_shell_appends.iid.pwsocsdobflag(OVERRIDE:_pwsocsdobflag_:0),boca_shell_appends.dobmatchlevel(OVERRIDE:_dobmatchlevel_:0),boca_shell_appends.fdattributesv2.sourcerisklevel(OVERRIDE:_sourcerisklevel_:0),boca_shell_appends.iid.reason1(OVERRIDE:_reason1_:\'\'),boca_shell_appends.iid.reason2(OVERRIDE:_reason2_:\'\'),boca_shell_appends.iid.reason3(OVERRIDE:_reason3_:\'\'),boca_shell_appends.iid.reason4(OVERRIDE:_reason4_:\'\'),boca_shell_appends.iid.reason5(OVERRIDE:_reason5_:\'\'),boca_shell_appends.iid.reason6(OVERRIDE:_reason6_:\'\'),boca_shell_appends.iid.socsvalflag(OVERRIDE:_socsvalflag_:0),boca_shell_appends.iid.drlcvalflag(OVERRIDE:_drlcvalflag_:0),boca_shell_appends.iid.hphonevalflag(OVERRIDE:_hphonevalflag_:0),boca_shell_appends.truedid(OVERRIDE:_truedid_),pr_best_appends.best_fname(OVERRIDE:_best__fname_:\'\'),pr_best_appends.best_lname(OVERRIDE:_best__lname_:\'\'),pr_best_appends.best_ssn(OVERRIDE:_best__ssn_:\'\'),boca_shell_appends.best_flags.input_fname_isbestmatch(OVERRIDE:_input__fname__isbestmatch_:\'\'),boca_shell_appends.best_flags.input_lname_isbestmatch(OVERRIDE:_input__lname__isbestmatch_:\'\'),boca_shell_appends.best_flags.input_ssn_isbestmatch(OVERRIDE:_input__ssn__isbestmatch_:\'\'),boca_shell_appends.adl_shell_flags.in_addrpop(OVERRIDE:_add__curr__pop_),boca_shell_appends.address_verification.input_address_information.prim_range(OVERRIDE:_add__curr__prim__range_:\'\'),boca_shell_appends.address_verification.input_address_information.predir(OVERRIDE:_add__curr__predir_:\'\'),boca_shell_appends.address_verification.input_address_information.prim_name(OVERRIDE:_add__curr__prim__name_:\'\'),boca_shell_appends.address_verification.input_address_information.addr_suffix(OVERRIDE:_add__curr__addr__suffix_:\'\'),boca_shell_appends.address_verification.input_address_information.postdir(OVERRIDE:_add__curr__postdir_:\'\'),boca_shell_appends.address_verification.input_address_information.unit_desig(OVERRIDE:_add__curr__unit__desig_:\'\'),boca_shell_appends.address_verification.input_address_information.sec_range(OVERRIDE:_add__curr__sec__range_:\'\'),boca_shell_appends.address_verification.input_address_information.city_name(OVERRIDE:_add__curr__city__name_:\'\'),boca_shell_appends.address_verification.input_address_information.st(OVERRIDE:_add__curr__st_:\'\'),boca_shell_appends.address_verification.input_address_information.zip5(OVERRIDE:_add__curr__zip5_:\'\'),boca_shell_appends.address_verification.input_address_information.county(OVERRIDE:_add__curr__county_:\'\'),boca_shell_appends.address_verification.input_address_information.geo_blk(OVERRIDE:_add__curr__geo__blk_:\'\'),boca_shell_appends.address_verification.input_address_information.lat(OVERRIDE:_add__curr__lat_:\'\'),boca_shell_appends.address_verification.input_address_information.long(OVERRIDE:_add__curr__long_:\'\'),boca_shell_appends.address_verification.input_address_information.isbestmatch(OVERRIDE:_add__input__isbestmatch_),boca_shell_appends.address_verification.input_address_information.date_first_seen(OVERRIDE:_bocashell__addr1__dt__first__seen_:DATE),boca_shell_appends.address_verification.input_address_information.date_last_seen(OVERRIDE:_bocashell__addr1__date__last__seen_:DATE),boca_shell_appends.historydatetimestamp(OVERRIDE:_historydatetimestamp_:\'\'),boca_shell_appends.reported_dob(OVERRIDE:_reported__dob_:DATE),boca_shell_appends.iid.diddeceased(OVERRIDE:_diddeceased_),boca_shell_appends.iid.diddeceaseddate(OVERRIDE:_diddeceaseddate_:DATE|OVERRIDE:Deceased_Date_:DATE),boca_shell_appends.fd_scores.fraudpoint_v3(OVERRIDE:_fraudpoint__v3_:\'\'),pr_best_appends.best_phone(OVERRIDE:_best__phone_:\'\'),pr_best_appends.dl_state(OVERRIDE:_best__drivers__license__state_:\'\'),pr_best_appends.dl_nbr(OVERRIDE:_best__drivers__license_:\'\'),dl_appends.expiration_date(OVERRIDE:_best__drivers__license__exp_:\'\'),boca_shell_appends.iid.diddeceaseddob(OVERRIDE:Deceased_Date_Of_Birth_:DATE),boca_shell_appends.iid.diddeceasedfirst(OVERRIDE:Deceased_First_:\'\'),boca_shell_appends.iid.diddeceasedlast(OVERRIDE:Deceased_Last_:\'\'),crim_hit(OVERRIDE:Crim_Hit_),curr_incar_flag(OVERRIDE:_curr__incar__flag_:\'\'),crim_match_type(OVERRIDE:_name__ssn__dob__match_:0),iprngbeg(OVERRIDE:_iprngbeg_:\'\'),iprngend(OVERRIDE:_iprngend_:\'\'),edgecountry(OVERRIDE:_edgecountry_:\'\'),edgeregion(OVERRIDE:_edgeregion_:\'\'),edgecity(OVERRIDE:_edgecity_:\'\'),edgeconnspeed(OVERRIDE:_edgeconnspeed_:\'\'),edgemetrocode(OVERRIDE:_edgemetrocode_:\'\'),edgelatitude(OVERRIDE:_edgelatitude_:\'\'),edgelongitude(OVERRIDE:_edgelongitude_:\'\'),edgepostalcode(OVERRIDE:_edgepostalcode_:\'\'),edgecountrycode(OVERRIDE:_edgecountrycode_:\'\'),edgeregioncode(OVERRIDE:_edgeregioncode_:\'\'),edgecitycode(OVERRIDE:_edgecitycode_:\'\'),edgecontinentcode(OVERRIDE:_edgecontinentcode_:\'\'),edgetwolettercountry(OVERRIDE:_edgetwolettercountry_:\'\'),edgeinternalcode(OVERRIDE:_edgeinternalcode_:\'\'),edgeareacodes(OVERRIDE:_edgeareacodes_:\'\'),edgecountryconf(OVERRIDE:_edgecountryconf_:\'\'),edgeregionconf(OVERRIDE:_edgeregionconf_:\'\'),edgecitycong(OVERRIDE:_edgecitycong_:\'\'),edgepostalconf(OVERRIDE:_edgepostalconf_:\'\'),edgegmtoffset(OVERRIDE:_edgegmtoffset_:\'\'),edgeindst(OVERRIDE:_edgeindst_:\'\'),siccode(OVERRIDE:_siccode_:\'\'),domainname(OVERRIDE:_domainname_:\'\'),ispname(OVERRIDE:_ispname_:\'\'),homebiztype(OVERRIDE:_homebiztype_:\'\'),asn(OVERRIDE:_asn_:\'\'),asnname(OVERRIDE:_asnname_:\'\'),primarylang(OVERRIDE:_primarylang_:\'\'),secondarylang(OVERRIDE:_secondarylang_:\'\'),proxytype(OVERRIDE:_proxytype_:\'\'),proxydescription(OVERRIDE:_proxydescription_:\'\'),isanisp(OVERRIDE:_isanisp_:\'\'),companyname(OVERRIDE:_companyname_:\'\'),ranks(OVERRIDE:_ranks_:\'\'),households(OVERRIDE:_households_:\'\'),women(OVERRIDE:_women_:\'\'),women18to34(OVERRIDE:_women18to34_:\'\'),women35to49(OVERRIDE:_women35to49_:\'\'),men(OVERRIDE:_men_:\'\'),men18to34(OVERRIDE:_men18to34_:\'\'),men35to49(OVERRIDE:_men35to49_:\'\'),teens(OVERRIDE:_teens_:\'\'),kids(OVERRIDE:_kids_:\'\'),naicscode(OVERRIDE:_naicscode_:\'\'),cbsacode(OVERRIDE:_cbsacode_:\'\'),cbsatitle(OVERRIDE:_cbsatitle_:\'\'),cbsatype(OVERRIDE:_cbsatype_:\'\'),csacode(OVERRIDE:_csacode_:\'\'),csatitle(OVERRIDE:_csatitle_:\'\'),mdcode(OVERRIDE:_mdcode_:\'\'),mdtitle(OVERRIDE:_mdtitle_:\'\'),organizationname(OVERRIDE:_organizationname_:\'\'),boca_shell_appends.advo_input_addr.address_vacancy_indicator(OVERRIDE:_advo__vacancyindicator_:\'\'),advo_appends.address_style_flag(OVERRIDE:_advo__addressstyle_:\'\'),boca_shell_appends.advo_input_addr.drop_indicator(OVERRIDE:_advo__dropindicator_:\'\'),boca_shell_appends.advo_input_addr.residential_or_business_ind(OVERRIDE:_advo__residentialorbusinessindicator_:\'\'),advo_appends.address_type(OVERRIDE:_advo__addresstype_:\'\'),advo_appends.mixed_address_usage(OVERRIDE:_advo__addressusagetype_:\'\')';
    SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
      SELF.Case_Id_ := __CN('');
      SELF.Client_Id_ := __CN('');
      SELF._unique__number_ := __CN('');
      SELF._addresspobox_ := __CN(FALSE);
      SELF._addresscmra_ := __CN(FALSE);
      SELF.Vanity_City_ := __CN('');
      SELF._is_Additional_ := __CN(FALSE);
      SELF.Type_ := __CN('');
      SELF.Created_On_ := __CN(0);
      SELF.Host_ := __CN('');
      SELF.Email_Last_Domain_ := __CN('');
      SELF._isdisposableemail_ := __CN(0);
      SELF.Ssn_Formatted_ := __CN('');
      SELF.Full_Bankname_ := __CN('');
      SELF.Abbreviated_Bankname_ := __CN('');
      SELF.Fractional_Routingnumber_ := __CN('');
      SELF.Headoffice_Routingnumber_ := __CN('');
      SELF.Headoffice_Branchcodes_ := __CN('');
      SELF.Bank_Hit_ := __CN('');
      SELF.Best_Hit_ := __CN(TRUE);
      SELF.Deceased_Middle_ := __CN('');
      SELF.Deceased_Match_Code_ := __CN('');
      SELF._isdeepdive_ := __CN(FALSE);
      SELF._county__death_ := __CN('');
      SELF.Deceased_Ssn_ := __CN('');
      SELF._state__death__flag_ := __CN('');
      SELF._death__rec__src_ := __CN('');
      SELF._state__death__id_ := __CN('');
      SELF._off__cat__list_ := __CN('');
      SELF._advo__hitflag_ := __CN('');
      SELF := __r;
    END;
    SHARED __d0_Out := RECORD
      RECORDOF(__PInputPIIDataset);
      KEL.typ.uid UID := 0;
    END;
    SHARED __d0_UID_Mapped := JOIN(__PInputPIIDataset,Lookup,TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
    SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
    SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'),__Mapping0_Transform(LEFT)));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED B_Event_8_Local := MODULE(B_Event_8)
    SHARED TYPEOF(E_Event.__Result) __E_Event := E_Event_Params.__Result;
  END;
  SHARED B_Event_7_Local := MODULE(B_Event_7)
    SHARED TYPEOF(B_Event_8.__ENH_Event_8) __ENH_Event_8 := B_Event_8_Local.__ENH_Event_8;
  END;
  SHARED B_Event_6_Local := MODULE(B_Event_6)
    SHARED TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7_Local.__ENH_Event_7;
  END;
  SHARED B_Event_5_Local := MODULE(B_Event_5)
    SHARED TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6_Local.__ENH_Event_6;
  END;
  SHARED B_Event_4_Local := MODULE(B_Event_4)
    SHARED TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License_Params.__Result;
    SHARED TYPEOF(B_Event_5.__ENH_Event_5) __ENH_Event_5 := B_Event_5_Local.__ENH_Event_5;
  END;
  SHARED B_Event_3_Local := MODULE(B_Event_3)
    SHARED TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4_Local.__ENH_Event_4;
  END;
  SHARED B_Event_2_Local := MODULE(B_Event_2)
    SHARED TYPEOF(B_Event_3.__ENH_Event_3) __ENH_Event_3 := B_Event_3_Local.__ENH_Event_3;
  END;
  SHARED B_Event_1_Local := MODULE(B_Event_1)
    SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer_Params.__Result;
    SHARED TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2_Local.__ENH_Event_2;
  END;
  SHARED B_Event_Local := MODULE(B_Event)
    SHARED TYPEOF(E_Address.__Result) __E_Address := E_Address_Params.__Result;
    SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer_Params.__Result;
    SHARED TYPEOF(E_Email.__Result) __E_Email := E_Email_Params.__Result;
    SHARED TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1_Local.__ENH_Event_1;
  END;
  SHARED TYPEOF(B_Event.__ENH_Event) __ENH_Event := B_Event_Local.__ENH_Event;
  SHARED __EE70857 := __ENH_Event;
  SHARED __ST8743_Layout := RECORD
    KEL.typ.int T1_L___Id_Curr_Incarc_Flag_ := 0;
    KEL.typ.nint T1_L___Id_Crim_Fl_Sd_Match_Flag_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Id_Age_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Adult_ := 0;
    KEL.typ.int Agency_Uid_ := 0;
    KEL.typ.int Agency_Prog_Type_ := 0;
    KEL.typ.nstr Agency_Prog_Jur_St_;
    KEL.typ.nint T___Src_Agency_Uid_;
    KEL.typ.nint T___Src_Agency_Prog_Type_;
    KEL.typ.nint T___Act_Uid_;
    KEL.typ.nkdate T___Act_Dt_Echo_;
    KEL.typ.nint T___Src_Type_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Person_Uid_Echo_;
    KEL.typ.nstr T___Inp_Cln_Title_Echo_;
    KEL.typ.nstr T___Inp_Cln_Full_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_First_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Middle_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Last_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Nm_Suffix_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Prim_Range_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Pre_Dir_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Prim_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Suffix_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Post_Dir_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Unit_Desig_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Sec_Range_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_City_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Zip5_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Zip4_Echo_;
    KEL.typ.nfloat T___Inp_Cln_Addr_Lat_Echo_;
    KEL.typ.nfloat T___Inp_Cln_Addr_Long_Echo_;
    KEL.typ.nint T___Inp_Cln_Addr_County_Echo_;
    KEL.typ.nint T___Inp_Cln_Addr_Geo_Blk_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ssn_Echo_;
    KEL.typ.nint T___Inp_Cln_Dob_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.nstr T___Inp_Cln_Phn_Echo_;
    KEL.typ.int T1___Lex_Id_Pop_Flag_ := 0;
    KEL.typ.int T1___Rin_Id_Pop_Flag_ := 0;
    KEL.typ.int T18___Is_Ip_Meta_Hit_Flag_ := 0;
    KEL.typ.nstr T18___Ip_Addr_City_;
    KEL.typ.nstr T18___Ip_Addr_Country_;
    KEL.typ.nstr T18___Ip_Addr_Region_;
    KEL.typ.nstr T18___Ip_Addr_Domain_;
    KEL.typ.nstr T18___Ip_Addr_Isp_Nm_;
    KEL.typ.nstr T18___Ip_Addr_Loc_Type_;
    KEL.typ.nstr T18___Ip_Addr_Proxy_Type_;
    KEL.typ.nstr T18___Ip_Addr_Proxy_Desc_;
    KEL.typ.nint T18___Ip_Addr_Is_Isp_Flag_;
    KEL.typ.nstr T18___Ip_Addr_Asn_Comp_Nm_;
    KEL.typ.nstr T18___Ip_Addr_Asn_;
    KEL.typ.nstr T18___Ip_Addr_Comp_Nm_;
    KEL.typ.nstr T18___Ip_Addr_Org_Nm_;
    KEL.typ.int T18___Ip_Addr_Hosted_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Vpn_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Tor_Node_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Loc_Non_Us_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Loc_Miami_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Pop_Flag_ := 0;
    KEL.typ.int T19___Is_Bnk_App_Hit_Flag_ := 0;
    KEL.typ.nstr T19___Bnk_Acct_Bnk_Nm_;
    KEL.typ.int T19___Bnk_Acct_Hr_Pre_Pd_Rtg_Flag_ := 0;
    KEL.typ.int T17___Email_Pop_Flag_ := 0;
    KEL.typ.nstr T17___Email_Domain_;
    KEL.typ.nint T17___Email_Domain_Disp_Flag_;
    KEL.typ.int T9___Addr_Pop_Flag_ := 0;
    KEL.typ.nstr T9___Addr_Type_;
    KEL.typ.nstr T9___Addr_Status_;
    KEL.typ.int T16___Phn_Pop_Flag_ := 0;
    KEL.typ.int T15___Ssn_Pop_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Pop_Flag_ := 0;
    KEL.typ.int P1___Id_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P9___Addr_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P15___Ssn_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P16___Phn_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P17___Email_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P18___Ip_Addr_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P19___Bnk_Acct_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int P20___Dl_Risk_Unscrble_Flag_ := 0;
    KEL.typ.int T1___Stol_Id_Flag_ := 0;
    KEL.typ.int T1___Synth_Id_Flag_ := 0;
    KEL.typ.int T1_L___Dob_Not_Ver_Flag_ := 0;
    KEL.typ.int T1___Manip_I_D_Flag_ := 0;
    KEL.typ.int T1___Adult_Id_Not_Seen_Flag_ := 0;
    KEL.typ.int T1_L___Ssn_W_Alt_N_A_Ver_Flag_ := 0;
    KEL.typ.int T1___First_Nm_Not_Ver_Flag_ := 0;
    KEL.typ.int T1___Last_Nm_Not_Ver_Flag_ := 0;
    KEL.typ.int T1___Addr_Not_Ver_Flag_ := 0;
    KEL.typ.int T1_L___Hi_Risk_Cvi_Flag_ := 0;
    KEL.typ.int T1_L___Med_Risk_Cvi_Flag_ := 0;
    KEL.typ.int T1___Minor_W_Lex_I_D_Flag_ := 0;
    KEL.typ.int T1___Phn_Not_Ver_Flag_ := 0;
    KEL.typ.int T1_L___Ssn_W_Addr_Not_Ver_Flag_ := 0;
    KEL.typ.nint T1___Ssn_Prior_D_O_B_Flag_;
    KEL.typ.int T1_L___Ssn_Not_Ver_Flag_ := 0;
    KEL.typ.int T1_L___Curr_Addr_Not_In_Agcy_Jur_St_Flag_ := 0;
    KEL.typ.int T1_L___Best_Dl_Not_In_Agcy_Jur_St_Flag_ := 0;
    KEL.typ.int T1___Hdr_Src_Cat_Cnt_Lw_Flag_ := 0;
    KEL.typ.int T1_L___Id_Deceased_Flag_ := 0;
    KEL.typ.int T1_L___Id_Dt_Of_Death_Aft_Id_Act_Flag_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_Stol_Id_Act_Flag_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_Gen_Frd_Act_Flag_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_App_Frd_Act_Flag_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_Oth_Frd_Act_Flag_Ev_ := 0;
    KEL.typ.int P9___Aot_Addr_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int P15___Aot_Ssn_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int P16___Aot_Phn_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int P17___Aot_Email_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int P18___Aot_Ip_Addr_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int P19___Aot_Bnk_Acct_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int P20___Aot_Dl_Kr_Act_Flag_Ev_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE70857,__ST8743_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),T1_L___Id_Curr_Incarc_Flag_,T1_L___Id_Crim_Fl_Sd_Match_Flag_,Entity_Context_Uid_,In_Customer_Population_,Deceased_,Deceased_Name_Match_,Deceased_Dob_Match_,Deceased_Match_,Currently_Incarcerated_Flag_,Id_Age_,No_Lex_Id_,No_Lex_Id_Adult_,Agency_Uid_,Agency_Prog_Type_,Agency_Prog_Jur_St_,T___Src_Agency_Uid_,T___Src_Agency_Prog_Type_,T___Act_Uid_,T___Act_Dt_Echo_,T___Src_Type_,T___Src_Class_Type_,T___Person_Uid_Echo_,T___Inp_Cln_Title_Echo_,T___Inp_Cln_Full_Nm_Echo_,T___Inp_Cln_First_Nm_Echo_,T___Inp_Cln_Middle_Nm_Echo_,T___Inp_Cln_Last_Nm_Echo_,T___Inp_Cln_Nm_Suffix_Echo_,T___Inp_Cln_Addr_Prim_Range_Echo_,T___Inp_Cln_Addr_Pre_Dir_Echo_,T___Inp_Cln_Addr_Prim_Nm_Echo_,T___Inp_Cln_Addr_Suffix_Echo_,T___Inp_Cln_Addr_Post_Dir_Echo_,T___Inp_Cln_Addr_Unit_Desig_Echo_,T___Inp_Cln_Addr_Sec_Range_Echo_,T___Inp_Cln_Addr_City_Echo_,T___Inp_Cln_Addr_St_Echo_,T___Inp_Cln_Addr_Zip5_Echo_,T___Inp_Cln_Addr_Zip4_Echo_,T___Inp_Cln_Addr_Lat_Echo_,T___Inp_Cln_Addr_Long_Echo_,T___Inp_Cln_Addr_County_Echo_,T___Inp_Cln_Addr_Geo_Blk_Echo_,T___Inp_Cln_Ssn_Echo_,T___Inp_Cln_Dob_Echo_,T___Inp_Cln_Dl_St_Echo_,T___Inp_Cln_Email_Echo_,T___Inp_Cln_Bnk_Acct_Echo_,T___Inp_Cln_Bnk_Acct_Rtg_Echo_,T___Inp_Cln_Ip_Addr_Echo_,T___Inp_Cln_Phn_Echo_,T1___Lex_Id_Pop_Flag_,T1___Rin_Id_Pop_Flag_,T18___Is_Ip_Meta_Hit_Flag_,T18___Ip_Addr_City_,T18___Ip_Addr_Country_,T18___Ip_Addr_Region_,T18___Ip_Addr_Domain_,T18___Ip_Addr_Isp_Nm_,T18___Ip_Addr_Loc_Type_,T18___Ip_Addr_Proxy_Type_,T18___Ip_Addr_Proxy_Desc_,T18___Ip_Addr_Is_Isp_Flag_,T18___Ip_Addr_Asn_Comp_Nm_,T18___Ip_Addr_Asn_,T18___Ip_Addr_Comp_Nm_,T18___Ip_Addr_Org_Nm_,T18___Ip_Addr_Hosted_Flag_,T18___Ip_Addr_Vpn_Flag_,T18___Ip_Addr_Tor_Node_Flag_,T18___Ip_Addr_Loc_Non_Us_Flag_,T18___Ip_Addr_Loc_Miami_Flag_,T19___Bnk_Acct_Pop_Flag_,T19___Is_Bnk_App_Hit_Flag_,T19___Bnk_Acct_Bnk_Nm_,T19___Bnk_Acct_Hr_Pre_Pd_Rtg_Flag_,T17___Email_Pop_Flag_,T17___Email_Domain_,T17___Email_Domain_Disp_Flag_,T9___Addr_Pop_Flag_,T9___Addr_Type_,T9___Addr_Status_,T16___Phn_Pop_Flag_,T15___Ssn_Pop_Flag_,T18___Ip_Addr_Pop_Flag_,P1___Id_Risk_Unscrble_Flag_,P9___Addr_Risk_Unscrble_Flag_,P15___Ssn_Risk_Unscrble_Flag_,P16___Phn_Risk_Unscrble_Flag_,P17___Email_Risk_Unscrble_Flag_,P18___Ip_Addr_Risk_Unscrble_Flag_,P19___Bnk_Acct_Risk_Unscrble_Flag_,P20___Dl_Risk_Unscrble_Flag_,T1___Stol_Id_Flag_,T1___Synth_Id_Flag_,T1_L___Dob_Not_Ver_Flag_,T1___Manip_I_D_Flag_,T1___Adult_Id_Not_Seen_Flag_,T1_L___Ssn_W_Alt_N_A_Ver_Flag_,T1___First_Nm_Not_Ver_Flag_,T1___Last_Nm_Not_Ver_Flag_,T1___Addr_Not_Ver_Flag_,T1_L___Hi_Risk_Cvi_Flag_,T1_L___Med_Risk_Cvi_Flag_,T1___Minor_W_Lex_I_D_Flag_,T1___Phn_Not_Ver_Flag_,T1_L___Ssn_W_Addr_Not_Ver_Flag_,T1___Ssn_Prior_D_O_B_Flag_,T1_L___Ssn_Not_Ver_Flag_,T1_L___Curr_Addr_Not_In_Agcy_Jur_St_Flag_,T1_L___Best_Dl_Not_In_Agcy_Jur_St_Flag_,T1___Hdr_Src_Cat_Cnt_Lw_Flag_,T1_L___Id_Deceased_Flag_,T1_L___Id_Dt_Of_Death_Aft_Id_Act_Flag_Ev_,P1___Aot_Id_Kr_Stol_Id_Act_Flag_Ev_,P1___Aot_Id_Kr_Gen_Frd_Act_Flag_Ev_,P1___Aot_Id_Kr_App_Frd_Act_Flag_Ev_,P1___Aot_Id_Kr_Oth_Frd_Act_Flag_Ev_,P9___Aot_Addr_Kr_Act_Flag_Ev_,P15___Aot_Ssn_Kr_Act_Flag_Ev_,P16___Aot_Phn_Kr_Act_Flag_Ev_,P17___Aot_Email_Kr_Act_Flag_Ev_,P18___Aot_Ip_Addr_Kr_Act_Flag_Ev_,P19___Aot_Bnk_Acct_Kr_Act_Flag_Ev_,P20___Aot_Dl_Kr_Act_Flag_Ev_,__Part},T1_L___Id_Curr_Incarc_Flag_,T1_L___Id_Crim_Fl_Sd_Match_Flag_,Entity_Context_Uid_,In_Customer_Population_,Deceased_,Deceased_Name_Match_,Deceased_Dob_Match_,Deceased_Match_,Currently_Incarcerated_Flag_,Id_Age_,No_Lex_Id_,No_Lex_Id_Adult_,Agency_Uid_,Agency_Prog_Type_,Agency_Prog_Jur_St_,T___Src_Agency_Uid_,T___Src_Agency_Prog_Type_,T___Act_Uid_,T___Act_Dt_Echo_,T___Src_Type_,T___Src_Class_Type_,T___Person_Uid_Echo_,T___Inp_Cln_Title_Echo_,T___Inp_Cln_Full_Nm_Echo_,T___Inp_Cln_First_Nm_Echo_,T___Inp_Cln_Middle_Nm_Echo_,T___Inp_Cln_Last_Nm_Echo_,T___Inp_Cln_Nm_Suffix_Echo_,T___Inp_Cln_Addr_Prim_Range_Echo_,T___Inp_Cln_Addr_Pre_Dir_Echo_,T___Inp_Cln_Addr_Prim_Nm_Echo_,T___Inp_Cln_Addr_Suffix_Echo_,T___Inp_Cln_Addr_Post_Dir_Echo_,T___Inp_Cln_Addr_Unit_Desig_Echo_,T___Inp_Cln_Addr_Sec_Range_Echo_,T___Inp_Cln_Addr_City_Echo_,T___Inp_Cln_Addr_St_Echo_,T___Inp_Cln_Addr_Zip5_Echo_,T___Inp_Cln_Addr_Zip4_Echo_,T___Inp_Cln_Addr_Lat_Echo_,T___Inp_Cln_Addr_Long_Echo_,T___Inp_Cln_Addr_County_Echo_,T___Inp_Cln_Addr_Geo_Blk_Echo_,T___Inp_Cln_Ssn_Echo_,T___Inp_Cln_Dob_Echo_,T___Inp_Cln_Dl_St_Echo_,T___Inp_Cln_Email_Echo_,T___Inp_Cln_Bnk_Acct_Echo_,T___Inp_Cln_Bnk_Acct_Rtg_Echo_,T___Inp_Cln_Ip_Addr_Echo_,T___Inp_Cln_Phn_Echo_,T1___Lex_Id_Pop_Flag_,T1___Rin_Id_Pop_Flag_,T18___Is_Ip_Meta_Hit_Flag_,T18___Ip_Addr_City_,T18___Ip_Addr_Country_,T18___Ip_Addr_Region_,T18___Ip_Addr_Domain_,T18___Ip_Addr_Isp_Nm_,T18___Ip_Addr_Loc_Type_,T18___Ip_Addr_Proxy_Type_,T18___Ip_Addr_Proxy_Desc_,T18___Ip_Addr_Is_Isp_Flag_,T18___Ip_Addr_Asn_Comp_Nm_,T18___Ip_Addr_Asn_,T18___Ip_Addr_Comp_Nm_,T18___Ip_Addr_Org_Nm_,T18___Ip_Addr_Hosted_Flag_,T18___Ip_Addr_Vpn_Flag_,T18___Ip_Addr_Tor_Node_Flag_,T18___Ip_Addr_Loc_Non_Us_Flag_,T18___Ip_Addr_Loc_Miami_Flag_,T19___Bnk_Acct_Pop_Flag_,T19___Is_Bnk_App_Hit_Flag_,T19___Bnk_Acct_Bnk_Nm_,T19___Bnk_Acct_Hr_Pre_Pd_Rtg_Flag_,T17___Email_Pop_Flag_,T17___Email_Domain_,T17___Email_Domain_Disp_Flag_,T9___Addr_Pop_Flag_,T9___Addr_Type_,T9___Addr_Status_,T16___Phn_Pop_Flag_,T15___Ssn_Pop_Flag_,T18___Ip_Addr_Pop_Flag_,P1___Id_Risk_Unscrble_Flag_,P9___Addr_Risk_Unscrble_Flag_,P15___Ssn_Risk_Unscrble_Flag_,P16___Phn_Risk_Unscrble_Flag_,P17___Email_Risk_Unscrble_Flag_,P18___Ip_Addr_Risk_Unscrble_Flag_,P19___Bnk_Acct_Risk_Unscrble_Flag_,P20___Dl_Risk_Unscrble_Flag_,T1___Stol_Id_Flag_,T1___Synth_Id_Flag_,T1_L___Dob_Not_Ver_Flag_,T1___Manip_I_D_Flag_,T1___Adult_Id_Not_Seen_Flag_,T1_L___Ssn_W_Alt_N_A_Ver_Flag_,T1___First_Nm_Not_Ver_Flag_,T1___Last_Nm_Not_Ver_Flag_,T1___Addr_Not_Ver_Flag_,T1_L___Hi_Risk_Cvi_Flag_,T1_L___Med_Risk_Cvi_Flag_,T1___Minor_W_Lex_I_D_Flag_,T1___Phn_Not_Ver_Flag_,T1_L___Ssn_W_Addr_Not_Ver_Flag_,T1___Ssn_Prior_D_O_B_Flag_,T1_L___Ssn_Not_Ver_Flag_,T1_L___Curr_Addr_Not_In_Agcy_Jur_St_Flag_,T1_L___Best_Dl_Not_In_Agcy_Jur_St_Flag_,T1___Hdr_Src_Cat_Cnt_Lw_Flag_,T1_L___Id_Deceased_Flag_,T1_L___Id_Dt_Of_Death_Aft_Id_Act_Flag_Ev_,P1___Aot_Id_Kr_Stol_Id_Act_Flag_Ev_,P1___Aot_Id_Kr_Gen_Frd_Act_Flag_Ev_,P1___Aot_Id_Kr_App_Frd_Act_Flag_Ev_,P1___Aot_Id_Kr_Oth_Frd_Act_Flag_Ev_,P9___Aot_Addr_Kr_Act_Flag_Ev_,P15___Aot_Ssn_Kr_Act_Flag_Ev_,P16___Aot_Phn_Kr_Act_Flag_Ev_,P17___Aot_Email_Kr_Act_Flag_Ev_,P18___Aot_Ip_Addr_Kr_Act_Flag_Ev_,P19___Aot_Bnk_Acct_Kr_Act_Flag_Ev_,P20___Aot_Dl_Kr_Act_Flag_Ev_,__Part,MERGE),__ST8743_Layout),'__Part');
END;
