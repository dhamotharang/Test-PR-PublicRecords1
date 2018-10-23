/*--SOAP--
<message name="WeAlsoFoundService">
  <part name="SSN" type="xsd:string"/>
  <part name="SSNTypos" type="xsd:boolean"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="PhoneticDistanceMatch" type="xsd:boolean"/>
  <part name="DistanceThreshold" type="xsd:unsignedInt"/>
  <part name="MiddleName" type="xsd:string"/>
	<part name="NonExclusion" type="xsd:boolean"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="Household" type="xsd:boolean"/> 
<!--  <part name="LookupType" type="xsd:string"/> -->
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="AllowWildcard" type="xsd:boolean"/>
</message>

*/
/*--INFO-- This service searches the dids from header file.*/

EXPORT WeAlsoFoundService := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
  import doxie;
  #CONSTANT('BestOnly', true);

  dids := doxie.Get_Dids ();
  boolean Err := count (dids) > 1;
  IF (Err, FAIL (11, doxie.ErrorCodes (11)));

  doxie.MAC_Header_Field_Declare(); // read glb, dppa

  // slim down to required fields
  slim_rec := RECORD
    dids.did;
		qstring5     title := '';
		qstring20    fname := '';
		qstring20    mname := '';
		qstring20    lname := '';
		qstring5     name_suffix := '';
    doxie.layout_lookups.xcount.comp_prop_count;
    doxie.layout_lookups.xcount.veh_cnt;
    doxie.layout_lookups.xcount.dl_cnt;
    doxie.layout_lookups.xcount.rel_count;
    doxie.layout_lookups.xcount.assoc_count;
    doxie.layout_lookups.xcount.prof_count;
    doxie.layout_lookups.xcount.vess_count;
    doxie.layout_lookups.xcount.paw_count;
    doxie.layout_lookups.xcount.phonesplus_count;
		doxie.layout_lookups.xcount.email_count;
		doxie.layout_lookups.xcount.accident_count;
  END;

  best_recs := doxie.best_records(dids,,dppa_purpose,glb_purpose,,,,false,true); 
  dids_adjust := join(dids,best_recs,left.did = right.did, transform (slim_rec, Self := Left, self := right, Self := []));

  doxie.MAC_Add_WeAlsoFound (dids_adjust, res, GLB_Purpose, DPPA_Purpose, false);  // false: do not convert into string

  IF (~ERR, OUTPUT (count (res), NAMED ('RecordsAvailable')));
  IF (~Err, OUTPUT (res, NAMED ('Results')));
ENDMACRO;

// WeAlsoFoundService ();