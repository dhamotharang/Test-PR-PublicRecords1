// Spawns additional cities from zip, if any.

EXPORT MAC_Add_Cities (indataset, inzip, incity_name, outdataset) := MACRO
import doxie;
// Get city list
#uniquename(rec_citynames)
%rec_citynames% := RECORD
  RECORDOF (indataset);
  string city_list;
END;

#uniquename(GetCityList)
#uniquename(with_citylist)
%rec_citynames% %GetCityList% (indataset L) := TRANSFORM
 // SELF.city_list := ZipLib.ZipToCities (if((integer)L.inzip = 0, '', (string)L.inzip));  //i may need to go back to this, but i dont like that a canadian zip would always get skipped
																																														//the function does not currently support canadian zips, but let it decide that
 SELF.city_list := ZipLib.ZipToCities (L.inzip);
 SELF:= L;
END;

%with_citylist% := PROJECT (nofold(indataset), %GetCityList% (Left)); //nofold is workaround for bug 35317

// normalize by new city names
// wrap transform into function, 'cause using SKIP side-effect within transform 
// won't compile, if incity_name is a field in, say, named layout. See #26701
#uniquename(NormalizeCityList)
%NormalizeCityList% (%rec_citynames% L, INTEGER C) := FUNCTION
  current_city := Stringlib.StringExtract (L.city_list, C);
  indataset t := TRANSFORM, SKIP((C <> 1) and (current_city = L.incity_name))
    SELF.incity_name := IF (C = 1, L.incity_name, current_city);
    SELF := L;
  END;
  RETURN t;
END;

outdataset := NORMALIZE (%with_citylist%, 
                          (integer) Stringlib.StringExtract (Left.city_list, 1)+1, 
                          %NormalizeCityList% (Left, COUNTER));

ENDMACRO;
