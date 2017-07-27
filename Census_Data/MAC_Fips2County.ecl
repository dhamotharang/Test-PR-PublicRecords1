export MAC_Fips2County(infile,st,fips_cty,cty_name,outfile) := macro

#uniquename(addName)
typeof(infile) %addName%(infile L, census_data.FILE_Fips2County r) := transform 
 self.cty_name := r.county_name;
 self := l;
end;

outfile := join(infile(st != '' or fips_cty != ''),census_data.FILE_Fips2County,left.st=right.state_code and
				(integer)(left.fips_cty) = (integer)right.county_fips,%addName%(left,right),left outer, lookup) + infile(st = '' and fips_cty = '');

endmacro;