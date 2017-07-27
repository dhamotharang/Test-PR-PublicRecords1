import canadianphones_v2,canadianphones; 

// Helper Macro
	MAC_GetRecords (ids,key,raw_recs)  :=macro
		#uniquename(get_out_recs);
		
		can_ph.layout_cwp_out %get_out_recs%(key r) := transform
			SELF.city := R.postalcity;
			SELF.penalt := 0;
			self := r;
			self := []; /* This is used to blank out the fields only available 
									   in canadianphones_v2  (and not available in canadianphones_v2 )  */
		end;

		raw_recs := JOIN (ids, key,
									 keyed (Left.id = Right.fdid),
									 %get_out_recs% (Right),
									 KEEP (1));
	endmacro;

// Main Attribute
EXPORT GetRawRecords(boolean isV2) := function

		/* 
    We are using the below code to read 2 different datasets. CanadianPhones and CanadianPhones_V2. 
    This has been possible because the Autokey index structures 
		are the exact same. There has been a change only in the payload key. The payload key of CanadianPhones_V2
		has extra 3 fields : history_flag, date_last_reported, date_first_reported.
		*/
		
		//retrieve ids
		ids := CAN_PH.Get_ids (,false,isV2);

		//get raw data,
		MAC_GetRecords(ids, canadianphones.key_fdids,raw_recs1);
		MAC_GetRecords(ids, canadianphones_V2.key_fdids,raw_recs2);
		
		// get the right version raw records
		raw_recs := if(isV2,raw_recs2,raw_recs1);							 

   return raw_recs;
end;