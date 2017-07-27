IMPORT Codes;

EXPORT Make2Code(SET OF STRING4 mk) :=
FUNCTION
  rMakes :=
  RECORD
    TYPEOF(mk[1]) make;
  END;
  
  dInMakes := DATASET(mk,rMakes);
  
  dInMakesCapitalize := PROJECT(dInMakes,TRANSFORM(rMakes,SELF.make := StringLib.StringToUpperCase(LEFT.make)));
  
  // Bug 152119
  // Picker file only contains 1 standardized make code while the make index contains different versions of the same code
  // Example is JEP and JEEP, picker file contains only one (JEEP) and we need the ability to search for both JEP and JEEP in the index
  // CodesV3 has all the make codes that correspond to the standardized Picker file code
  dMakesAll := JOIN(dInMakesCapitalize,
                    Codes.Key_Codes_V3,
                    KEYED(RIGHT.file_name = 'VEHICLE_REGISTRATION') AND
                    KEYED(RIGHT.field_name = 'MAKE_CODE') AND
                    WILD(RIGHT.field_name2) AND
                    KEYED(LEFT.make = RIGHT.code),
                    TRANSFORM(rMakes,SELF.make := RIGHT.long_desc),
                    LIMIT(10,SKIP));
  
  // Join to the wildcard make key to get the codes
  dMakeCodes := JOIN(dMakesAll,
                      Vehicle_Wildcard.Key_Make,
                      KEYED(LEFT.make = RIGHT.makecode),
                      LIMIT(0),KEEP(1));
  
  // Debug statements
  // OUTPUT(dInMakesCapitalize,NAMED('dInMakesCapitalize'));
  // OUTPUT(dMakesAll,NAMED('dMakesAll'));
  // OUTPUT(dMakeCodes,NAMED('dMakeCodes'));
  
  RETURN SET(dMakeCodes,i);
END;