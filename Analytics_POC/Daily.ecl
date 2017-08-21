export Daily := module


// volume and rev is in the address file, moving on...
essbase_vol := sort(
	table(CompanyAddresses.file_essbase(GL_DT_KEY>=20080000), {cust_cd, GL_DT_KEY, unit_cnt, sls_amt})
	,cust_cd, GL_DT_KEY
);

accts := FS_Accounts.ds_accts;

slim_units_layout := record
	accts.sys_cd;
	accts.cust_cd;
	accts.vc_id;
	accts.mig_gen03_cd;
	accts.cust_id;
	accts.hh_id;
	essbase_vol.GL_DT_KEY;
	essbase_vol.unit_cnt;
	essbase_vol.sls_amt;
end;

slim_units := join(accts, //FS_Accounts.ds_accts,
                   essbase_vol,
									 left.cust_cd=right.cust_cd,
									 transform(slim_units_layout,
									           self:=left,
														 self:=right)
									);

mig_units_layout := record
	slim_units.sys_cd;
	slim_units.cust_cd;
	slim_units.vc_id;
	slim_units.mig_gen03_cd;
	slim_units.cust_id;
	slim_units.hh_id;
	slim_units.GL_DT_KEY;
	decimal10_2 sls_amt := sum(group,slim_units.sls_amt);
	integer unit_cnt := sum(group,slim_units.unit_cnt);
	unsigned1 merged_sub_cnt := count(group);
end;

export mig_units := table(slim_units, mig_units_layout, mig_gen03_cd, GL_DT_KEY);

hh_agg_layout := record
	mig_units.hh_id;
	mig_units.gl_dt_key;
	decimal10_2 sls_amt:=sum(group,mig_units.sls_amt);
	integer unit_cnt:=sum(group,mig_units.unit_cnt);
end;

export hh_agg := table(mig_units, hh_agg_layout, hh_id, gl_dt_key);

mig_hh_agg_layout := record
	mig_units.sys_cd;
	mig_units.cust_cd;
	mig_units.vc_id;
	mig_units.mig_gen03_cd;
	mig_units.cust_id;
	mig_units.hh_id;
	mig_units.gl_dt_key;
	mig_units.sls_amt;
	mig_units.unit_cnt;
	mig_units.merged_sub_cnt;
	decimal10_2 hh_sls_amt;
	integer hh_unit_cnt;
end;



export fs_daily_agg := join(mig_units,
                            hh_agg,
														left.hh_id=right.hh_id
														and left.gl_dt_key=right.gl_dt_key,
														transform(mig_hh_agg_layout,
														          self.hh_sls_amt:=right.sls_amt;
																			self.hh_unit_cnt:=right.unit_cnt;
																			self:=left)
														);

export proc_despray_daily :=
	sequential(
		output(fs_daily_agg, ,
				   'poc::fs_daily', 
				   csv(heading(single), quote(''), separator('\t'), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_daily', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_daily.tsv', ,,,true)
	);


end;