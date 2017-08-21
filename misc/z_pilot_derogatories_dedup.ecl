
pd := misc._pilot_derogatories(record_type='ACTIVE');

pds := sort(distribute(pd,hash(unique_id))
				,unique_id,st,-did_out,local);

pdd := dedup(pds,unique_id,st,local);
					
// count(pd);
// count(pdd);
// output(choosen(pds,1000));
// output(choosen(pdd,500));

export _pilot_derogatories_dedup := pdd : persist('~thor400_84::persist::_pilot_derogatories_dedup');
