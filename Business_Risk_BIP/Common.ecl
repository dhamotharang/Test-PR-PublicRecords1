IMPORT BIPV2, Business_Credit, Business_Risk_BIP, Doxie, Inquiry_AccLogs, MDR, Models, UT, STD;

EXPORT Common := MODULE
	// Grabs just the linking ID's and Unique Seq Number - this is needed to use the BIP kFetch
	EXPORT GetLinkIDs(DATASET(Business_Risk_BIP.Layouts.Shell) shell) := FUNCTION
		
		BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
			SELF.UniqueID		:= le.Seq;
			SELF.PowID			:= le.BIP_IDs.PowID.LinkID;
			SELF.PowScore		:= le.BIP_IDs.PowID.Score;
			SELF.PowWeight	:= le.BIP_IDs.PowID.Weight;
			
			SELF.ProxID			:= le.BIP_IDs.ProxID.LinkID;
			SELF.ProxScore	:= le.BIP_IDs.ProxID.Score;
			SELF.ProxWeight	:= le.BIP_IDs.ProxID.Weight;
			
			SELF.SeleID			:= le.BIP_IDs.SeleID.LinkID;
			SELF.SeleScore	:= le.BIP_IDs.SeleID.Score;
			SELF.SeleWeight	:= le.BIP_IDs.SeleID.Weight;
			
			SELF.OrgID			:= le.BIP_IDs.OrgID.LinkID;
			SELF.OrgScore		:= le.BIP_IDs.OrgID.Score;
			SELF.OrgWeight	:= le.BIP_IDs.OrgID.Weight;
			
			SELF.UltID			:= le.BIP_IDs.UltID.LinkID;
			SELF.UltScore		:= le.BIP_IDs.UltID.Score;
			SELF.UltWeight	:= le.BIP_IDs.UltID.Weight;
			
			SELF := []; // Don't populate DotID or EmpID
		END;
		
		linkIDsOnly := PROJECT(shell, grabLinkIDs(LEFT));
		
		RETURN linkIDsOnly;
	END;
	
	
	
	// 1. slim down the header layout to only the fields we need in business_risk_bip queries
  // 2. rollup the duplicate records per source where the only difference between the records is the vl_id
	EXPORT mac_slim_header (RawData, SlimData) := MACRO
  SlimData1 := table(RawData,
{
uniqueid,
ultid,
orgid,
seleid,
proxid,
powid,
empid,
dotid,
UltScore,
OrgScore,
SELEScore,
ProxScore,
POWScore,
EmpScore,
DotScore,
UltWeight,
OrgWeight,
SELEWeight,
ProxWeight,
POWWeight,
EmpWeight,
DotWeight,
company_name,
company_fein,
company_phone,
prim_range,
predir,
prim_name,
addr_suffix,
postdir,
unit_desig,
sec_range,
p_city_name,
v_city_name,
st,
zip,
zip4,
fips_county,
geo_lat,
geo_long,
dt_first_seen,
dt_last_seen,
dt_vendor_first_reported,
dt_vendor_last_reported,
source,
fetch_error_code,
has_lgid,
is_sele_level,
is_org_level,
is_ult_level,
parent_proxid,
sele_proxid,
org_proxid,
ultimate_proxid,
levels_from_top,
nodes_below,
nodes_total,
ParentAboveSELE,
sele_gold,
ult_seg,
org_seg,
sele_seg,
prox_seg,
pow_seg,
dba_name,
company_org_structure_derived,
company_sic_code1,
company_sic_code2,
company_sic_code3,
company_sic_code4,
company_sic_code5,
company_naics_code1,
company_naics_code2,
company_naics_code3,
company_naics_code4,
company_naics_code5,
company_inc_state,
contact_did,
fname,
lname,
contact_phone,
contact_ssn,
dt_first_seen1 := min(group, dt_first_seen),            // get the earliest first seen in the group
dt_last_seen1 := max(group, dt_last_seen),             // get the latest last seen in the group
dt_vendor_first_reported1 := min(group,dt_vendor_first_reported), // get the earliest first reported in the group
dt_vendor_last_reported1 := max(group,dt_vendor_last_reported)  // get the latest last reported in the group
},

uniqueid,
ultid,
orgid,
seleid,
proxid,
powid,
empid,
dotid,
UltScore,
OrgScore,
SELEScore,
ProxScore,
POWScore,
EmpScore,
DotScore,
UltWeight,
OrgWeight,
SELEWeight,
ProxWeight,
POWWeight,
EmpWeight,
DotWeight,
company_name,
company_fein,
company_phone,
prim_range,
predir,
prim_name,
addr_suffix,
postdir,
unit_desig,
sec_range,
p_city_name,
v_city_name,
st,
zip,
zip4,
fips_county,
geo_lat,
geo_long,
dt_first_seen,
dt_last_seen,
dt_vendor_first_reported,
dt_vendor_last_reported,
source,
fetch_error_code,
has_lgid,
is_sele_level,
is_org_level,
is_ult_level,
parent_proxid,
sele_proxid,
org_proxid,
ultimate_proxid,
levels_from_top,
nodes_below,
nodes_total,
ParentAboveSELE,
sele_gold,
ult_seg,
org_seg,
sele_seg,
prox_seg,
pow_seg,
dba_name,
company_org_structure_derived,
company_sic_code1,
company_sic_code2,
company_sic_code3,
company_sic_code4,
company_sic_code5,
company_naics_code1,
company_naics_code2,
company_naics_code3,
company_naics_code4,
company_naics_code5,
company_inc_state,
contact_did,
fname,
lname,
contact_phone,
contact_ssn
);

temp_layout := record
  recordof(SlimData1) - dt_first_seen1 - dt_last_seen1 - dt_vendor_first_reported1 - dt_vendor_last_reported1;
end;

SlimData := project(SlimData1, transform(temp_layout,
self.dt_first_seen := left.dt_first_seen1;
self.dt_last_seen := left.dt_last_seen1;
self.dt_vendor_first_reported := left.dt_vendor_first_reported1;
self.dt_vendor_last_reported := left.dt_vendor_last_reported1;
self := left));
	ENDMACRO;
	
	// Have this here to be able to universally change between either Y/N or 1/0 depending on what product decides
	EXPORT SetBoolean(BOOLEAN input) := IF(input, '1', '0');
	
	// Given a Dataset, field in that Dataset to create the Delimited list from, and the Delimiter, will output a STRING field delimited list
	/* Usage: 
RiskCodeRecord := RECORD
	STRING SuspiciousRiskCode := '';
	STRING SuspiciousRiskCodeDescription := '';
END;
SetToConvert := DATASET([{'S01', ''},
												 {'S02', ''},
												 {'S04', ''},
												 {'S03', ''}], RiskCodeRecord);
converted := Suspicious_Fraud_LN.Common.convertDelimited(SetToConvert, SuspiciousRiskCode, ',');
OUTPUT(SetToConvert, NAMED('Set_To_Convert'));
OUTPUT(converted, NAMED('Converted_Set'));
	*/
	EXPORT convertDelimited(myDataset, field, delimiter, rollConditions = 'TRUE') := FUNCTIONMACRO
		myConvertRecord := RECORD
			RECORDOF(myDataset);
			STRING finalizedDelimitedList := '';
		END;

		prep := PROJECT(myDataset, TRANSFORM(myConvertRecord, SELF.finalizedDelimitedList := (STRING)LEFT.field; SELF := LEFT));
	
		roll := ROLLUP(prep, #EXPAND(rollConditions), TRANSFORM(myConvertRecord, SELF.finalizedDelimitedList := TRIM(LEFT.finalizedDelimitedList) + delimiter + TRIM(RIGHT.finalizedDelimitedList); SELF := LEFT));
	
		RETURN(roll[1].finalizedDelimitedList);
	ENDMACRO;
	
	// Generates a dataset from a delimited string field
	EXPORT fromDelimited(field, delimiter) := FUNCTIONMACRO
		outputLayout := RECORD
			STRING fieldValues := '';
		END;
		
		myDataset := Models.Common.Zip2(field, field, delimiter);
		
		final := PROJECT(myDataset, TRANSFORM(outputLayout, SELF.fieldValues := LEFT.Str1));
		
		RETURN(final);
	ENDMACRO;
	
	// Utilized for BIP kFetch calls rather than copying everywhere
	EXPORT SetLinkSearchLevel (INTEGER LinkSearchLevel) := CASE(LinkSearchLevel,
																							Business_Risk_BIP.Constants.LinkSearch.PowID	=> Business_Risk_BIP.Constants.FetchPowID,
																							Business_Risk_BIP.Constants.LinkSearch.ProxID	=> Business_Risk_BIP.Constants.FetchProxID,
																							Business_Risk_BIP.Constants.LinkSearch.SeleID	=> Business_Risk_BIP.Constants.FetchSeleID,
																							Business_Risk_BIP.Constants.LinkSearch.OrgID	=> Business_Risk_BIP.Constants.FetchOrgID,
																							Business_Risk_BIP.Constants.LinkSearch.UltID	=> Business_Risk_BIP.Constants.FetchUltID,
																																															 Business_Risk_BIP.Constants.FetchSeleID); // Defaulting to SeleID per Heather
	
	EXPORT GetLinkSearchLevel (LinkSearchLevel, DefaultLevel) := MACRO
									CASE(LinkSearchLevel, 
												 Business_Risk_BIP.Constants.LinkSearch.PowID		=> PowID,
												 Business_Risk_BIP.Constants.LinkSearch.ProxID	=> ProxID,
												 Business_Risk_BIP.Constants.LinkSearch.SeleID	=> SeleID,
												 Business_Risk_BIP.Constants.LinkSearch.OrgID		=> OrgID,
												 Business_Risk_BIP.Constants.LinkSearch.UltID		=> UltID,
																																					 DefaultLevel)
	ENDMACRO;
	
	// RawData = The result from kFetch
	// RawShell = The current running Business Shell fields containing cleaned input etc
	// JoinResult = This is the result of this join so that you can use the results later on
	// LinkSearchLevel = This indicates if our search was anything other than the default SeleID search
	// NOTE: This will hopefully be replaced in the future with kFetch2 BIP Enhancements
	EXPORT AppendSeq (RawData, RawShell, JoinResult, LinkSearchLevel) := MACRO
		JoinResult := JOIN(RawData, RawShell, LEFT.UltID = RIGHT.BIP_IDs.UltID.LinkID AND // UltID should always match
																					(LEFT.OrgID = RIGHT.BIP_IDs.OrgID.LinkID OR LinkSearchLevel IN Business_Risk_BIP.Constants.UltIDSet) AND // OrgID should match, OR we were doing an UltID only search
																					(LEFT.SeleID = RIGHT.BIP_IDs.SeleID.LinkID OR LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgIDSet) AND // SeleID should match, OR we were doing an UltID/OrgID only search
																					(LEFT.ProxID = RIGHT.BIP_IDs.ProxID.LinkID OR LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgSeleIDSet) AND // ProxID should match, OR we were doing an UltID/OrgID/SeleID/Default only search
																					(LEFT.PowID = RIGHT.BIP_IDs.PowID.LinkID OR LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgSeleProxIDSet), // PowID should match, OR we were doing an UltID/OrgID/SeleID/Default/ProxID only search
									TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength}, 
											SELF.Seq := RIGHT.Seq; 
											SELF.HistoryDate := RIGHT.Clean_Input.HistoryDate; 
											SELF.HistoryDateTime := RIGHT.Clean_Input.HistoryDateTime; 
											SELF.HistoryDateLength := LENGTH( (STRING)RIGHT.Clean_Input.HistoryDateTime );
											SELF := LEFT), 
									FEW); // Can use FEW because the RIGHT side should contain < 10000 rows (100 only average in batch)
	ENDMACRO;
	
	// Use this function when you need to re-append the History Date for each record after running a kFetch2
	// RawData = The result from kFetch2
	// RawShell = The current running Business Shell fields containing cleaned input etc
	// JoinResult = This is the result of this join so that you can use the results later on
	EXPORT AppendSeq2 (RawData, RawShell, JoinResult) := MACRO
		JoinResult := JOIN(RawData, RawShell, LEFT.UniqueID = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, UNSIGNED6 HistoryDateTime, UNSIGNED1 HistoryDateLength},
											SELF.Seq := RIGHT.Seq;
											SELF.HistoryDate := RIGHT.Clean_Input.HistoryDate; 
											SELF.HistoryDateTime := RIGHT.Clean_Input.HistoryDateTime; 
											SELF.HistoryDateLength := LENGTH( (STRING)RIGHT.Clean_Input.HistoryDateTime );
											SELF := LEFT), 
									FEW); // Can use FEW because the RIGHT side should contain < 10000 rows (100 only average in batch)
	ENDMACRO;
	
	// RawData = The result from AppendSeq
	// RawShell = The current running Business Shell fields containing cleaned input etc
	// JoinResult = This is the result of this join so that you can use the results later on
	EXPORT AppendCleanedInput (RawData, RawShell, JoinResult) := MACRO
		JoinResult := JOIN(RawData, RawShell, LEFT.Seq = RIGHT.Seq, 
							TRANSFORM({RECORDOF(LEFT), Business_Risk_BIP.Layouts.Input Clean_Input}, SELF.Clean_Input := RIGHT.Clean_Input; SELF := LEFT), 
							ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader), // Need to keep the largest limit in case this is utilized for the results of that append Seq
							FEW); // Can use FEW because the RIGHT side should contain < 10000 rows (100 only average in batch)
	ENDMACRO;
	
	// This functionmacro takes in a dataset (Generally from a kFetch that has been run through AppendSeq), the field in that dataset containing the source code,
	// and the field containing the date first seen.  It then returns only the records from sources that are allowed in the Business Shell, with DateFirstSeen prior to the history date.
	// The HistoryDate field is appended to myDataset as part of the AppendSeq macro above.
	EXPORT FilterRecords(myDataset, dateFirstSeenField, secondaryDateFirstSeenField, sourceCode, AllowedSourcesSet) := FUNCTIONMACRO
		filtered := myDataset ((sourceCode = '' OR sourceCode IN AllowedSourcesSet) AND // Only keep allowed Business Shell sources as specified by the prebuilt key
														IF((INTEGER)dateFirstSeenField > 0, ((HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)dateFirstSeenField)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6])) // If running in realtime mode - still filter out any future dates, but include everything up to today's date (Thus <= comparison)
														OR (INTEGER)(((STRING)dateFirstSeenField)[1..6]) < HistoryDate),
														((INTEGER)secondaryDateFirstSeenField > 0 AND ((HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)secondaryDateFirstSeenField)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6]))
														OR (INTEGER)(((STRING)secondaryDateFirstSeenField)[1..6]) < HistoryDate))));
		
		RETURN(filtered);
	ENDMACRO;
	
	// The following function evaluates whether a date from a matching record is earlier than 
	// a HistoryDateTime. It trims the longer of the two dates so that they both have the same formatting.
	// E.g. YYYYMM, YYYYMMDD, YYYYMMDDTTTT.
	EXPORT fn_filter_on_archive_date(INTEGER dt, INTEGER history_date_time, UNSIGNED1 history_date_length) :=
		FUNCTION
			length_dt := LENGTH( (STRING)dt );
			
			is_earlier_than_archive_date :=
				MAP(
					history_date_length < length_dt  => (INTEGER)(((STRING)dt)[1..history_date_length]) < history_date_time AND dt > 0,
					length_dt < history_date_length  => dt < (INTEGER)(((STRING)history_date_time)[1..length_dt]) AND dt > 0,
					/* else they're of equal length */  dt < history_date_time AND dt > 0
				);
			
			RETURN is_earlier_than_archive_date;
		END;
	
	// This functionmacro does the same thing as FilterRecords above, except it doesn't filter on
	// a HistroyDate of YYYYMM. Instead it filters on HistoryDateTime, which can have the following
	// formats: YYYYMM, YYYYMMDD, YYYYMMDDTTTT. The HistoryDate, HistoryDateTime, and HistoryDateLength 
	// fields are appended to myDataset as part of the AppendSeq macro above.
	EXPORT FilterRecords2(myDataset, dateFirstSeenField, sourceCode, AllowedSourcesSet) := FUNCTIONMACRO
		filtered := myDataset ((sourceCode = '' OR sourceCode IN AllowedSourcesSet) AND // Only keep allowed Business Shell sources as specified by the prebuilt key
													 ((HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)dateFirstSeenField)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6])) // If running in realtime mode - still filter out any future dates, but include everything up to today's date (Thus <= comparison)
														OR Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)dateFirstSeenField, HistoryDateTime, HistoryDateLength))); 
		
		RETURN(filtered);
	ENDMACRO;

//start FilterRecords3

	// This functionmacro is a copy of 'FilterRecords' above, but with additional logic to use the HistoryDateTime field as well as the HistoryDate field for filtering out header records for 	
	// archive purposes.  This is to make running in current mode return identical results as running with an archive date of today's date in the Boca shell.
	EXPORT FilterRecords3(myDataset, dateFirstSeenField, secondaryDateFirstSeenField, sourceCode, AllowedSourcesSet) := FUNCTIONMACRO
		filtered := myDataset ((sourceCode = '' OR sourceCode IN AllowedSourcesSet) AND // Only keep allowed Business Shell sources as specified by the prebuilt key
														IF((INTEGER)dateFirstSeenField > 0, ((HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)dateFirstSeenField)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6])) // If running in realtime mode - still filter out any future dates, but include everything up to today's date (Thus <= comparison)
														OR (INTEGER)(((STRING)dateFirstSeenField)[1..6]) < HistoryDate
														OR Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)dateFirstSeenField, HistoryDateTime, HistoryDateLength)),
														((INTEGER)secondaryDateFirstSeenField > 0 AND ((HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)secondaryDateFirstSeenField)[1..6]) <= (INTEGER)(StringLib.getDateYYYYMMDD()[1..6]))
														OR (INTEGER)(((STRING)secondaryDateFirstSeenField)[1..6]) < HistoryDate
														OR Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)secondaryDateFirstSeenField, HistoryDateTime, HistoryDateLength)))));
		
		RETURN(filtered);
	ENDMACRO;

//end FilterRecords3

	// This functionmacro does the same thing as FilterRecords2 above, except it omits the check for NinesDate
	// (actually covered in getFutureDate( ) below), and it filters on a HistoryDate set in the future.
	EXPORT FilterRecordsFuture(myDataset, dateFirstSeenField, sourceCode, AllowedSourcesSet) := FUNCTIONMACRO
		filtered := myDataset ((sourceCode = '' OR sourceCode IN AllowedSourcesSet) AND // Only keep allowed Business Shell sources as specified by the prebuilt key
													 Business_Risk_BIP.Common.fn_filter_on_archive_date(dateFirstSeenField, Business_Risk_BIP.Common.getFutureDate(HistoryDateTime), HistoryDateLength)); 
		
		RETURN(filtered);
	ENDMACRO;
	
	// Modifying the FilterRecords functionMacro for Cortera data. For Cortera records, we only want to keep records from the most recent Cortera build as of the history date.
	// This is defined as records marked as current, or records from within a week of the historydate (since we do weekly Cortera builds).
	EXPORT FilterCorteraRecords(myDataset, dateFirstSeenField, secondaryDateFirstSeenField, dateLastSeenField, currentIndicator, sourceCode, AllowedSourcesSet) := FUNCTIONMACRO
		filtered := myDataset ((sourceCode = '' OR sourceCode IN AllowedSourcesSet) AND
														dateFirstSeenField < (UNSIGNED)(((STRING)HistoryDate + '01')[1..8]) AND
														secondaryDateFirstSeenField < (UNSIGNED)(((STRING)HistoryDate + '01')[1..8]) AND
														secondaryDateFirstSeenField > 0 AND
														(currentIndicator OR
														(((STRING)HistoryDate) <> Business_Risk_BIP.Constants.NinesDate AND 
														dateLastSeenField >= STD.Date.AdjustDate((UNSIGNED)(((STRING)HistoryDate + '01')[1..8]), day_delta := -7))));
		RETURN(filtered);
	ENDMACRO;
	
	
	// This functionmacro takes in the results of kFetch2 and determines if there was an error code returns from the kFetch which might indicate a large company
	EXPORT GrabFetchErrorCode(myDataset) := FUNCTIONMACRO
		errorCodes := TABLE(myDataset,
									{Seq,
									Fetch_Error_Code}, Seq);
		RETURN(errorCodes);
	ENDMACRO;
	
	// This function converts the raw source codes into modeling friendly codes as specified by our modeling team.
	EXPORT groupSources(inputlayout, sources) := FUNCTIONMACRO
		inputlayout groupMySources(inputlayout le) := TRANSFORM
		SELF.Source := MAP(le.Source IN MDR.SourceTools.set_Business_Registration			=> Business_Risk_BIP.Constants.Src_BusinessRegistration,
											 le.Source IN MDR.SourceTools.set_CorpV2										=> Business_Risk_BIP.Constants.Src_CorpV2,
											 le.Source IN MDR.SourceTools.set_Dunn_Bradstreet						=> Business_Risk_BIP.Constants.Src_DunnBradstreet,
											 le.Source IN MDR.SourceTools.set_Dunn_Bradstreet_Fein			=> Business_Risk_BIP.Constants.Src_DunnBradstreetFEIN,
											 le.Source IN MDR.SourceTools.set_EBR												=> Business_Risk_BIP.Constants.Src_Bureau,
											 le.Source IN MDR.SourceTools.set_FBNv2											=> Business_Risk_BIP.Constants.Src_FBN,
											 le.Source IN MDR.SourceTools.set_Frandx										=> Business_Risk_BIP.Constants.Src_Frandx,
											 le.Source IN MDR.SourceTools.set_Liens											=> Business_Risk_BIP.Constants.Src_Liens,
											 le.Source IN MDR.SourceTools.set_DCA												=> Business_Risk_BIP.Constants.Src_DCA,
											 le.Source IN MDR.SourceTools.set_UCCS											=> Business_Risk_BIP.Constants.Src_UCC,
											 le.Source IN MDR.SourceTools.set_Aircrafts									=> Business_Risk_BIP.Constants.Src_Aircrafts,
											 le.Source IN MDR.SourceTools.set_Bk												=> Business_Risk_BIP.Constants.Src_Bankruptcy,
											 le.Source IN MDR.SourceTools.set_BBB_Member								=> Business_Risk_BIP.Constants.Src_BBB_Member,
											 le.Source IN MDR.SourceTools.set_BBB_Non_Member						=> Business_Risk_BIP.Constants.Src_BBB_Non_Member,
											 le.Source IN MDR.SourceTools.set_Calbus										=> Business_Risk_BIP.Constants.Src_CalBus,
											 le.Source IN MDR.SourceTools.set_Credit_Unions							=> Business_Risk_BIP.Constants.Src_CreditUnions,
											 le.Source IN MDR.SourceTools.set_DEA												=> Business_Risk_BIP.Constants.Src_DEA,
											 le.Source IN MDR.SourceTools.set_Experian_CRDB							=> Business_Risk_BIP.Constants.Src_ExperianCRDB,
											 le.Source IN MDR.SourceTools.set_Experian_FEIN							=> Business_Risk_BIP.Constants.Src_ExperianFEIN,
											 le.Source IN MDR.SourceTools.set_FDIC											=> Business_Risk_BIP.Constants.Src_FDIC,
											 le.Source IN MDR.SourceTools.set_IRS_5500									=> Business_Risk_BIP.Constants.Src_IRS5500,
											 le.Source IN MDR.SourceTools.set_IRS_Non_Profit						=> Business_Risk_BIP.Constants.Src_IRS_Non_Profit,
											 le.Source IN MDR.SourceTools.set_Vehicles									=> Business_Risk_BIP.Constants.Src_Vehicles,
											 le.Source IN MDR.SourceTools.set_OSHAIR										=> Business_Risk_BIP.Constants.Src_OSHA,
											 le.Source IN MDR.SourceTools.set_Prolic										=> Business_Risk_BIP.Constants.Src_Prolic,
											 le.Source IN MDR.SourceTools.set_Property									=> Business_Risk_BIP.Constants.Src_Property,
											 le.Source IN MDR.SourceTools.set_SKA												=> Business_Risk_BIP.Constants.Src_SKA,
											 le.Source IN MDR.SourceTools.set_TXBUS											=> Business_Risk_BIP.Constants.Src_TXBUS,
											 le.Source IN MDR.SourceTools.set_INFOUSA_ABIUS_USABIZ			=> Business_Risk_BIP.Constants.Src_INFOUSA_ABIUS_USABIZ,
											 le.Source IN MDR.SourceTools.set_WC												=> Business_Risk_BIP.Constants.Src_Watercraft,
											 le.Source IN MDR.SourceTools.set_Yellow_Pages							=> Business_Risk_BIP.Constants.Src_Yellow_Pages,
											 le.Source IN MDR.SourceTools.set_INFOUSA_DEAD_COMPANIES		=> Business_Risk_BIP.Constants.Src_INFOUSA_DEAD_COMPANIES,
											 le.Source IN MDR.SourceTools.set_Diversity_Cert						=> Business_Risk_BIP.Constants.Src_Diversity_Cert,
											 le.Source IN MDR.SourceTools.set_FCC_Radio_Licenses				=> Business_Risk_BIP.Constants.Src_FCC_Radio_Licenses,
											 le.Source IN MDR.SourceTools.set_GSA												=> Business_Risk_BIP.Constants.Src_GSA,
											 le.Source IN MDR.SourceTools.set_Gong											=> Business_Risk_BIP.Constants.Src_Gong,
											 le.Source IN MDR.SourceTools.set_LaborActions_WHD					=> Business_Risk_BIP.Constants.Src_LaborActions_WHD,
											 le.Source IN MDR.SourceTools.set_SEC_Broker_Dealer					=> Business_Risk_BIP.Constants.Src_SEC_Broker_Dealer,
											 le.Source IN MDR.SourceTools.set_Workers_Compensation			=> Business_Risk_BIP.Constants.Src_Workers_Compensation,
											 le.Source IN MDR.SourceTools.set_ACF												=> Business_Risk_BIP.Constants.Src_ACF,
											 le.Source IN MDR.SourceTools.set_AMS												=> Business_Risk_BIP.Constants.Src_AMS,
											 le.Source IN MDR.SourceTools.set_Atf												=> Business_Risk_BIP.Constants.Src_Atf,
											 le.Source IN MDR.SourceTools.set_Bankruptcy_Attorney				=> Business_Risk_BIP.Constants.Src_Bankruptcy_Attorney,
											 le.Source IN MDR.SourceTools.set_Ingenix_Sanctions					=> Business_Risk_BIP.Constants.Src_Ingenix_Sanctions,
											 le.Source IN MDR.SourceTools.set_CA_Sales_Tax							=> Business_Risk_BIP.Constants.Src_CA_Sales_Tax,
											 le.Source IN MDR.SourceTools.set_CLIA											=> Business_Risk_BIP.Constants.Src_CLIA,
											 le.Source IN MDR.SourceTools.set_Edgar											=> Business_Risk_BIP.Constants.Src_Edgar,
											 le.Source IN MDR.SourceTools.set_Employee_Directories			=> Business_Risk_BIP.Constants.Src_Employee_Directories,
											 le.Source IN MDR.SourceTools.set_FDIC											=> Business_Risk_BIP.Constants.Src_FDIC,
											 le.Source IN (MDR.SourceTools.set_Foreclosures + 
																		MDR.SourceTools.set_Foreclosures_Delinquent)	=> Business_Risk_BIP.Constants.Src_Foreclosures,
											 le.Source IN MDR.SourceTools.set_Garnishments							=> Business_Risk_BIP.Constants.Src_Garnishments,
											 le.Source IN MDR.SourceTools.set_Insurance_Certification		=> Business_Risk_BIP.Constants.Src_Insurance_Certification,
											 le.Source IN MDR.SourceTools.set_IA_Sales_Tax							=> Business_Risk_BIP.Constants.Src_IA_Sales_Tax,
											 le.Source IN MDR.SourceTools.set_MartinDale_Hubbell				=> Business_Risk_BIP.Constants.Src_MartinDale_Hubbell,
											 le.Source IN MDR.SourceTools.set_MS_Worker_Comp						=> Business_Risk_BIP.Constants.Src_MS_Worker_Comp,
											 le.Source IN MDR.SourceTools.set_NaturalDisaster_Readiness	=> Business_Risk_BIP.Constants.Src_NaturalDisaster_Readiness,
											 le.Source IN [MDR.SourceTools.src_NCPDP]										=> Business_Risk_BIP.Constants.Src_NCPDP,
											 le.Source IN MDR.SourceTools.set_NPPES											=> Business_Risk_BIP.Constants.Src_NPPES,
											 le.Source IN MDR.SourceTools.set_OIG												=> Business_Risk_BIP.Constants.Src_OIG,
											 le.Source IN MDR.SourceTools.set_OR_Worker_Comp						=> Business_Risk_BIP.Constants.Src_OR_Worker_Comp,
											 le.Source IN MDR.SourceTools.set_CrashCarrier							=> Business_Risk_BIP.Constants.Src_CrashCarrier,
											 le.Source IN (MDR.SourceTools.set_SDAA + 
																		MDR.SourceTools.set_SDA)											=> Business_Risk_BIP.Constants.Src_SDAA,
											 le.Source IN MDR.SourceTools.set_Sheila_Greco							=> Business_Risk_BIP.Constants.Src_Sheila_Greco,
											 le.Source IN MDR.SourceTools.set_Spoke											=> Business_Risk_BIP.Constants.Src_Spoke,
											 le.Source  = MDR.SourceTools.src_Targus_Gateway						=> Business_Risk_BIP.Constants.Src_Targus_Gateway,
											 le.Source IN MDR.SourceTools.set_Utility_sources						=> Business_Risk_BIP.Constants.Src_Utility_sources,
											 le.Source IN MDR.SourceTools.set_Vickers										=> Business_Risk_BIP.Constants.Src_Vickers,
											 le.Source IN MDR.SourceTools.set_Phones_Plus								=> Business_Risk_BIP.Constants.Src_PhonesPlus,
											 le.Source IN MDR.SourceTools.set_Business_Credit						=> Business_Risk_BIP.Constants.Src_Business_Credit,
																																										 le.Source);
			SELF := le;
		END;
	
		RETURN (PROJECT(sources, groupMySources(LEFT)));
	ENDMACRO;
	
	// The following takes the somewhat ugly Corporations Business Type data and attempts to normalize it up into nicer groups.
	// A full table of the CorpV2 key was done to create this list which is exhaustive as of 11/17/2014, and then the Product Manager assisted with type classifications.
	EXPORT GetBusinessType (STRING Corp_Address1_Type_CD, STRING Corp_Address1_Type_Desc) := FUNCTION
		cd := TRIM(StringLib.StringToUpperCase(Corp_Address1_Type_CD));
		desc := TRIM(StringLib.StringToUpperCase(Corp_Address1_Type_Desc));
		
		cleanBusinessType := MAP(
														cd = ''   AND desc = 'BUSINESS'                                  => 'B', // Business 
														cd = ''   AND desc = 'CORPORATE ADDRESS'                         => 'C', // Corporate
														cd = ''   AND desc = 'CORPORATE MAILING ADDRESS'                 => 'M', // Mailing 
														cd = ''   AND desc = 'DESIGNATED OFFICE ADDRESS'                 => 'B', // Business 
														cd = ''   AND desc = 'DOMICILE ADDRES'                           => 'B', // Business 
														cd = ''   AND desc = 'DOMICILE ADDRESS'                          => 'B', // Business 
														cd = ''   AND desc = 'EXECUTIVE OFFICE'                          => 'C', // Corporate
														cd = ''   AND desc = 'HOME OFFICE'                               => 'H', // Home Office
														cd = ''   AND desc = 'HOME STATE MAILING ADDRESS'                => 'M', // Mailing 
														cd = ''   AND desc = 'LA. REG. OFFICE'                           => 'R', // Registerd Office
														cd = ''   AND desc = 'LOCAL OFFICE ADDRESS'                      => 'B', // Business 
														cd = ''   AND desc = 'MAILING'                                   => 'M', // Mailing 
														cd = ''   AND desc = 'MAILING ADDRESS'                           => 'M', // Mailing 
														cd = ''   AND desc = 'MAIN BUSINESS ADDRESS'                     => 'C', // Corporate
														cd = ''   AND desc = 'MARKHOLDER'                                => 'O', // Other
														cd = ''   AND desc = 'OTHER'                                     => 'O', // Other
														cd = ''   AND desc = 'PREVIOUS BUSINESS'                         => 'B', // Business 
														cd = ''   AND desc = 'PREVIOUS MAILING'                          => 'M', // Mailing 
														cd = ''   AND desc = 'PREVIOUS REGISTERED OFFICE'                => 'R', // Registerd Office
														cd = ''   AND desc = 'PRIMARY CORPORATE ADDRESS'                 => 'P', // Principal
														cd = ''   AND desc = 'PRINCIPAL BUS./LA'                         => 'P', // Principal
														cd = ''   AND desc = 'PRINCIPAL CORPORATE ADDRESS'               => 'P', // Principal
														cd = ''   AND desc = 'PRINCIPAL OFFICE'                          => 'P', // Principal
														cd = ''   AND desc = 'PRINCIPAL OFFICE ADDRESS'                  => 'P', // Principal
														cd = ''   AND desc = 'PRINCIPLE ADDRESS'                         => 'P', // Principal
														cd = ''   AND desc = 'REGISTERED NAME ADDRESS'                   => 'D', // Filing (ucc, sos or other)
														cd = ''   AND desc = 'SPECIAL ADDRESS INFORMATION'               => 'O', // Other
														cd = '1'  AND desc = ''                                          => 'M', // Mailing 
														cd = '1'  AND desc = 'MAILING'                                   => 'M', // Mailing 
														cd = '11' AND desc = ''                                          => 'B', // Business 
														cd = '11' AND desc = 'PREV REG. OFFICE'                          => 'R', // Registerd Office
														cd = '14' AND desc = ''                                          => 'M', // Mailing 
														cd = '14' AND desc = 'PREV REG MAILING'                          => 'M', // Mailing 
														cd = '15' AND desc = ''                                          => 'O', // Other
														cd = '15' AND desc = 'OTHER ADDRESS'                             => 'O', // Other
														cd = '16' AND desc = ''                                          => 'P', // Principal
														cd = '16' AND desc = 'PRINCIPAL OFFICE MAILING'                  => 'P', // Principal
														cd = '16' AND desc = 'QUICK ACCOUNT'                             => 'O', // Other
														cd = '17' AND desc = 'WITHDRAWAL ADDRESS'                        => 'O', // Other
														cd = '18' AND desc = ''                                          => 'M', // Mailing 
														cd = '18' AND desc = 'DESIGNATED OFFICE MAILING'                 => 'M', // Mailing 
														cd = '18' AND desc = 'UCC ADDRESS'                               => 'D', // Filing (ucc, sos or other)
														cd = '19' AND desc = ''                                          => 'M', // Mailing 
														cd = '19' AND desc = 'PREVIOUS UCC ADDRESS'                      => 'D', // Filing
														cd = '25' AND desc = 'REG. NAME OWNER'                           => 'H', // Home Office
														cd = '26' AND desc = 'PREV. REG. NAME OWNER'                     => 'H', // Home Office
														cd = '27' AND desc = 'PHYSICAL'                                  => 'B', // Business 
														cd = '4'  AND desc = 'HOME OFFICE'                               => 'H', // Home Office
														cd = '5'  AND desc = 'PRINCIPAL OFFICE'                          => 'P', // Principal
														cd = '6'  AND desc = ''                                          => 'M', // Mailing 
														cd = '6'  AND desc = 'PREV MAILING'                              => 'M', // Mailing 
														cd = '6'  AND desc = 'PREVIOUS MAILING'                          => 'M', // Mailing 
														cd = '7'  AND desc = ''                                          => 'D', // Filing
														cd = '7'  AND desc = 'LISTING'                                   => 'D', // Filing
														cd = '8'  AND desc = ''                                          => 'B', // Business 
														cd = '8'  AND desc = 'DESIGNATED OFFICE'                         => 'B', // Business 
														cd = '8'  AND desc = 'PRINCIPAL OFFICE'                          => 'P', // Principal
														cd = '8'  AND desc = 'PRINCIPAL OFFICE ADDRESS'                  => 'P', // Principal
														cd = '9'  AND desc = ''                                          => 'P', // Principal
														cd = '9'  AND desc = 'PREV PRINCIPAL'                            => 'P', // Principal
														cd = '9'  AND desc = 'PREVIOUS BUSINESS'                         => 'B', // Business 
														cd = '9'  AND desc = 'PREVIOUS PRINCIPAL OFFICE'                 => 'P', // Principal
														cd = 'B'  AND desc = ''                                          => 'B', // Business 
														cd = 'B'  AND desc = 'ASSOCIATION'                               => 'O', // Other
														cd = 'B'  AND desc = 'BUSINESS'                                  => 'B', // Business 
														cd = 'B'  AND desc = 'BUSINESS ADDRESS'                          => 'B', // Business 
														cd = 'B'  AND desc = 'FOREIGN'                                   => 'F', // Foreign
														cd = 'B'  AND desc = 'NAME REGISTRATION'                         => 'D', // Filing
														cd = 'B'  AND desc = 'OTHER'                                     => 'O', // Other
														cd = 'B'  AND desc = 'PREVIOUS BUSINESS'                         => 'B', // Business 
														cd = 'B'  AND desc = 'PREVIOUS MAILING'                          => 'M', // Mailing 
														cd = 'B'  AND desc = 'PREVIOUS REGISTERED OFFICE'                => 'R', // Registerd Office
														cd = 'C'  AND desc = 'CORPORATE ADDRESS'                         => 'C', // Corporate
														cd = 'F'  AND desc = 'FILING'                                    => 'D', // Filing
														cd = 'F'  AND desc = 'FOREIGN'                                   => 'F', // Foreign
														cd = 'F'  AND desc = 'PREVIOUS BUSINESS'                         => 'B', // Business 
														cd = 'F'  AND desc = 'PREVIOUS MAILING'                          => 'M', // Mailing 
														cd = 'G'  AND desc = 'REGISTERED OFFICE'                         => 'R', // Registerd Office
														cd = 'H'  AND desc = 'HOME OFFICE'                               => 'H', // Home Office
														cd = 'H'  AND desc = 'HOME OFFICE / PRINCIPAL PLACE OF BUSINESS' => 'H', // Home Office
														cd = 'M'  AND desc = ''                                          => 'M', // Mailing 
														cd = 'M'  AND desc = 'MAILING'                                   => 'M', // Mailing 
														cd = 'M'  AND desc = 'MAILING ADDRESS'                           => 'M', // Mailing 
														cd = 'M'  AND desc = 'OTHER'                                     => 'O', // Other
														cd = 'M'  AND desc = 'PREVIOUS BUSINESS'                         => 'B', // Business 
														cd = 'M'  AND desc = 'PREVIOUS MAILING'                          => 'M', // Mailing 
														cd = 'M'  AND desc = 'PRINCIPAL MAILING'                         => 'M', // Mailing 
														cd = 'O'  AND desc = 'OUT OF STATE'                              => 'F', // Foreign
														cd = 'O'  AND desc = 'OWNER ADDRESS'                             => 'H', // Home Office
														cd = 'P'  AND desc = 'BUSINESS'                                  => 'B', // Business 
														cd = 'P'  AND desc = 'PRIMARY'                                   => 'P', // Principal
														cd = 'P'  AND desc = 'PRINCIPAL'                                 => 'P', // Principal
														cd = 'P'  AND desc = 'PRINCIPAL OFFICE'                          => 'P', // Principal
														cd = 'P'  AND desc = 'PROCESS'                                   => 'O', // Other
														cd = 'P'  AND desc = 'PROCESS ADDRESS'                           => 'O', // Other
														cd = 'R'  AND desc = 'REGISTERED AGENT ADDRESS'                  => 'H', // Home Office
														cd = 'S'  AND desc = 'SUBSIDIARY'                                => 'B', // Business 
														cd = 'T'  AND desc = 'CONTACT'                                   => 'H', // Home Office
																																																'U' // Unknown
														);
		
		RETURN (cleanBusinessType);
	END;
	
	EXPORT todaysDate(STRING8 buildDate, INTEGER HistoryDate) := IF(HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate, buildDate, (STRING)HistoryDate + '01');
	
	EXPORT capNum(field, minNum, maxNum) := MAX(MIN(field, maxNum), minNum);
	
	EXPORT commonIndustry(STRING Industry) := FUNCTION
		In_Industry := StringLib.StringToUpperCase(TRIM(Industry, LEFT, RIGHT));
		Clean_Industry := MAP(In_Industry IN Inquiry_AccLogs.Shell_Constants.Collection_Industry			=> 'COL',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.Auto_Industry						=> 'AUTO',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.Banking_Industry5				=> 'BANK',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.Mortgage_Industry				=> 'MORT',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.HighRiskCredit_industry5	=> 'HRCRD',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.Retail_industry					=> 'RET',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.communications_industry5	=> 'COM',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.QuizProvider_industry		=> 'QUIZ',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.PrepaidCards_industry		=> 'PPCRD',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.RetailPayments_industry	=> 'REPAY',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.Utilities_industry				=> 'UTIL',
													In_Industry IN Inquiry_AccLogs.Shell_Constants.StudentLoans_industry		=> 'STLN',
																																																		 'OTH');
		RETURN(Clean_Industry);
	END;
	
	EXPORT industryGroup(STRING Code, STRING SIC_or_NAIC = '') := FUNCTION
		SICCode := IF(SIC_or_NAIC = Business_Risk_BIP.Constants.SIC, Code, '');
		NAICCode := IF(SIC_or_NAIC = Business_Risk_BIP.Constants.NAIC, Code, '');
		NAICGroupNumber := CASE(TRIM(NAICCode, LEFT, RIGHT)[1..2],
													'11' => '11',
													'21' => '21',
													'22' => '22',
													'23' => '23',
													'31' => '31-33',
													'32' => '31-33',
													'33' => '31-33',
													'42' => '42',
													'44' => '44-45',
													'45' => '44-45',
													'48' => '48-49',
													'49' => '48-49',
													'51' => '51',
													'52' => '52',
													'53' => '53',
													'54' => '54',
													'55' => '55',
													'56' => '56',
													'61' => '61',
													'62' => '62',
													'71' => '71',
													'72' => '72',
													'81' => '81',
													'92' => '92',
																	'');
		// These mappings were created by Haley Vicchio after researching SIC Code lists on the internet. Since SIC codes haven't changed groups since they were created it's fairly safe to hard code these lists.
		SICGroupNumber := MAP(SICCode IN ['0111', '0112', '0115', '0116', '0119', '0131', '0132', '0133', '0134', '0139', '0161', '0171', '0172', '0173', '0174', '0175', '0179', 
																			'0181', '0182', '0191', '0211', '0212', '0213', '0214', '0219', '0241', '0251', '0252', '0253', '0254', '0259', '0271', '0272', '0273', 
																			'0279', '0291', '0711', '0721', '0722', '0723', '0724', '0751', '0761', '0762', '0811', '0831', '0851', '0912', '0913', '0919', '0921', 
																			'0971', '2411']																																																														=> '11',
													SICCode IN ['1011', '1021', '1031', '1041', '1044', '1061', '1081', '1094', '1099', '1221', '1222', '1231', '1241', '1311', '1321', '1381', '1382', 
																			'1389', '1411', '1422', '1423', '1429', '1442', '1446', '1455', '1459', '1474', '1475', '1479', '1481', ' 1499', '3295']									=> '21',
													SICCode IN ['4911', '4923', '4924', '4925', '4931', '4932', '4939', '4941', '4952', '4961', '4971']																										=> '22',
													SICCode IN ['1521', '1522', '1531', '1541', '1542', '1611', '1622', '1623', '1629', '1711', '1721', '1731', '1741', '1742', '1743', '1751', '1752', 
																			'1761', '1771', '1781', '1791', '1793', '1794', '1795', '1796', '1799', '6552', '6553']																										=> '23',
													SICCode IN ['2011', '2013', '2015', '2021', '2022', '2023', '2024', '2026', '2032', '2033', '2034', '2035', '2037', '2038', '2041', '2043', '2044', 
																			'2045', '2046', '2047', '2048', '2051', '2052', '2053', '2061', '2062', '2063', '2064', '2065', '2066', '2067', '2068', '2074', '2075', 
																			'2076', '2077', '2079', '2082', '2083', '2084', '2085', '2086', '2087', '2091', '2092', '2095', '2096', '2097', '2098', '2099', '2111', 
																			'2121', '2131', '2141', '2211', '2221', '2231', '2241', '2251', '2252', '2253', '2254', '2257', '2258', '2259', '2261', '2262', '2269', 
																			'2273', '2281', '2282', '2284', '2295', '2296', '2297', '2298', '2299', '2311', '2321', '2322', '2323', '2325', '2326', '2329', '2331', 
																			'2335', '2337', '2339', '2341', '2342', '2353', '2361', '2369', '2371', '2381', '2384', '2385', '2386', '2387', '2389', '2391', '2392', 
																			'2393', '2394', '2395', '2396', '2397', '2399', '2421', '2426', '2429', '2431', '2434', '2435', '2436', '2439', '2441', '2448', '2449', 
																			'2451', '2452', '2491', '2493', '2499', '2511', '2512', '2514', '2515', '2517', '2519', '2521', '2522', '2531', '2541', '2542', '2591', 
																			'2599', '2611', '2621', '2631', '2652', '2653', '2655', '2656', '2657', '2671', '2672', '2673', '2674', '2675', '2676', '2677', '2678', 
																			'2679', '2752', '2754', '2759', '2761', '2771', '2782', '2789', '2791', '2796', '2812', '2813', '2816', '2819', '2821', '2822', '2823', 
																			'2824', '2833', '2834', '2835', '2836', '2841', '2842', '2843', '2844', '2851', '2861', '2865', '2869', '2873', '2874', '2875', '2879', 
																			'2891', '2892', '2893', '2895', '2899', '2911', '2951', '2952', '2992', '2999', '3011', '3021', '3052', '3053', '3061', '3069', '3081', 
																			'3082', '3083', '3084', '3085', '3086', '3087', '3088', '3089', '3111', '3131', '3142', '3143', '3144', '3149', '3151', '3161', '3171', 
																			'3172', '3199', '3211', '3221', '3229', '3231', '3241', '3251', '3253', '3255', '3259', '3261', '3262', '3263', '3264', '3269', '3271', 
																			'3272', '3273', '3274', '3275', '3281', '3291', '3292', '3296', '3297', '3299', '3312', '3313', '3315', '3316', '3317', '3321', '3322', 
																			'3324', '3325', '3331', '3334', '3339', '3341', '3351', '3353', '3354', '3355', '3356', '3357', '3363', '3364', '3365', '3366', '3369', 
																			'3398', '3399', '3411', '3412', '3421', '3423', '3425', '3429', '3431', '3432', '3433', '3441', '3442', '3443', '3444', '3446', '3448', 
																			'3449', '3451', '3452', '3462', '3463', '3465', '3466', '3469', '3471', '3479', '3482', '3483', '3484', '3489', '3491', '3492', '3493', 
																			'3494', '3495', '3496', '3497', '3498', '3499', '3511', '3519', '3523', '3524', '3531', '3532', '3533', '3534', '3535', '3536', '3537', 
																			'3541', '3542', '3543', '3544', '3545', '3546', '3547', '3548', '3549', '3552', '3553', '3554', '3555', '3556', '3559', '3561', '3562', 
																			'3563', '3564', '3565', '3566', '3567', '3568', '3569', '3571', '3572', '3575', '3577', '3578', '3579', '3581', '3582', '3585', '3586', 
																			'3589', '3592', '3593', '3594', '3596', '3599', '3612', '3613', '3621', '3624', '3625', '3629', '3631', '3632', '3633', '3634', '3635', 
																			'3639', '3641', '3643', '3644', '3645', '3646', '3647', '3648', '3651', '3652', '3661', '3663', '3669', '3671', '3672', '3674', '3675', 
																			'3676', '3677', '3678', '3679', '3691', '3692', '3694', '3695', '3699', '3711', '3713', '3714', '3715', '3716', '3721', '3724', '3728', 
																			'3731', '3732', '3743', '3751', '3761', '3764', '3769', '3792', '3795', '3799', '3812', '3821', '3822', '3823', '3824', '3825', '3826', 
																			'3827', '3829', '3841', '3842', '3843', '3844', '3845', '3851', '3861', '3873', '3911', '3914', '3915', '3931', '3942', '3944', '3949', 
																			'3951', '3952', '3953', '3955', '3961', '3965', '3991', '3993', '3995', '3996', '3999', '8072']																						=> '31-33',
													SICCode IN ['5012', '5013', '5014', '5015', '5021', '5023', '5031', '5032', '5033', '5039', '5043', '5044', '5045', '5046', '5047', '5048', '5049', 
																			'5051', '5052', '5063', '5064', '5065', '5072', '5074', '5075', '5078', '5082', '5083', '5084', '5085', '5087', '5088', '5091', '5092', 
																			'5093', '5094', '5099', '5111', '5112', '5113', '5122', '5131', '5136', '5137', '5139', '5141', '5142', '5143', '5144', '5145', '5146', 
																			'5147', '5148', '5149', '5153', '5154', '5159', '5162', '5169', '5171', '5172', '5181', '5182', '5191', '5192', '5193', '5194', '5198', 
																			'5199']																																																																		=> '42',
													SICCode IN ['5211', '5231', '5251', '5261', '5271', '5311', '5331', '5399', '5411', '5421', '5431', '5441', '5451', '5461', '5499', '5511', '5521', 
																			'5531', '5541', '5551', '5561', '5571', '5599', '5611', '5621', '5632', '5641', '5651', '5661', '5699', '5712', '5713', '5714', '5719', 
																			'5722', '5731', '5734', '5735', '5736', '5912', '5921', '5932', '5941', '5942', '5943', '5944', '5945', '5946', '5947', '5948', '5949', 
																			'5961', '5962', '5963', '5983', '5984', '5989', '5992', '5993', '5994', '5995', '5999']																										=> '44-45',
													SICCode IN ['4011', '4013', '4111', '4119', '4121', '4131', '4141', '4142', '4151', '4173', '4212', '4213', '4214', '4215', '4221', '4222', '4225', 
																			'4226', '4231', '4311', '4412', '4424', '4432', '4449', '4481', '4482', '4489', '4491', '4492', '4499', '4512', '4513', '4522', '4581', 
																			'4612', '4613', '4619', '4731', '4783', '4785', '4789', '4922']																																						=> '48-49',
													SICCode IN ['2711', '2721', '2731', '2732', '2741', '4812', '4813', '4822', '4832', '4833', '4841', '4899', '7372', '7374', '7375', '7383', '7812', 
																			'7819', '7822', '7829', '7832', '7833']																																																		=> '51',
													SICCode IN ['0741', '0742', '6011', '6019', '6021', '6022', '6029', '6035', '6036', '6061', '6062', '6081', '6082', '6091', '6099', '6111', '6140', 
																			'6141', '6153', '6159', '6162', '6163', '6211', '6221', '6231', '6282', '6289', '6311', '6321', '6324', '6331', '6351', '6361', '6371', 
																			'6399', '6411', '6722', '6726', '6733', '6799']																																														=> '52',
													SICCode IN ['4741', '6512', '6513', '6514', '6515', '6517', '6519', '6531', '6792', '6794', '6798', '7352', '7353', '7359', '7377', '7513', '7514', 
																			'7515', '7519', '7841']																																																										=> '53',
													SICCode IN ['0781', '6541', '7221', '7291', '7311', '7312', '7313', '7319', '7331', '7335', '7336', '7371', '7373', '7376', '7379', '7389', '8111', 
																			'8711', '8712', '8713', '8721', '8731', '8732', '8733', '8734', '8742', '8743', '8748']																										=> '54',
													SICCode IN ['6712', '6719']																																																														=> '55',
													SICCode IN ['0782', '0783', '4724', '4725', '4729', '4953', '4959', '7217', '7322', '7323', '7334', '7338', '7342', '7349', '7361', '7363', '7381', 
																			'7382', '8741', '8744']																																																										=> '56',
													SICCode IN ['7911', '8211', '8221', '8222', '8231', '8243', '8244', '8249', '8299']																																		=> '61',
													SICCode IN ['8011', '8021', '8031', '8041', '8042', '8043', '8049', '8051', '8052', '8059', '8062', '8063', '8069', '8071', '8082', '8092', '8093', 
																			'8099', '8322', '8331', '8351', '8361']																																																		=> '62',
													SICCode IN ['4493', '7922', ' 7929', '7933', '7941', '7948', '7991', '7992', '7993', '7996', '7997', '7999', '8412', '8422']													=> '71',
													SICCode IN ['5812', '5813', '7011', '7021', '7032', '7033', '7041']																																										=> '72',
													SICCode IN ['0752', '6732', '7211', '7212', '7213', '7215', '7216', '7218', '7219', '7231', '7241', '7251', '7299', '7378', '7384', '7521', '7532', 
																			'7533', '7534', '7536', '7537', '7538', '7539', '7542', '7549', '7622', '7623', '7629', '7631', '7641', '7692', '7694', '7699', '8399', 
																			'8611', '8621', '8631', '8641', '8651', '8661', '8699', '8811', '8999']																																		=> '81',
													SICCode IN ['9111', '9121', '9231', '9199', '9211', '9221', '9222', '9223', '9224', '9229', '9311', '9411', '9431', '9441', '9451', '9511', '9512', 
																			'9531', '9532', '9611', '9621', '9631', '9641', '9651', '9661', '9711', '9721']																														=> '92',
																																																																																										'');
		groupCode := MAP(NAICGroupNumber <> ''	=> NAICGroupNumber,
										 SICGroupNumber <> ''		=> SICGroupNumber,
																							 '');
		RETURN(groupCode);
	END;
	
	EXPORT industryGroupName (STRING industryGroupNumber) := CASE(industryGroupNumber,
		'11' => 'Agriculture, Forestry, Fishing and Hunting',
		'21' => 'Mining, Quarrying, and Oil and Gas Extraction',
		'22' => 'Utilities',
		'23' => 'Construction',
		'31-33' => 'Manufacturing',
		'42' => 'Wholesale Trade',
		'44-45' => 'Retail Trade',
		'48-49' => 'Transportation and Warehousing',
		'51' => 'Information',
		'52' => 'Finance and Insurance',
		'53' => 'Real Estate and Rental and Leasing',
		'54' => 'Professional, Scientific, and Technical Services',
		'55' => 'Management of Companies and Enterprises',
		'56' => 'Administrative and Support and Waste Management and Remediation Services',
		'61' => 'Educational Services',
		'62' => 'Health Care and Social Assistance',
		'71' => 'Arts, Entertainment, and Recreation',
		'72' => 'Accommodation and Food Services',
		'81' => 'Other Services',
		'92' => 'Public Administration',
						'');
	
	EXPORT checkInvalidDate(STRING Date, STRING InvalidDateReplacement = '0', UNSIGNED6 HistoryDate) := FUNCTION
		// Invalid Date Rules:
		// -- Blank Dates will be set to whatever is passed in for InvalidDateReplacement (Often '0' or '999999' depending on how this date is being used, '0' is default).
		// -- Dates with invalid Years, or a Year prior to 1900 (So 1899 and earlier) will be set to whatever is passed in for InvalidDateReplacement.
		// -- Dates with valid, non-futuristic Years but no valid Month or valid Day will be set to YYYY0101 (January 1st of that year).
		// -- Dates with valid, non-futuristic Years and valid Months but no valid Day will be set to YYYYMM01 (The 1st of that month/year).
		// -- Futuristic dates will be capped at the history date in Archive mode. Only Dates Last Seen should be impacted as Date First Seen futuristic dates are filtered out by the FilterRecords function above.
		blankDate := (INTEGER)Date <= 0;
		paddedDate := CASE(LENGTH(TRIM(Date, LEFT, RIGHT)), // If the Date isn't the full length - pad it with the 1st month/1st of the month
											6 => Date[1..6] + '01', 	// Passed in YYYYMM, missing DD (Listed first since most dates being checked are YYYYMM format, this help short circuit the logic for minor speed increase)
											8 => Date[1..8],					// Passed in full YYYYMMDD
											4 => Date[1..4] + '0101', // Passed in YYYY, missing MMDD
													 Date); 							// Something weird was passed in, keep it - but it will likely fail the valid date checks below unless it's YYYYMMDD+garbage, then the valid YYYYMMDD will be kept
		validateDate := Doxie.DOBTools((UNSIGNED)paddedDate); // Parse out the date to determine if it is valid - accounts for leap years
		
		validFullDate := validateDate.IsValidDOB; // Check to see if YYYYMMDD is a valid date (>= 19000101)
		validYearMonth := validateDate.IsValidYOB AND validateDate.IsValidMonth; // Check to see if YYYYMM is a valid date (>= 190001)
		validYear := validateDate.IsValidYOB; // Check to see if YYYY is a valid year (>= 1900)
		
		cleanedDate := MAP(blankDate			=> InvalidDateReplacement,
											 validFullDate	=> paddedDate[1..8],
											 validYearMonth	=> paddedDate[1..6] + '01',
											 validYear			=> paddedDate[1..4] + '0101',
																				 InvalidDateReplacement);
		
		// Only cap Dates Last Seen, NinesDate InvalidDateReplacement only happens for Dates First Seen, cap it at the full 8 digit history date to prevent full realtime dates from being capped at 999999 instead of 99999901
		cappedDate := IF(InvalidDateReplacement <> Business_Risk_BIP.Constants.NinesDate, (STRING)capNum((INTEGER)cleanedDate, 0, (INTEGER)((HistoryDate + '01')[1..8])), cleanedDate);
		
		RETURN(cappedDate);
	END;
	
	EXPORT groupMinDate6(DateFirstSeenField, HistoryDate) := MACRO 
			(STRING)MIN(GROUP, (INTEGER)((Business_Risk_BIP.Common.checkInvalidDate((STRING)DateFirstSeenField, Business_Risk_BIP.Constants.NinesDate, HistoryDate))[1..6])) // Check to see if the date is valid - if not clean it up or overwrite it to all 9's so that MIN works
	ENDMACRO;
	
	EXPORT groupMaxDate6(DateLastSeenField, HistoryDate) := MACRO
			// Check to see if it's a valid date - if not clean it up or overwrite with a missing date value ('0') so that MAX works
			// Also, cap the Date Last Seen at the History Date so that it doesn't look like a future date (Date First Seen doesn't have this issue because future Date First Seen records are filitered out completely.
			(STRING)MAX(GROUP, (INTEGER)((Business_Risk_BIP.Common.checkInvalidDate((STRING)DateLastSeenField, Business_Risk_BIP.Constants.MissingDate, HistoryDate))[1..6]))
	ENDMACRO;
	
	EXPORT filterOutSpecialChars(STRING inputString, STRING AllowedSpecialChars = ', !@#$%^&*()-=+_') := StringLib.StringFilter(inputString, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' + AllowedSpecialChars);
	
	EXPORT countDelimitedList(STRING inputString, STRING delimiter) := IF(TRIM(inputString) <> '', StringLib.StringFindCount(inputString, delimiter) + 1, 0);

	// The following rules were pulled from the NANPA Government Website June 2015
	EXPORT validPhone(STRING10 Phone10) := 
											 LENGTH(StringLib.StringFilter(Phone10, '0123456789')) = 10 AND // We have a 10 digit phone
											 StringLib.StringFilterOut(Phone10, '0123456789') = '' AND // No non-numeric characters entered
											 (INTEGER)Phone10[1] BETWEEN 2 AND 9 AND // NPA rules: First digit 2-9, second and third digits 0-9
											 (INTEGER)Phone10[4] BETWEEN 2 AND 9 AND Phone10[5..6] <> '11' AND // NXX rules: First digit 2-9, second and third digits 0-9 + second and third digits not 11 (So as to form 911, 411, etc)
											 (INTEGER)Phone10[4..10] NOT BETWEEN 5550100 AND 5550199; // Fictional numbers are between: NPA-555-0100 through NPA-555-0199

	EXPORT INTEGER getFutureDate(INTEGER date, INTEGER years_in_future=3) := FUNCTION
		year := ((STRING)date)[1..4];
		future_year := (STRING)((INTEGER)year + years_in_future);
		future_date := future_year + ((STRING)date)[5..];
		RETURN IF(((STRING)date)[1..6]='999999', date,(INTEGER)future_date);	
	END;

	// The following function adds minutes to a YYYYMMDDTTTT value. It's not very 
	// robust: it cannot add a negative number of minutes correctly, for example,
	// when it takes the DD value to the previous day. Needs a few more lines of
	// code. It's recommended that you add a day's worth of minutes or less (see
	// the "carry the 1" comment below). 
	EXPORT INTEGER getFutureTime(INTEGER YYYYMMDDTTTT_value, INTEGER mins_in_future = 15) := 
		FUNCTION
			YYYYMMDDTTTT_as_string := (STRING)YYYYMMDDTTTT_value;
			
			// Break up input YYYYMMDDTTTT into parts for processing.
			year  := YYYYMMDDTTTT_as_string[1..4];
			month := YYYYMMDDTTTT_as_string[5..6];
			day   := YYYYMMDDTTTT_as_string[7..8];
			time  := YYYYMMDDTTTT_as_string[9..12];

			// Convert TTTT (i.e. HHMM) into minutes.
			int_time      := (INTEGER)time;
			hours_as_mins := (int_time DIV 100) * 60;
			mins          := int_time % 100;
			time_as_mins  := hours_as_mins + mins; 

			// Add the new minutes...
			new_time_as_mins := time_as_mins + mins_in_future;

			// ...and convert it back to HHMM. 
			new_hours := new_time_as_mins DIV 60;
			new_mins  := new_time_as_mins - (new_hours * 60);
			new_int_time := new_hours * 100 + new_mins;

			// Did we gain a day? Carry the 1.
			carryover_day  := IF( new_int_time > 2400, 1, 0 );
			carryover_time := IF( new_int_time > 2400, new_int_time - 2400, new_int_time );

			// Convert the YYYYMMDD values into days since 1900, add the carryover day...
			days_since_1900     := ut.DaysSince1900(year, month, day);
			new_days_since_1900 := days_since_1900 + carryover_day;

			// ...and convert it back to YYYYMMDD. Append TTTT.
			new_YYYYMMDD     := ut.DateFrom_DaysSince1900(new_days_since_1900);
			new_YYYYMMDDTTTT := (INTEGER)new_YYYYMMDD * 10000 + carryover_time;

			RETURN IF( LENGTH(YYYYMMDDTTTT_as_string) < 12, YYYYMMDDTTTT_value, new_YYYYMMDDTTTT);
	END;

	// Similar to Business_Header.is_ActiveCorp, but to allow for accurate archiving, we remove the requirement that the record to
	// be marked as current for the record to be classified as 'active'.
	EXPORT BOOLEAN is_ActiveCorp(STRING record_type, STRING corp_status_cd, STRING corp_status_desc) := 
		  (corp_status_cd IN ['A','U']) OR
		  (stringlib.stringfind(corp_status_desc, 'ACTIVE', 1) > 0 AND 
				stringlib.stringfind(corp_status_desc, 'INACTIVE', 1) = 0) OR
			(corp_status_desc <> '' AND stringlib.stringfind(corp_status_desc, 'INACTIVE', 1) = 0 AND
				stringlib.stringfind(corp_status_desc, 'DISSOLVED', 1) = 0) OR
			(corp_status_cd = '' AND corp_status_desc = '');
  
  EXPORT STRING1 calcBNAP_narrow(BOOLEAN NameMatched, BOOLEAN AddressMatched, BOOLEAN PhoneMatched) := 
    MAP(PhoneMatched = TRUE AND		NameMatched = FALSE AND	AddressMatched = FALSE	=> '1', // Input Phone returns a different Name and Address
        PhoneMatched = TRUE AND		NameMatched = FALSE AND	AddressMatched = TRUE		=> '4', // Input Phone matches Address, but the Name is different
        PhoneMatched = TRUE AND		NameMatched = TRUE  AND	AddressMatched = FALSE	=> '5', // Input Phone matches Business name, but the Address is different
        PhoneMatched = TRUE AND		NameMatched = TRUE  AND	AddressMatched = TRUE		=> '8', // Input Business name, Address and Phone Verified
        '0');
        
  EXPORT STRING1 calcBNAP_wide(BOOLEAN PhoneMatched, BOOLEAN PhonePopulated, BOOLEAN NameMatched, BOOLEAN AddressMatched, BOOLEAN StateMatched) := 
    MAP(PhoneMatched   = TRUE  AND	NameMatched  = FALSE AND	AddressMatched = FALSE																=> '1', // Input Phone returns a different Name and Address
        PhoneMatched   = FALSE AND	NameMatched  = FALSE AND	AddressMatched = TRUE																	=> '2', // Input Address returns a different Name and Phone
        PhoneMatched   = FALSE AND	NameMatched  = TRUE  AND	AddressMatched = FALSE AND StateMatched = TRUE => '3', // Input Business name exists in the state, but with a different Address and Phone
        PhoneMatched   = TRUE  AND	NameMatched  = FALSE AND	AddressMatched = TRUE																	=> '4', // Input Phone matches Address, but the Name is different
        PhoneMatched   = TRUE  AND	NameMatched  = TRUE  AND	AddressMatched = FALSE																=> '5', // Input Phone matches Business name, but the Address is different
        PhonePopulated = TRUE  AND PhoneMatched = FALSE AND	NameMatched    = TRUE AND	AddressMatched = TRUE => '6', // Input Business name matches Address, but the Phone doesn't match
        PhonePopulated = FALSE AND NameMatched  = TRUE  AND	AddressMatched = TRUE																	=> '7', // Input Name matches Address, But the Phone was not found or missing
        PhoneMatched   = TRUE  AND	NameMatched  = TRUE  AND	AddressMatched = TRUE																	=> '8', // Input Business name, Address and Phone Verified
        '0');
  
  // The following function cleans all non-ANSI chars from a string and substitutes a space instead.
  EXPORT STRING fn_CleanString(STRING x) := REGEXREPLACE('[^ -~]+',x,' ');
  
	EXPORT INTEGER getSalesRangeIndex(INTEGER SalesAmount) := FUNCTION
			SalesIndex := MAP(
					SalesAmount = -1																					=> -1,
					SalesAmount = 0																					  => 0,
					SalesAmount >= 1 AND SalesAmount < 500000 								=> 1,
					SalesAmount >= 500000 AND SalesAmount < 1000000 					=> 2,
					SalesAmount >= 1000000 AND SalesAmount < 5000000 					=> 3,
					SalesAmount >= 5000000 AND SalesAmount < 10000000 				=> 4,
					SalesAmount >= 10000000 AND SalesAmount < 25000000 				=> 5,
					SalesAmount >= 25000000 AND SalesAmount < 50000000 				=> 6,
					SalesAmount >= 50000000 AND SalesAmount < 75000000 				=> 7,
					SalesAmount >= 75000000 AND SalesAmount < 150000000 			=> 8,
					SalesAmount >= 150000000 AND SalesAmount < 200000000 			=> 9,
					SalesAmount >= 200000000 AND SalesAmount < 500000000 			=> 10,
					SalesAmount >= 500000000 AND SalesAmount < 1000000000 		=> 11,
					SalesAmount >= 1000000000 AND SalesAmount < 5000000000 		=> 12,
					SalesAmount >= 5000000000 AND SalesAmount < 10000000000 	=> 13,
					SalesAmount >= 10000000000 AND SalesAmount < 50000000000 	=> 14,
					SalesAmount >= 50000000000 AND SalesAmount < 100000000000 => 15,
					SalesAmount >= 100000000000																=> 16,
																																			 -1);
			RETURN SalesIndex;
		END;	

	EXPORT INTEGER getEmployeeRangeIndex(INTEGER EmployeeCount) := FUNCTION
			EmployeeIndex := MAP(
					EmployeeCount = -1																 => -1,
          EmployeeCount = 0                                  => 0,
					EmployeeCount >= 1 AND EmployeeCount < 5 					 => 1,
					EmployeeCount >= 5 AND EmployeeCount < 10 				 => 2,
					EmployeeCount >= 10 AND EmployeeCount < 20 				 => 3,
					EmployeeCount >= 20 AND EmployeeCount < 50 				 => 4,
					EmployeeCount >= 50 AND EmployeeCount < 100 			 => 5,
					EmployeeCount >= 100 AND EmployeeCount < 250 			 => 6,
					EmployeeCount >= 250 AND EmployeeCount < 500 			 => 7,
					EmployeeCount >= 500 AND EmployeeCount < 1000 		 => 8,
					EmployeeCount >= 1000 AND EmployeeCount < 2000 		 => 9,
					EmployeeCount >= 2000 AND EmployeeCount < 5000 		 => 10,
					EmployeeCount >= 5000 AND EmployeeCount < 10000 	 => 11,
					EmployeeCount >= 10000 AND EmployeeCount < 25000 	 => 12,
					EmployeeCount >= 25000 AND EmployeeCount < 50000 	 => 13,
					EmployeeCount >= 50000 AND EmployeeCount < 75000 	 => 14,
					EmployeeCount >= 75000 AND EmployeeCount < 100000  => 15,
					EmployeeCount >= 100000 AND EmployeeCount < 150000 => 16,
					EmployeeCount >= 150000 AND EmployeeCount < 200000 => 17,
					EmployeeCount >= 200000 AND EmployeeCount < 250000 => 18,
					EmployeeCount >= 250000 AND EmployeeCount < 300000 => 19,
					EmployeeCount >= 300000														 => 20,
																															 -1);
			RETURN EmployeeIndex;
		END;	
		
EXPORT STRING getCorteraTradelineIndex(STRING AvgPctTradelinesBeyondTerms) := FUNCTION
			IndexResults := MAP(AvgPctTradelinesBeyondTerms = '-1' 				=> '-1',
													AvgPctTradelinesBeyondTerms = '0'	 				=> '0',
													(INTEGER)AvgPctTradelinesBeyondTerms > 0 	=> '1',
																																			 '-1');
			RETURN IndexResults;
		END;

EXPORT STRING getCorteraTrajectory(STRING total_numrel_avg, STRING total_slope, STRING mthspastleast = '24', STRING mthspastmost = '24') := FUNCTION
      DataReported := (REAL)total_numrel_avg <> 0 OR (REAL)mthspastleast <> 24 OR (REAL)mthspastmost <> 24;
			TrajectoryIndex := MAP(	TRIM(total_numrel_avg) = '' 					=> '-1', // Not on file
                              NOT DataReported                      => '0',	 // No B2B data reported in the last 12 months
														 (REAL)total_slope < 0 AND DataReported	=> '2',  // Negative trajectory in the last 12 months
														 (REAL)total_slope = 0 AND DataReported => '3',	 // No change in the past 12 months
														 (REAL)total_slope > 0 AND DataReported => '4',	 // Positive trajectory in the past 12 months
																																			 '1'); // Else: unknown trajectory			
			RETURN TrajectoryIndex;
		END;	
		
EXPORT STRING rollCorteraTrajectory(STRING left_trajectory, STRING right_trajectory) := FUNCTION
			RolledTrajectory := MAP(left_trajectory = right_trajectory 																   => left_trajectory,																									                         // If trajectories are equal, use that
															(left_trajectory = '-1' OR right_trajectory = '-1') AND 																																									
															((INTEGER)left_trajectory >= 0 OR (INTEGER)right_trajectory >= 0) => (STRING)MAX((INTEGER)left_trajectory, (INTEGER)right_trajectory), // If one trajectory is -1, use the other trajectory
															(left_trajectory = '0' OR right_trajectory = '0') AND 
															((INTEGER)left_trajectory > 0 OR (INTEGER)right_trajectory > 0) 	 => (STRING)MAX((INTEGER)left_trajectory, (INTEGER)right_trajectory), // If one trajectory is 0, use the other trajectory
                                                                                    '1');																														                               // Otherwise, the two trajectories are both > 0 but are not equal, 
                                                                                                                                                      // so return '1' indicating trajectory is unknown.
			RETURN RolledTrajectory;
		END;
		
	// This function determines whether a firstname or lastname are found as at least one of the words in the companyname.
EXPORT fn_isFoundInCompanyName( STRING CompanyName, STRING PersonName ) := FUNCTION
		UCase       := STD.Str.ToUpperCase;
		layout_word := {STRING companyname_word};

		// Make sure the first and last name are at least 2 characters long so 
		// we aren't comparing blank or 1 character names to the company name.
		hasAtLeastTwoChars := LENGTH(TRIM(PersonName)) >= 2;

		// Remove possessive suffixes (...'s and ...'), and commas.
		layout_word xfm_removeUnwantedChars( layout_word le ) := TRANSFORM
			filt1 := STD.Str.FindReplace( le.companyname_word, '\'S', '' );
			filt2 := STD.Str.FindReplace( filt1     , '\'' , '' );
			filt3 := STD.Str.FindReplace( filt2     , ','  , '' );
			SELF.companyname_word := filt3;
		END;
		
		set_CompanyName_words     := STD.Str.SplitWords(UCase(CompanyName),' ');
		ds_CompanyName_words      := DATASET( set_CompanyName_words, layout_word );
		ds_CompanyName_words_filt := PROJECT( ds_CompanyName_words, xfm_removeUnwantedChars(LEFT) );
		isFoundInCompanyName      := COUNT( ds_CompanyName_words_filt(companyname_word = UCase(PersonName)) ) > 0;
		
		RETURN isFoundInCompanyName AND hasAtLeastTwoChars;
	END;
	
  // The following function takes a comma-delimited string of any length, and a numeric
		// length to truncate the string to. Since the resulting string will often have an 
		// incomplete value at the end, the function trims it off, leaving complete values only.
    
  EXPORT truncate_list (STRING str, UNSIGNED max_len) := FUNCTION //
    strt := TRIM (str); 
    str_temp := str[1..max_len+1]; 
    cm := STD.Str.Find (str_temp, ',', STD.Str.CountWords (str_temp, ',')-1); 
    strt_trimmed := IF (STD.Str.EndsWith (str_temp, ','), str_temp[1..max_len], str_temp[1..cm-1]); 
    RETURN IF (length (strt) < max_len, strt, strt_trimmed); 
  END;
	
  
  
END;