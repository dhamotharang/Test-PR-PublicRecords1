//============================================================================
// Attribute: Phone_raw.  Based on Gong_Services.GongHistorySearchService.
// Function to get Gong records by did or hhid.
// Return: dataset.  
// This could be replaced by Gong_Services.GongHistorySearchService when it adds did part.
//============================================================================
import doxie, Gong_Services;

export Phone_Raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    boolean ln_branded_value = false
) := FUNCTION


all_phones := Gong_Services.Fetch_Gong_History(dids,,,true,true);

return project(all_phones,gong_services.Layout_GongHistorySearchService);

end;