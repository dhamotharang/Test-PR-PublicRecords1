import	_control, PRTE_CSV;

export Proc_Build_Neighborhood_Keys (string pIndexVersion) := function 

	rKey_neighborhood_aca_institutions_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_aca_institutions_geolink;
	end;
	
dKey_neighborhood_aca_institutions_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_aca_institutions_geolink, rKey_neighborhood_aca_institutions_geolink);
kKey_neighborhood_aca_institutions_geolink	:=	index(dKey_neighborhood_aca_institutions_geolink,{geolink}, {dKey_neighborhood_aca_institutions_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::aca_institutions_geolink'); 

	rKey_neighborhood_advo_neighborhoodstats_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_advo_neighborhoodstats_geolink;
	end;
	
dKey_neighborhood_advo_neighborhoodstats_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_advo_neighborhoodstats_geolink, rKey_neighborhood_advo_neighborhoodstats_geolink);
kKey_neighborhood_advo_neighborhoodstats_geolink	:=	index(dKey_neighborhood_advo_neighborhoodstats_geolink,{geolink}, {dKey_neighborhood_advo_neighborhoodstats_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::advo_neighborhoodstats::geolink'); 

	rKey_neighborhood_businesses_addr :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_businesses_addr;
	end;
	
dKey_neighborhood_businesses_addr	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_businesses_addr, rKey_neighborhood_businesses_addr);
kKey_neighborhood_businesses_addr	:=	index(dKey_neighborhood_businesses_addr,{zip,prim_range,prim_name,addr_suffix,predir}, {dKey_neighborhood_businesses_addr}, '~prte::key::neighborhood::' + pIndexVersion + '::businesses_addr'); 

	rKey_neighborhood_businesses_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_businesses_geolink;
	end;
	
dKey_neighborhood_businesses_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_businesses_geolink, rKey_neighborhood_businesses_geolink);
kKey_neighborhood_businesses_geolink	:=	index(dKey_neighborhood_businesses_geolink,{geolink,bdid}, {dKey_neighborhood_businesses_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::businesses_geolink');  

	rKey_neighborhood_colleges_address :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_colleges_address;
	end;
	
dKey_neighborhood_colleges_address	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_colleges_address, rKey_neighborhood_colleges_address);
kKey_neighborhood_colleges_address	:=	index(dKey_neighborhood_colleges_address,{zip,prim_range,prim_name}, {dKey_neighborhood_colleges_address}, '~prte::key::neighborhood::' + pIndexVersion + '::colleges::address');  
  
	rKey_neighborhood_colleges_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_colleges_geolink;
	end;
	
dKey_neighborhood_colleges_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_colleges_geolink, rKey_neighborhood_colleges_geolink);
kKey_neighborhood_colleges_geolink	:=	index(dKey_neighborhood_colleges_geolink,{geolink}, {dKey_neighborhood_colleges_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::colleges::geolink');  

	rKey_neighborhood_crime_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_crime_geolink;
	end;
	
dKey_neighborhood_crime_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_crime_geolink, rKey_neighborhood_crime_geolink);
kKey_neighborhood_crime_geolink	:=	index(dKey_neighborhood_crime_geolink,{geolink}, {dKey_neighborhood_crime_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::crime::geolink');  

	rKey_neighborhood_fbi_cius_city_address :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_fbi_cius_city_address;
	end;
	
dKey_neighborhood_fbi_cius_city_address	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_fbi_cius_city_address, rKey_neighborhood_fbi_cius_city_address);
kKey_neighborhood_fbi_cius_city_address	:=	index(dKey_neighborhood_fbi_cius_city_address,{state,city}, {dKey_neighborhood_fbi_cius_city_address}, '~prte::key::neighborhood::' + pIndexVersion + '::fbi_cius_city::address');  

	rKey_neighborhood_fire_department_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_fire_department_geolink;
	end;
	
dKey_neighborhood_fire_department_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_fire_department_geolink, rKey_neighborhood_fire_department_geolink);
kKey_neighborhood_fire_department_geolink	:=	index(dKey_neighborhood_fire_department_geolink,{geolink}, {dKey_neighborhood_fire_department_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::fire_department_geolink');

	rKey_neighborhood_geoblk_info_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geoblk_info_geolink;
	end;
	
dKey_neighborhood_geoblk_info_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geoblk_info_geolink, rKey_neighborhood_geoblk_info_geolink);
kKey_neighborhood_geoblk_info_geolink	:=	index(dKey_neighborhood_geoblk_info_geolink,{geolink}, {dKey_neighborhood_geoblk_info_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::geoblk_info_geolink');   
  
	rKey_neighborhood_geoblk_latlon :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geoblk_latlon;
	end;
	
dKey_neighborhood_geoblk_latlon	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geoblk_latlon, rKey_neighborhood_geoblk_latlon);
kKey_neighborhood_geoblk_latlon	:=	index(dKey_neighborhood_geoblk_latlon,{lat1000}, {dKey_neighborhood_geoblk_latlon}, '~prte::key::neighborhood::' + pIndexVersion + '::geoblk_latlon');   

	rKey_neighborhood_geolink_to_geolink_geolink1geolink2 :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geolink_to_geolink_geolink1geolink2;
	end;
	
dKey_neighborhood_geolink_to_geolink_geolink1geolink2	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geolink_to_geolink_geolink1geolink2, rKey_neighborhood_geolink_to_geolink_geolink1geolink2);
kKey_neighborhood_geolink_to_geolink_geolink1geolink2	:=	index(dKey_neighborhood_geolink_to_geolink_geolink1geolink2,{geolink1,geolink2}, {dKey_neighborhood_geolink_to_geolink_geolink1geolink2}, '~prte::key::neighborhood::' + pIndexVersion + '::geolink_to_geolink::geolink1geolink2');   

	rKey_neighborhood_geolink_to_geolink_geolink_dist_100th :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geolink_to_geolink_geolink_dist_100th;
	end;
	
dKey_neighborhood_geolink_to_geolink_geolink_dist_100th	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_geolink_to_geolink_geolink_dist_100th, rKey_neighborhood_geolink_to_geolink_geolink_dist_100th);
kKey_neighborhood_geolink_to_geolink_geolink_dist_100th	:=	index(dKey_neighborhood_geolink_to_geolink_geolink_dist_100th,{geolink1,dist_100th}, {dKey_neighborhood_geolink_to_geolink_geolink_dist_100th}, '~prte::key::neighborhood::' + pIndexVersion + '::geolink_to_geolink::geolink_dist_100th');   

	rKey_neighborhood_law_enforcement_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_law_enforcement_geolink;
	end;
	
dKey_neighborhood_law_enforcement_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_law_enforcement_geolink, rKey_neighborhood_law_enforcement_geolink);
kKey_neighborhood_law_enforcement_geolink	:=	index(dKey_neighborhood_law_enforcement_geolink,{geolink},{dKey_neighborhood_law_enforcement_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::law_enforcement_geolink');   

	rKey_neighborhood_liens_evictions_address :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_liens_evictions_address;
	end;
	
dKey_neighborhood_liens_evictions_address	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_liens_evictions_address, rKey_neighborhood_liens_evictions_address);
kKey_neighborhood_liens_evictions_address	:=	index(dKey_neighborhood_liens_evictions_address,{zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range},{dKey_neighborhood_liens_evictions_address}, '~prte::key::neighborhood::' + pIndexVersion + '::liens_evictions::address');   

	rKey_neighborhood_national_2000_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_national_2000_geolink;
	end;
	
dKey_neighborhood_national_2000_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_national_2000_geolink, rKey_neighborhood_national_2000_geolink);
kKey_neighborhood_national_2000_geolink	:=	index(dKey_neighborhood_national_2000_geolink,{geolink},{dKey_neighborhood_national_2000_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::national_2000::geolink');   

	rKey_neighborhood_neighborhoodsfdstats_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_neighborhoodsfdstats_geolink;
	end;
	
dKey_neighborhood_neighborhoodsfdstats_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_neighborhoodsfdstats_geolink, rKey_neighborhood_neighborhoodsfdstats_geolink);
kKey_neighborhood_neighborhoodsfdstats_geolink	:=	index(dKey_neighborhood_neighborhoodsfdstats_geolink,{geolink},{dKey_neighborhood_neighborhoodsfdstats_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::neighborhoodsfdstats::geolink');   
               
	rKey_neighborhood_neighborhoodstats_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_neighborhoodstats_geolink;
	end;
	
dKey_neighborhood_neighborhoodstats_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_neighborhoodstats_geolink, rKey_neighborhood_neighborhoodstats_geolink);
kKey_neighborhood_neighborhoodstats_geolink	:=	index(dKey_neighborhood_neighborhoodstats_geolink,{geolink},{dKey_neighborhood_neighborhoodstats_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::neighborhoodstats::geolink');   

	rKey_neighborhood_schools_address :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_schools_address;
	end;
	
dKey_neighborhood_schools_address	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_schools_address, rKey_neighborhood_schools_address);
kKey_neighborhood_schools_address	:=	index(dKey_neighborhood_schools_address,{geolink},{dKey_neighborhood_schools_address}, '~prte::key::neighborhood::' + pIndexVersion + '::schools::address');   

	rKey_neighborhood_schools_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_schools_geolink;
	end;
	
dKey_neighborhood_schools_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_schools_geolink, rKey_neighborhood_schools_geolink);
kKey_neighborhood_schools_geolink	:=	index(dKey_neighborhood_schools_geolink,{geolink},{dKey_neighborhood_schools_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::schools::geolink');   

	rKey_neighborhood_sex_offender_geolink :=
	record
		PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_sex_offender_geolink;
	end;
	
dKey_neighborhood_sex_offender_geolink	:= 	project(PRTE_CSV.Neighborhood.dthor_data400_key_neighborhood_sex_offender_geolink, rKey_neighborhood_sex_offender_geolink);
kKey_neighborhood_sex_offender_geolink	:=	index(dKey_neighborhood_sex_offender_geolink,{geolink},{dKey_neighborhood_sex_offender_geolink}, '~prte::key::neighborhood::' + pIndexVersion + '::sex_offender_geolink');   
                     
return	sequential(
														parallel(
																build(kKey_neighborhood_aca_institutions_geolink							, update),
																build(kKey_neighborhood_advo_neighborhoodstats_geolink				, update),
																build(kKey_neighborhood_businesses_addr												, update),
																build(kKey_neighborhood_businesses_geolink										, update),
																build(kKey_neighborhood_colleges_address											, update),
																build(kKey_neighborhood_colleges_geolink											, update),
																build(kKey_neighborhood_crime_geolink													, update),
																build(kKey_neighborhood_fbi_cius_city_address									, update),
																build(kKey_neighborhood_fire_department_geolink								, update),
																build(kKey_neighborhood_geoblk_info_geolink										, update),
																build(kKey_neighborhood_geoblk_latlon													, update),
																build(kKey_neighborhood_geolink_to_geolink_geolink1geolink2		, update),
																build(kKey_neighborhood_geolink_to_geolink_geolink_dist_100th	, update),
																build(kKey_neighborhood_law_enforcement_geolink								, update),
																build(kKey_neighborhood_liens_evictions_address								, update),
																build(kKey_neighborhood_national_2000_geolink									, update),
																build(kKey_neighborhood_neighborhoodsfdstats_geolink					, update),
																build(kKey_neighborhood_neighborhoodstats_geolink							, update),
																build(kKey_neighborhood_schools_address												, update),
																build(kKey_neighborhood_schools_geolink												, update),
																build(kKey_neighborhood_sex_offender_geolink									, update)
																),

   											PRTE.UpdateVersion('NeighborhoodKeys',									//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																					 ),
								);								 
end;

