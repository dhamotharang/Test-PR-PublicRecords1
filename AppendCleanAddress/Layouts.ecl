
EXPORT Layouts := MODULE

   EXPORT rRawACE := RECORD
		string80 line1;
		string60 linelast;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
  END;
	
  EXPORT rAppendLayout := record
		string10        adc_PrimaryRange; 	// [1..10]
		string2         adc_PreDirectional;		// [11..12]
		string28        adc_PrimaryName;	// [13..40]
		string4         adc_AddressSuffix;  // [41..44]
		string2         adc_PostDirectional;		// [45..46]
		string10        adc_UnitDesignation;	// [47..56]
		string8         adc_SecondaryRange;	// [57..64]
		string25        adc_PostalCity;	// [65..89]
		string25        adc_VanityCity;  // [90..114]
		string2         adc_State;			// [115..116]
		string5         adc_Zip;		// [117..121]
		string4         adc_Zip4;		// [122..125]
		string2         adc_DBPC;		// [136..137]
		string1         adc_CheckDigit;	// [138]
		string2         adc_RecordType;	// [139..140]
		string5         adc_County;		// [141..145]
		string10        adc_Latitude;		// [146..155]
		string11        adc_Longitude;	// [156..166]
		string4         adc_Msa;		// [167..170]
		string7         adc_GeoBlock;		// [171..177]
		string1         adc_GeoMatchCode;	// [178]
		string4         adc_ErrorStatus;	// [179..182]
  END;	

	EXPORT rFinalMac := RECORD
		rAppendLayout;
		QSTRING45 addx1;
		QSTRING45	addx2;
		BOOLEAN adc_CacheHit := FALSE;
		BOOLEAN adc_CleanerHit := FALSE;
    STRING adc_CleanedAddress := '';
    STRING adc_InputAddress := '';
	END;

END;