import sexoffender,doxie_files, death_master, prof_licensev2;

pd := prof_licensev2.File_Proflic_Base_Tiers;

layout_provider_with_flags := record 
recordof(pd);
boolean has_death := false;
boolean has_sanction := false;
boolean has_sor := false;
boolean has_crim := false;
end;

layout_provider_with_details := record
layout_provider_with_flags;
string offender_key;
string offender_keys;
string crim_offense_description;
string seisint_primary_key;
string seisint_primary_keys;
string sor_offense_description;
string offenses;
end;


in_data0 := dataset('~foreign::10.173.84.201::thor::temp::_pl_derogatories_details',layout_provider_with_details,flat);

in_data := dedup(sort(distribute(in_data0,hash(did)),record,local),all,local);

o1 := output(in_data(has_crim));
o2 := output(in_data(has_sor));
o3 := output(in_data(has_death));
o4 := output(in_data(has_crim and has_sor));

export _pl_derogatories_details2 := in_data;

