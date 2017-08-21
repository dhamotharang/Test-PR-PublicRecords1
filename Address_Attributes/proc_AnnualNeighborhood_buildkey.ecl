
import header,codes,did_add,didville,ut,header_slimsort,watchdog,doxie_files,roxiekeybuild,doxie, Address_Attributes, addrfraud;

export proc_AnnualNeighborhood_buildkey(string filedate) := function
  #uniquename(version_date)
  %version_date% := filedate;

//Build Monthly Neighborhood Keys

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

//Build Annual Neighborhood Keys

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_School_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::schools::geolink', 
										  '~thor40_241::key::neighborhood::@version@::schools::geolink', a10, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_school_addr,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::schools::address', 
										  '~thor40_241::key::neighborhood::@version@::schools::address',a11, '2');

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_Colleges_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::colleges::geolink', 
										  '~thor40_241::key::neighborhood::@version@::colleges::geolink', a12, '2');
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_colleges_addr,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::colleges::address', 
										  '~thor40_241::key::neighborhood::@version@::colleges::address', a13, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_FireDepartment_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::fire_department_geolink', 
										  '~thor40_241::key::neighborhood::@version@::fire_department_geolink',a14, '2');

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Address_Attributes.key_LawEnforcement_geolink,
										  '~thor40_241::key::neighborhood::'+%version_date%+'::law_enforcement_geolink', 
										  '~thor40_241::key::neighborhood::@version@::law_enforcement_geolink', a15, '2');											
											
										
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


//Move Annual Neighborhood Keys

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::schools::geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::schools::geolink', b10, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::schools::address', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::schools::address',b11, '2');

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::colleges::geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::colleges::geolink', b12, '2');
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::colleges::address', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::colleges::address', b13, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::fire_department_geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::fire_department_geolink',b14, '2');

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor40_241::key::neighborhood::@version@::law_enforcement_geolink', 
										  '~thor40_241::key::neighborhood::'+%version_date%+'::law_enforcement_geolink', b15, '2');											
											

									
full1 := 	sequential(	parallel(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15),
					  					parallel(b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15)
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
	
	

//Move Annual Neighborhood Keys

RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::schools::geolink','Q', move10)											
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::schools::address','Q',move11);
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::colleges::geolink','Q', move12);											
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::colleges::address','Q', move13)										
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::fire_department_geolink','Q',move14);
RoxieKeyBuild.Mac_SK_Move_V2('~thor40_241::key::neighborhood::@version@::law_enforcement_geolink','Q',move15);					


	move_qa	:=	parallel(move1,move2,move3,move4,move5,move6,move7,move8,move9,move10,
											 move11,move12,move13,move14,move15);


//Rename Census keys
all_superkeynames := DATASET([

{'~thor40_241::key::neighborhood::qa::national_2000::geolink','thor40_241::key::neighborhood::'+%version_date%+'::national_2000::geolink'},
{'~thor40_241::key::neighborhood::qa::geolink_to_geolink::geolink_dist_100th','thor40_241::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink_dist_100th'},
{'~thor40_241::key::neighborhood::qa::geolink_to_geolink::geolink1geolink2','thor40_241::key::neighborhood::'+%version_date%+'::geolink_to_geolink::geolink1geolink2'},
{'~thor40_241::key::neighborhood::qa::geoblk::latlon','thor40_241::key::neighborhood::'+%version_date%+'::geoblk::latlon'},
{'~thor40_241::key::neighborhood::qa::geoblk_info::geolink','thor40_241::key::neighborhood::'+%version_date%+'::geoblk_info::geolink'}

], ut.Layout_Superkeynames.inputlayout);

    // UpdateRoxiePage := RoxieKeybuild.updateversion('NeighborhoodKeys',filedate,'Gavin.Witz@lexisNexis.com');


return sequential(full1,move_qa,ut.fLogicalKeyRenaming(all_superkeynames, false));//,parallel(UpdateRoxiePage));
END;				
					