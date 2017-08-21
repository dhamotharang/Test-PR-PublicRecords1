export BWR_Build_Idx_Example := 'todo';




STRING F_uip_location_std := '~g2::uip_location_std';
STRING F_uip_location_std_idx := '~g2::uip_location_std_idx_test';

L_uip_location_std := RECORD
  string30 ip;
  string30 country_code;
  string30 country_name;
  string30 region;
  string30 city;
  string30 latitude;
  string30 longitude;
  string60 isp_name;
  string60 domain_name;
END;

DS_Ip_location_std := DATASET('~g2::uip_location_std',L_uip_location_std, THOR);

IDX_uip_location_std := INDEX(
	DATASET(F_uip_location_std, {L_uip_location_std; UNSIGNED8 fpos {virtual(fileposition)}},	FLAT), 
	{Ip}, 
	{country_code, country_name, region, city, latitude, longitude, isp_name, domain_name, fpos},
	F_uip_location_std_idx
);
								
BUILDINDEX(IDX_uip_location_std, OVERWRITE);