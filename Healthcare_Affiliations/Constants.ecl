IMPORT IESP;
EXPORT Constants := MODULE
	EXPORT UseProd := FALSE;
	EXPORT MaxSearchIDs := 2000;
	EXPORT MaxAddressesPerMatch := 1;
	EXPORT MaxRecordsPerMatch := 10000;
	EXPORT MaxResponseIDs := iesp.constants.HCAffiliationSearch.MaxResults;
	EXPORT ProviderIndicator := 'LNPID';
	EXPORT FacilityIndicator := 'LNFID';
	Export ValidProviderSearchInput := ['P','LNPID'];
	Export ValidFacilitySearchInput := ['F','LNFID'];
end;