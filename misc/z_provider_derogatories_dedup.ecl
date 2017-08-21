import ingenix_natlprof;

providers := ingenix_natlprof.basefile_provider_did;

layout_provider_with_flags := record 
recordof(providers);
boolean has_death;
boolean has_sanction := false;
boolean has_sor := false;
boolean has_crim := false;
end;

pd := dataset('~thor400_94::temp::_provider_derogatories',layout_provider_with_flags,flat);

pds := sort(distribute(pd,hash(providerid))
				,providerid,filetyp,prov_clean_st,-did,local);

pdd := dedup(pds,providerid,filetyp,prov_clean_st,     local);
					
count(pd);
count(pdd);
output(choosen(pds,1000));
output(choosen(pdd,500));

export _provider_derogatories_dedup := pdd;