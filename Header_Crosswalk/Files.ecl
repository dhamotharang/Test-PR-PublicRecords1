IMPORT Header_Crosswalk;

EXPORT Files := MODULE
  EXPORT Build_Summary := DATASET(Header_Crosswalk.Constants.str_build_summary_sf, Header_Crosswalk.Layouts.summary, THOR);
END;