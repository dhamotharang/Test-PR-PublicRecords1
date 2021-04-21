/*--SOAP--
<message name="IngenixProviderReportRequest">
  <part name="Gateways" type="tns:XmlDataSet" cols="80" rows="4"/> 
	<part name="DID" type="xsd:string"/>
  <part name="ProviderID" type="xsd:unsignedInt" required="1"/>
  <part name="ProviderSrc" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte" />
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="IncludeSanctions" type="xsd:boolean"/>
  <part name="SanctionID" type="tns:EspStringArray"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service pulls from the Ingenix provider files.*/

IMPORT AutoStandardI, doxie_files, ingenix_natlprof, Prof_licensev2_services, Healthcare_Header_Services,ut,Gateway;

EXPORT ING_provider_report := 
  MACRO

UNSIGNED6 rawdid := 0: STORED('DID');
UNSIGNED6 provid := 0: STORED('ProviderID');
string provsrc := 'P': STORED('ProviderSrc');
set of unsigned6  sanc_set := [] : stored('SanctionID');
boolean		IncludeSanc := false : stored('IncludeSanctions');


doxie.MAC_Header_Field_Declare()
gm := AutoStandardI.GlobalModule();

layout  := Healthcare_Header_Services.Layouts.autokeyInput;
layout setinput():=transform
	self.acctno := '1';
	self.did:=rawdid;
	self.providerid:=provid;
	self.providerSRC:=STD.Str.ToUpperCase(provsrc);
	self:=[]
end;
layout setinputSanc(integer cnt):=transform
	self.acctno := '1';
	self.providerid:=(integer)((STRING)sanc_set[cnt])[1..length((String)sanc_set[cnt])-3];
	self.providerSRC:=STD.Str.ToUpperCase(provsrc);
	self:=[]
end;
dsSet:=dedup(project(dataset(sanc_set,{unsigned6 did}),setinputSanc(counter)),acctno,providerid,providerSRC,hash,all);
searchByCriteria := dataset([setinput()])+dsSet;
Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
	self.includeSanctions:=IncludeSanc;
	self.DRM := gm.DataRestrictionMask;
	self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
	self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
	self.glb :=  gm.GLBPurpose;
	self.dppa := gm.DPPAPurpose;
	self.IncludeGroupAffiliations := true; 
	self.IncludeHospitalAffiliations := true;
	// self:=[];Do not uncomment otherwise the default values will not get set.
end;
cfg:=dataset([buildConfig()]);
prov_rslts := doxie.ING_provider_report_records(dataset([],prof_licensev2_services.layout_search_ids_prov),IncludeSanc,searchByCriteria,cfg);
OUTPUT(prov_rslts, NAMED('Results'));

ENDMACRO;