import doxie,lib_ziplib,lib_stringlib;

export ZipToCities(string5 zip_val) := 
MODULE

//***** CALL ZIPLIB
shared cities := if(zip_val <> '', ziplib.ZipToCities(zip_val), '');
shared num_cities := (unsigned)(cities[1..stringlib.stringfind(cities,',',1)]);

//***** LAYOUTS
shared cr := {string25 city};
shared r := {cr, unsigned codev1, unsigned codev2, set of unsigned codes};
shared nada := dataset([{''}], cr);

//***** NORMALIZE
r norm(nada l, integer c) := transform

	comma1pos := stringlib.stringfind(cities,',',c);
	start := comma1pos + 1;
	comma2pos := stringlib.stringfind(cities,',',c + 1);
	stop := if(comma2pos > 0, comma2pos - 1, length(cities));

	cty := cities[start..stop];

	self.city := cty;
	self.codev1 := doxie.Make_CityCodes(cty).v1;
	self.codev2 := doxie.Make_CityCodes(cty).v2;
	self.codes := doxie.Make_CityCodes(cty).rox;
end;

shared p := normalize(nada, num_cities, norm(left, counter));

//***** RETURN OPTIONS
export records := project(p, cr);

//cem - instead of using p here, use another dataset.  piece of cake
export set_codes := set(p, codev1) + set(p(codev2 <> codev1), codev2);  //W20120508-174218 shows legacy result.  W20120508-174503 shows OSS result.

export set_cities := set(p, city);

END;