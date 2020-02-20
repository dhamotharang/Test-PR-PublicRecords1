/*--SOAP--
<message name="LocationReportService">
  <part name="addr_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>	   
	<part name="NeighborsPerAddress" type="xsd:unsignedInt"/>
	<part name="NeighborsPerNA" type="xsd:unsignedInt"/>
	<part name="NeighborRecency" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="UccVersion" type="xsd:byte"/>
	<part name="JudgmentLienVersion" type="xsd:byte"/>
	<part name="BankruptcyVersion" type="xsd:byte"/>
	<part name="VehicleVersion" type="xsd:byte"/>
	<part name="VoterVersion" type="xsd:byte"/>
	<part name="DlVersion" type="xsd:byte"/>
	<part name="DeaVersion" type="xsd:byte"/>
  <part name="loc_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
	<part name="TrackPropertyChanges" type="xsd:boolean"/>
	<part name="TrackAssociateChanges" type="xsd:boolean"/>
	<part name="UseBusinessIds" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the Header for address variations, then uses joins against the property data.*/


import Doxie_Raw,address,Royalty, Doxie, AutoStandardI;
export LocationReportService := MACRO
#option('spotThroughAggregate', 0);
#constant('isLocationReportService',true); //hacky workaround for bug 25247

inputOrig := dataset([], Doxie_Raw.Layout_address_input) : stored('addr_in',few);
useBusinessIds := FALSE : stored('UseBusinessIds');

//Do address cleaning to standardize the address information.


Doxie_Raw.Layout_address_input caseFormat(Doxie_Raw.Layout_address_input L):= transform
		addr1 := if (l.streetAddr1 <> '', l.streetAddr1 + ' ' + l.streetAddr2 , L.prim_range+' '+L.predir+' '+L.prim_name+' '+L.suffix+' '+L.postdir+' '+L.sec_range);
		clean_add := Address.GetCleanAddress(addr1,L.city_name+' '+L.st+' '+L.zip, address.Components.Country.US);
    SELF.prim_range := StringLib.StringToUpperCase(clean_add.results.prim_range);
    SELF.predir := StringLib.StringToUpperCase(clean_add.results.predir);
    SELF.prim_name := StringLib.StringToUpperCase(clean_add.results.prim_name);
    SELF.suffix := StringLib.StringToUpperCase(clean_add.results.suffix);
    SELF.postdir := StringLib.StringToUpperCase(clean_add.results.postdir);
    SELF.sec_range := StringLib.StringToUpperCase(clean_add.results.sec_range);
    SELF.city_name := StringLib.StringToUpperCase(clean_add.results.p_city);
    SELF.st := StringLib.StringToUpperCase(clean_add.results.state);
    SELF.zip := StringLib.StringToUpperCase(clean_add.results.zip);
    self := L;
end;
inputUp := project(inputOrig, caseFormat(left));
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
locReport := Location_Services.location_report(inputUp, mod_access, , useBusinessIds);


doxie_raw.Layout_input intoInput(Doxie_Raw.Layout_address_input L) := transform
 self.idtype := '';
 self.id := '';
 self.section := '';  // get all sections
 self := L;
end;

inputAllSrcs := PROJECT(inputUp, intoInput(LEFT));

locSources := Location_Services.location_sources(inputAllSrcs, mod_access, useBusinessIds);

Royalty.RoyaltyFares.MAC_SetC(locReport(do_royal=1), locReport(do_royal=0), royalties);

locSrcCounts := Location_Services.source_counts(locSources);

layout_flag := record
	string20	field_present;
end;

layout_flag into_flags(locSrcCounts L, integer C) := transform
	self.field_present := choose(C,
						if (L.atf_cnt != 0,'ATF', skip),
						if (L.bk_cnt != 0, 'BK', skip),
						if (L.bkv2_cnt != 0, 'BK_V2', skip),
						if (L.lien_cnt != 0, 'LIEN', skip),
						if (L.lienv2_cnt != 0, 'LIEN_V2', skip),
						if (L.dl_cnt != 0, 'DL', skip),
						if (L.dl2_cnt != 0, 'DL2', skip),
						if (L.death_cnt != 0, 'DEATH', skip),
						if (L.proflic_cnt != 0, 'PROFLIC', skip),
						if (L.sanc_cnt != 0, 'SANC', skip),
						if (L.prov_cnt != 0, 'PROV', skip),
						if (L.veh_cnt != 0, 'VEH', skip),
						if (L.vehv2_cnt != 0, 'VEH_V2', skip),
						if (L.eq_cnt != 0, 'EQ', skip),
						if (L.en_cnt != 0, 'EN', skip),
						if (l.dea_cnt != 0, 'DEA', skip),
						if (L.airc_cnt != 0, 'AIRC', skip),
						if (L.pilot_cnt != 0, 'PILOT', skip),
						if (L.pilotcert_cnt != 0, 'PILOTCERT', skip),
						if (L.watercraft_cnt != 0, 'WATERCRAFT', skip),
						if (L.ucc_Cnt != 0, 'UCC', skip),
						if (L.uccv2_Cnt != 0, 'UCC_V2', skip),
						if (L.corpAffil_cnt != 0, 'CORPAFFIL', skip),
						if (L.ccw_cnt != 0, 'CCW', skip),
						if (L.voter_cnt != 0, 'VOTER', skip),
						if (L.voterv2_cnt != 0, 'VOTER_V2', skip),
						if (L.hunt_cnt != 0, 'HUNT', skip),
						if (L.whois_cnt != 0, 'WHOIS', skip),
						if (L.phone_cnt != 0, 'PHONE', skip),
						if (L.assessment_cnt != 0, 'ASSESSMENT', skip),
						if (L.assessmentv2_cnt != 0, 'ASSESSMENT_V2', skip),
						if (L.deed_cnt != 0, 'DEED', skip),
						if (L.deedv2_cnt != 0, 'DEED_V2', skip),
						if (L.flcrash_Cnt != 0, 'FLCRASH', skip),
						if (L.DOC_cnt	!= 0, 'DOC', skip),
						if (L.SO_cnt	!= 0, 'SEXOFFENDER', skip),
						if (L.finder_cnt != 0, 'FINDER', skip),
						if (L.ak_cnt != 0, 'AK', skip),
						if (L.emerge_cnt != 0, 'EMERGE', skip),
						if (L.for_cnt != 0, 'FOR', skip),
						if (L.util_cnt != 0, 'UTIL', skip),
						if (L.mswork_cnt != 0, 'MSWORK', skip),
						if (L.boater_cnt != 0, 'BOATER', skip),
						if (L.tu_cnt != 0, 'TU', skip),
						if (L.tn_cnt != 0, 'TN', skip),
						if (L.busheader_cnt != 0, 'BUSHEADER', skip),
						if (l.busheaderlinkIds_cnt != 0, 'BUSHEADER_LINK_IDS', skip),
						if (L.targ_cnt != 0, 'TARG', skip),
						skip);
end;

locSrcSections := normalize(locSrcCounts,47,into_flags(LEFT,COUNTER));

alerters := Location_Services.alert_hashes(locReport);
changedSections := alerters.changed_sections;
outputHashes := alerters.output_hashes;
hashmap := alerters.hashmap;
sendResults := alerters.sendResults;
sendHashes := alerters.sendHashes;

use_records := IF(sendHashes, changedSections, locReport);

recs_available := dataset([ if(exists(locSrcSections), 1, 0) ], {integer1 recs {xpath('RecordsAvailable')}});

parallel(
	IF(sendResults,
		sequential(
			parallel(
				output(use_records,named('Location_Report'));
				output(locSrcCounts,named('Source_Counts'));
				output(locSrcSections,named('Source_Flags'));
				output(royalties,named('RoyaltySet'))),
			output(recs_available,named('RecordsAvailable')))),	
	IF(sendHashes, 
		parallel(
			output(outputHashes,named('Hashes')),
			output(hashmap, named('Hashmap')))));	

ENDMACRO;