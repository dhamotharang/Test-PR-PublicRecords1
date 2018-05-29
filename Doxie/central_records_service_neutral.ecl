// This is an FCRA-neutral service; called by fcra-services through the soap interface.

/*--SOAP--
<message name="central_records_service_neutral" wuTimeout="300000">
  <part name="SSN" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
</message>
*/
/*--INFO-- This service searches all available datafiles and returns DID (wrapped into central-alike layout).*/

IMPORT doxie, doxie_crs;

// The sole purpose of it is to find a DID using non-fcra header.
// At the moment I prefer to keep the same format as before, but later we can either reduce it to just DIDs
//   or simply call a different service.
// Note: no suppression (inless executed in the search-library);
//       a caller has a choice whether to use standard suppression or domain specific (i.e. overrides on FCRA side)

EXPORT central_records_service_neutral :=  MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#stored('IsCRS',TRUE);
#stored('useOnlyBestDID',TRUE);
#constant('AllowGLB',TRUE);
#constant('AllowDPPA',TRUE);

// find DIDs
dids := doxie.Get_Dids();

// create pseudo-best record
besr := PROJECT (dids, TRANSFORM (doxie_crs.layout_best_information, 
                                  SELF.did := LEFT.did,
                                  SELF := []));// phones, deceased

// keep same format for backward compatibility
doxie.layout_central_records Format () := TRANSFORM
  SELF.best_information_children := besr;
  SELF := [];
END;

cent := DATASET ([Format ()]);
IF (COUNT (dids)>1, FAIL('ambiguous criteria'), OUTPUT (cent, NAMED ('CRS_result')));

ENDMACRO;
// central_records_service_neutral ();