export Layout_Roxie_Matter
 := record
// added dates to the civil_court Layout_in_matter 
 string8 dt_first_reported;
 string8 dt_last_reported;
 civil_court.Layout_In_Matter;
 
 end
 ;