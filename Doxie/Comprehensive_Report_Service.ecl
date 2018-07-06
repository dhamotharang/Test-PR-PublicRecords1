/*--SOAP-- 
<message name="ComprehensiveReport" wuTimeout="300000">
  <part name="ENTRP_Month_Value" type="xsd:string"/>
  <part name="IndustryCLASS" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="StateCityZip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="BusinessPhone" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ExcludeSources" type="xsd:boolean"/>	
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="PhonesPerAddress" type="xsd:byte"/>
	<part name="LawEnforcement" type="xsd:boolean"/>
	<part name="LegacyVerified" type="xsd:boolean"/>
	<part name="UccVersion" type="xsd:byte"/>
	<part name="JudgmentLienVersion" type="xsd:byte"/>
	<part name="BankruptcyVersion" type="xsd:byte"/>
	<part name="VehicleVersion" type="xsd:byte"/>
	<part name="VoterVersion" type="xsd:byte"/>
	<part name="CriminalRecordVersion" type="xsd:byte"/>
	<part name="DlVersion" type="xsd:byte"/>
	<part name="DeaVersion" type="xsd:byte"/>	
	<part name="PropertyVersion" type="xsd:byte"/>	
	<part name="IncludePhonesPlus" type="xsd:boolean"/>
  <part name="SelectIndividually" type="xsd:boolean"/>
	<part name="IncludeTimeline" type="xsd:boolean"/>
	<part name="IncludeAKAs" type="xsd:boolean"/>
	<part name="IncludeImposters" type="xsd:boolean"/>
	<part name="IncludeAssociates" type="xsd:boolean"/>
	<part name="MaxAssociates" type="xsd:unsignedInt"/>
	<part name="ExcludeResidentsForAssociatesAddresses" type="xsd:boolean"/>	
	<part name="IncludeOldPhones" type="xsd:boolean"/>
	<part name="IncludeProperties" type="xsd:boolean"/>
  <part name="IncludePropertySellerData" type="xsd:boolean"/>
	<part name="IncludePriorProperties" type="xsd:boolean"/>
	<part name="UseCurrentlyOwnedProperty" type="xsd:boolean"/>
	<part name="UseCurrentlyOwnedVehicles" type="xsd:boolean"/>
	<part name="IncludeDriversLicenses" type="xsd:boolean"/>
	<part name="IncludeMotorVehicles" type="xsd:boolean"/>
	<part name="IncludeBankruptcies" type="xsd:boolean"/>
	<part name="IncludeLiensJudgments" type="xsd:boolean"/>
	<part name="IncludeCorporateAffiliations" type="xsd:boolean"/>
	
	<part name="IncludeUCCFilings" type="xsd:boolean"/>
	<part name="IncludeDEARecords" type="xsd:boolean"/>
	<part name="IncludeFAACertificates" type="xsd:boolean"/>
	<part name="IncludeCriminalRecords" type="xsd:boolean"/>
	<part name="IncludeCensusData" type="xsd:boolean"/>
	<part name="IncludeAccidents" type="xsd:boolean"/>
	<part name="EnableNationalAccidents" type="xsd:boolean"/>
	<part name="EnableExtraAccidents" type="xsd:boolean"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="AccidentState" type="xsd:string"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="IncludeSanctions" type="xsd:boolean"/>
	<part name="IncludeProviders" type="xsd:boolean"/>
	<part name="IncludeUtility" type="xsd:boolean"/>
	<part name="IncludeEmailAddresses" type="xsd:boolean"/>
	<part name="IncludePeopleAtWork" type = "xsd:boolean"/>
	<part name="IncludeVoterRegistrations" type="xsd:boolean"/>
	<part name="IncludeHuntingFishingLicenses" type="xsd:boolean"/>
	<part name="IncludeFirearmsAndExplosives" type="xsd:boolean"/>
	<part name="IncludeWeaponPermits" type="xsd:boolean"/>
	<part name="IncludeSexualOffenses" type="xsd:boolean"/>
	
	<part name="IncludeInternetDomains" type="xsd:boolean"/>

	<part name="IncludeFAAAircrafts" type="xsd:boolean"/>
	<part name="IncludeWatercrafts" type="xsd:boolean"/>
	<part name="IncludeHRI" type="xsd:boolean"/>
	<part name="IncludeNoticeOfDefaults" type="xsd:boolean"/>
	<part name="IncludeForeclosures" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/>

	<part name="IncludeRelatives" type="xsd:boolean"/>
  <part name="MaxRelatives" type="xsd:unsignedInt"/>
  <part name="RelativeDepth" type="xsd:byte"/> 
	<part name="IncludeRelativeAddresses" type="xsd:boolean"/>
  <part name="MaxRelativeAddresses" type="xsd:unsignedInt"/>
	<part name="IncludeNeighbors" type="xsd:boolean"/>
	<part name="MaxNeighborhoods" type="xsd:unsignedInt"/>
  <part name="NeighborsPerAddress" type="xsd:byte"/>
  <part name="AddressesPerNeighbor" type="xsd:byte"/>
	<part name="IncludeHistoricalNeighbors" type="xsd:boolean"/>
	<part name="NeighborsPerNA" type="xsd:byte"/>
	<part name="NeighborRecency" type="xsd:byte"/>
	<part name="MaxAddresses" type="xsd:unsignedInt"/>

	<part name="IncludeBusinessAddress" type="xsd:boolean"/>
	<part name="IncludeGroupAffiliations" type="xsd:boolean"/>
	<part name="IncludeHospitalAffiliations" type="xsd:boolean"/>
	<part name="IncludeEducation" type="xsd:boolean"/>

	<part name="IncludeVerification" type="xsd:boolean"/>
	<part name="IncludePhoneSummary" type="xsd:boolean"/>
	<part name="IncludeImages" type="xsd:boolean"/>
	<part name="IncludeStudentInformation" type="xsd:boolean"/>
	
  <part name="RecordByDate" type="xsd:string"/>
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="LnBranded" type="xsd:boolean"/>
	<part name="UsingKeepSSNs" type="xsd:boolean"/>
	<part name="KeepOldSsns" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>

  <part name="hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
	<part name="TrackNameChanges" type="xsd:boolean"/>
	<part name="TrackSSNChanges" type="xsd:boolean"/>
	<part name="TrackStatusChanges" type="xsd:boolean"/>
	<part name="TrackAddressChanges" type="xsd:boolean"/>
	<part name="TrackPhoneChanges" type="xsd:boolean"/>
	<part name="TrackListedPhoneChanges" type="xsd:boolean"/>
	<part name="TrackAssetChanges" type="xsd:boolean"/>
	<part name="TrackPropertyChanges" type="xsd:boolean"/>
	<part name="TrackBankruptcyChanges" type="xsd:boolean"/>
	<part name="TrackUCCChanges" type="xsd:boolean"/>
	<part name="TrackLiensChanges" type="xsd:boolean"/>
	<part name="TrackLicenseChanges" type="xsd:boolean"/>
	<part name="TrackCriminalChanges" type="xsd:boolean"/>
	<part name="TrackSexOffenderChanges" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="IncludeDriversAtAddress" type="xsd:boolean"/>
	<part name="IncludePatriot" type="xsd:boolean"/>
	<part name="IncludeFBN" type="xsd:boolean"/>
	<part name="IncludeRTVeh" type="xsd:boolean"/>
	<part name="IncludeBlankDOD" type="xsd:boolean"/>
	<part name="IncludeTransactionHistory" type="xsd:boolean"/>
	<part name="AppendRTVeh" type="xsd:boolean"/>
	<part name='RealTimePermissibleUse' 	type = 'xsd:string' />

	<part name="MaxSubjectAddresses" type="xsd:integer" default="-1"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>

  <part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
  <part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean"/>

	<part name="ExcludeDMVPII" type="xsd:boolean"/>
  <part name="GetSSNBest" type="xsd:boolean"/>

	<!-- FDN only options/fields -->
	<part name="IncludeFraudDefenseNetwork" type="xsd:boolean"/>
	<part name="IncludeFDNSubjectOnly"      type="xsd:boolean"/>
	<part name="IncludeFDNAllAssociations"  type="xsd:boolean"/>
	<part name="GlobalCompanyId"				    type="xsd:unsignedInt"/>
	<part name="IndustryType"	    			    type="xsd:unsignedInt"/>
	<part name="ProductCode"		  		      type="xsd:unsignedInt"/>

	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>

	<!-- Premium phones options/fields -->
	<part name="IncludePremiumPhones" type="xsd:boolean"/>
	<part name="DedupPremiumPhones" type="tns:EspStringArray"/>

 </message>
*/
/*--INFO-- This service searches all available datafiles.*/

import doxie, CriminalRecords_Services, doxie_crs, doxie_raw, DriversV2_Services, images, Royalty;

export Comprehensive_Report_Service := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#CONSTANT('TwoPartySearch', FALSE);


#option ('maxCompileThreads', 4);
#stored('IncludeAllDIDRecords','1');
#stored('ReportReq',true);
#stored('useOnlyBestDID',true);
#stored('DataRestrictionMask','00000000000000000000');  //intentionally has diff default behavior than doxie_ln version
#CONSTANT('GONG_SEARCHTYPE','PERSON');
#CONSTANT('IsCRS', true);
#constant('IncludeNonDMVSources', true);

BOOLEAN in_getSSNBest := FALSE: STORED('GetSSNBest');
UNSIGNED1 OFACversion      := 1        : stored('OFACversion');

gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(OFACversion = 4 and le.servicename = 'bridgerwlc',le.servicename, '');
	self.url := if(OFACversion = 4 and le.servicename = 'bridgerwlc', le.url, ''); 		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if( OFACversion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

doxie.MAC_Header_Field_Declare();
doxie.MAC_Selection_Declare();

  // use non-remote header data; non-fcra;
  dids := doxie.get_dids();
  ds_header := doxie.central_header (dids, false, false, in_getSSNBest);
  cent := doxie.central_records (false, 'D', ds_header);

//pick up the distributed records

boolean includeGeoLocation := false : stored('IncludeGeoLocation');
vehi := if(VehicleVersion in [0,1],doxie.vehicle_search_records_crs); 
vehi2 := if(VehicleVersion in [0,2] and Include_MotorVehicles_val,doxie.vehicleV2_search_records_crs(dids, Use_CurrentlyOwnedVehicles_value));
rt_cent := normalize (choosen (cent, 1), left.RealTime_Vehicle_children, transform(right));
vehV2_geo := IF(~AppendRTVeh,vehi2,vehi2+doxie.vehicleV2_transform_records_crs(rt_cent));
vehV2_nogeo := project(vehV2_geo, VehicleV2_Services.Functions.RemoveLatLong(left));
vehV2 := if (includeGeoLocation, vehV2_geo, vehV2_nogeo);
sexo := if (Include_SexualOffenses_val, dedup(doxie.sexoffender_search_records (),seisint_primary_key));
dlsr := if(DlVersion in [0,1],doxie.dl_search_records);
dlsr2 := if(DlVersion in [0,2] and Include_DriversLicenses_val,DriversV2_Services.DLEmbed_records(dids));
docr := IF (CriminalRecordVersion in [0,1] and Include_CriminalRecords_val, doxie.doc_search_records);
imar := IF (IncludeImages_val,images.image_fullrecords);
transaction_hist := if(IncludeTransactionHistory,doxie.TransactionHistory_Records(dids)[1]);

// mods for comp report phase 2
// new waterfall phone additions:
BOOLEAN   IncludeProgressivePhone  := FALSE : STORED('IncludeProgressivePhone');
ProgPhone_mod     := doxie.iParam.getProgressivePhoneParams();
progressivePhones := if (IncludeProgressivePhone, doxie.fn_progressivePhone.CompReportAddProgPhones(dids, progPhone_mod,application_type_value));												
// comment                                                                                                                                                                                                                         ^^^^^^^^^^^^^^^^^^^
// comment                                                                                                                                                                                         from doxie.MAC_Header_Field_Declare above                         

tempmod := module(project(AutoStandardI.GlobalModule(),CriminalRecords_Services.IParam.report,opt))
    export string14 did := (string) dids[1].did;
    export string25 doc_number   := '' ;
    export string60 offender_key := '' ;
    export boolean  IncludeAllCriminalRecords := true;
    export boolean  IncludeSexualOffenses := false;           
end;
crmr := CriminalRecords_Services.ReportService_Records.val(tempmod);
docr2 := IF (CriminalRecordVersion = 2 and Include_CriminalRecords_val,crmr[1].CriminalRecords);


//**** Full record def
outrec := doxie_crs.layout_report;

outrec patch(cent l) := transform
	self.vehicle_children := IF(not ut.IndustryClass.is_knowx,global(vehi));
	self.vehicle2_children := IF(not ut.IndustryClass.is_knowx,global(vehV2));
	self.RealTime_Vehicle_children := IF(IncludeRTVeh_val,l.RealTime_Vehicle_children);
	self.sex_offenses_children := global(sexo);		
	self.drivers_licenses_children := IF(not ut.IndustryClass.is_knowx,global(dlsr));
	self.drivers_licenses2_children := IF(not ut.IndustryClass.is_knowx,global(dlsr2));
	self.DOC_children := global(docr);
	self.images_children:= global(imar);
	self.DOC2_children := global(docr2);
	self.TransactionHistory := global(transaction_hist);
	self.progressive_Phones := global(progressivePhones);	
	self := l;
end;

//Added Entitlement Filter
all_records_reg := project(cent, patch(left));
all_records_entrp := PROJECT(all_records_reg,doxie_raw.Entrp_Central_records(LEFT));
all_records := IF(ut.IndustryClass.is_entrp,all_records_entrp,all_records_reg);

src_recs := if (~Exclude_Sources_val, doxie.source_counts (dids));
layout_flag := record
	string	field_present;
end;

//***** SOURCE WORK *****

// if u include a new entry into doxie.Source_counts 
//update the count below this transform in normalize
layout_flag into_flags(src_recs L, integer C) := transform
	self.field_present := choose(C,
						if (L.atf_cnt != 0,'ATF', skip),
						if (L.bk_cnt != 0, 'BK', skip),
						if (L.bkv2_cnt != 0, 'BK_V2', skip),
						if (L.lien_cnt != 0, 'LIEN', skip),
						if (L.lienv2_cnt != 0, 'LIEN_V2', skip),
						if (L.dl_cnt != 0, 'DL', skip),
						if (L.dl2_cnt != 0, 'DL_V2', skip),
						if (L.death_cnt != 0, 'DEATH', skip),
						if (L.proflic_cnt != 0, 'PROFLIC', skip),
						if (L.sanc_cnt != 0, 'SANC', skip), //10
						if (L.prov_cnt != 0, 'PROV',skip),
						if (L.email_cnt !=0, 'EMAIL',skip),
						if (L.veh_cnt != 0, 'VEH', skip),
						if (L.vehv2_cnt != 0, 'VEH_V2', skip),
						if (L.eq_cnt != 0, 'EQ', skip),
						if (L.en_cnt != 0, 'EN', skip),
						if (l.dea_cnt != 0, 'DEA', skip),
						if (l.deav2_cnt != 0, 'DEA_V2', skip),
						if (L.airc_cnt != 0, 'AIRC', skip),
						if (L.pilot_cnt != 0, 'PILOT', skip), //20
						if (L.pilotcert_cnt != 0, 'PILOTCERT', skip),
						if (L.watercraft_cnt != 0, 'WATERCRAFT', skip),
						if (L.ucc_Cnt != 0, 'UCC', skip),
						if (L.uccv2_cnt != 0, 'UCC_V2', skip),
						if (L.corpAffil_cnt != 0, 'CORPAFFIL', skip),
						if (L.ccw_cnt != 0, 'CCW', skip),
						if (L.voter_cnt != 0, 'VOTER', skip),
						if (L.voterv2_cnt != 0, 'VOTER_V2', skip),
						if (L.hunt_cnt != 0, 'HUNT', skip),
						if (L.whois_cnt != 0, 'WHOIS', skip), //30
						if (L.phone_cnt != 0, 'PHONE', skip),
						if (L.assessment_cnt != 0 or l.deed_cnt!= 0, 'PROPERTY', skip),
						if (L.assessment_cnt != 0, 'ASSESSMENT', skip),
						if (L.deed_cnt != 0, 'DEED', skip),
						if (L.assessment2_cnt != 0 or l.deed2_cnt!= 0, 'PROPERTY_V2', skip),
						if (L.assessment2_cnt != 0, 'ASSESSMENT_V2', skip),
						if (L.deed2_cnt != 0, 'DEED_V2', skip),
						if (L.flcrash_Cnt != 0, 'FLCRASH', skip),
						if (L.DOC_cnt	!= 0, 'DOC', skip),
						if (L.SO_cnt	!= 0, 'SEXOFFENDER', skip), //40
						if (L.finder_cnt != 0, 'FINDER', skip),
						if (L.ak_cnt != 0, 'AK', skip),
						if (L.nod_cnt != 0, 'NOD', skip),
						if (L.for_cnt != 0, 'FOR', skip),
						if (L.util_cnt != 0, 'UTIL', skip),
						if (L.mswork_cnt != 0, 'MSWORK', skip),
						if (L.statedeath_cnt != 0, 'STATEDEATH', skip),
						if (L.boater_cnt != 0, 'BOATER', skip),
						if (L.tu_cnt != 0, 'TU', skip),
						if (L.tn_cnt != 0, 'TN', skip),
						if (L.quickheader_cnt != 0, 'QH', skip), //50
						if (L.targ_cnt != 0, 'TARG', skip),
						if (L.phonesPlus_cnt != 0, 'PP', skip),
						if (L.FBNv2_cnt != 0, 'FBNV2', skip),
						skip);
end;

recflags1 := normalize(src_recs,54,into_flags(LEFT,COUNTER));

header_recs := Doxie_Raw.Header_Raw(dids, dateVal, dppa_purpose, glb_purpose);

layout_flag into_flags2(header_recs L, integer C) := transform
	self.field_present := choose(C,
						if (L.ssn != '', 'SSN', skip),
						if (L.dob != 0, 'DOB', skip),
						'ADDRESSES',
						skip);
end;

recflags2 := normalize(header_recs, 3, into_flags2(LEFT,COUNTER));

recflags := if (not Exclude_Sources_val, dedup(recflags1 + recflags2,all));

//***** ROYALTY WORK *****

doxie_crs.layout_property_ln property_child(doxie_crs.layout_property_ln l):= transform
self := l;
END;

property_table := normalize(all_records, left.property_children,property_child(right));

doxie_crs.layout_foreclosure_report foreclosure_child(doxie_crs.layout_foreclosure_report l):=transform
self := l;
END;

foreclosure_table :=normalize(all_records, left.foreclosure_children,foreclosure_child(right));

iesp.frauddefensenetwork.t_FDNSearchRecord fdn_child(iesp.frauddefensenetwork.t_FDNSearchRecord l):=transform
self := l;
END;
fdn_table :=normalize(all_records, left.fdn_children,fdn_child(right));

iesp.frauddefensenetwork.t_FDNRecord FDNrecords_child(iesp.frauddefensenetwork.t_FDNRecord l):=transform
self := l;
END;
FDNrecords_table :=normalize(fdn_table, left.MatchDetails.records, FDNrecords_child(right));

Royalty.RoyaltyFares.MAC_SetA(property_table, foreclosure_table, royalties_fares);
Royalty.MAC_RoyaltyEmail(all_records.email_children, royalties_email,, false);
Royalty.RoyaltyVehicles.MAC_ReportSet(all_records.RealTime_Vehicle_children, royalties_rtv, datasource, vehicleinfo.vin);
Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(all_records.premium_phone_children,equifax_royalties,vendor,MDR.sourceTools.src_EQUIFAX);
FDN_Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(FDNrecords_table);	
//----------------------------------------
trackFares := not ut.IndustryClass.is_knowx and (Include_Properties_val or Include_PriorProperties or Include_foreclosures_val);
royalties := if(trackFares,royalties_fares) +
					 	 if(Include_Email_Addresses_val,royalties_email) +
						 if(IncludeRTVeh_val, royalties_rtv) +
						 if(Include_PremiumPhones_val, equifax_royalties) +
	           if(IncludeFDNSubjectOnly or IncludeFDNAllAssociations, FDN_Royalties);
						 						 
//***** ALERT WORK *****

alerters := doxie_crs.alert_hashes(all_records);
changedSections := alerters.changed_sections;
outputHashes := alerters.output_hashes;
hashmap := alerters.hashmap;
sendResults := alerters.sendResults;
sendHashes := alerters.sendHashes;
versionChange := alerters.versionChange;

use_records := IF(sendHashes, changedSections, all_records);

DO_ALL := 
	parallel(
  IF(sendResults,
		parallel(
			output(use_records,named('CRS_result')),
			output(src_recs,named('Source_Counts')),
			output(recflags,named('Source_Flags')),
			output(royalties,named('RoyaltySet')))),
	IF(sendHashes or versionChange, 
		parallel(
			output(outputHashes,named('Hashes')),
			output(hashmap, named('Hashmap')))));	
	if( count(dids)>1,FAIL('ambiguous criteria'),DO_ALL )
	
ENDMACRO;
// Comprehensive_Report_Service ();

