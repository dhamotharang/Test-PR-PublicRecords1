import watchdog, doxie, dx_header, Data_Services;

//layouts
rInput := record
	UNSIGNED6		did;
	QSTRING20   fname;
	QSTRING20   mname;
	STRING1			gender;
end;
rOutput := RECORD
  qstring20 fname;
  integer8 f;
  integer8 m;
  integer8 groupcount;
  real4 pct_f;
  real4 pct_m;
 END;
//

//get gender data from header
key_lookups := dx_header.key_did_lookups();
rInput addGender(Watchdog.Key_watchdog_glb l, key_lookups r) := transform
	self.gender := r.gender;
	self := l;
end;

individuals := join(Watchdog.Key_watchdog_glb, key_lookups,
								keyed(left.did=right.did), 
								addGender(left,right), keep(1));

ds := distribute(individuals(gender='M' or gender='F'), did);
ds_sort := sort(ds(length(trim(fname))>1 and length(trim(mname))>1), fname, local);

fname_counts := record
	fname := ds_sort.fname;
	F := COUNT(GROUP, ds_sort.gender ='F');
	M := COUNT(GROUP, ds_sort.gender ='M');
	GroupCount := COUNT(GROUP);
	real4	pct_F := COUNT(GROUP, ds_sort.gender ='F') / COUNT(GROUP);
	real4	pct_M := COUNT(GROUP, ds_sort.gender ='M') / COUNT(GROUP);
end;

fname_gender := TABLE(ds_sort, fname_counts, ds_sort.fname);


export key_gender_fname := index(fname_gender,
																{fname},
																{fname_gender},Data_Services.Data_location.Prefix()+'thor_data400::key::msi::' + doxie.Version_SuperKey + '::gender::fname');

 