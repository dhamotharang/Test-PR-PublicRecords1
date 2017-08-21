/*2008-01-09T15:25:09Z (Unknown)

*/
export Module_Ip_Location := MODULE

	SHARED g := buzzsaw.Mod_Data.DS_Unique_Ips_Location;
	SHARED layout := buzzsaw.Mod_Data.L_Unique_Ips_Location;

	/*
	 * EXACT: BEVERLY
	 * REGEX: *^B.*Y$
	 * FUZZY: ~BEVRLY (1 removed from BEVERLY) <- not sure how to do this
	 * NOT:   !BEVERLY
	 * NOT REGEX: !*^B.*Y$
	 */
	export matchColumn(DATASET(layout) ds, STRING f, STRING v) := FUNCTION
		return MAP(
			v = '' => ds,
			length(v) > 1 AND v[1] = '*' => ds(REGEXFIND(v[2..],f)),
			length(v) > 2 AND v[1] = '!' AND v[2] = '*' => ds(~REGEXFIND(v[3..], f)),
			length(v) > 1 AND v[1] = '!' => ds(f <> v[2..]),
			ds(f = v)
		);
	END;

	export findByIp(DATASET(layout) ds, STRING _ip) := matchColumn(ds,ds.ip,_ip);
	export findByCountryCode(DATASET(layout) ds, STRING _country_code) := matchColumn(ds,ds.country_code,_country_code);
	export findByCountryName(DATASET(layout) ds, STRING _country_name) := matchColumn(ds,ds.country_name,_country_name);
	export findByRegion(DATASET(layout) ds, STRING _region) := matchColumn(ds,ds.region,_region);
	export findByCity(DATASET(layout) ds, STRING _city) := matchColumn(ds,ds.city,_city);
	export findByIspName(DATASET(layout) ds, STRING _isp_name) := matchColumn(ds,ds.isp_name,_isp_name);
	export findByDomainName(DATASET(layout) ds, STRING _domain_name) := matchColumn(ds,ds.domain_name,_domain_name);
	
	export find(
			STRING _ip, 
			STRING _country_code, 
			STRING _country_name, 
			STRING _region, 
			STRING _city, 
			STRING _isp_name, 
			STRING _domain_name) := FUNCTION

		ds := g;
		
		f1 := findByIp(ds, _ip);
		f2 := findByCountryCode(f1, _country_code);
		f3 := findByCountryName(f2, _country_name);
		f4 := findByRegion(f3, _region);
		f5 := findByCity(f4, _city);
		f6 := findByIspName(f5, _isp_name);
		f7 := findByDomainName(f6, _domain_name);
		
		return f7;
	END;
	
END;