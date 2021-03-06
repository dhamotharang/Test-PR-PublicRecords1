/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_agencylayer.xml. ***/
/*===================================================*/

import iesp;

export bair_agencylayer := MODULE
			
export t_BAIRAgencyLayerSearchRecord := record
	unsigned LayerID {xpath('LayerID')};
	unsigned GeoType {xpath('GeoType')};
end;
		
export t_BAIRAgencyLayerSearchBy := record
	dataset(t_BAIRAgencyLayerSearchRecord) LayerEntityIDs {xpath('LayerEntityIDs/LayerEntityID'), MAXCOUNT(iesp.bair_constants.MAX_LAYERENTITYIDS)};
end;
		
export t_BAIRAgencyLayerOption := record (iesp.bair_share.t_BAIRBaseOption)
end;
		
export t_BAIRAgencyLayerRecord := record
	unsigned LayerID {xpath('LayerID')};
	unsigned Segment {xpath('Segment')};
	varstring GeoText {xpath('GeoText'), maxlength(iesp.bair_constants.MAX_GEOLENGTH)}; // Xsd type: base64binary
end;
		
export t_BAIRAgencyLayerSearchResponse := record (iesp.bair_share.t_BAIRBaseSearchResponse)
	dataset(t_BAIRAgencyLayerRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.bair_constants.MAX_SEARCH_RESULTS)};
end;
		
export t_BAIRAgencyLayerInfo := record
	integer LayerID {xpath('LayerID')};
	string LayerName {xpath('LayerName')};
end;
		
export t_BAIRAgencyLayerGroup := record
	integer LayerGroupID {xpath('LayerGroupID')};
	string LayerGroupName {xpath('LayerGroupName')};
	dataset(t_BAIRAgencyLayerInfo) Layers {xpath('Layers/LayerInfo'), MAXCOUNT(iesp.bair_constants.MAX_LAYERSPERGROUP)};
end;
		
export t_BAIRAgencyLayerGroupRecord := record
	integer AgencyID {xpath('AgencyID')};
	string AgencyName {xpath('AgencyName')};
	dataset(t_BAIRAgencyLayerGroup) LayerGroups {xpath('LayerGroups/LayerGroup'), MAXCOUNT(iesp.bair_constants.MAX_AGENCYLAYERGROUPRESULTS)};
end;
		
export t_BAIRAgencyLayerGroupSearchBy := record (iesp.bair_share.t_BAIRMultiModeSearchBy)
end;
		
export t_BAIRAgencyLayerGroupOption := record (iesp.bair_share.t_BAIRBaseOption)
end;
		
export t_BAIRAgencyLayerGroupSearchResponse := record (iesp.bair_share.t_BAIRBaseSearchResponse)
	dataset(t_BAIRAgencyLayerGroupRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.bair_constants.MAX_SEARCH_RESULTS)};
end;
		
export t_BAIRAgencyLayerSearchRequest := record
	iesp.bair_share.t_BAIRUser User {xpath('User')};
	t_BAIRAgencyLayerOption Options {xpath('Options')};
	t_BAIRAgencyLayerSearchBy SearchBy {xpath('SearchBy')};
	iesp.bair_share.t_BAIRContext BAIRContext {xpath('BAIRContext')};//hidden[ecl_only]
end;
		
export t_BAIRAgencyLayerGroupSearchRequest := record
	iesp.bair_share.t_BAIRUser User {xpath('User')};
	t_BAIRAgencyLayerGroupOption Options {xpath('Options')};
	t_BAIRAgencyLayerGroupSearchBy SearchBy {xpath('SearchBy')};
	iesp.bair_share.t_BAIRContext BAIRContext {xpath('BAIRContext')};//hidden[ecl_only]
end;
		
export t_BAIRAgencyLayerSearchResponseEx := record
	t_BAIRAgencyLayerSearchResponse response {xpath('response')};
end;
		
export t_BAIRAgencyLayerGroupSearchResponseEx := record
	t_BAIRAgencyLayerGroupSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_agencylayer.xml. ***/
/*===================================================*/

