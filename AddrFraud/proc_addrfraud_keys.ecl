import RoxieKeybuild , AddrFraud , ut; 
export proc_addrfraud_keys(string filedate) := function 

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_Distance_GeoLinkToGeoLink, '~thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2','~thor_data400::key::'+filedate+ '::geolink_to_geolink::geolink1geolink2',geolink1geolink2_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2','~thor_data400::key::'+filedate+ '::geolink_to_geolink::geolink1geolink2',mv_geolink1geolink2);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_GeoInfo_Geolink, '~thor_data400::key::addrfraud::geoblk_info_geolink','~thor_data400::key::'+filedate+'::geoblk_info_geolink',geoblk_info_geolink_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geoblk_info_geolink','~thor_data400::key::'+filedate+'::geoblk_info_geolink',mv_geoblk_info_geolink);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_GeoLink_LatLon, '~thor_data400::key::addrfraud::geoblk_latlon','~thor_data400::key::'+filedate+'::geoblk_latlon',geoblk_latlon_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geoblk_latlon','~thor_data400::key::'+filedate+'::geoblk_latlon',mv_geoblk_latlon);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_GeoLinkDistance_GeoLink, '~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th','~thor_data400::key::'+filedate+'::geolink_to_geolink::geolink_dist_100th',geolink_dist_100th_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th','~thor_data400::key::'+filedate+'::geolink_to_geolink::geolink_dist_100th',mv_geolink_dist_100th);


// move to qa 
ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2','Q',out1) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geoblk_info_geolink','Q',out2) ; 

ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geoblk_latlon','Q',out3) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th','Q',out4) ; 


return sequential(geolink1geolink2_blg, geoblk_info_geolink_blg,geoblk_latlon_blg,geolink_dist_100th_blg, mv_geolink1geolink2, mv_geoblk_info_geolink,mv_geoblk_latlon,mv_geolink_dist_100th,out1, out2,out3,out4); 

end; 