import std, ut, IP_Metadata, dx_ip_metadata;

//Creates the IP_Metadata Base File & Maintains History of Changes
//Only the "Current" Records are Exposed in the Key

EXPORT Map_IP_Metadata_ipv6(string8 version) := function

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Cleanup Fields////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	inFile :=  IP_Metadata.File_IP_Metadata.Raw_ipv6;

	IP_Metadata.Layout_IP_Metadata.base_ipv6 trFile(inFile L):= transform
		self.dt_first_seen						:= version;
		self.dt_last_seen							:= version;
		
		beg_hextets 										:= Std.Str.SplitWords(l.ip_rng_beg,':');
		self.beg_hextet1 							:= dx_ip_metadata.functions.hex4format(beg_hextets[1]);
		end_hextets 										:= Std.Str.SplitWords(l.ip_rng_end,':');
		self.end_hextet1 							:= dx_ip_metadata.functions.hex4format(end_hextets[1]);
		f_beg := $._Functions.FormatHexAddress(l.ip_rng_beg);
		f_end := $._Functions.FormatHexAddress(l.ip_rng_end);
		self.ip_rng_beg_full 						:= f_beg;
		self.ip_rng_end_full						:= f_end;
		self.ip_rng_beg_full6_39					:= f_beg[6..39];
		self.ip_rng_end_full6_39					:= f_end[6..39];
		self.edge_country 						:= _Functions.clAlph(l.edge_country);
		self.edge_region 							:= _Functions.clAlphNum(l.edge_region);
		self.edge_city 								:= _Functions.clAlph(l.edge_city);
		self.edge_conn_speed 					:= _Functions.clAlphNum(l.edge_conn_speed);
		self.edge_metro_code					:= l.edge_metro_code;
		self.edge_latitude 						:= _Functions.clNum(l.edge_latitude);
		self.edge_longitude 					:= _Functions.clNum(l.edge_longitude);
		self.edge_postal_code 				:= _Functions.clAlphNum(l.edge_postal_code);
		self.edge_country_code				:= l.edge_country_code;
		self.edge_region_code					:= l.edge_region_code;
		self.edge_city_code						:= l.edge_city_code;
		self.edge_continent_code			:= l.edge_continent_code;
		self.edge_two_letter_country 	:= _Functions.clAlph(l.edge_two_letter_country);
		self.edge_internal_code				:= l.edge_internal_code;
		self.edge_area_codes 					:= _Functions.clNum(l.edge_area_codes);
		self.edge_country_conf				:= l.edge_country_conf;
		self.edge_region_conf					:= l.edge_region_conf;
		self.edge_city_conf						:= l.edge_city_conf;
		self.edge_postal_conf					:= l.edge_postal_conf;
		self.edge_gmt_offset 					:= l.edge_gmt_offset;
		self.edge_in_dst 							:= _Functions.clAlph(l.edge_in_dst);
		self.edge_timezone_name				:= _Functions.clAlph(l.edge_timezone_name); 
		self.sic_code 								:= '';//_Functions.clNum(l.sic_code);
		self.domain_name 							:= _Functions.clAlphNum(l.domain_name);
		self.isp_name 								:= _Functions.clAlphNum(l.isp_name);
		self.homebiz_type 						:= _Functions.clAlph(l.homebiz_type);
		self.asn											:= l.asn;
		self.asn_name 								:= _Functions.clAlphNum(l.asn_name);
		self.primary_lang 						:= _Functions.clAlph(l.primary_lang);
		self.secondary_lang 					:= _Functions.clAlph(l.secondary_lang);
		self.proxy_type 							:= _Functions.clAlph(l.proxy_type);
		self.proxy_description 				:= _Functions.clAlph(l.proxy_description);
		self.is_an_isp 								:= _Functions.clAlph(l.is_an_isp);
		self.company_name 						:= _Functions.clAlphNum(l.company_name);
		self.ranks 										:= _Functions.clNum(l.ranks);
		self.households 							:= _Functions.clNum(l.households);
		self.women 										:= _Functions.clNum(l.women);
		self.w18_34 									:= _Functions.clNum(l.w18_34);
		self.w35_49 									:= _Functions.clNum(l.w35_49);
		self.men 											:= _Functions.clNum(l.men);
		self.m18_34 									:= _Functions.clNum(l.m18_34);
		self.m35_49 									:= _Functions.clNum(l.m35_49);
		self.teens 										:= _Functions.clNum(l.teens);
		self.kids											:= _Functions.clNum(l.kids);
		self.naics_code								:= l.naics_code;
		self.cbsa_code								:= l.cbsa_code;
		self.cbsa_title 							:= _Functions.clAlph(l.cbsa_title);
		self.cbsa_type 								:= _Functions.clAlph(l.cbsa_type);
		self.csa_code 								:= l.csa_code;
		self.csa_title 								:= _Functions.clAlph(l.csa_title);
		self.md_code 									:= l.md_code;
		self.md_title 								:= _Functions.clAlph(l.md_title);
		self.organization_name 				:= _Functions.clAlphNum(l.organization_name);
		self.generated_rec						:= FALSE;
		self.is_current								:= FALSE;
		self													:= l;
	end;

	cleanRec		:= project(inFile, trFile(left));
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Expand Ranges/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		//Expand beg_hextet1!=end_hextet1
		expRecs1				:= $._Functions.expandRangesHex(cleanRec(beg_hextet1!=end_hextet1),1);
		expandRec				:= expRecs1(beg_hextet1=end_hextet1);
		ddExpRec				:= dedup(sort(distribute(expandRec, hash(ip_rng_beg_full, ip_rng_end_full)), record, local), record, local);
		concatExpRecs 			:= cleanRec(beg_hextet1=end_hextet1) + 	 expandRec;	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Compare Previous File Against New File////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		srtNewRec				:= sort(distribute(concatExpRecs, hash(ip_rng_beg_full, ip_rng_end_full)), ip_rng_beg_full, ip_rng_end_full, -dt_last_seen, local);
		srtOldRec				:= //dataset( [],IP_Metadata.Layout_IP_Metadata.base_ipv6);
									sort(distribute(IP_Metadata.File_IP_Metadata.Base_ipv6, hash(ip_rng_beg_full, ip_rng_end_full)), ip_rng_beg_full, ip_rng_end_full, -dt_last_seen, local); 
		//Flag existing and new records as "current"	
		Layout_IP_Metadata.Base_ipv6 compActF(srtNewRec l, srtOldRec r):= transform
			self.dt_first_seen:= (string)(ut.min2((unsigned)l.dt_first_seen, (unsigned)r.dt_first_seen));
			self.dt_last_seen	:= max(l.dt_last_seen, r.dt_last_seen);
			self.is_current		:= TRUE;
			self 							:= l;
		end;
		
		//changing ip_rng_beg and ip_rng_end to full versions below
		activeRec 	:= join(srtNewRec, srtOldRec(is_current=TRUE),
												//left.ip_rng_beg = right.ip_rng_beg and
												//left.ip_rng_end = right.ip_rng_end and 
												left.ip_rng_beg_full = right.ip_rng_beg_full and
												left.ip_rng_end_full = right.ip_rng_end_full and 
												left.ip_rng_beg_full6_39 = right.ip_rng_beg_full6_39 and
												left.ip_rng_end_full6_39 = right.ip_rng_end_full6_39 and
												left.edge_country = right.edge_country and 
												left.edge_region = right.edge_region and 
												left.edge_city = right.edge_city and 
												left.edge_conn_speed = right.edge_conn_speed and 
												left.edge_metro_code = right.edge_metro_code and 
												left.edge_latitude = right.edge_latitude and 
												left.edge_longitude = right.edge_longitude and 
												left.edge_postal_code = right.edge_postal_code and 
												left.edge_country_code = right.edge_country_code and 
												left.edge_region_code = right.edge_region_code and 
												left.edge_city_code = right.edge_city_code and 
												left.edge_continent_code = right.edge_continent_code and 
												left.edge_two_letter_country = right.edge_two_letter_country and 
												left.edge_internal_code = right.edge_internal_code and 
												left.edge_area_codes = right.edge_area_codes and 
												left.edge_country_conf = right.edge_country_conf and 
												left.edge_region_conf = right.edge_region_conf and 
												left.edge_city_conf = right.edge_city_conf and 
												left.edge_postal_conf = right.edge_postal_conf and 
												left.edge_gmt_offset = right.edge_gmt_offset and 
												left.edge_in_dst = right.edge_in_dst and 
												left.edge_timezone_name = right.edge_timezone_name and 
												left.sic_code = right.sic_code and 
												left.domain_name = right.domain_name and 
												left.isp_name = right.isp_name and 
												left.homebiz_type = right.homebiz_type and 
												left.asn = right.asn and 
												left.asn_name = right.asn_name and 
												left.primary_lang = right.primary_lang and 
												left.secondary_lang = right.secondary_lang and 
												left.proxy_type = right.proxy_type and 
												left.proxy_description = right.proxy_description and 
												left.is_an_isp = right.is_an_isp and 
												left.company_name = right.company_name and 
												left.ranks = right.ranks and 
												left.households = right.households and 
												left.women = right.women and 
												left.w18_34 = right.w18_34 and 
												left.w35_49 = right.w35_49 and 
												left.men = right.men and 
												left.m18_34 = right.m18_34 and 
												left.m35_49 = right.m35_49 and 
												left.teens = right.teens and 
												left.kids = right.kids and 
												left.naics_code = right.naics_code and 
												left.cbsa_code = right.cbsa_code and 
												left.cbsa_title = right.cbsa_title and 
												left.cbsa_type = right.cbsa_type and 
												left.csa_code = right.csa_code and 
												left.csa_title = right.csa_title and 
												left.md_code = right.md_code and 
												left.md_title = right.md_title and 
												left.organization_name = right.organization_name,
												compActF(left, right), left outer, local);
	
		//Flag missing records as "not current"
		Layout_IP_Metadata.Base_ipv6 compDeactF(srtNewRec l, srtOldRec r):= transform
			self.dt_last_seen	:= r.dt_last_seen;
			self.is_current		:= FALSE;
			self 							:= r;
		end;

		deactivRec 	:= join(srtNewRec, srtOldRec(is_current=TRUE),
												//left.ip_rng_beg = right.ip_rng_beg and
												//left.ip_rng_end = right.ip_rng_end and 
												left.ip_rng_beg_full = right.ip_rng_beg_full and
												left.ip_rng_end_full = right.ip_rng_end_full and 
												left.edge_country = right.edge_country and 
												left.edge_region = right.edge_region and 
												left.edge_city = right.edge_city and 
												left.edge_conn_speed = right.edge_conn_speed and 
												left.edge_metro_code = right.edge_metro_code and 
												left.edge_latitude = right.edge_latitude and 
												left.edge_longitude = right.edge_longitude and 
												left.edge_postal_code = right.edge_postal_code and 
												left.edge_country_code = right.edge_country_code and 
												left.edge_region_code = right.edge_region_code and 
												left.edge_city_code = right.edge_city_code and 
												left.edge_continent_code = right.edge_continent_code and 
												left.edge_two_letter_country = right.edge_two_letter_country and 
												left.edge_internal_code = right.edge_internal_code and 
												left.edge_area_codes = right.edge_area_codes and 
												left.edge_country_conf = right.edge_country_conf and 
												left.edge_region_conf = right.edge_region_conf and 
												left.edge_city_conf = right.edge_city_conf and 
												left.edge_postal_conf = right.edge_postal_conf and 
												left.edge_gmt_offset = right.edge_gmt_offset and 
												left.edge_in_dst = right.edge_in_dst and 
												left.edge_timezone_name = right.edge_timezone_name and 
												left.sic_code = right.sic_code and 
												left.domain_name = right.domain_name and 
												left.isp_name = right.isp_name and 
												left.homebiz_type = right.homebiz_type and 
												left.asn = right.asn and 
												left.asn_name = right.asn_name and 
												left.primary_lang = right.primary_lang and 
												left.secondary_lang = right.secondary_lang and 
												left.proxy_type = right.proxy_type and 
												left.proxy_description = right.proxy_description and 
												left.is_an_isp = right.is_an_isp and 
												left.company_name = right.company_name and 
												left.ranks = right.ranks and 
												left.households = right.households and 
												left.women = right.women and 
												left.w18_34 = right.w18_34 and 
												left.w35_49 = right.w35_49 and 
												left.men = right.men and 
												left.m18_34 = right.m18_34 and 
												left.m35_49 = right.m35_49 and 
												left.teens = right.teens and 
												left.kids = right.kids and 
												left.naics_code = right.naics_code and 
												left.cbsa_code = right.cbsa_code and 
												left.cbsa_title = right.cbsa_title and 
												left.cbsa_type = right.cbsa_type and 
												left.csa_code = right.csa_code and 
												left.csa_title = right.csa_title and 
												left.md_code = right.md_code and 
												left.md_title = right.md_title and 
												left.organization_name = right.organization_name,
												compDeactF(left, right), right only, local);

		//Keep all activity
		allRec		:= activeRec + deactivRec + srtOldRec(is_current=FALSE);
return dedup(sort(distribute(allRec, hash(ip_rng_beg_full, ip_rng_end_full)), ip_rng_beg_full, ip_rng_end_full, -dt_last_seen, local), record, local);

end;