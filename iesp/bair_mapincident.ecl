/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_mapincident.xml. ***/
/*===================================================*/

import iesp;

export bair_mapincident := MODULE
			
export t_BAIRMapIncidentSearchOption := record (iesp.bair_share.t_BAIRBaseSearchOption)
	boolean IncludeMetadata {xpath('IncludeMetadata')};
	boolean IncludeClusterMetadata {xpath('IncludeClusterMetadata')};
	integer ClusterDepth {xpath('ClusterDepth')};
	boolean ClusterByClass {xpath('ClusterByClass')};
	boolean ClusterByMode {xpath('ClusterByMode')};
	boolean IncludeIncidentDetails {xpath('IncludeIncidentDetails')};
	boolean EIDDownload {xpath('EIDDownload')};
	boolean Raids {xpath('Raids')};
	boolean ApplyOffenderDates {xpath('ApplyOffenderDates')};
end;
		
export t_BAIRMetadataAllTime := record
	string GoogleGeocode {xpath('GoogleGeocode')};
	string AgencyGeocode {xpath('AgencyGeocode')};
	string Uploaded {xpath('Uploaded')};
	string Approved {xpath('Approved')};
	string Flagged {xpath('Flagged')};
	iesp.share.t_TimeStamp StartDate {xpath('StartDate')};
	iesp.share.t_TimeStamp EndDate {xpath('EndDate')};
end;
		
export t_BAIRMetadataInView := record
	string AccuracyAddress {xpath('AccuracyAddress')};
	iesp.share.t_Address AccuracyAddressClean {xpath('AccuracyAddressClean')};
	string AccuracyIntersection {xpath('AccuracyIntersection')};
	string AccuracyStreet {xpath('AccuracyStreet')};
	string RecordsInView {xpath('RecordsInView')};
	iesp.share.t_TimeStamp StartDate {xpath('StartDate')};
	iesp.share.t_TimeStamp EndDate {xpath('EndDate')};
end;
		
export t_BAIRMetadata := record
	string Notes {xpath('Notes')};
	string Agency {xpath('Agency')};
	string LastUpload {xpath('LastUpload')};
	t_BAIRMetadataAllTime AllTimeData {xpath('AllTimeData')};
	t_BAIRMetadataInView InViewData {xpath('InViewData')};
end;
		
export t_BAIRClusterMetaData := record
	string Cluster {xpath('Cluster')};
	string Mode {xpath('Mode')};
	string Level {xpath('Level')};
	string ClassCode {xpath('ClassCode')};
	string Class {xpath('Class')};
	string Latitude {xpath('Latitude')};
	string Longitude {xpath('Longitude')};
	string MinLatitude {xpath('MinLatitude')};
	string MaxLatitude {xpath('MaxLatitude')};
	string MinLongitude {xpath('MinLongitude')};
	string MaxLongitude {xpath('MaxLongitude')};
	string Total {xpath('Total')};
end;
		
export t_BAIRMapEventRecord := record
	dataset(iesp.bair_event.t_BAIRMOBaseRecord) MOs {xpath('MOs/MO'), MAXCOUNT(iesp.bair_constants.MAX_EVE_MOS)};
end;
		
export t_BAIRMapCFSRecord := record (iesp.bair_cfs.t_BAIRCfsBaseCallRecord)
end;
		
export t_BAIRMapCrashRecord := record (iesp.bair_crash.t_BAIRCrashBaseIncidentRecord)
end;
		
export t_BAIRMapOffenderRecord := record (iesp.bair_offender.t_BAIROffenderBaseRecord)
end;
		
export t_BAIRMapLPRRecord := record (iesp.bair_lpr.t_BAIRLprBaseRecord)
end;
		
export t_BAIRMapShotSpotterRecord := record (iesp.bair_shotspotter.t_BAIRShotSpotterBaseRecord)
end;
		
export t_BAIRMapIncidentSearchRecord := record
	string Distance {xpath('Distance')};
	string EntityID {xpath('EntityID')};
	string ReferenceID {xpath('ReferenceID')};
	string UCRGroup {xpath('UCRGroup')};
	string Class {xpath('Class')};
	string Address {xpath('Address')};
	iesp.share.t_Address AddressClean {xpath('AddressClean')};
	string11 Latitude {xpath('Latitude')};
	string10 Longitude {xpath('Longitude')};
	string12 GeoHash {xpath('GeoHash')};
	string DateTime {xpath('DateTime')};
	string AgencyID {xpath('AgencyID')};
	string Agency {xpath('Agency')};
	t_BAIRMapEventRecord EventRecord {xpath('EventRecord')};
	t_BAIRMapCFSRecord CFSRecord {xpath('CFSRecord')};
	t_BAIRMapCrashRecord CrashRecord {xpath('CrashRecord')};
	t_BAIRMapOffenderRecord OffenderRecord {xpath('OffenderRecord')};
	t_BAIRMapLPRRecord LPRRecord {xpath('LPRRecord')};
	t_BAIRMapShotSpotterRecord ShotSpotterRecord {xpath('ShotSpotterRecord')};
end;
		
export t_BAIRMapIncidentSearchResponse := record (iesp.bair_share.t_BAIRBaseSearchResponse)
	dataset(t_BAIRMapIncidentSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.bair_constants.MAX_MAP_RESULTS)};
	dataset(t_BAIRMetadata) Metadata {xpath('Metadata/Record'), MAXCOUNT(iesp.bair_constants.MAX_METADATA_RESULTS)};
	dataset(t_BAIRClusterMetaData) ClusterMetaData {xpath('ClusterMetaData/Record'), MAXCOUNT(iesp.bair_constants.MAX_CLUSTER_METADATA_RESULTS)};
end;
		
export t_BAIRMapIncidentSearchBy := record (iesp.bair_share.t_BAIRMultiModeSearchBy)
	unsigned LayerID {xpath('LayerID')}; // Xsd type: string
end;
		
export t_BAIRMapIncidentSearchRequest := record
	iesp.bair_share.t_BAIRUser User {xpath('User')};
	t_BAIRMapIncidentSearchOption Options {xpath('Options')};
	t_BAIRMapIncidentSearchBy SearchBy {xpath('SearchBy')};
	iesp.bair_share.t_BAIRContext BAIRContext {xpath('BAIRContext')};//hidden[ecl_only]
end;
		
export t_BAIRMapIncidentSearchResponseEx := record
	t_BAIRMapIncidentSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_mapincident.xml. ***/
/*===================================================*/

