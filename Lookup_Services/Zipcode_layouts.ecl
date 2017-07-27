export Zipcode_layouts := module

	Export Zipcode_slim := record
			 string10   STREET_NUM;
			 string2		STREET_PRE_DIRectional;
			 string28	  STREET_NAME;
			 string2		STREET_POST_DIRectional;
			 string4		STREET_SUFFIX;
			 string4		Secondary_Unit_Designator;
			 string8		Secondary_Unit_Number;
			 string28		County_Name;
			 string28		City_Name;
			 string2		State_Code;
			 string5		ZIP_5;
			 string4		ZIP_4;
	end;

	Export Zipcode_StreetListing_slim := record
			 string2		STREET_PRE_DIRectional;
			 string28	  STREET_NAME;
			 string2		STREET_POST_DIRectional;
			 string4		STREET_SUFFIX;
			 string28		County_Name;
			 string28		City_Name;
			 string2		State_Code;
			 string5		ZIP_5;
	end;

	Export Zipcode_CityListing := record
			 string		City_Name;
	end;

	Export Zipcode_ZipcodeListing := record
			 string5		ZIP_5;
	end;
	
	Export Zipcode_Zip4Listing := record
			 string5		ZIP_5;
			 string4		ZIP_4;
	end;
	
end;