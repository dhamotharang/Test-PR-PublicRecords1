import roxiekeybuild,Address_Attributes, addrfraud,FBI_UCR,Orbit3;

export proc_CensusNeighborhood_buildkey(string filedate) := function

  #OPTION('multiplePersistInstances',FALSE);
  #uniquename(version_date)
  %version_date% := filedate;

//Monthly Neighborhood Keys

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_ACA_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::aca_institutions_geolink', 
										  '~thor_data400::key::neighborhood::@version@::aca_institutions_geolink',a1, '2')
											

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_Neighborhood_Stats_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::neighborhoodstats::geolink', 
										  '~thor_data400::key::neighborhood::@version@::neighborhoodstats::geolink', a2, '2')
	
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_businesses_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::businesses_geolink', 
										  '~thor_data400::key::neighborhood::@version@::businesses_geolink',a3, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_businesses_addr,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::businesses_addr', 
										  '~thor_data400::key::neighborhood::@version@::businesses_addr', a4, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_crime_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::crime::geolink', 
										  '~thor_data400::key::neighborhood::@version@::crime::geolink',a5a, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_sexoffender_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::sex_offender_geolink', 
										  '~thor_data400::key::neighborhood::@version@::sex_offender_geolink',a5, '2')


RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_liens_address,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::liens_evictions::address', 
										  '~thor_data400::key::neighborhood::@version@::liens_evictions::address',a7, '2')											

RoxieKeyBuild.MAC_SK_BuildProcess_Local(address_attributes.key_ADVO_Neighborhood_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::advo_neighborhoodstats::geolink', 
										  '~thor_data400::key::neighborhood::@version@::advo_neighborhoodstats::geolink',a8, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_nbrhd_sfd_stats_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::neighborhoodsfdstats::geolink', 
										  '~thor_data400::key::neighborhood::@version@::neighborhoodsfdstats::geolink',a9, '2')

//Annual Neighborhood Keys

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_School_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::schools::geolink', 
										  '~thor_data400::key::neighborhood::@version@::schools::geolink', a10, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_school_addr,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::schools::address', 
										  '~thor_data400::key::neighborhood::@version@::schools::address',a11, '2');

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_Colleges_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::colleges::geolink', 
										  '~thor_data400::key::neighborhood::@version@::colleges::geolink', a12, '2');
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_colleges_addr,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::colleges::address', 
										  '~thor_data400::key::neighborhood::@version@::colleges::address', a13, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_FireDepartment_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::fire_department_geolink', 
										  '~thor_data400::key::fire_department_geolink_@version@',a14, '2');

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_LawEnforcement_geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::law_enforcement_geolink', 
										  '~thor_data400::key::neighborhood::@version@::law_enforcement_geolink', a15, '2');											
											

//NON-UPDATING Neighborhood Keys

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_national_geolinks,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::national_2000::geolink', 
										  '~thor_data400::key::neighborhood::@version@::national_2000::geolink', a16, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(AddrFraud.Key_GeoLinkDistance_GeoLink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink_dist_100th', 
										  '~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th_@version@',a17, '2');

RoxieKeyBuild.MAC_SK_BuildProcess_Local(AddrFraud.Key_Distance_GeoLinkToGeoLink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink1geolink2', 
										  '~thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2_@version@', a18, '2');
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(AddrFraud.Key_GeoLink_LatLon,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geoblk_latlon', 
										  '~thor_data400::key::addrfraud::geoblk_latlon_@version@', a19, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(AddrFraud.Key_GeoInfo_Geolink,
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geoblk_info_geolink', 
										  '~thor_data400::key::addrfraud::geoblk_info_geolink_@version@',a20, '2');

RoxieKeyBuild.MAC_SK_BuildProcess_Local(FBI_UCR.key_CIUS_city_addr,
										  '~thor_Data400::key::neighborhood::'+%version_date%+'::fbi_cius_city::address', 
										  '~thor_data400::key::neighborhood::@version@::fbi_cius_city::address',a21, '2');
								
				
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::aca_institutions_geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::aca_institutions_geolink',b1, '2')
									
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::neighborhoodstats::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::neighborhoodstats::geolink', b2, '2')
	
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::businesses_geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::businesses_geolink',b3, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::businesses_addr', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::businesses_addr', b4, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::crime::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::crime::geolink',b5a, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::sex_offender_geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::sex_offender_geolink',b5, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::liens_evictions::address', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::liens_evictions::address',b7, '2')											

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::advo_neighborhoodstats::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::advo_neighborhoodstats::geolink',b8, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::neighborhoodsfdstats::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::neighborhoodsfdstats::geolink',b9, '2')


//Move Annual Neighborhood Keys

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::schools::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::schools::geolink', b10, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::schools::address', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::schools::address',b11, '2');

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::colleges::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::colleges::geolink', b12, '2');
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::colleges::address', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::colleges::address', b13, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::fire_department_geolink_@version@', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::fire_department_geolink',b14, '2');

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::law_enforcement_geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::law_enforcement_geolink', b15, '2');											
											


//Move NON-UPDATING Neighborhood Keys

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::national_2000::geolink', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::national_2000::geolink', b16, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th_@version@', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink_dist_100th',b17, '2');

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2_@version@', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink1geolink2', b18, '2');
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::addrfraud::geoblk_latlon_@version@', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geoblk_latlon', b19, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::addrfraud::geoblk_info_geolink_@version@', 
										  '~thor_data400::key::neighborhood::'+%version_date%+'::geoblk_info_geolink',b20, '2');	 

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::neighborhood::@version@::fbi_cius_city::address', 
										  '~thor_Data400::key::neighborhood::'+%version_date%+'::fbi_cius_city::address',b21, '2');	 


//Move Monthly Neighborhood Keys
				
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::aca_institutions_geolink','Q',move1)						
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::neighborhoodstats::geolink','Q',move2)	
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::businesses_geolink','Q',move3)
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::businesses_addr','Q',move4)	
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::crime::geolink','Q',move5a)										
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::sex_offender_geolink','Q',move5)
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::liens_evictions::address','Q',move7)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::advo_neighborhoodstats::geolink','Q',move8)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::neighborhoodsfdstats::geolink','Q',move9)
	
	

//Annual Neighborhood Keys

RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::schools::geolink','Q', move10)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::schools::address','Q',move11);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::colleges::geolink','Q', move12);											
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::colleges::address','Q', move13)										
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fire_department_geolink_@version@','Q',move14);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::law_enforcement_geolink','Q', move15);					


//NON-UPDATING Neighborhood Keys

RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::national_2000::geolink','Q', move16)										
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th_@version@','Q',move17);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2_@version@','Q', move18);											
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::addrfraud::geoblk_latlon_@version@','Q', move19)								
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::addrfraud::geoblk_info_geolink_@version@','Q',move20);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::neighborhood::@version@::fbi_cius_city::addres','Q',move21);

  
full1 := 	sequential(parallel(a1,a2,a3,a4,a5a,a5,sequential(a7,b7,move7),sequential(a8,b8,move8,a9),a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21),
										 parallel(b1,b2,b3,b4,b5a,b5,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21));	

	move_qa	:=	parallel(move1,move2,move3,move4,move5a,move5,move9,move10,
											 move11,move12,move13,move14,move15,move16,move17,move18,move19,move20,move21);

     UpdateRoxiePage := RoxieKeybuild.updateversion('NeighborhoodKeys',filedate, 'Christopher.Brodeur@lexisnexisrisk.com;Charles.Pettola@lexisnexisrisk.com',,'N');

     create_orbit_build:= Orbit3.proc_Orbit3_CreateBuild ('Neighborhood',filedate,'N');
		 
build_all := sequential(full1,move_qa,UpdateRoxiePage,create_orbit_build) : //,parallel(UpdateRoxiePage));

SUCCESS(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com', 'Neighborhood Keybuild Complete', WORKUNIT)),
Failure(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com', 'Neighborhood Keybuild Failure',WORKUNIT + '\n' + FAILMESSAGE));

		 
return build_all;
END;										