import std, ut;

//Creates the IP_Metadata Base File & Maintains History of Changes
//Only the "Current" Records are Exposed in the Key

EXPORT Map_IP_Metadata(string8 version) := function

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Cleanup Fields////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	inFile := IP_Metadata.File_IP_Metadata.Raw;

	Layout_IP_Metadata.Base trFile(inFile L):= transform
		self.dt_first_seen						:= version;
		self.dt_last_seen							:= version;
		
		beg_octets 										:= Std.Str.SplitWords(l.ip_rng_beg,'.');
		self.beg_octet1 							:= (unsigned)beg_octets[1];
		self.beg_octet2 							:= (unsigned)beg_octets[2];
		self.beg_octets34 						:= _Functions.IPv4toInt(l.ip_rng_beg);
		end_octets 										:= Std.Str.SplitWords(l.ip_rng_end,'.');
		self.end_octet1 							:= (unsigned)end_octets[1];
		self.end_octet2 							:= (unsigned)end_octets[2];
		self.end_octets34 						:= _Functions.IPv4toInt(l.ip_rng_end);
		self.ip_rng_beg 							:= _Functions.clNum(l.ip_rng_beg);
		self.ip_rng_end 							:= _Functions.clNum(l.ip_rng_end);
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

		//Expand beg_octet1!=end_octet1
		expRecs1				:= _Functions.expandRanges(cleanRec(beg_octet1!=end_octet1),1);
		rsltRecs1				:= expRecs1(beg_octet1=end_octet1,beg_octet2=end_octet2);	
	
		//Expand beg_octet2!=end_octet2
		concatExpRecs2 	:= cleanRec(beg_octet1=end_octet1,beg_octet2!=end_octet2) + 
											 expRecs1(beg_octet1=end_octet1,beg_octet2!=end_octet2);	
											
		rsltRecs2				:= _Functions.expandRanges(concatExpRecs2,2);

		//Same beg_octet1=end_octet1 and beg_octet2=end_octet2
		rsltRecSame			:= cleanRec(beg_octet1=end_octet1,beg_octet2=end_octet2);

		//Concat results
		expandRec				:= rsltRecs1 + rsltRecs2 + rsltRecSame;
		ddExpRec				:= dedup(sort(distribute(expandRec, hash(ip_rng_beg, ip_rng_end)), record, local), record, local);

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Compare Previous File Against New File////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		srtNewRec				:= sort(distribute(ddExpRec, hash(ip_rng_beg, ip_rng_end)), ip_rng_beg, ip_rng_end, -dt_last_seen, local);
		srtOldRec				:= sort(distribute(IP_Metadata.File_IP_Metadata.Base, hash(ip_rng_beg, ip_rng_end)), ip_rng_beg, ip_rng_end, -dt_last_seen, local); 

		//Flag existing and new records as "current"	
		Layout_IP_Metadata.Base compActF(srtNewRec l, srtOldRec r):= transform
			self.dt_first_seen:= (string)(ut.min2((unsigned)l.dt_first_seen, (unsigned)r.dt_first_seen));
			self.dt_last_seen	:= max(l.dt_last_seen, r.dt_last_seen);
			self.is_current		:= TRUE;
			self 							:= l;
		end;

		activeRec 	:= join(srtNewRec, srtOldRec(is_current=TRUE),
												left.ip_rng_beg = right.ip_rng_beg and
												left.ip_rng_end = right.ip_rng_end and 
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
		Layout_IP_Metadata.Base compDeactF(srtNewRec l, srtOldRec r):= transform
			self.dt_last_seen	:= r.dt_last_seen;
			self.is_current		:= FALSE;
			self 							:= r;
		end;

		deactivRec 	:= join(srtNewRec, srtOldRec(is_current=TRUE),
												left.ip_rng_beg = right.ip_rng_beg and
												left.ip_rng_end = right.ip_rng_end and
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

return dedup(sort(distribute(allRec, hash(ip_rng_beg, ip_rng_end)), record, local), record, local);

end;