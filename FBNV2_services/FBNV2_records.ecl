 import doxie, business_header;
 
unsigned2 pt := 10 : stored('PenaltThreshold');

business_header.doxie_MAC_Field_Declare()

boolean is_search := bdid_value = 0 and did_value = '' and tmsid_value = '' and rmsid_value='';

ids := FBNV2_services.FBNSearchService_ids(~noDeepDive,is_search);

rpen := FBNv2_services.FBN_raw.Search_view.by_rmsid(ids, is_search);

rsrt := sort(rpen(penalt <= pt), if(isDeepDive, 1, 0), penalt, -orig_filing_date, -filing_date, filing_jurisdiction, orig_filing_number, record);

// doxie.MAC_Marshall_Results(rsrt,rmar);

// export FBNV2_records := rmar;

EXPORT FBNV2_records := rsrt;