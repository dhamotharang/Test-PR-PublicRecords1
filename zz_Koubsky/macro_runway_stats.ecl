
EXPORT macro_runway_stats(ds1, ds2, at_name) := FUNCTIONMACRO
	
	INTEGER full_count1 := COUNT(ds1);
	INTEGER mid_count1 := full_count1 / 2;
	sorted_ds1 := SORT(ds1, -#expand(at_name));
	medn1 := sorted_ds1[mid_count1];
	
	REAL temp_mean1 := table(ds1, {temp_mean := AVE(group, (real)ds1.#expand(at_name))} )[1].temp_mean;
	STRING temp_median1 := medn1.#expand(at_name);
	REAL temp_std_dev1 := SQRT( VARIANCE(ds1, (REAL) #expand(at_name)));
	
	INTEGER full_count2 := COUNT(ds2);
	INTEGER mid_count2 := full_count2 / 2;
	sorted_ds2 := SORT(ds2, -#expand(at_name));
	medn2 := sorted_ds2[mid_count2];

	REAL temp_mean2 := table(ds2, {temp_mean := AVE(group, (real)ds2.#expand(at_name))} )[1].temp_mean;
	STRING temp_median2 := medn2.#expand(at_name);
	REAL temp_std_dev2 := SQRT( VARIANCE(ds2, (REAL) #expand(at_name)));	
	
	INTEGER first_count := COUNT(ds1);
	INTEGER second_count := COUNT(ds2);

	j1 := JOIN(ds1, ds2, LEFT.seq = RIGHT.seq 
							AND LEFT.#expand(at_name) <> RIGHT.#expand(at_name),
							TRANSFORM(recordof(ds1), SELF := LEFT; SELF := []));

	diff_count := COUNT(j1);	
	
	stats_layout := record
		STRING name;
		REAL mean1;
		STRING median1;
		REAL std_dev1;
		STRING _X_;
		REAL mean2;
		STRING median2;
		REAL std_dev2;
		STRING X_X;
		REAL diff_mean;
		INTEGER diff_median;
		REAL diff_std_dev;
		STRING XXX;
		INTEGER full_count_1;
		INTEGER full_count_2;
		INTEGER diff_count;
		REAL diff_percent;
	END;

	stats_layout add_stats(ut.ds_oneRecord le) := transform
		self.name := at_name;
		self.mean1 := temp_mean1;
		self.median1 := temp_median1;
		self.std_dev1 := temp_std_dev1;
		self._X_ := '';
		self.mean2 := temp_mean2;
		self.median2 := temp_median2;
		self.std_dev2 := temp_std_dev2;
		self.X_X := '';
		self.diff_mean := temp_mean2 - temp_mean1;
		self.diff_median := (INTEGER)temp_median2 - (INTEGER)temp_median1;
		self.diff_std_dev := temp_std_dev2 - temp_std_dev1;
		self.XXX := '';
		self.full_count_1 := first_count;
		self.full_count_2 := second_count;
		self.diff_count := diff_count;
		self.diff_percent := diff_count / first_count;
		// self := [];
	END;
	
	dset := project(ut.ds_oneRecord, add_stats(left));

	return dset;
endmacro;