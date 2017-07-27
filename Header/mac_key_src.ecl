export mac_key_src(srcFile, srcLayout, cdName, indxName, indxOut) := macro

import ak_perm_fund,atf,bankrupt,drivers,emerges,govdata,prof_license,ln_property,ln_mortgage,property,utilfile,vehlic,dea,faa,watercraft, Doxie, Doxie_Raw,Doxie_crs, LN_TU,liensv2,targus,ln_propertyv2;

#uniquename(slim)
srcLayout %slim%(srcFile L) := transform
 self := l;
end;

#uniquename(keyLayout)
%keyLayout% := record
 header.layout_Source_ID;
 dataset(srcLayout) cdName;
end;

#uniquename(get)
%keyLayout% %get%(srcFile L) := transform
 self.cdName := row(L,%slim%(l));
 self := l;
end;

#uniquename(with_)
%with_% := project(srcFile,%get%(left));

indxOut := index(
%with_%,
{uid,src},
{%with_%},
indxName + doxie.Version_SuperKey);

endmacro;