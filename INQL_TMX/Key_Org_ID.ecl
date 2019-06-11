import Data_Services;

d := dataset([], INQL_TMX.layouts.key);

// -----------------------------------------------------------------------------------------------------------
// Setup index for TMX building org_id index file...
// -----------------------------------------------------------------------------------------------------------
EXPORT Key_Org_ID(string v = 'qa') := 
    INDEX
    (
        d,
        {org_id, trans_date, trans_hhmm, trans_ss, api_type, event_type}, 
        {d},
        // KJE - ORIGINAL
        // Data_Services.Data_location.Prefix('TMX')+'thor_data::key::INQL::tmx::'+v+'::org_id'
        Data_Services.Data_location.Prefix('TMX')+'wwtm::key::INQL::tmx::'+v+'::org_id'
    );