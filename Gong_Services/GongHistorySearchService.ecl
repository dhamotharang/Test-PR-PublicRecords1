/*--SOAP--
<message name="gongHistorySearchRequest">
	<part name="SourceDocView" type="xsd:boolean"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
  <part name="PrimRange" type="xsd:string"/>
  <part name="PrimName" type="xsd:string"/>
  <part name="SecRange" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="Addr2" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="StateCityZip" type="xsd:string"/>
	<part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="ExcludeRadius" type="xsd:unsignedInt"/>
	<part name="County" type="xsd:string"/>
	<part name="CompanyName" type="xsd:string"/>
	<part name="FirstWord" type="xsd:string"/>
	<part name="AnyWord1" type="xsd:string"/>
	<part name="AnyWord2" type="xsd:string"/>
  <part name="phone" type="xsd:string"/>
	<part name="AreaCode" type="xsd:string"/>
	<part name="DID" type="xsd:string"/>
	<part name="PhoneticMatch" type="xsd:boolean"/>
	<part name="AllowNickNames" type="xsd:boolean"/>
	<part name="SuppressNonCurrent" type="xsd:boolean"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="ScoreThreshold" type="xsd:unsignedInt"/>
	<part name="ExcludeResultsInGivenCity" type="xsd:boolean"/>
	<part name="ExcludeResidence" type="xsd:boolean"/>
	<part name="ExcludeBusiness" type="xsd:boolean"/>
	<part name="ExcludeGovernment" type="xsd:boolean"/>
	<part name="AllowNameWildCard" type="xsd:boolean"/>
	<part name="AllowUseCNkey" type="xsd:boolean"/>
	<part name="NoFallBack" type="xsd:boolean"/>
	<part name="AllowNonPublish" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="RestrictRollupInDays" type="xsd:unsignedInt"/>
	<part name="ApplicationType"     type="xsd:string"/>
  <part name="UseBusinessIds" type="xsd:boolean"/>
	</message>
*/
/*--INFO-- This service searches the gong history file. */
/*
	There's basically two mode of operation of this query. There's
	SourceDocView and not SourceDocView, switched by the SourceDocView soapcall
	parameter.
	SourceDocView accepts name, address, and phone number inputs and
	finds all the records in the history by those
	name, address, and phone number inputs. The did and hhid entries of
  the found records are used to find matching did and hhid records.
	The records are scored and returned to the caller.
	Not SourceDocView is used by phone and reverse phone lookup. Phone lookup
	takes name and address information as input , reverse phone takes a phone
	number as input. Records are found using the input information. The dids and
	hhids of the found records are NOT used to find additional records.
	The found records are rolled up by listing name, address, phone number.
	During the rollup, the dt_first_seen and dt_last_seen dates are calculated
	from the duplicate records. The records are scored and returned to the
	caller.

	Inputs
		ZipRadius. Sets search distance from the supplied Zip Code.
		PhoneticMatch. Sets phonetic matching on LastName.
		AllowNickNames. When true, the FirstName may be a nickname.
		MaxResults. Set the maximum number of records returned. This value
			can be smaller but cannot be greater than the default.
		ScoreThreshold. Return only records below this score threshold.

*/
import doxie, ut, progressive_phone, iesp, suppress;
export GongHistorySearchService := MACRO

  string120 in_cname_value := '' : stored('CompanyName');
	string30 in_county_value := '' : stored('County');
  #STORED('ScoreThreshold',if((in_cname_value<>'' or in_county_value<>''), 10, 1000));

	boolean SuppressNonCurrent := false : stored('SuppressNonCurrent');
	boolean exclude_given_city := false : stored('ExcludeResultsInGivenCity');
	boolean exclude_residence := false : stored('ExcludeResidence');
	boolean exclude_business := false : stored('ExcludeBusiness');
	boolean exclude_government := false : stored('ExcludeGovernment');
	boolean no_fallback_value := false : stored('NoFallBack');
	string25 in_city_val := '' : stored('City');
	string25 in_city_value := stringlib.StringToUpperCase(in_city_val);
	unsigned2 exclude_zipradius_value := 0 : stored('ExcludeRadius');
	unsigned2 RestrictRollupInDays := 0 : stored('RestrictRollupInDays');
	boolean allow_non_publish_value := false : stored('AllowNonPublish');
	string3 area_code_value := '' : stored('AreaCode');
	boolean useBusinessIds := false : stored('UseBusinessIds');

	doxie.MAC_Header_Field_Declare()

  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

	exclude_zip_set := ut.fn_GetZipSet(city_value, state_value, zip_val,	county_value, city_zip_value, exclude_zipradius_value);

	phone_ds_in := dataset([{phone_value,''}],{string10 subj_phone10, string1 switch_type});
	progressive_phone.mac_get_switchtype(phone_ds_in, phone_ds_out_raw)

	phone_ds_out_exp_rec := record
		phone_ds_out_raw;
		string10 switch_type_desc;
	end;

	phone_ds_out := project(phone_ds_out_raw, transform(phone_ds_out_exp_rec,
	                                                    self.switch_type_desc := map(left.switch_type='C' => 'MOBILE',
																											                             left.switch_type='G' => 'PAGER', ''),
	                                                    self := left));

	OUTPUT(phone_ds_out, NAMED('PhoneTypeRecs'));

	MatchingRawRecs := Gong_Services.Fetch_Gong_History(
    indids := dataset([{did_value}],doxie.layout_references),
    mod_access := mod_access,
    SuppressNonCurrent := SuppressNonCurrent,
    AllowFallBack := ~no_fallback_value,
    AllowLooseSecRangeMatch := true,
    RestrictRollupInDays := RestrictRollupInDays,
    useBusinessIds := useBusinessIds) //END of function call, start of results filter.
    (publish_code<>'N' or allow_non_publish_value or
    (company_name<>'' or phone_value<>'' or
    fname_value<>''  or lname_value<>'' or mname_value<>''),
    exclude_zipradius_value=0 or (INTEGER4)z5 not in exclude_zip_set,
    area_code_value='' or phone10[1..3]=area_code_value);

	MatchingRecs := map(phone_value<>'' and SuppressNonCurrent =>
	                    sort(MatchingRawRecs, penlty, phone10, -dt_last_seen, -dt_first_seen),
											zipradius_value<>0 and city_value<>'' and SuppressNonCurrent =>
											sort(MatchingRawRecs, if(p_city_name=city_value,0,1) +
																						if(state_value='' or st=state_value,0,1) +
																						if(lname_value='' or name_last=lname_value, 0,1) +
																						if(fname_value='' or name_first=fname_value, 0,1) +
																						if(pname_value='' or prim_name=pname_value,0,1) +
																						if(prange_value='' or prim_range=prange_value,0,1) +
																						if(company_name='' or listing_type_bus='' or listed_name=company_name,0,1),
											                      listed_name, -dt_last_seen, -dt_first_seen, -phone10),
											zipradius_value<>0 and SuppressNonCurrent =>
											sort(MatchingRawRecs, ut.zip_Dist(z5, if(zip_val<>'', zip_val, city_zip_value)),
											                      z5, listed_name, -dt_last_seen, -dt_first_seen, -phone10),
										  MatchingRawRecs);

	layout_with_timezone := record
			MatchingRecs;
			string8 timezone := '';
  		iesp.share.t_duration TimePhoneInService ;
	end;

	WithTimeZoneReadyRecs := project(MatchingRecs, transform(layout_with_timezone,self := left, self:=[]));

	ut.getTimeZone(WithTimeZoneReadyRecs,phone10,timezone,WithTimeZoneRawRecs);

	WithTimeZoneRecs := project(WithTimeZoneRawRecs, transform(layout_with_timezone,
	                                                           self.phone10 := if(left.publish_code='N', 'UNLISTED', left.phone10),
																														 self.timezone := if(left.publish_code='N', 'UNLISTED', left.timezone),
																										   	     self.prim_range := if(left.publish_code='N', '', left.prim_range),
																												  	 self.predir := if(left.publish_code='N', '', left.predir),
																												     self.prim_name := if(left.publish_code='N', '', left.prim_name),
																													   self.suffix := if(left.publish_code='N', '', left.suffix),
																													   self.postdir := if(left.publish_code='N', '', left.postdir),
			                                                       self.unit_desig := if(left.publish_code='N', '', left.unit_desig),
																												  	 self.sec_range := if(left.publish_code='N', '', left.sec_range),
																												  	 self.v_predir := if(left.publish_code='N', '', left.v_predir),
																												     self.v_prim_name := if(left.publish_code='N', '', left.v_prim_name),
																												  	 self.v_suffix := if(left.publish_code='N', '', left.v_suffix),
																												     self.v_postdir := if(left.publish_code='N', '', left.v_postdir),
																														 SELF.TimePhoneInService := iesp.ECL2ESP.GetDuration(left.dt_first_seen,left.dt_last_seen),
	                                                           self := left));

	MatchingReadyRecs_preSuppress := map(exclude_given_city => WithTimeZoneRecs(in_city_value='' or
	                                                                p_city_name<>in_city_value and
																									   							v_city_name<>in_city_value),
													exclude_residence => WithTimeZoneRecs(listing_type_bus<>''),
													exclude_business => WithTimeZoneRecs(listing_type_res<>''),
													exclude_government => WithTimeZoneRecs(listing_type_gov='' or
													                                       listing_type_gov<>'' and listing_type_bus<>'' and listing_type_res<>''),
													WithTimeZoneRecs);

	Suppress.MAC_Suppress(MatchingReadyRecs_preSuppress,MatchingReadyRecs,application_type_value,Suppress.Constants.LinkTypes.DID,did,'','',false,'');

	doxie.MAC_Marshall_Results(MatchingReadyRecs, MatchingFinalRecs);

	//OUTPUT(COUNT(MatchingFinalRecs), NAMED('RecordsAvailable'));
  OUTPUT(MatchingFinalRecs, NAMED('MatchingRecs'));
	// Tell the caller something about the phone number.
	TelcordiaRec := Gong_Services.Fetch_Telcordia_for_Gong_History;

	OUTPUT(COUNT(TelcordiaRec), NAMED('TelcordiaCount'));
	OUTPUT(TelcordiaRec, NAMED('TelcordiaRecs'));

ENDMACRO;
 //Gong_Services.GongHistorySearchService();