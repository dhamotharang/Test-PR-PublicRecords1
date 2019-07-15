EXPORT macAppendIPMetadata(dIn, inIpAddress, appendPrefix = '\'\'', UseIndexThreshold=100000000) := FUNCTIONMACRO
	IMPORT hipie_ecl, IP_Metadata;
	
	LOCAL SplitOctets := PROJECT(dIn,
		TRANSFORM({
			RECORDOF(LEFT),
			UNSIGNED octet1,
			UNSIGNED octet2,
			UNSIGNED octets34},
			octets:=Std.Str.SplitWords(LEFT.inIpAddress,'.');
			SELF.octet1:=(UNSIGNED)octets[1];
			SELF.octet2:=(UNSIGNED)octets[2];
			SELF.octets34:=(UNSIGNED)(INTFORMAT((UNSIGNED)octets[3],3,1)+INTFORMAT((UNSIGNED)octets[4],3,1));
			SELF:=LEFT)
	);
	
	//Usually we hit the key after a filter/sort/dedup on the KEYED fields; however, this type of dataset tends to have a huge skew 
	//on the IP Address and the JOIN to get all the records back is very slow so we are better off with doing a LEFT OUTER on the KEYED JOIN
	LOCAL dIpMetadata := hipie_ecl.macJoinKey(SplitOctets, IP_Metadata.Key_IP_Metadata_IPv4,
		'KEYED(LEFT.octet1=RIGHT.beg_octet1 AND LEFT.octet1=RIGHT.end_octet1 AND LEFT.octet2=RIGHT.beg_octet2 AND LEFT.octet2=RIGHT.end_octet2 AND (LEFT.octets34 BETWEEN RIGHT.beg_octets34 AND RIGHT.end_octets34))',
		'RIGHT.octet1=LEFT.beg_octet1 AND RIGHT.octet1=LEFT.end_octet1 AND RIGHT.octet2=LEFT.beg_octet2 AND RIGHT.octet2=LEFT.end_octet2 AND (RIGHT.octets34 BETWEEN LEFT.beg_octets34 AND LEFT.end_octets34)',
		UseIndexThreshold,
		JoinType := 'LEFT OUTER',
		KeepOption := TRUE, KeepValue := 1); 
		
	rOut := RECORD
		RECORDOF(dIn);
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.ip_rng_beg) #EXPAND(appendPrefix + 'IpRngBeg');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.ip_rng_end) #EXPAND(appendPrefix + 'IpRngEnd');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_country) #EXPAND(appendPrefix + 'EdgeCountry');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_region) #EXPAND(appendPrefix + 'EdgeRegion');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_city) #EXPAND(appendPrefix + 'EdgeCity');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_conn_speed) #EXPAND(appendPrefix + 'EdgeConnSpeed');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_metro_code) #EXPAND(appendPrefix + 'EdgeMetroCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_latitude) #EXPAND(appendPrefix + 'EdgeLatitude');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_longitude) #EXPAND(appendPrefix + 'EdgeLongitude');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_postal_code) #EXPAND(appendPrefix + 'EdgePostalCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_country_code) #EXPAND(appendPrefix + 'EdgeCountryCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_region_code) #EXPAND(appendPrefix + 'EdgeRegionCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_city_code) #EXPAND(appendPrefix + 'EdgeCityCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_continent_code) #EXPAND(appendPrefix + 'EdgeContinentCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_two_letter_country) #EXPAND(appendPrefix + 'EdgeTwoLetterCountry');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_internal_code) #EXPAND(appendPrefix + 'EdgeInternalCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_area_codes) #EXPAND(appendPrefix + 'EdgeAreaCodes');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_country_conf) #EXPAND(appendPrefix + 'EdgeCountryConf');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_region_conf) #EXPAND(appendPrefix + 'EdgeRegionConf');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_city_conf) #EXPAND(appendPrefix + 'EdgeCityCong');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_postal_conf) #EXPAND(appendPrefix + 'EdgePostalConf');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_gmt_offset) #EXPAND(appendPrefix + 'EdgeGmtOffset');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.edge_in_dst) #EXPAND(appendPrefix + 'EdgeInDst');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.sic_code) #EXPAND(appendPrefix + 'SicCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.domain_name) #EXPAND(appendPrefix + 'DomainName');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.isp_name) #EXPAND(appendPrefix + 'IspName');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.homebiz_type) #EXPAND(appendPrefix + 'HomebizType');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.asn) #EXPAND(appendPrefix + 'Asn');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.asn_name) #EXPAND(appendPrefix + 'AsnName');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.primary_lang) #EXPAND(appendPrefix + 'PrimaryLang');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.secondary_lang) #EXPAND(appendPrefix + 'SecondaryLang');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.proxy_type) #EXPAND(appendPrefix + 'ProxyType');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.proxy_description) #EXPAND(appendPrefix + 'ProxyDescription');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.is_an_isp) #EXPAND(appendPrefix + 'IsAnIsp');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.company_name) #EXPAND(appendPrefix + 'CompanyName');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.ranks) #EXPAND(appendPrefix + 'Ranks');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.households) #EXPAND(appendPrefix + 'Households');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.women) #EXPAND(appendPrefix + 'Women');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.w18_34) #EXPAND(appendPrefix + 'Women18to34');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.w35_49) #EXPAND(appendPrefix + 'Women35to49');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.men) #EXPAND(appendPrefix + 'Men');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.m18_34) #EXPAND(appendPrefix + 'Men18to34');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.m35_49) #EXPAND(appendPrefix + 'Men35to49');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.teens) #EXPAND(appendPrefix + 'Teens');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.kids) #EXPAND(appendPrefix + 'Kids');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.naics_code) #EXPAND(appendPrefix + 'NaicsCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.cbsa_code) #EXPAND(appendPrefix + 'CbsaCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.cbsa_title) #EXPAND(appendPrefix + 'CbsaTitle');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.cbsa_type) #EXPAND(appendPrefix + 'CbsaType');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.csa_code) #EXPAND(appendPrefix + 'CsaCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.csa_title) #EXPAND(appendPrefix + 'CsaTitle');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.md_code) #EXPAND(appendPrefix + 'MdCode');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.md_title) #EXPAND(appendPrefix + 'MdTitle');
		TYPEOF(IP_Metadata.Layout_IP_Metadata.base.organization_name) #EXPAND(appendPrefix + 'OrganizationName');
	END;
	
	LOCAL dOut := PROJECT(dIpMetadata,
		TRANSFORM(rOut,
			SELF.#EXPAND(appendPrefix + 'IpRngBeg') := LEFT.ip_rng_beg,
			SELF.#EXPAND(appendPrefix + 'IpRngEnd') := LEFT.ip_rng_end,
			SELF.#EXPAND(appendPrefix + 'EdgeCountry') := LEFT.edge_country,
			SELF.#EXPAND(appendPrefix + 'EdgeRegion') := LEFT.edge_region,
			SELF.#EXPAND(appendPrefix + 'EdgeCity') := LEFT.edge_city,
			SELF.#EXPAND(appendPrefix + 'EdgeConnSpeed') := LEFT.edge_conn_speed,
			SELF.#EXPAND(appendPrefix + 'EdgeMetroCode') := LEFT.edge_metro_code,
			SELF.#EXPAND(appendPrefix + 'EdgeLatitude') := LEFT.edge_latitude,
			SELF.#EXPAND(appendPrefix + 'EdgeLongitude') := LEFT.edge_longitude,
			SELF.#EXPAND(appendPrefix + 'EdgePostalCode') := LEFT.edge_postal_code,
			SELF.#EXPAND(appendPrefix + 'EdgeCountryCode') := LEFT.edge_country_code,
			SELF.#EXPAND(appendPrefix + 'EdgeRegionCode') := LEFT.edge_region_code,
			SELF.#EXPAND(appendPrefix + 'EdgeCityCode') := LEFT.edge_city_code,
			SELF.#EXPAND(appendPrefix + 'EdgeContinentCode') := LEFT.edge_continent_code,
			SELF.#EXPAND(appendPrefix + 'EdgeTwoLetterCountry') := LEFT.edge_two_letter_country,
			SELF.#EXPAND(appendPrefix + 'EdgeInternalCode') := LEFT.edge_internal_code,
			SELF.#EXPAND(appendPrefix + 'EdgeAreaCodes') := LEFT.edge_area_codes,
			SELF.#EXPAND(appendPrefix + 'EdgeCountryConf') := LEFT.edge_country_conf,
			SELF.#EXPAND(appendPrefix + 'EdgeRegionConf') := LEFT.edge_region_conf,
			SELF.#EXPAND(appendPrefix + 'EdgeCityCong') := LEFT.edge_city_conf,
			SELF.#EXPAND(appendPrefix + 'EdgePostalConf') := LEFT.edge_postal_conf,
			SELF.#EXPAND(appendPrefix + 'EdgeGmtOffset') := LEFT.edge_gmt_offset,
			SELF.#EXPAND(appendPrefix + 'EdgeInDst') := LEFT.edge_in_dst,
			SELF.#EXPAND(appendPrefix + 'SicCode') := LEFT.sic_code,
			SELF.#EXPAND(appendPrefix + 'DomainName') := LEFT.domain_name,
			SELF.#EXPAND(appendPrefix + 'IspName') := LEFT.isp_name,
			SELF.#EXPAND(appendPrefix + 'HomebizType') := LEFT.homebiz_type,
			SELF.#EXPAND(appendPrefix + 'Asn') := LEFT.asn,
			SELF.#EXPAND(appendPrefix + 'AsnName') := LEFT.asn_name,
			SELF.#EXPAND(appendPrefix + 'PrimaryLang') := LEFT.primary_lang,
			SELF.#EXPAND(appendPrefix + 'SecondaryLang') := LEFT.secondary_lang,
			SELF.#EXPAND(appendPrefix + 'ProxyType') := LEFT.proxy_type,
			SELF.#EXPAND(appendPrefix + 'ProxyDescription') := LEFT.proxy_description,
			SELF.#EXPAND(appendPrefix + 'IsAnIsp') := LEFT.is_an_isp,
			SELF.#EXPAND(appendPrefix + 'CompanyName') := LEFT.company_name,
			SELF.#EXPAND(appendPrefix + 'Ranks') := LEFT.ranks,
			SELF.#EXPAND(appendPrefix + 'Households') := LEFT.households,
			SELF.#EXPAND(appendPrefix + 'Women') := LEFT.women,
			SELF.#EXPAND(appendPrefix + 'Women18to34') := LEFT.w18_34,
			SELF.#EXPAND(appendPrefix + 'Women35to49') := LEFT.w35_49,
			SELF.#EXPAND(appendPrefix + 'Men') := LEFT.men,
			SELF.#EXPAND(appendPrefix + 'Men18to34') := LEFT.m18_34,
			SELF.#EXPAND(appendPrefix + 'Men35to49') := LEFT.m35_49,
			SELF.#EXPAND(appendPrefix + 'Teens') := LEFT.teens,
			SELF.#EXPAND(appendPrefix + 'Kids') := LEFT.kids,
			SELF.#EXPAND(appendPrefix + 'NaicsCode') := LEFT.naics_code,
			SELF.#EXPAND(appendPrefix + 'CbsaCode') := LEFT.cbsa_code,
			SELF.#EXPAND(appendPrefix + 'CbsaTitle') := LEFT.cbsa_title,
			SELF.#EXPAND(appendPrefix + 'CbsaType') := LEFT.cbsa_type,
			SELF.#EXPAND(appendPrefix + 'CsaCode') := LEFT.csa_code,
			SELF.#EXPAND(appendPrefix + 'CsaTitle') := LEFT.csa_title,
			SELF.#EXPAND(appendPrefix + 'MdCode') := LEFT.md_code,
			SELF.#EXPAND(appendPrefix + 'MdTitle') := LEFT.md_title,
			SELF.#EXPAND(appendPrefix + 'OrganizationName') := LEFT.organization_name,
			SELF := LEFT));
		
	RETURN dOut;
ENDMACRO;