/**
These are the incoming files from the vendor
**/
export File_Vendor := MODULE

shared superbase := Easi2010.cluster + 'in::easi::';

export census := DATASET(superbase + 'current_census', Layout_Vendor.Layout_Census,
			csv(MAXLENGTH(32000),HEADING(2),QUOTE('"'),SEPARATOR(','),TERMINATOR(['\r\n','\n','\n\r'])));

export current_yr := DATASET(superbase + 'current_yr', Layout_Vendor.Layout_Current_yr,
			csv(MAXLENGTH(64000),HEADING(2),QUOTE('"'),SEPARATOR(','),TERMINATOR(['\r\n','\n','\n\r'])));

export five_yr_projection := DATASET(superbase + 'five_yr_projection', Layout_Vendor.Layout_Projection,
			csv(MAXLENGTH(32000),HEADING(2),QUOTE('"'),SEPARATOR(','),TERMINATOR(['\r\n','\n','\n\r'])));
			
export naics := DATASET(superbase + 'naics', Layout_NAICS,
			csv(MAXLENGTH(32000),HEADING(2),QUOTE('"'),SEPARATOR(','),TERMINATOR(['\r\n','\n','\n\r'])));

END;