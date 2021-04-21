﻿// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    This service searches all available datafiles.
*/

import  AutoheaderV2, Gateway, doxie, CriminalRecords_Services, doxie_crs, doxie_raw,
        DriversV2_Services, images, Royalty, ut, Phones;

export Comprehensive_Report_Service := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#CONSTANT('TwoPartySearch', FALSE);


#option ('maxCompileThreads', 4);
#stored('IncludeAllDIDRecords','1');
#stored('ReportReq',true);
#stored('useOnlyBestDID',true);
#stored('DataRestrictionMask','00000000000000000000');  //intentionally has diff default behavior than doxie_ln version
#CONSTANT('GONG_SEARCHTYPE','PERSON');
#CONSTANT('IsCRS', true);
#CONSTANT('UseAddressHierarchy', true);
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
mod_access := doxie.compliance.GetGlobalDataAccessModule ();
doxie.MAC_Selection_Declare();
boolean is_consumer := mod_access.isConsumer();

// get realtime phones
useRTP := Include_RealTimePhones and
          doxie.Compliance.use_qsent(mod_access.DataPermissionMask) and
          not doxie.Compliance.isQSentRestricted(mod_access.DataRestrictionMask);

// use non-remote header data; non-fcra;
dids := doxie.get_dids();
ds_header := doxie.central_header (dids, mod_access, false, false, in_getSSNBest);
cent := doxie.central_records (ds_header, mod_access, false, 'D', skipPhonesPlus := useRTP);

//pick up the distributed records

boolean includeGeoLocation := false : stored('IncludeGeoLocation');
vehi := if(VehicleVersion in [0,1],doxie.vehicle_search_records_crs);
vehi2 := if(VehicleVersion in [0,2] and Include_MotorVehicles_val,doxie.vehicleV2_search_records_crs(dids, Use_CurrentlyOwnedVehicles_value));
rt_cent := normalize (choosen (cent, 1), left.RealTime_Vehicle_children, transform(right));
vehV2_geo := IF(~AppendRTVeh,vehi2,vehi2+doxie.vehicleV2_transform_records_crs(rt_cent));
vehV2_nogeno := project(vehV2_geo, VehicleV2_Services.Functions.RemoveLatLong(left));
vehV2 := if (includeGeoLocation, vehV2_geo, vehV2_nogeno);
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
global_mod := AutoStandardI.GlobalModule();
crim_mod := module(project(global_mod,CriminalRecords_Services.IParam.report,opt))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    export string14 did := (string) dids[1].did;
    export string25 doc_number   := '' ;
    export string60 offender_key := '' ;
    export boolean  IncludeAllCriminalRecords := true;
    export boolean  IncludeSexualOffenses := false;
end;
crmr := CriminalRecords_Services.ReportService_Records.val(crim_mod);
docr2 := IF (CriminalRecordVersion = 2 and Include_CriminalRecords_val,crmr[1].CriminalRecords);

in_mod := MODULE(doxie.realTimePhonesParams.searchParams)
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    EXPORT STRING11   SSN := ds_header[1].best_information_children[1].ssn;
    EXPORT STRING30   LastName := ds_header[1].best_information_children[1].lname;
		EXPORT DATASET(Gateway.Layouts.Config) Gateways := gateways_in;
  END;

rtprecs_remote := IF(useRTP, Doxie.get_realtime_phones_remote(in_mod, useRTP));
rtprecs_results := rtprecs_remote.Results((UNSIGNED6)did=dids[1].did);

inhouseRTP(STRING tflag) := tflag NOT IN [Phones.Constants.TypeFlag.DataSource_PV,Phones.Constants.TypeFlag.DataSource_iQ411];

rtprecs := PROJECT(
             //  gw records to the top, only inhouse records have dt last seen.
             SORT(rtprecs_results, IF(inhouseRTP(typeflag), 1, 0), -dt_last_seen, RECORD),
               TRANSFORM(Doxie.layout_realTimePhones.rtp_out_layout_final, SELF := LEFT));

rtprecs_royalties := rtprecs_remote.RoyaltySet;

//**** Full record def
outrec := doxie_crs.layout_report;

outrec patch(cent l) := transform
  self.vehicle_children := IF(not is_consumer,global(vehi));
  self.vehicle2_children := IF(not is_consumer,global(vehV2));
  self.RealTime_Vehicle_children := IF(IncludeRTVeh_val,l.RealTime_Vehicle_children);
  self.sex_offenses_children := global(sexo);
  self.drivers_licenses_children := IF(not is_consumer,global(dlsr));
  self.drivers_licenses2_children := IF(not is_consumer,global(dlsr2));
  self.DOC_children := global(docr);
  self.images_children:= global(imar);
  self.DOC2_children := global(docr2);
  self.TransactionHistory := global(transaction_hist);
  self.progressive_Phones := global(progressivePhones);
  self.realtime_phones_children := IF(useRTP, global(rtpRecs));
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
// update the count below this transform in normalize
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
            if (L.emailv2_cnt !=0, 'EMAIL_V2',skip),
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

recflags1 := normalize(src_recs,55,into_flags(LEFT,COUNTER));

header_recs := Doxie_Raw.Header_Raw(dids, mod_access);

layout_flag into_flags2(header_recs L, integer C) := transform
  self.field_present := choose(C,
            if (L.ssn != '', 'SSN', skip),
            if (L.dob != 0, 'DOB', skip),
            'ADDRESSES',
            skip);
end;

recflags2 := normalize(header_recs, 3, into_flags2(LEFT,COUNTER));

recflags := if (not Exclude_Sources_val, dedup(recflags1 + recflags2,all));

// ***** ROYALTY WORK *****

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
// ----------------------------------------
trackFares := not is_consumer and (Include_Properties_val or Include_PriorProperties or Include_foreclosures_val);
royalties := if(trackFares,royalties_fares) +
             if(Include_Email_Addresses_val,if(EmailVersion=2, cent.EmailV2Royalties, royalties_email)) +
             if(IncludeRTVeh_val, royalties_rtv) +
             if(Include_PremiumPhones_val, equifax_royalties) +
             if(useRTP, rtpRecs_royalties) +
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
      output(royalties,named('RoyaltySet'))));
  IF(sendHashes or versionChange,
    parallel(
      output(outputHashes,named('Hashes')),
      output(hashmap, named('Hashmap')))));
  if( count(dids)>1,FAIL('ambiguous criteria'),DO_ALL )

ENDMACRO;
// Comprehensive_Report_Service ();
