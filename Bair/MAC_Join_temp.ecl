import Bair;

export MAC_Join_temp(res, leftDS, rightDS, linkflags) := macro
#uniquename(j0)
	%j0% := JOIN(leftDS,rightDS,#EXPAND(linkflags));
#uniquename(res0)
	%res0%	:= %j0% + rightDS;
#uniquename(geo_f)
#uniquename(geo_d)
	%geo_f%:=bair.files().geohash_base.qa;
	%geo_d%:=bair.files('', false, true).geohash_base.qa;
#uniquename(j1)
	%j1% := JOIN(%geo_f%,%geo_d%,#EXPAND(linkflags)) + %geo_d%;
#uniquename(j)
	%j% := JOIN(%res0%,%j1%,left.eid=right.eid,transform(left),inner);
	res	:= %j%;
endmacro;