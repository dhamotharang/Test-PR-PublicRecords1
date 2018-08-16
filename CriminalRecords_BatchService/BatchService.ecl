/*--SOAP--
<message name="BatchService">
  <part name="batch_in"    type="tns:XmlDataSet" cols="70" rows="25"/>
	<!-- part name="NoDeepDive"  type="xsd:boolean"/ -->
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose"  type="xsd:byte"/> 
  <part name="MaxResults"  type="xsd:unsignedInt"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="ApplicationType" type="xsd:string"/>

	<!-- Optional indicators for offense categories to be filtered on/returned. 06/13/2017 enhancement. --> 
	<part name="IncludeArson"                       type="xsd:boolean"/>
	<part name="IncludeAssaultAgg"                  type="xsd:boolean"/>
  <part name="IncludeAssaultOther"                type="xsd:boolean"/>
  <part name="IncludeBadChecks"                   type="xsd:boolean"/>
  <part name="IncludeBribery"                     type="xsd:boolean"/>
  <part name="IncludeBurglaryComm"                type="xsd:boolean"/>   
  <part name="IncludeBurglaryRes"                 type="xsd:boolean"/>
  <part name="IncludeBurglaryVeh"                 type="xsd:boolean"/> 
  <part name="IncludeComputer"                    type="xsd:boolean"/>
  <part name="IncludeCounterfeit"                 type="xsd:boolean"/>
  <part name="IncludeCurLoiVag"                   type="xsd:boolean"/>
  <part name="IncludeVandalism"                   type="xsd:boolean"/>
  <part name="IncludeDisorderly"                  type="xsd:boolean"/>
  <part name="IncludeDUI"                         type="xsd:boolean"/>
  <part name="IncludeDrug"                        type="xsd:boolean"/>
  <part name="IncludeDrunk"                       type="xsd:boolean"/>
  <part name="IncludeFamilyOff"                   type="xsd:boolean"/>
  <part name="IncludeFraud"                       type="xsd:boolean"/>
  <part name="IncludeGambling"                    type="xsd:boolean"/>
  <part name="IncludeHomicide"                    type="xsd:boolean"/>
  <part name="IncludeHumanTraff"                  type="xsd:boolean"/>
  <part name="IncludeIdTheft"                     type="xsd:boolean"/>
  <part name="IncludeKidnapping"                  type="xsd:boolean"/>
  <part name="IncludeLiquorLaw"                   type="xsd:boolean"/>
  <part name="IncludeMVTheft"                     type="xsd:boolean"/>
  <part name="IncludePeepingTom"                  type="xsd:boolean"/>
  <part name="IncludePornography"                 type="xsd:boolean"/>
  <part name="IncludeProstitution"                type="xsd:boolean"/>
  <part name="IncludeRestraining"                 type="xsd:boolean"/>
  <part name="IncludeRobberyComm"                 type="xsd:boolean"/>
  <part name="IncludeRobberyRes"                  type="xsd:boolean"/>
  <part name="IncludeSOForce"                     type="xsd:boolean"/>
  <part name="IncludeSONonForce"                  type="xsd:boolean"/>
  <part name="IncludeShoplift"                    type="xsd:boolean"/>
  <part name="IncludeStolenProp"                  type="xsd:boolean"/> 
  <part name="IncludeTerrorist"                   type="xsd:boolean"/>
  <part name="IncludeTheft"                       type="xsd:boolean"/>
  <part name="IncludeTraffic"                     type="xsd:boolean"/>
  <part name="IncludeTrespass"                    type="xsd:boolean"/>
  <part name="IncludeWeaponLaw"                   type="xsd:boolean"/>
  <part name="IncludeOther"                       type="xsd:boolean"/>
	<part name="IncludeCannotClassify"              type="xsd:boolean"/>
	<part name="IncludeWarrantFugitive"             type="xsd:boolean"/>
	<part name="IncludeObstructResist"              type="xsd:boolean"/>

</message>
*/

EXPORT BatchService() := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
 #WEBSERVICE(DESCRIPTION('This service pulls from the Criminal Offenders & 2 Offenses files.'));

	ds_xml_in		    := DATASET([], CriminalRecords_BatchService.Layouts.batch_in) : STORED('batch_in');
	
	crim_batch_params := CriminalRecords_BatchService.IParam.getBatchParams();
	
	// run input through some standard procedures
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);	
	
	ds_batch_out := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_batch_in);
	
	// Restore original acctno.	
	BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out.Records, results, false);	
	
	ut.mac_TrimFields(results, 'results', result);
	
	OUTPUT(result, NAMED('RESULTS'), ALL);

ENDMACRO;
