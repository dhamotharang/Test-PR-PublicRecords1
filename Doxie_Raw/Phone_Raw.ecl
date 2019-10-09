//============================================================================
// Attribute: Phone_raw.  Based on Gong_Services.GongHistorySearchService.
// Function to get Gong records by did or hhid.
// Return: dataset.
// This could be replaced by Gong_Services.GongHistorySearchService when it adds did part.
//============================================================================
import doxie, Gong_Services;

export Phone_Raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION


all_phones := Gong_Services.Fetch_Gong_History(dids, mod_access,
  did_onlyL := true,
  SuppressNoncurrent := true);

return project(all_phones,gong_services.Layout_GongHistorySearchService);

end;