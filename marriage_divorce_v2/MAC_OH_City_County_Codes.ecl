export MAC_OH_City_County_Codes(infile1,infile2, field1,field2, outfile) := macro


#uniquename(ohCityCountyCodes)
typeof(infile1)%ohCityCountyCodes%(infile1 l, infile2 r) := transform

self.field2:=r.city;
self := l;
end;

outfile := JOIN(infile1,infile2,left.field1 = right.code, %ohCityCountyCodes%(left,right),lookup,left outer);

endmacro;