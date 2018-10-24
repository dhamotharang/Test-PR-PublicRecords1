// This should be shared among all future services (in theory)
IMPORT census_data, Risk_Indicators, ut, doxie, AutoStandardI,address, suppress, iesp, lib_stringlib;
  
EXPORT ECL2ESP := MODULE

  
  // function takes in a t_Date and returns a string8 date.
	EXPORT string8 t_DateToString8(iesp.share.t_Date inDate) := function
		string8 outDate := (string)(inDate.day+(inDate.month*100)+(inDate.year*10000));
		return if(outDate='0','',outDate);
	end;
	
  EXPORT iesp.share.t_Date toDate (unsigned4 d) := 
    row ({d DIV 10000, (d % 10000) DIV 100, d % 100}, iesp.share.t_Date);
    
  EXPORT iesp.share.t_Date2 toTDate2 (unsigned4 d) :=
    row ({(STRING4)(d DIV 10000), (STRING2)((d % 10000) DIV 100), (STRING2)(d % 100)}, iesp.share.t_Date2);

  EXPORT iesp.share.t_Date toDateYM (unsigned3 d) := 
    row ({d DIV 100, d % 100, 0}, iesp.share.t_Date);

  EXPORT iesp.share.t_Date toDatestring8 (string8 d) := 
    row ({(integer2) d[1..4],(integer2) d[5..6],(integer2) d[7..8]}, iesp.share.t_Date);  

  EXPORT iesp.share.t_Date toDatestring8MMDDYYYY (string8 d) := 
    row ({(integer2) d[5..8],(integer2) d[1..2],(integer2) d[3..4]}, iesp.share.t_Date);  
		
  EXPORT string8 DateToString (iesp.share.t_Date Date) := 
    intformat (Date.Year, 4, 1) + intformat (Date.Month, 2, 1) + intformat (Date.Day, 2, 1);

  EXPORT integer DateToInteger (iesp.share.t_Date Date) := (integer) DateToString (Date);

	EXPORT iesp.share.t_TimeStamp toTimeStamp(STRING d) := ROW(TRANSFORM(iesp.share.t_TimeStamp,
										Self.Year   := (INTEGER2) d[1..4], 
										Self.Month  := (INTEGER2) d[5..6], 
										Self.Day    := (INTEGER2) d[7..8],
										Self.Hour24 := (INTEGER2) d[10..11],	
										Self.Minute := (INTEGER2) d[12..13],
										Self.Second := (INTEGER2) d[14..15]));
		
	// d = //YYYYMMDD 
	EXPORT iesp.share.t_MaskableDate toMaskableDatestring8 (string8 d) := 
    row ({d[1..4],d[5..6],d[7..8]}, iesp.share.t_MaskableDate);  
  // Perhaps, better create TRANSFORMs instead of functions.

  shared sc := suppress.Constants.datemask;

  EXPORT iesp.share.t_Date ApplyDateMask (iesp.share.t_Date dt, unsigned1 dob_mask) := 
    row (transform (iesp.share.t_Date, 
                    Self.Year  := if ((dob_mask = sc.YEAR) or (dob_mask = sc.ALL), 0, dt.Year),
                    Self.Month := if ((dob_mask = sc.MONTH) or (dob_mask = sc.ALL), 0, dt.Month),
                    Self.Day   := if ((dob_mask = sc.DAY) or (dob_mask = sc.ALL), 0, dt.Day)));
 
 //isDoNotMaskEmpty enables to conditionally mask or unmask when the date value is absent.
  EXPORT iesp.share.t_MaskableDate ApplyDateStringMask (iesp.share.t_MaskableDate dt, unsigned1 dob_mask , boolean isDoNotMaskEmpty = false) := 
	if(isDoNotMaskEmpty ,
    row (transform (iesp.share.t_MaskableDate, 
                    Self.Year  := if ((dob_mask = sc.YEAR or dob_mask = sc.ALL) and (integer)dt.Year > 0, 'XXXX', dt.Year),
                    Self.Month := if ((dob_mask = sc.MONTH or dob_mask = sc.ALL) and (integer)dt.Month > 0, 'XX', dt.Month),
                    Self.Day   := if ((dob_mask = sc.DAY or dob_mask = sc.ALL) and (integer)dt.Day > 0, 'XX', dt.Day)))
										,
		 row (transform (iesp.share.t_MaskableDate, 
                    Self.Year  := if ((dob_mask = sc.YEAR) or (dob_mask = sc.ALL), 'XXXX', dt.Year),
                    Self.Month := if ((dob_mask = sc.MONTH) or (dob_mask = sc.ALL), 'XX', dt.Month),
                    Self.Day   := if ((dob_mask = sc.DAY) or (dob_mask = sc.ALL), 'XX', dt.Day))) 
	 );

  // naive implementation of gender translation
  // Generally, this can be a wrapper for any more complex functionality.
  EXPORT string GetGender (string3 prefix) := function
    string pers_title := trim (stringlib.StringToUpperCase (prefix));
    return MAP (pers_title = 'MR' => 'Male',
                pers_title = 'MS' => 'Female',
                '');
  end;

  EXPORT iesp.bpsreport.t_BpsReportCensusData ProjectCensus (census_data.Key_Smart_Jury cens) := FUNCTION
       iesp.bpsreport.t_BpsReportCensusData SetCensus (census_data.Key_Smart_Jury cens) := TRANSFORM
         Self.Age := (integer) cens.age;// {xpath('Age')};
         Self.Income := cens.income; // {xpath('Income')};
         Self.HomeValue := cens.home_value; // {xpath('HomeValue')};
         Self.Education := cens.education; // {xpath('Education')};
       END;
       RETURN PROJECT (cens, SetCensus (Left));
   END;


  EXPORT iesp.share.t_RiskIndicator FormatRiskIndicators (Risk_Indicators.Layout_Desc L) := TRANSFORM
    Self.RiskCode := L.hri;
    Self.Description := L.desc;
  END;

  shared waf := RECORD
    unsigned8 comp_prop_count := 0;
    unsigned8 veh_cnt := 0;
    unsigned8 dl_cnt := 0;
    unsigned8 rel_count := 0;
    unsigned8 assoc_count := 0;
    unsigned8 prof_count := 0;
    unsigned8 paw_count := 0;
    unsigned8 vess_count := 0;
    unsigned8 email_count := 0;
    unsigned8 phonesplus_count := 0;
  END;


  // status code, message and exceptions are out of ECL control;
  // these are ESP-specific and they must be read from XML directly in the future.
  shared string q_id := '' : stored ('_QueryId');
  shared string t_id := '' : stored ('_TransactionId');
  EXPORT GetHeaderRow () := ROW ({0, '', q_id, t_id, []}, iesp.share.t_ResponseHeader);

  // This block of code is modeled after MAC_Marshall_Results, but it uses iesp-style
  // parameters and returns everything in a dataset instead of OUTPUTting the RecordCount
	export Marshall := module
		
		export integer return_count			:= 10	: stored('ReturnCount');		// records per page
		export integer starting_record	:= 1	: stored('StartingRecord');	// which record page starts with
		
		export integer max_return := ut.Min2(
			return_count, iesp.Constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS
		);
	
    export Mac_Set (tag_options) := macro
      unsigned ReturnCount := global(tag_options).ReturnCount;
      #stored ('ReturnCount', ReturnCount);
      unsigned StartingRecord := global(tag_options).StartingRecord;
      #stored ('StartingRecord', StartingRecord);
    endmacro;

		/*
		** This macro incorporates the supplied records into the standard ESDL output structure, counting and
		** paging when requested.  An "extra" field or dataset may now be supplied, which is useful for reporting
		** info about the results that isn't tied to each individual record.
		*/
		export MAC_Marshall_Results(infile,outfile,l_out,recField='Records',noCount=false,countField='RecordCount',extraField='',extraValue='',
																maxRetCnt=iesp.Constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS) := macro
			#uniquename(xform)
			l_out %xform%() := transform
				self._Header			:= iesp.ECL2ESP.GetHeaderRow();
				#if(noCount=false)
					self.countField	:= count(infile);
					self.recField		:= choosen(infile, MIN(iesp.ECL2ESP.Marshall.max_return,maxRetCnt), iesp.ECL2ESP.Marshall.starting_record);
				#else
					self.recField		:= infile;
				#end
				#if(#TEXT(extraField)<>'')
					self.extraField	:= extraValue;
				#end
				self							:= [];
			end;
			outfile := dataset([%xform%()]);
		endmacro;
	end;


  //////////////////////////////////////////////////////////////////
  // Maps ESP-standard input parameters' names to ECL-style names //
  //////////////////////////////////////////////////////////////////

  // ===========================================================================================
  // Re: #34281: in some cases we can try to find out whether tag was or default should be used.
  // Generally, when there's a discrepancy between ecl-type and "actual" type. For example, glb,
  // dppa: ecl-type string, but actual is an integer. Another case would be when "zero" value is
  // the same as default: SSN Mask 'NONE' is the same as blank...
  // For all others: ESP MUST send tags for values whos type/default pair is
  // integer/non-zero; string/non-blank; boolean/true
  //
  // This approach IS a patch: currently the only way of reliable specifying defaults is
  // passing tags by ESP. This may change in the future depending on #34281 resolution.
  // ===========================================================================================

  // iesp.share.t_Name Name {xpath('Name')};
  EXPORT SetInputName (iesp.share.t_Name xml_in, boolean cleanInputs = false) := FUNCTION
		// if cleanInputs is true and at least firstName and LastName have content,
		//    re-clean first/last and #store them, and blank full-name, if any;
    // otherwise, #store whatever was provided

    string20 First := global(xml_in).First;
    string20 Middle := global(xml_in).Middle;
    string20 Last := global(xml_in).Last;
    string5 Suffix := global(xml_in).Suffix;
    string62 Full := global(xml_in).Full;

		shouldClean := cleanInputs and (First <> '' and Last <> '');
		cleaned_name := address.CleanPersonFML73 (First + ' ' + Middle + ' ' + Last + ' ' + Suffix);

		s_First := IF(shouldClean, cleaned_name[6..25], First);
		s_Middle := IF(shouldClean, cleaned_name [26..45], Middle);
		s_Last := IF(shouldClean, cleaned_name[46..65], Last);
		s_Suffix := IF(shouldClean, cleaned_name[66..70], Suffix);
		s_Full := IF (shouldClean, '', Full); // avoid ambiguity if both full and parsed were provided
		
    #stored ('FirstName', s_First);
    #stored ('MiddleName', s_Middle);
    #stored ('LastName', s_Last);
    #stored ('namesuffix', s_Suffix); // unlikely used anywhere.
    #stored ('UnParsedFullName', s_Full);
		// string3 Prefix {xpath('Prefix')};
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	EXPORT SetInputNameCompanyName (iesp.share.t_NameAndCompany xml_in) := FUNCTION
    string62 Full := global(xml_in).Full;
    #stored ('UnParsedFullName', Full);
    string20 First := global(xml_in).First;
    #stored ('FirstName', First);
    string20 Middle := global(xml_in).Middle;
    #stored ('MiddleName', Middle);
    string20 Last := global(xml_in).Last;
    #stored ('LastName', Last);
    string5 Suffix := global(xml_in).Suffix;
    #stored ('namesuffix', Suffix);	
		 string62 CompanyName := global(xml_in).CompanyName;
    #stored ('CompanyName', CompanyName); 
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;

  // iesp.share.t_Address Address {xpath('Address')};
  EXPORT SetInputAddress (iesp.share.t_Address xml_in, boolean cleanInputs = false) := FUNCTION
		// if cleanInputs is true, we don't want to #store any of the component parts, 
		// as InterfaceTranslator prefers those over the cleaned inputs
    string28 streetName := global(xml_in).StreetName;
		s_StreetName := IF(cleanInputs, '', streetName);
    #stored ('prim_name', s_streetName);
    string10 streetNumber := global(xml_in).StreetNumber;
		s_StreetNumber := IF(cleanInputs, '', streetNumber);
    #stored ('prim_range', s_streetNumber);
    string2 streetPreDirection := global(xml_in).StreetPreDirection;
		s_streetPreDirection := IF(cleanInputs, '', streetPreDirection);
    #stored ('predir', s_streetPreDirection);
    string2 streetPostDirection := global(xml_in).StreetPostDirection;
		s_streetPostDirection := IF(cleanInputs, '', streetPostDirection);
    #stored ('postdir', s_streetPostDirection);
    string4 streetSuffix := global(xml_in).StreetSuffix;
		s_streetSuffix := IF(cleanInputs, '', streetSuffix);
    #stored ('suffix', s_streetSuffix);
      // string10 UnitDesignation {xpath('UnitDesignation')};
    string8 UnitNumber := global(xml_in).UnitNumber;
		s_UnitNumber := IF(cleanInputs, '', UnitNumber);
    #stored ('sec_range', s_UnitNumber);
		
		in_streetaddr := address.Addr1FromComponents(streetNumber,StreetPreDirection,streetName,StreetSuffix,
																								 StreetPostDirection,'',UnitNumber);
    string60 in_streetAddress1 := IF(global(xml_in).StreetAddress1='',in_streetAddr,global(xml_in).StreetAddress1);
    string60 in_streetAddress2 := global(xml_in).StreetAddress2;
    string addr := trim (in_streetAddress1) + ' ' + trim (in_streetAddress2);
    #stored('Addr',addr);
    string2 State := global(xml_in).State;
    #stored ('State', State);
    string25 City := global(xml_in).City;
    #stored ('City', City);
    string5 zip5 := global(xml_in).Zip5; 
    #stored('zip',zip5);
    // string4 Zip4 {xpath('Zip4')};
    string18 County := global(xml_in).County;
		#stored('County',County);
    // string6 PostalCode {xpath('PostalCode')};
    string50 StateCityZip := global(xml_in).StateCityZip; 
    #stored('StateCityZip',StateCityZip);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;

  // iesp.share.t_Date DOB {xpath('DOB')}; 
  EXPORT SetInputDate (iesp.share.t_Date xml_in, string date_target) := FUNCTION
    integer2 Year  := global(xml_in).Year; 
    integer2 Month := global(xml_in).Month; 
    integer2 Day   := global(xml_in).Day;
    unsigned8 date := Year*10000 + Month*100 + Day;
//    #stored(date_target, date); // doesn't work
    #stored('dob', date);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;
		
  // iesp.share.t_User User {xpath('User')}; -- we use just a fraction of it
  EXPORT SetInputUser (iesp.share.t_User xml_in) := FUNCTION
    string in_dlpurpose := global(xml_in).DLPurpose;
    unsigned1 DLPurpose := if (in_dlpurpose = '', 0, (unsigned1) in_dlpurpose); 
    #stored('DPPAPurpose', DLPurpose);

    string in_glbpurpose := global(xml_in).GLBPurpose;
    unsigned1 GLBPurpose := if (in_glbpurpose = '', 8, (unsigned1) in_glbpurpose);
    #stored('GLBPurpose', GLBPurpose);

    string in_ssnmask := global(xml_in).SSNMask;
    string6 SSNMask := if (in_ssnmask = '', 'NONE', in_ssnmask);
    #stored('SSNMask', SSNMask);
    unsigned1 DLMask := (unsigned1) global(xml_in).DLMask; // def=0
    #stored('DLMask', DLMask);
		  STRING DOBMask := global(xml_in).DOBMask; // def=NONE
    #stored('DOBMask', DOBMask);
    string5 IndustryClass := global(xml_in).IndustryClass; // def=''
    #stored('IndustryClass', IndustryClass);
		  string32 ApplicationType := global(xml_in).ApplicationType; // def=''
    #stored('ApplicationType', ApplicationType);
		
    string50 DataRestrictionMask := global(xml_in).DataRestrictionMask; // must be provided: '1'
    #stored('DataRestrictionMask', DataRestrictionMask);
    string50 DataPermissionMask := global(xml_in).DataPermissionMask;   // def=''
    #stored('DataPermissionMask', DataPermissionMask);
    // integer MaxWaitSeconds {xpath('MaxWaitSeconds')}; // may be needed for soap calls?
    string50 QueryId := global(xml_in).QueryId; 
    #stored('_QueryId', QueryId);
		
		  boolean suppressDMVInfo := global(xml_in).ExcludeDMVPII;
		  #stored('ExcludeDMVPII', suppressDMVInfo);
		
		  string10 DeathMasterPurpose := global(xml_in).DeathMasterPurpose;
		  #stored('DeathMasterPurpose', DeathMasterPurpose);	
			
    // test data
    #stored ('TestDataEnabled', xml_in.TestDataEnabled);
    #stored ('TestDataTableName', xml_in.TestDataTableName);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;

  // iesp.share.t_BaseRequest
  EXPORT SetInputBaseRequest (iesp.share.t_BaseRequest xml_in) := FUNCTION
    // dataset(t_StringArrayItem) RemoteLocations {xpath('RemoteLocations/Item'), MAXCOUNT(1)};
    // dataset(t_ServiceLocation) ServiceLocations {xpath('ServiceLocations/ServiceLocation'), MAXCOUNT(1)};
    SetInputUser (xml_in.User);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;

  EXPORT SetInputReportBy (iesp.bpsreport.t_BpsReportBy xml_in, boolean cleanInputs = false) := FUNCTION
    SetInputName (global(xml_in).Name, cleanInputs);
    SetInputAddress (global(xml_in).Address, cleanInputs);
    // TODO: clarify what is ssn4-5 in the input?
	  string11 SSN       := trim (global(xml_in).SSN);
    string4  SSNLast4  := trim (global(xml_in).SSNLast4);
    string5  SSNFirst5 := trim (global(xml_in).SSNFirst5);
    string11 ssn_calc := MAP (SSN != '' => SSN, SSNLast4 != '' => SSNLast4, SSNFirst5);
    #stored('ssn', ssn_calc);
	  string12 UniqueId := global(xml_in).UniqueId;
    #stored('did', UniqueId);
    SetInputDate (global(xml_in).DOB, 'DOB');
    string15 Phone10 := global(xml_in).Phone10; // funny...
    #stored('phone', Phone10);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;

  // warning: usually every particular search query will pass its own extended 
  // search options -- a "wider" record: in this case object "slicing" will occur.
  EXPORT SetInputSearchOptions (iesp.share.t_BaseSearchOptionEx tag_searchex) := FUNCTION
    boolean UseNicknames := global(tag_searchex).UseNicknames; // must be provided: 'true'
    #stored ('allownicknames', UseNicknames);
    boolean IncludeAlsoFound := global(tag_searchex).IncludeAlsoFound; //def=false
    #stored ('nodeepdive', ~IncludeAlsoFound);
    boolean UsePhonetics := global(tag_searchex).UsePhonetics;  //def=false
    #stored ('phoneticmatch', UsePhonetics);
    boolean StrictMatch := global(tag_searchex).StrictMatch;  //def=false
    #stored ('StrictMatch', StrictMatch);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  
  shared blank_hri := dataset ([], iesp.share.t_RiskIndicator);


  EXPORT iesp.share.t_PhoneInfo setPhoneInfo (STRING phone10 = '', STRING pubNonPub = '', STRING ListingPh10 = '', STRING listingName = '', STRING timeZone = '', STRING listingTimeZone = '') := 
    FUNCTION
      iesp.share.t_PhoneInfo xform () := 
        TRANSFORM
          SELF.Phone10         := phone10;
          SELF.PubNonpub       := pubNonPub;
          SELF.ListingPhone10  := listingPh10;
          SELF.ListingName     := listingName;
          SELF.TimeZone        := timeZone;
          SELF.ListingTimeZone := listingTimeZone;
        END;
      RETURN ROW (xform ());
    END;

  EXPORT iesp.share.t_PhoneTimeZone  setPhoneTimeZone (STRING phone10, STRING TimeZone) := 
    FUNCTION
      iesp.share.t_PhoneTimeZone xform () :=
        TRANSFORM
          SELF.Phone10  := phone10;
          SELF.TimeZone := TimeZone;
        END;
      RETURN ROW( xform ());
    END;


  // inline definition of t_Name (neutral to order of fields in esdl-layout)
  shared MAC_BaseNameFields () := MACRO
    Self.First := first;
    Self.Middle := middle;
    Self.Last := last;
    Self.Suffix := suffix;
    Self.Prefix := prefix;
    Self.Full := full;
  ENDMACRO;

  EXPORT iesp.share.t_Name SetName (string first, string middle, string last, string suffix, string prefix, string full = '') := function
    iesp.share.t_Name xform () := transform
      MAC_BaseNameFields ();
    end;
    return Row (xform ());
  END;

  // inline definition of t_NameAndCompany (neutral to order of fields in esdl-layout)
  EXPORT iesp.share.t_NameAndCompany SetNameAndCompany (string first, string middle, string last, string suffix, 
                                                        string prefix, string full = '', string company = '') := function
    iesp.share.t_NameAndCompany xform () := transform
      MAC_BaseNameFields ();
      Self.CompanyName := company; 
    end;
    return Row (xform ());
  END;

  // this function should be deprecated eventually
  EXPORT SetNameFields(string fn, string mn, string lna, string na, string suf, string pre) :=               
				 SetName (fn, mn, lna, suf, pre);


  // inline definition of t_Address (neutral to order of fields in esdl-layout)
  shared MAC_BaseAddressFields () := MACRO
    Self.StreetNumber := primrange;
    Self.StreetPreDirection := predir;
    Self.StreetName := primname;
    Self.StreetSuffix := suffix;
    Self.StreetPostDirection := postdir;
    Self.UnitDesignation := unitdesig;
    Self.UnitNumber := secrange;
    Self.City := cityname;
    Self.State := st;
    Self.Zip5 := zip;
    Self.Zip4 := zip4;
    Self.County := countyname;
    Self.PostalCode := postalcode;
    Self.StreetAddress1 := addr1;
    Self.StreetAddress2 := addr2;
    Self.StateCityZip := stcityzip;
  ENDMACRO;

  EXPORT iesp.share.t_Address SetAddress (
           string primname, string primrange, string predir, string postdir,
           string suffix, string unitdesig, string secrange, string cityname,
           string st, string zip, string zip4, string countyname, 
           string postalcode = '', string addr1 = '', string addr2 = '', string stcityzip = '') := function
    iesp.share.t_Address xform () := transform
      MAC_BaseAddressFields ();
    end;
    return Row (xform ());
  END;

  EXPORT iesp.share.t_AddressEx SetAddressEx (
           string primname, string primrange, string predir, string postdir,
           string suffix, string unitdesig, string secrange, string cityname,
           string st, string zip, string zip4, string countyname, 
           string postalcode = '', string addr1 = '', string addr2 = '', string stcityzip = '',
           dataset(iesp.share.t_RiskIndicator) HRIs = blank_hri) := function
    iesp.share.t_AddressEx xform () := transform
      MAC_BaseAddressFields ();
      Self.HighRiskIndicators := HRIs;
    end;
    return Row (xform ());
  END;

  EXPORT iesp.share.t_AddressWithType SetAddressWithType (
           string primname, string primrange, string predir, string postdir,
           string suffix, string unitdesig, string secrange, string cityname,
           string st, string zip, string zip4, string countyname, 
           string postalcode = '', string addr1 = '', string addr2 = '', string stcityzip = '',
           string _type = '') := function
    iesp.share.t_AddressWithType xform () := transform
      MAC_BaseAddressFields ();
      Self._Type := _type;
    end;
    return Row (xform ());
  END;

  EXPORT iesp.share.t_UniversalAddress SetUniversalAddress (
           string primname, string primrange, string predir, string postdir,
           string suffix, string unitdesig, string secrange, string cityname,
           string st, string zip, string zip4, string countyname, 
           string postalcode = '', string addr1 = '', string addr2 = '', string stcityzip = '',
           string country = '', string province = '', boolean is_foreign = false) := function
    iesp.share.t_UniversalAddress xform () := transform
      MAC_BaseAddressFields ();
      Self.Country := country;
      Self.Province := province;
      Self.IsForeign := is_foreign;
    end;
    return Row (xform ());
  END;

  // this function should be deprecated eventually
  EXPORT SetAddressFields(string primname, string primrange, string predir, string postdir,
	                        string addrsuff, string unitdesig, string secrange, string pcityname,
													string vcityname, string paramcity, string st, string zip, string zip4,
													string countyname, string postalcode) :=
				 SetAddress(primname, primrange, predir, postdir, addrsuff, unitdesig, secrange, vcityname,
                    st, zip, zip4, countyname, postalcode);


  // inline definition of t_SSNInfo (neutral to order of fields in esdl-layout)
  shared MAC_BaseSSNFields () := MACRO
    Self.SSN := ssn;
    Self.Valid := valid;
    Self.IssuedLocation := location;
    Self.IssuedStartDate := issuedStart;
    Self.IssuedEndDate := issuedEnd;
  ENDMACRO;
		
  EXPORT iesp.share.t_SSNInfo SetSSNInfo (string ssn, string valid, string location, 
                                          iesp.share.t_Date issuedStart, iesp.share.t_Date issuedEnd) := function
    iesp.share.t_SSNInfo xform () := transform
      MAC_BaseSSNFields ();
    end;
    return Row (xform ());
  END;

  EXPORT iesp.share.t_SSNInfoEx SetSSNInfoEx (string ssn, string valid, string location, 
                                              iesp.share.t_Date issuedStart, iesp.share.t_Date issuedEnd, 
                                              dataset(iesp.share.t_RiskIndicator) HRIs = blank_hri) := function
    iesp.share.t_SSNInfoEx xform () := transform
      MAC_BaseSSNFields ();
      Self.HighRiskIndicators := HRIs;
    end;
    return Row (xform ());
  END;


  export EnforceRead () := beginc++ endc++;

  EXPORT string InsertPlaceHolders (string _value) := FUNCTION
  // no check for alpha-characters or leading zeros (responsibility of a caller)
  // returns input string unchanged if blank or longer than 12 chars (probably invalid value)
  // output string is generally bigger (caller should check)

    // validate:
    in_value := trim (_value, Left, Right);
    boolean is_formatted := stringlib.StringFind (in_value, ',', 1) > 0; // already formatted

    // cut off fractions (will be added at the result at the end) 
    pos_decimal := stringlib.StringFind (in_value, '.', 1);

    unsigned1 len := length (in_value);

    // string length without fractions (can be zero -- no whole-amount)
    integer1 len_wholes := IF (pos_decimal > 0, pos_decimal-1, len);

    rem := len_wholes % 3;
    start := if (rem = 0, 3, rem);
    whole_value := MAP (
      len_wholes > 9  => in_value[1..start] + ',' + in_value[start+1..start+3] + ',' + 
                         in_value[start+4..start+6] + ',' + in_value[start+7..start+9],
      len_wholes > 6  => in_value[1..start] + ',' + in_value[start+1..start+3] + ',' +  in_value[start+4..start+6],
      len_wholes > 3  => in_value[1..start] + ',' + in_value[start+1..start+3],
      len_wholes > 0  => in_value[1..start],
      '');
    // or
    // whole_value := if (len_wholes > 0, in_value[1..start], '') +
                   // if (len_wholes > 3, ',' + in_value[start+1..start+3], '') +
                   // if (len_wholes > 6, ',' + in_value[start+4..start+6], '') +
                   // if (len_wholes > 9, ',' + in_value[start+7..start+9], '');

    res := whole_value + if (pos_decimal > 0, in_value[pos_decimal..], '');
    return if (len_wholes > 12 OR len =0 or is_formatted, _value, res);
  END;


  EXPORT string FormatDollarAmount (string amount) := function
    int_amount := (integer) amount;
    return if (int_amount > 0, '$' + InsertPlaceHolders (amount), '');
  END;

  EXPORT string GetSSNValidation (string1 code) := MAP (
    code = 'G' => 'yes', 
    code = 'B' => 'no', 
    code = 'O' => 'no', 
   'maybe');
  
  EXPORT SetRiskIndicator(string riskCode, string description) :=               
				 Row({riskCode,description}, iesp.share.t_RiskIndicator);
  
  EXPORT SetStatusIndicator(string statusCode, string description) :=               
				 Row({statusCode,description}, iesp.share.t_RiskIndicator);

  shared boolean is_leap (unsigned2 year) := (year % 4 = 0) and (year % 100 != 0 or year % 400=0);

  shared unsigned1 days_in_month (unsigned1 month, unsigned2 year) := map (
    month in [1,3,5,7,8,10,12] => 31,
    month in [4,6,9,11] => 30,
    month = 2 => if (is_leap (year), 29, 28),
    0);

  export iesp.share.t_Duration GetDuration (string8 date_from, string8 date_to) := function 
    // switch places
    integer days_diff := (unsigned) date_to - (unsigned) date_from;
    dt_to   := if (days_diff > 0, date_to,   date_from);
    dt_from := if (days_diff > 0, date_from, date_to);

    // separate durations: full years, months, days
    years  := (unsigned) dt_to[1..4] - (unsigned) dt_from[1..4];
   integer months := (unsigned) dt_to[5..6] - (unsigned) dt_from[5..6]; // can be negative
   integer days   := (unsigned) dt_to[7..8] - (unsigned) dt_from[7..8]; // can be negative

    // months, adjusted for days accordingly
    all_months := years * 12 + months - if (days >= 0, 0 , 1);

    _years := all_months div 12;
    _months := all_months % 12;
    _days := if (days >= 0, days, days + days_in_month ((unsigned) dt_from[5..6], (unsigned) dt_from[1..4]));

    return row ({_years, _months, _days}, iesp.share.t_Duration);
  end;

  // wrapper to translate a tag name returned from ESP auto-generated code to an integer representing
  // Roxie internal data versioning. 
  // TODO: remove default from customer version
  export version (client_version = 0.0) := MODULE
    // shared ver := iesp.ws_accurint_versionmap (client_version);
    shared ver := iesp._version (client_version);
	  export unsigned1 Bankruptcy := map (ver.BankruptcyVersion = 'Bankruptcies' => 1,
                                        ver.BankruptcyVersion = 'Bankruptcies2' => 2, 1);
    export unsigned1 Ucc := map (ver.UccVersion = 'UCCFilingsNew' => 1,
                                        ver.UccVersion = 'UCCFilingsNew2' => 2, 1);
    export unsigned1 JudgmentLien := map (ver.JudgmentLienVersion = 'LiensJudgments' => 1,
                                        ver.JudgmentLienVersion = 'LiensJudgments2' => 2, 1);
    export unsigned1 Vehicles := map (ver.VehicleVersion = 'Vehicles' => 1,
                                        ver.VehicleVersion = 'Vehicles2' => 2, 1);
    export unsigned1 Voters := map (ver.VoterVersion = 'VoterRegistrations' => 1,
                                        ver.VoterVersion = 'VoterRegistrations2' => 2, 1);
    export unsigned1 Dl  := map (ver.DlVersion = 'DriverLicenses' => 1,
                                        ver.DlVersion = 'DriverLicenses2' => 2, 1);
    export unsigned1 Property := map (ver.PropertyVersion = 'Properties' => 1,
                                        ver.PropertyVersion = 'Properties2' => 2,1);
    export unsigned1 ProfLicense := map (ver.ProfLicenseVersion = 'ProfessionalLicenses' => 1,
                                         ver.ProfLicenseVersion = 'ProfessionalLicenses2' => 2,
                                         1);
    export unsigned1 CriminalRecord := 1;

    export unsigned1 Dea         := if (ver.DeaVersion = 'ControlledSubstances', 2, 0);
    export unsigned1 En          := 1; //counts only // getClientVersion() >= BZ46844_VERSION
    export unsigned1 Email       := if (ver.EmailVersion = 'EmailAddresses', 1, 0); // ver >= EMAIL_SEARCH_VERSION
    export unsigned1 PhonesPlus  := if (ver.PhonesPlusVersion = 'PhonesPluses2', 1, 0); // getClientVersion() >= PHONESPLUS_REPORT_VERSION)||  (getClientVersion()>=1.042 && m_ctx.checkOptional("lndayton"))
    export unsigned1 Provider    := if (ver.ProvidersVersion = 'Providers', 1, 0); // getClientVersion() < PROFESSIONALLICENSE_V2_VERSION
    export unsigned1 Sanctions   := if (ver.SanctionsVersion = 'Sanctions', 1, 0); // getClientVersion() < PROFESSIONALLICENSE_V2_VERSION
    export unsigned1 StateDeath  := 1; // getClientVersion() < DEATH_V2_VERSION
    export unsigned1 Targus      := 1; //counts only // getClientVersion() >= 1.0397
  end;

  // Set input business ids
  export SetInputBusinessIds(iesp.share.t_BusinessIdentity xml_in) :=
  function
    DotID := xml_in.DotID;
    #STORED('DotID',DotID);
    EmpID := xml_in.EmpID;
    #STORED('EmpID',EmpID);
    POWID := xml_in.POWID;
    #STORED('POWID',POWID);
    ProxID := xml_in.ProxID;
    #STORED('ProxID',ProxID);
    SELEID := xml_in.SELEID;
    #STORED('SELEID',SELEID);
    OrgID := xml_in.OrgID;
    #STORED('OrgID',OrgID);
    UltID := xml_in.UltID;
    #STORED('UltID',UltID);
    
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;
END;
