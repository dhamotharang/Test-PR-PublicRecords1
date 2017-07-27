export MAC_Fips2County_Keyed(ds, st_field, county_field, county_name_field, ot) := 
MACRO

#uniquename(adder)
#uniquename(le)
#uniquename(ri)

ds %adder%(ds %le%, census_data.Key_Fips2County %ri%) :=
TRANSFORM
	SELF.county_name_Field := %ri%.county_name;
	SELF := %le%;
END;

ot := join(ds, Census_Data.Key_Fips2County,
							 LEFT.st_field<>'' AND LEFT.county_field<>'' AND
               KEYED(LEFT.st_field = right.state_code) and
		           KEYED(LEFT.county_field[LENGTH(LEFT.county_field)-2..] = RIGHT.county_fips),
							 %adder%(LEFT,RIGHT),LEFT OUTER,KEEP(1));
ENDMACRO;
