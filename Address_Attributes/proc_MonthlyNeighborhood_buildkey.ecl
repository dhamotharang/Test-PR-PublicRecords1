



import header,codes,did_add,didville,ut,header_slimsort,watchdog,doxie_files,roxiekeybuild,doxie, Address_Attributes, addrfraud;

export proc_MonthlyNeighborhood_buildkey(string filedate) := function
  #uniquename(version_date)
  %version_date% := filedate;

//Monthly Neighborhood Keys

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_ACA_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::aca_institutions_geolink', 
										  '~thor40_241::key::neighborhood::@version@::aca_institutions_geolink',a1, '2')
											

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_Neighborhood_Stats_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::neighborhoodstats::geolink', 
										  '~thor40_241::key::neighborhood::@version@::neighborhoodstats::geolink', a2, '2')
	
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_businesses_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::businesses_geolink', 
										  '~thor40_241::key::neighborhood::@version@::businesses_geolink',a3, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_businesses_addr,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::businesses_addr', 
										  '~thor40_241::key::neighborhood::@version@::businesses_addr', a4, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_sexoffender_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::sex_offender_geolink', 
										  '~thor40_241::key::neighborhood::@version@::sex_offender_geolink',a5, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(AddrFraud.Key_AddrFraud_GeoLink,
										  '~thor40_241::key::header::neighborhood::'+%version_date%+'::addrrisk_geolink', 
										  '~thor40_241::key::header::neighborhood::@version@::addrrisk_geolink',a6, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_liens_address,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::liens_evictions::address', 
										  '~thor40_241::key::neighborhood::@version@::liens_evictions::address',a7, '2')											

RoxieKeyBuild.MAC_SK_BuildProcess_Local(address_attributes.key_ADVO_Neighborhood_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::advo_neighborhoodstats::geolink', 
										  '~thor40_241::key::neighborhood::@version@::advo_neighborhoodstats::geolink',a8, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_nbrhd_sfd_stats_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::neighborhoodsfdstats::geolink', 
										  '~thor40_241::key::neighborhood::@version@::neighborhoodsfdstats::geolink',a9, '2')

											
//Move Monthly Neighborhood Keys
				

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::'+%version_date%+'::aca_institutions_geolink', 
										  '~thor40_241::key::neighborhood::@version@::aca_institutions_geolink',b1, '2')
									
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::neighborhoodstats::geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::neighborhoodstats::geolink', b2, '2')
	
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::businesses_geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::businesses_geolink',b3, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::businesses_addr', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::businesses_addr', b4, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::sex_offender_geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::sex_offender_geolink',b5, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::header::neighborhood::@version@::addrrisk_geolink', 
										  '~thor40_241::key::header::neighborhood::'+%version_date%+'::addrrisk_geolink',b6, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::liens_evictions::address', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::liens_evictions::address',b7, '2')											

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::advo_neighborhoodstats::geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::advo_neighborhoodstats::geolink',b8, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::neighborhoodsfdstats::geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::neighborhoodsfdstats::geolink',b9, '2')



									
full1 := 	sequential(	parallel(a1,a2,a3,a4,a5,a6,a7,a8,a9),
					  					parallel(b1,b2,b3,b4,b5,b6,b7,b8,b9)
										);					


//Move Monthly Neighborhood Keys
				
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::aca_institutions_geolink','Q',move1)						
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::neighborhoodstats::geolink','Q',move2)	
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::businesses_geolink','Q',move3)
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::businesses_addr','Q',move4)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::sex_offender_geolink','Q',move5)
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::header::neighborhood::@version@::addrrisk_geolink','Q',move6)
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::liens_evictions::address','Q',move7)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::advo_neighborhoodstats::geolink','Q',move8)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::neighborhoodsfdstats::geolink','Q',move9)
	
	
move_qa	:=	parallel(move1,move2,move3,move4,move5,move6,move7,move8,move9);


//Rename Annual and Census keys
all_superkeynames := DATASET([

{'~thor40_241::key::neighborhood::qa::schools::geolink','thor40_241::key::neighborhood::'+%version_date%+'::schools::geolink'},
{'~thor40_241::key::neighborhood::qa::schools::address','thor40_241::key::neighborhood::'+%version_date%+'::schools::address'},
{'~thor40_241::key::neighborhood::qa::colleges::geolink','thor40_241::key::neighborhood::'+%version_date%+'::colleges::geolink'},
{'~thor40_241::key::neighborhood::qa::colleges::address','thor40_241::key::neighborhood::'+%version_date%+'::colleges::address'},
{'~thor40_241::key::neighborhood::qa::fire_department::geolink','thor40_241::key::neighborhood::'+%version_date%+'::fire_department::geolink'},
{'~thor40_241::key::neighborhood::qa::law_enforcement::geolink','thor40_241::key::neighborhood::'+%version_date%+'::law_enforcement::geolink'},


{'~thor40_241::key::neighborhood::qa::national_2000::geolink','thor40_241::key::neighborhood::'+%version_date%+'::national_2000::geolink'},
{'~thor40_241::key::neighborhood::qa::geolink_to_geolink::geolink_dist_100th','thor40_241::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink_dist_100th'},
{'~thor40_241::key::neighborhood::qa::geolink_to_geolink::geolink1geolink2','thor40_241::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink1geolink2'},
{'~thor40_241::key::neighborhood::qa::geoblk::latlon','thor40_241::key::neighborhood::'+%version_date%+'::geoblk::latlon'},
{'~thor40_241::key::neighborhood::qa::geoblk_info::geolink','thor40_241::key::neighborhood::'+%version_date%+'::geoblk_info::geolink'}

], ut.Layout_Superkeynames.inputlayout);
 
 // UpdateRoxiePage := RoxieKeybuild.updateversion('NeighborhoodKeys',filedate,'Gavin.Witz@lexisNexis.com');


return sequential(full1,move_qa,ut.fLogicalKeyRenaming(all_superkeynames, false));//,parallel(UpdateRoxiePage));
END;				
									