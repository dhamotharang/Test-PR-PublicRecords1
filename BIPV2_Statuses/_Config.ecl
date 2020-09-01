import MDR;

EXPORT _Config :=
module

  // http://prod_esp.br.seisint.com:8010/?Wuid=W20200421-133448&Widget=WUDetailsWidget -- look at Sources_source_DESC_pct_date result which analyzes the top 5 most frequent dt_last_seens for each source.  
  // -- using this, you can see which sources are more stable and which ones have big updates or swings that can dramatically affect golds and actives on a monthly basis.
  // -- high confidence sources use dates derived from vendor fields that correlate to how current the data in the record is.  Also, you can verify that they do not have big churns in their dates when looking at the above
  // -- wuid.  medium and low confidence sources have dates that are either not relevant to how current the data in the record is, or questionably relevant, or they use the process date.
  // -- and they have more churn in their dates
  
  // -- 37 total sources

  // -- high confidence sources use dates derived from vendor fields that correlate to how current the data in the record is.  Also, you can verify that they do not have big churns in their dates when looking at the above wuid.
	export set_High_conf := // 11 sources
      MDR.sourceTools.set_BBB                     // BBB2.Clean_Member -- member_since_date or report_date.  PROBABLY GOOD
    + MDR.sourceTools.set_bk                      // disposed_date, reopen_date , converted_date or date_filed.  all seem GOOD.  BankruptcyV2.fBankruptv2_As_Business_Linking  DAILY.
		+ MDR.sourceTools.set_Business_Registration   // BusReg.Standardize_Input .. uses start date, file date, form date, exp date, disol date, report date or change date.  seems relevant.  GOOD
    + MDR.sourceTools.set_CClue                   // CClue.As_Business_Linking -- claim_date.  PROBABLY GOOD
		+ MDR.sourceTools.set_CorpV2                  // Corp2.fCorp2_As_Business_Linking -- uses various dates from all 50 corp sources.  most used is filing date, status_date or event_filing_date.  GOOD
		+ MDR.sourceTools.set_DCA                     // uses update date.  DCAV2.Prep_Input.  GOOD
		+ MDR.sourceTools.set_Dunn_Bradstreet         // a.k.a. DNB_DMI.  DNB_DMI.Scrub_Number_Fields.  uses report date which is curated by D&B by calling the companies or public sources. GOOD.
		+ MDR.sourceTools.set_Frandx                  // -- uses franchise start date, Frandx.Standardize_Input.  GOOD
    + MDR.sourceTools.set_Liens_V2                // -- liensv2 uses filing date.  ex: LiensV2.mapping_CA_federal_party.  GOOD
    + MDR.sourceTools.set_LnPropertyV2            // -- uses tax year, recording date or sale date.  ex: LN_PropertyV2.Prep_Fares_Assessment.  PROBABLY GOOD, ALTHOUGH MAY BE MISSING MONTH AND DAY
    + MDR.sourceTools.set_Yellow_Pages            // YellowPages.As_Business_Linking -- uses pub_date.  guessing is publish date, which could be GOOD.
    ;

  // -- medium and low confidence sources have dates that are either not relevant to how current the data in the record is, or questionably relevant, or they use the process date.
  // -- use vendor date that has lots of churn(SBFE, databridge) and lots of records, or questionable vendor dates or process date
	export set_medium_conf := // 11 sources
      MDR.sourceTools.set_Business_Credit         // Business_Credit.fn_linkSBFEFile -- portfolioHeader.Cycle_End_Date.  NOT SURE, but lots of updates in FEB, so this will have a lot of churn, and cause big swings in gold.  out of top 5, 4 are in 2020 and account for 20% of all dates.
    + MDR.sourceTools.set_DataBridge              // DataBridge.Standardize_Input -- uses Transaction_date.  NOT SURE, BUT ISSUES WITH IT.  top 2 most frequent dates account for over 40% of all dt_last_seens.  not good
		+ MDR.sourceTools.set_Dunn_Bradstreet_Fein    // a.k.a. DNB_FEIN uses DATE_INPUT_DATA.  not sure how good this is or what it refers to.  need data dictionary.  DNB_FEINV2.Mapping_as_base_main.  NOT SURE, GUT TELLS ME DON'T USE IT.  top 5 = 22% of all dates
		+ MDR.sourceTools.set_EBR                     // -- extract date or file_estab_date.  EBR.BDID_0010_Header -- move to medium conf because questions about reliability of dates.  NOT SURE, but we do seem to get lots with same date in updates.  top date is 12.5%, #2 is 8% and from 2020 which accounts for big increase in actives.  
    + MDR.sourceTools.set_Equifax_Business_Data   // Record_Update_Refresh_Date .  Equifax_Business_Data.Standardize_Input  .  NOT SURE.. top 5 = 17% of all dates.
	  + MDR.sourceTools.set_Experian_CRDB           // Last_Experian_Inquiry_Date.  Experian_CRDB.As_Business_Linking .  NOT SURE.  HAVE TO LOOK AT DD.  top 5 = 13% of all.  not too bad.
		+ MDR.sourceTools.set_FBNV2                   // uses process date for dt_last_seen sometimes.  but file_date for dt_first_seen and sometimes for dt_last_seen depending on the source.  monthly..  example: FBNV2.Standardize_FBN_CA_Orange, FBNV2.Mapping_FBN_FL_Business.  MOSTLY GOOD.  some have very high frequencies of one date, like 92%, but the actual numbers are very low(110K), and the those ones are old, so this still looks GOOD.
    + MDR.sourceTools.set_FDIC                    // Govdata.fFDIC_As_Business_Linking -- repdte or endefymd .  NOT SURE.  #1 date = 14.7%, rest are very low percentages and only 35K total records.
	  + MDR.sourceTools.set_Infutor_NARB            // Infutor_NARB.Standardize_Input -- validationdate.  BAD.  #1 = 45% and is from 2020 and 10 million records.  so lots of churn.  #2 also from 2020 and 11%.
    + MDR.sourceTools.set_OSHAIR                  // OSHAIR.fCleaned_OSHAIR_Inspection_As_Business_Linking -- uses last_activity_date.  NOT SURE.  lots of old dates.  top 5 are from 70s and 80s.  5.6 million total
    + MDR.sourceTools.set_UCCS                    // -- uses process date, but is run daily, ex: UCCV2.proc_build_CA_party_base.  PROBABLY GOOD.  265 million total.  out of top 5, #4 is from 2020 at 2% and 5 million records.  rest are old.
    ;

  // -- low confidence sources have dates that are either not relevant to how current the data in the record is, or they use the process date.
  // -- uses process_date, not relevant vendor date, no dates, commented out or dead source
	export set_low_conf := // 15 sources
      MDR.sourceTools.set_AK_Busreg               // CHECK TO SEE IF THIS EXISTS IN OUR FILE  ak_busreg module, but don't see it in BIPV2.Business_Sources.  is it in Busreg module?  DON'T SEE IT.
		+ MDR.sourceTools.set_Cortera                 // LOC_DATE_LAST_SEEN.  Cortera.proc_processHeader.  but this does not relate to how current the data is(vendor told us this).  NOT GOOD.  
    + MDR.sourceTools.set_Credit_Unions           // Credit_Unions.Standardize_Input -- uses process date.  BAD
    + MDR.sourceTools.set_Dea                     // dea.Proc_Build_Preprocess -- uses process date even though there is an expiration date that might be relevant.  BAD
    + MDR.sourceTools.set_Experian_FEIN           // don't have dt_last_seen.  doesn't look like they send dates in the update records.  monthly build.  BAD  THIS SOURCE HAS NO DATES AT ALL!!!
    + MDR.sourceTools.set_FAA                     // faa.aircraft_preprocess -- uses process date.  monthly.  PROBABLY BAD
    + MDR.sourceTools.set_FBNV2_BusReg            // NOT SURE ABOUT THIS EITHER.  DONT SEE IT IN MY EXAMPLES IN THE WUID.  
    + MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ    // InfoUSA.fABIUS_Company_As_Business_Linking -- uses DATE ADDED.  this is a DEAD source.  OLD BAD
    + MDR.sourceTools.set_IRS_5500                // COMMENTED OUT
    + MDR.sourceTools.set_IRS_Non_Profit          // Govdata.fIRS_Non_Profit_As_Business_Linking -- uses process date even though dt_first_seen uses ruling date or tax period(unfortunately or process date too if those are blank).  BAD  monthly
    + MDR.sourceTools.set_State_Sales_Tax         // CA_Sales_Tax_File_Date.  Govdata.fCA_Sales_Tax_As_Business_Linking.  GOOD, but old from 2006.  MUST BE DEAD SOURCE.
    + MDR.sourceTools.set_TXBUS                   // TXBUS.Cleaned_Txbus -- uses process date, even though it contains Outlet_Permit_Issue_Date and Outlet_First_Sales_Date(Txbus.Layouts_txbus) which might be relevant.  PROBABLY BAD.  weekly
    + MDR.sourceTools.set_vehicles                // I think this is an example, although it is hard to follow: VehLic.ID_as_Vehicles.  uses process date, even though orig_EXPIRATION_DATE & orig_ISSUE_DATE exist in the record.  BAD.  every two weeks.
    + MDR.sourceTools.set_WC                      // filtered out.  NOT USED
    + MDR.sourceTools.set_Workers_Compensation    // build date.  every two weeks  BAD
    ;                                            

end;