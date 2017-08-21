import address;

//get the current city on address_id's that appear across files
//it's a weak attempt to handle Davis vs Weston occurrences
//note that it does not handle instances where Davis & Weston
//appear in a single source (i.e. Header).  to resolve this you
//simply need to re-clean all the records, not just those where
//city='' and st='' in Rollup_On_AddressID

export Reclean_Address(dataset(recordof(address_file.Layout_address_file)) in_file) := function

    candidate := in_file(  trim(city_name)='' or trim(st)='');
not_candidate := in_file(~(trim(city_name)='' or trim(st)=''));

recordof(in_file) t_clean(candidate le) := transform
  
 string182 v_ca := address.CleanAddress182(stringlib.stringcleanspaces(le.prim_range+le.predir+le.prim_name+le.suffix+le.postdir+le.unit_desig+le.sec_range),
                                           stringlib.stringcleanspaces(le.zip+le.zip4)
										  );
 
 string25  v_city := v_ca[ 90..114];
 string2   v_st   := v_ca[115..116];
 
 self.city_name := if(le.city_name<>'',le.city_name,v_city);
 self.st        := if(le.st       <>'',le.st,       v_st);
 self           := le;
end;

p_clean := project(candidate,t_clean(left));

concat := p_clean+not_candidate;

return concat;

end;