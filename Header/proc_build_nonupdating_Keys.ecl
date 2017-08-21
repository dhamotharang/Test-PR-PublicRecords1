import AddrFraud,Address_Attributes,RoxieKeybuild , header , ut; 
export proc_build_nonupdating_Keys(string filedate) := function 

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_Phonetic_equivs_fname, '~thor_data400::key::hdr_phonetic_fname_top10','~thor_data400::key::header::'+filedate+'::phonetic_fname_top10',fname_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_phonetic_fname_top10','~thor_data400::key::header::'+filedate+'::phonetic_fname_top10',mv_fname);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_Phonetic_equivs_lname, '~thor_data400::key::hdr_phonetic_lname_top10','~thor_data400::key::header::'+filedate+'::phonetic_lname_top10',lname_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_phonetic_lname_top10','~thor_data400::key::header::'+filedate+'::phonetic_lname_top10',mv_lname);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_fname_ngram, '~thor_data400::key::hdr_fname_ngram','~thor_data400::key::header::'+filedate+'::fname_ngram',fname_ngram);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_fname_ngram','~thor_data400::key::header::'+filedate+'::fname_ngram',mv_fname_ngram);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_lname_ngram, '~thor_data400::key::hdr_lname_ngram','~thor_data400::key::header::'+filedate+'::lname_ngram',lname_ngram);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_lname_ngram','~thor_data400::key::header::'+filedate+'::lname_ngram',mv_lname_ngram);


RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_GeoInfo_Geolink, '~thor_data400::key::addrfraud::geoblk_info_geolink','~thor_data400::key::'+filedate+'::geoblk_info_geolink',geoblk_info_geolink_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geoblk_info_geolink','~thor_data400::key::'+filedate+'::geoblk_info_geolink',mv_geoblk_info_geolink);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_GeoLink_LatLon, '~thor_data400::key::addrfraud::geoblk_latlon','~thor_data400::key::'+filedate+'::geoblk_latlon',geoblk_latlon_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geoblk_latlon','~thor_data400::key::'+filedate+'::geoblk_latlon',mv_geoblk_latlon);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_GeoLinkDistance_GeoLink, '~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th','~thor_data400::key::'+filedate+'::geolink_to_geolink::geolink_dist_100th',geolink_dist_100th_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th','~thor_data400::key::'+filedate+'::geolink_to_geolink::geolink_dist_100th',mv_geolink_dist_100th);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Address_Attributes.key_sexoffender_geolink,
										  '~thor_data400::key::sex_offender::geolink', 
										  '~thor_data400::key::'+filedate+'::sex_offender_geolink',so_geolink)
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sex_offender::geolink','~thor_data400::key::'+filedate+'::sex_offender_geolink',mv_so_geolink);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Address_Attributes.key_FireDepartment_geolink,
										  '~thor_data400::key::fire_department_geolink', 
										  '~thor_data400::key::'+filedate+'::fire_department_geolink',fd_geolink)
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fire_department_geolink','~thor_data400::key::'+filedate+'::fire_department_geolink',mv_fd_geolink);

// move to qa 

// move to qa 
ut.MAC_SK_Move_v2('~thor_data400::key::hdr_phonetic_fname_top10','Q',out1) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::hdr_phonetic_lname_top10','Q',out2) ; 

ut.MAC_SK_Move_v2('~thor_data400::key::hdr_fname_ngram','Q',out3) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::hdr_lname_ngram','Q',out4) ; 

ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geoblk_info_geolink','Q',mv2) ; 

ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geoblk_latlon','Q',mv3) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th','Q',mv4) ;
 
ut.MAC_SK_Move_v2('~thor_data400::key::sex_offender::geolink','Q',mv5) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::fire_department_geolink','Q',mv6) ; 

update_dops := RoxieKeyBuild.updateversion('HeaderNonUpdatingKeys',filedate,'skasavajjala@seisint.com',,'N|B');


update_idops := RoxieKeyBuild.updateversion('HeaderNonUpdatingKeys',filedate,'skasavajjala@seisint.com',,'N',,,'A');


create_orbitI := Header.Proc_hdrOrbitI_Createbuild(filedate);

build_all := parallel(sequential( fname_blg, lname_blg,fname_ngram,lname_ngram, mv_fname, mv_lname,mv_fname_ngram,mv_lname_ngram,out1, out2,out3,out4),
                sequential( geoblk_info_geolink_blg,geoblk_latlon_blg,geolink_dist_100th_blg,  mv_geoblk_info_geolink,mv_geoblk_latlon,mv_geolink_dist_100th,mv2,mv3,mv4),
								sequential(so_geolink,fd_geolink,mv_so_geolink,mv_fd_geolink,mv5,mv6),update_dops/*,update_idops,create_orbitI*/): success(send_email(filedate).buildsuccess), failure(send_email(filedate).buildfailure);; 

return build_all;
end; 