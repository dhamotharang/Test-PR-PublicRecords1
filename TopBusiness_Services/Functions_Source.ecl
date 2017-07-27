IMPORT Census_data;

EXPORT Functions_Source := MODULE

  // A common routine to get the county name using the fips state & county codes.
  export get_county_name(string2 st_in, string3 county_in) := function
	  county_name := Census_data.Key_Fips2County(keyed(st_in = state_code AND
                                               county_in = county_fips))[1].county_name;
	  return county_name;

  end; // end of get_county_name function

  // A common routine to strip dash(es) out of date fields.
  export fix_date(string10 date_in) := function
	  
		string8 date_fixed := StringLib.StringFilterOut(date_in, '-/');
		
	  return date_fixed;

  end; // end of fix_date fucntion
	
	/* Module used to zero out the linkids based on the passed level. Can be used to allow grouping,
	  sorting, rollup flexibilty based on the report level */
	EXPORT setLinkidFetchLev(inRecs,inLayout,inLevel) := FUNCTIONMACRO
		outrecs := PROJECT(inRecs,TRANSFORM(inLayout,
									self.ultID := left.ultid,
									self.ProxID := if(inLevel in bipv2.IDconstants.Set_Fetch_Level_ProxID_And_Down, left.ProxID, 0),
									self.SELEID := if(inLevel in bipv2.IDconstants.Set_Fetch_Level_SELEID_And_Down, left.SELEID, 0),
									self.OrgID :=  if(inLevel in bipv2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  left.OrgID, 0),
									self.EmpID := 0,
									self.POWID := 0,		
									self := left));
		return(outrecs);
	ENDMACRO;
 
END; // end of Functions_Source module