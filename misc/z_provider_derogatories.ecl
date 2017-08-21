import ingenix_natlprof,doxie,doxie_files,sexoffender;

// export _provider_derogatories := 'todo';

// current provider list(s) 
// for:
// 1.       Dead List
// 2.       Medical Sanctions
// 3.       Sex Offender
// 4.       Criminal Convictions
// with counts, broken down by State to aid with the analysis.

pd := ingenix_natlprof.basefile_provider_did;
pds := sort(distribute(pd,hash(providerid)),providerid,filetyp,prov_clean_st,-did,local);
pdd := dedup(pds,							providerid,filetyp,prov_clean_st,     local);
providers := sort(distribute(pdd,hash((unsigned) did)),(unsigned) did,local);

deaths := pull(Doxie.key_death_masterV2_DID);
sanctions := pull(Doxie_files.key_sanctions_did);
sors := pull(sexoffender.Key_SexOffender_DID);
crims:= pull(doxie_files.key_offenders(data_type='1'));

layout_provider_with_flags := record 
recordof(providers);
boolean has_death;
boolean has_sanction := false;
boolean has_sor := false;
boolean has_crim := false;
end;


//********************  MACRO ******************************
mac_find_did(ds_left,ds_right,right_did,has_fld,joined_ds) := MACRO
#uniquename(find_did)
layout_provider_with_flags %find_did%(ds_left L, ds_right R) := TRANSFORM
self.has_fld:= if( (integer) L.did<>0 and ((integer) L.did = (integer) R.right_did),true,false);
self:=L;
END;
#uniquename(ds_right_sorted)
%ds_right_sorted%:=sort(distribute(ds_right,hash((integer) right_did)),(integer) right_did,LOCAL);
joined_ds := JOIN(ds_left,%ds_right_sorted%, (integer) LEFT.did=(integer)RIGHT.right_did, %find_did%(LEFT,RIGHT),LEFT OUTER,LOCAL, KEEP(1));
ENDMACRO;
//******************** END MACRO ******************************

mac_find_did(providers,deaths,did,has_death,providers_with_death);
mac_find_did(providers_with_death,sanctions,l_did,has_sanction,providers_with_sanction);
mac_find_did(providers_with_sanction,sors,sdid,has_sor,providers_with_sor);
mac_find_did(providers_with_sor,crims,sdid,has_crim,providers_with_crim);

o1:=output(providers_with_crim,,'~thor::temp::_provider_derogatories',overwrite);

o1;


