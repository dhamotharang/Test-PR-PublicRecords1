export Index_uip_location_std := INDEX(DATASET('~g2::uip_location_std', 
								{Buzzsaw.Layout_uip_location_std; UNSIGNED8 fpos {virtual(fileposition)}},
								FLAT), {Ip}, {country_code, country_name, region, city, latitude, longitude, isp_name, domain_name, fpos},
								'~g2::uip_location_std_idx');						