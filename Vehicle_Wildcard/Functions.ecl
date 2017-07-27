IMPORT ut,vehicle_wildcard;

// Functions derived from logic in Vehicle_Wildcard.MAC_Field_Declare

EXPORT Functions := MODULE;

	// Determine allowable zip codes based on Zip5, ZipRadius, County, City, State and set of zips
	EXPORT getZips(STRING5   zip5_value,
                 UNSIGNED2 zipradius_value,
                 STRING30  county_value,
                 STRING30  city_value,
                 STRING2   state_value,
                 SET OF STRING5 zips_in) := FUNCTION

		STRING5 city_zip_value := ziplib.CityToZip5(state_value,city_value);
		SET OF INTEGER4 zipr_set := ut.fn_GetZipSet(,,zip5_value,,,zipradius_value);
		SET OF INTEGER4 zipcity_set := ut.fn_GetZipSet(,,city_zip_value,,,zipradius_value);
		SET OF INTEGER4 zipcnty_set := ut.fn_GetZipSet(,state_value,,county_value);
		zipr_ds  := PROJECT(DATASET(zipr_set,{INTEGER4 zip}),TRANSFORM({STRING5 zip},SELF.zip := INTFORMAT(LEFT.zip,5,1)));
		zipcnty_ds  := PROJECT(DATASET(zipcnty_set,{INTEGER4 zip}),TRANSFORM({STRING5 zip},SELF.zip := INTFORMAT(LEFT.zip,5,1)));
		zipcity_ds  := PROJECT(DATASET(zipcity_set,{INTEGER4 zip}),TRANSFORM({STRING5 zip},SELF.zip := INTFORMAT(LEFT.zip,5,1)));
		doWildZip := LENGTH(StringLib.StringFilter(zip5_value,'*?')) > 0;
		SET OF STRING5 zips := MAP(
			doWildZip				=> [],								// Zip wildcards override everythig else
			EXISTS(zipr_ds) => SET(zipr_ds,zip),	// zip radius is preferred (Zip5+ZipRadius)
			EXISTS(zipcity_ds) => SET(zipcity_ds,zip),	// zip radius of city (cityZip+ZipRadius)
			EXISTS(zips_in) => zips_in,						// a list of zips is next-best (Zip)
			EXISTS(zipcnty_ds) => SET(zipcnty_ds,zip),	// zips derived from county are better than nothing (County+State)
			[]);
		zip_dataset := DATASET(zips, {STRING5 zip});
		zip_use := set(zip_dataset, (UNSIGNED3)zip);

		RETURN zip_use;
	END;

	// Determine allowable state codes based on ZipRadius, City, State and set of zips
	// adds additional state codes for cases when city is close to state border and radius overlaps
	// example BRISTOL, TN ZipRadius=5 
	EXPORT getStates(UNSIGNED2 zipradius_value,
                   STRING30  city_value,
                   STRING2   state_value,
								   SET OF INTEGER4 zip_use) := FUNCTION

		STRING5 city_zip_value := ziplib.CityToZip5(state_value,city_value);
		SET OF INTEGER4 zipcity_set := ut.fn_GetZipSet(,,city_zip_value,,,zipradius_value);
		zip_dataset := PROJECT(DATASET(zip_use,{INTEGER4 zip}),TRANSFORM({STRING5 zip},self.zip := intformat(left.zip,5,1)));
		zipCd:={string5 zip,unsigned1 code};
		zipCdRec := dataset([{city_zip_value,ut.St2Code(ziplib.ZipToState2(city_zip_value))}],zipCd);
		zipCdRecs := project(zip_dataset,transform(zipCd,
		  self.zip:=left.zip,
		  self.code:=ut.St2Code(ziplib.ZipToState2(left.zip))
		  ));
		set of unsigned1 state_use := set(dedup(sort(zipCdRec(code!=0)+zipCdRecs,code),code),code);

		RETURN state_use;
	END;

	// convert string make to integer make
	EXPORT getMakes(SET OF STRING4 Makes) := FUNCTION
		makeCodes := vehicle_wildcard.Make2Code(Makes);
		RETURN makeCodes;
	END;

	// convert string model to integer model
	EXPORT getModels(SET OF STRING36 Models) := FUNCTION
		model_dataset := DATASET(Models,{STRING36 m});
		model_convert := JOIN(DEDUP (model_dataset, m, ALL), Vehicle_Wildcard.Key_ModelIndex,
			KEYED((QSTRING36)LEFT.m = RIGHT.str[1..LENGTH(TRIM(LEFT.m))]),KEEP(100));
		modelCodes := SET(model_convert,i);
		RETURN modelCodes;
	END;

	// convert string body to integer body
	EXPORT getBodys(SET OF STRING36 Bodys) := FUNCTION
		body_dataset := DATASET(Bodys,{STRING36 b});
		body_convert := JOIN(DEDUP (body_dataset, b, ALL), Vehicle_Wildcard.Key_BodyStyle,
			KEYED(Stringlib.StringToUpperCase(LEFT.b) = RIGHT.body_style),KEEP(100));
		bodyCodes := SET(body_convert,i);
		RETURN bodyCodes;
	END;

	// convert string color to integer color
	EXPORT getColors(SET OF STRING36 Colors) := FUNCTION
		color_dataset := DATASET(Colors,{STRING36 c});
		colorCodes := SET(color_dataset, vehicle_wildcard.Color2Code(c));
		RETURN colorCodes;
	END;

END;