/* ************************************************************************************
PRTE2_Gong_Ins.Layouts
	Boca_Base_Layout is the final layout the the boca build requires.
	Alpha_Common - is our common layouts + bug_num + renaming any fields we can keep from the Boca base.
************************************************************************************ */
IMPORT prte2_gong;

EXPORT Layouts := MODULE

// Names have been changed so those fields just move as needed between the two formats.
	EXPORT Alpha_Common := RECORD
			UNSIGNED did;							// switched to unsigned to match final Boca file and make transforms easier
			STRING5 name_prefix;			// renamed to keep the Boca field
			STRING xSponsor:='';			// send to cust_name 
			STRING xBug_num:='';
			STRING xAmbest:='';
			STRING20 name_first;			// renamed to keep the Boca field
			STRING20 name_middle;			// renamed to keep the Boca field
			STRING20 name_last;				// renamed to keep the Boca field
			STRING5 name_suffix;			// renamed to keep the Boca field
			// NOTE: Need to build listed_name from first+middle+last above.
			STRING8 link_dob;					// renamed to keep the Boca field
			STRING9 link_ssn;					// renamed to keep the Boca field
			STRING1 xGender:='';
			STRING60 address1;				// renamed to keep the Boca field
			STRING25 city;
			STRING2 state;
			STRING10 zip;
			STRING xZip4:='';
			STRING xDLState:='';
			STRING xDLN:='';
			STRING phone10;			// ADDED to bring the phone number up closer to the front of the spreadsheet.
	END;

	EXPORT Boca_Base_Layout := prte2_gong.Layouts.Layout_gong_in;
	
	// we're "or'ing" these together so it just keeps one field if names match
	EXPORT Alpha_CSV_Layout := RECORD
			Alpha_Common, Boca_Base_Layout;
	END;
			

END;