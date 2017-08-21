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
string crim_offense_description;
string seisint_primary_key;
string sor_offense_description;
string offenses;
end;


in_data := dataset('~thor::temp::_pl_derogatories_details',layout_provider_with_details,flat);

o1 := output(in_data(has_crim));
o2 := output(in_data(has_sor));
o3 := output(in_data(has_death));
o4 := output(in_data(has_crim and has_sor));

export _pl_derogatories_details2 := sequential(o1,o2,o3,o4);

