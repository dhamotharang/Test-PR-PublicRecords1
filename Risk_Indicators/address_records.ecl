import ut,Business_Header;

layout_inll :=
RECORD
	real lat := 0;
	real long := 0;
END;
inll := dataset([],layout_inll) : STORED('LatLong',few);

SET OF STRING4 sic_value := [] : STORED('SicCodes');
unsigned1 radius_value := 0 : STORED('Radius');
string6 zip_value6 := '' : stored('Zip');
string5 zip_value := zip_value6;
boolean IncludeBH := false : STORED('IncludeNonHriSicCodes');
	
sic_data := DATASET(sic_value,{string4 sic_code});

layout_zips :=
RECORD
	STRING5 zip5;
END;

layout_zip_ll_cnt := record
	layout_inll;
	unsigned4 zips_cnt := 0;
	DATASET(layout_zips) zips_ll;
end;

layout_zip_ll_cnt ll_to_zips(layout_inll le) := transform
  zips_raw := dataset(ziplib.ZipsWithinLatLongRadius(le.lat, le.long, radius_value + 5),{unsigned4 zip5}); 
	self.zips_ll := project(zips_raw, transform({string5 zip5}, self.zip5 := intformat(left.zip5,5,1))); 
	self := le;
end;

zips_w_chd := PROJECT(inll, ll_to_zips(LEFT));

full_layout := record
  string5 zip5;
	layout_inll;
	string4 sic_code := '';
end;

full_layout norm_zips(zips_w_chd l, layout_zips r) := transform
	self.zip5 := r.zip5;
	SELF := l;
end;

zip_dist_ll := normalize(zips_w_chd, LEFT.zips_ll, norm_zips(LEFT, RIGHT));

inz := dataset(ziplib.ZipsWithinRadius(zip_value,radius_value),{unsigned4 zip5});

full_layout get_from_zip(inz l) := transform
	self.zip5 := intformat(l.zip5,5,1);
	zip2ll := ziplib.ZipToGeo21(zip_value);
	SELF.lat := (real)(zip2ll[1..9]);
	SELF.long := (real)(zip2ll[11..]);
end;

zip_dist_z := project(inz, get_from_zip(left));

p := IF(~exists(inll),zip_dist_z,zip_dist_ll);

full_layout combine(sic_data le, full_layout ri) :=
TRANSFORM
	SELF := le;
	SELF := ri;
END;
j := JOIN(sic_data,p,true,combine(LEFT,RIGHT),all);
j_srt := sort(j, record);
j_dep := dedup(j);

j2 := j_dep(length(trim(sic_code))=2);
j4 := j_dep(length(trim(sic_code))=4);

k := Risk_Indicators.Key_HRI_Sic_Zip_To_Address;
h := Business_Header.Key_SICCode_Zip;

r :=
RECORD
	k;
	real      distance;
END;

r proj(full_layout le, k ri) :=
TRANSFORM
	local_dist := ut.LL_Dist(le.lat,le.long,ri.lat,ri.long);

	SELF.distance := IF(local_dist > radius_value, SKIP, local_dist);
	SELF := ri;
END;

f2 := JOIN(j2, k, keyed(LEFT.sic_code=RIGHT.sic_code[1..2]) and 
                  keyed(LEFT.zip5=RIGHT.z5), proj(LEFT,RIGHT), LIMIT(400000));
f4 := JOIN(j4, k, keyed(LEFT.sic_code=RIGHT.sic_code) and
                  keyed(LEFT.zip5=RIGHT.z5), proj(LEFT,RIGHT), LIMIT(400000));
bh := JOIN(j4, h, keyed(LEFT.sic_code=RIGHT.sic_code) and
                  keyed(LEFT.zip5=RIGHT.z5) and
									RIGHT.sic_code NOT IN SET(f4,sic_code),	proj(LEFT,RIGHT), LIMIT(400000));

f := if(IncludeBH, f2 + f4 + bh, f2 + f4);

export address_records := f;