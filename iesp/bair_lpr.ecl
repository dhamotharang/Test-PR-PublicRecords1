/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_lpr.xml. ***/
/*===================================================*/

import iesp;

export bair_lpr := MODULE
			
export t_BAIRLprBaseRecord := record
	string XCoordinate {xpath('XCoordinate')};
	string YCoordinate {xpath('YCoordinate')};
	string LicensePlateRecordGUID {xpath('LicensePlateRecordGUID')};
	string EventNumber {xpath('EventNumber')};
	string PlateNumber {xpath('PlateNumber')};
	string CaptureDateTime {xpath('CaptureDateTime')};
	boolean ImageAvailable {xpath('ImageAvailable')};
end;
		
export t_BAIRLprSearchBy := record (iesp.bair_share.t_BAIRBaseModeSearchBy)
end;
		
export t_BAIRLprSearchOption := record (iesp.bair_share.t_BAIRBaseSearchOption)
	boolean IncludeNotes {xpath('IncludeNotes')};
end;
		
export t_BAIRLprSearchRecord := record
	string EntityID {xpath('EntityID')};
	string UCRGroup {xpath('UCRGroup')};
	string Class {xpath('Class')};
	string LicensePlateRecordGUID {xpath('LicensePlateRecordGUID')};
	string EventNumber {xpath('EventNumber')};
	string PlateNumber {xpath('PlateNumber')};
	string CaptureDateTime {xpath('CaptureDateTime')};
	string PlateImage {xpath('PlateImage')};
	string OverviewImage {xpath('OverviewImage')};
	string XCoordinate {xpath('XCoordinate')};
	string YCoordinate {xpath('YCoordinate')};
	string Distance {xpath('Distance')};
	string Agency {xpath('Agency')};
	integer Accuracy {xpath('Accuracy')};
	string ORI {xpath('ORI')};
	boolean ImageAvailable {xpath('ImageAvailable')};
end;
		
export t_BAIRLprSearchResponse := record (iesp.bair_share.t_BAIRBaseSearchResponse)
	dataset(t_BAIRLprSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.bair_constants.MAX_SEARCH_RESULTS)};
end;
		
export t_BAIRLprSearchRequest := record
	iesp.bair_share.t_BAIRUser User {xpath('User')};
	t_BAIRLprSearchOption Options {xpath('Options')};
	t_BAIRLprSearchBy SearchBy {xpath('SearchBy')};
	iesp.bair_share.t_BAIRContext BAIRContext {xpath('BAIRContext')};//hidden[ecl_only]
end;
		
export t_BAIRLprSearchResponseEx := record
	t_BAIRLprSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_lpr.xml. ***/
/*===================================================*/

