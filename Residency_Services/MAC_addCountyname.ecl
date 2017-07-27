EXPORT MAC_addCountyname (infile,zipfield,outfile) := MACRO

IMPORT Advo;

	outfile := JOIN(infile,Advo.Key_Addr1,
                    KEYED(LEFT.zipfield   = RIGHT.zip)        AND
                    KEYED(LEFT.prim_range = RIGHT.prim_range) AND
                    KEYED(LEFT.prim_name  = RIGHT.prim_name), 
                  TRANSFORM(RECORDOF(infile), 
									  SELF.county_name := RIGHT.county_name,
									  SELF := left),
									LEFT OUTER,
									KEEP(1));

ENDMACRO;