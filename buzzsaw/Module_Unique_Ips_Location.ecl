/*
	STRING ip;
	STRING country_code;
	STRING country_name;
	STRING region;
	STRING city;
	STRING latitude;
	STRING longitude;
	STRING isp_name;
	STRING domain_name;
*/
export Module_Unique_Ips_Location := MODULE

		SHARED g := Dataset_Unique_Ips_Location;

		export findByIp(STRING _ip) := IF(_ip <> '', g( ip = _ip), g);
		export findByCountryCode(STRING _country_code) := IF(_country_code <> '', g( country_code = _country_code), g);
		export findByCountryName(STRING _country_name) := IF(_country_name <> '', g( country_name = _country_name), g);
		export findByRegion(STRING _region) := IF(_region <> '', g( region = _region), g);
		export findByCity(STRING _city) := IF(_city <> '', g( city = _city), g);
		export findByIspName(STRING _isp_name) := IF(_isp_name <> '', g( isp_name = _isp_name), g);
		export findByDomainName(STRING _domain_name) := IF(_domain_name <> '', g( domain_name = _domain_name), g);
		
		// Unimplmented at the moment
		export findByLatLonBox(INTEGER x1, INTEGER y1, INTEGER x2, INTEGER y2) := FUNCTION
			return g;
		END;

		export getCountryCodeDistribution(INTEGER _record_limit = 100) := FUNCTION
			g_dist := DISTRIBUTE(g,HASH32(country_code));
			g_tble := TABLE(g_dist,{country_code, INTEGER country_code_count := COUNT(GROUP)}, country_code, MANY, LOCAL);
			g_sort := SORT(g_tble, -country_code_count);
			
			return CHOOSEN(g_sort,_record_limit);
		END;
		
END;