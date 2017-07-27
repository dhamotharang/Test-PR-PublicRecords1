/*
Takes a file with city, zip field and dups the records to give all possible
versions of the city name (based upon zip)
*/
export MAC_Multi_City(infile,city_field,zip_field,outfile) := macro
import lib_ziplib, lib_stringlib;
#uniquename(new_rec)
%new_rec% := record
  infile;
  varstring citylist; 
  end;

#uniquename(getcitylist)

// Project to get city list for each zip
%new_rec% %GetCityList%(infile L) := TRANSFORM
SELF.citylist := ZipLib.ZipToCities(L.zip_field);
SELF:= L;
END;
 
#uniquename(zipcitiesset)
%ZipCitiesSet% := PROJECT(InFile, %GetCityList%(LEFT));

#uniquename(normcitylist)
typeof(infile) %NormCityList%(%New_Rec% L, INTEGER C) := TRANSFORM
SELF.city_field := IF(c=1,L.city_field,Stringlib.StringExtract(L.citylist, C));
SELF := L;
END;
 
#uniquename(z)
%Z% := NORMALIZE(%ZipCitiesSet%, 1+(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1), %NormCityLIst%(LEFT, COUNTER));
#uniquename(dis_norm)
#uniquename(sort_norm)
%dis_norm% := distribute(%z%,hash(zip_field));
%sort_norm% := sort(%dis_norm%,whole record,local);
outfile := dedup(%sort_norm%,local);

  endmacro;