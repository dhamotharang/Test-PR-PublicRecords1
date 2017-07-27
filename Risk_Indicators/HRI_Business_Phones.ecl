import ut, business_header;

export HRI_Business_Phones (boolean IsFCRA = false) := function

f_sic_addr_out := HRI_Businesses(isFCRA);

f_sic_addr_valid := f_sic_addr_out(phone<>0);

f_sic_addr_dist := distribute(f_sic_addr_valid,hash(phone,sic_code));
	 
f_sic_addr_sort := sort(f_sic_addr_dist,phone,sic_code,local);

f_sic_addr_sort get_date(f_sic_addr_sort le, f_sic_addr_sort ri) := TRANSFORM
	SELF.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	SELF := le;
END;

persistrootname := business_header._dataset().thor_cluster_persists + 'persist::Risk_Indicators::HRI_Business_Phones::';
persistname := if (isFCRA, persistrootname + 'FCRA', persistrootname + 'Not_FCRA');

f_sic_addr_dedup := ROLLUP(f_sic_addr_sort,get_date(LEFT,RIGHT),phone,sic_code,local) : persist(persistname);


return f_sic_addr_dedup;

end;
