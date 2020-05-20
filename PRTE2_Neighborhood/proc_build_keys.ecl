IMPORT PRTE, PRTE2, PRTE2_Neighborhood, PRTE2_Common, roxiekeybuild, ut, VersionControl, _control, Orbit3, dops;

EXPORT proc_build_keys (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

//Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.aca_geolink, Constants.KEY_PREFIX + 'aca_institutions_geolink', Constants.KEY_PREFIX + filedate +'::aca_institutions_geolink', aca_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.businesses_geolink, Constants.KEY_PREFIX + 'businesses_geolink', Constants.KEY_PREFIX + filedate +'::businesses_geolink', business_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.sexoffender_geolink, Constants.KEY_PREFIX + 'sex_offender_geolink', Constants.KEY_PREFIX + filedate +'::sex_offender_geolink', sexoff_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.school_geolink, Constants.KEY_PREFIX + 'schools::geolink', Constants.KEY_PREFIX + filedate +'::schools::geolink', schools_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.colleges_geolink, Constants.KEY_PREFIX + 'colleges::geolink', Constants.KEY_PREFIX + filedate +'::colleges::geolink', colleges_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.FireDepartment_geolink, Constants.KEY_PREFIX + 'fire_department_geolink', Constants.KEY_PREFIX + filedate +'::fire_department_geolink', fd_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Neighborhood.Keys.LawEnforcement_geolink, Constants.KEY_PREFIX + 'law_enforcement_geolink', Constants.KEY_PREFIX + filedate +'::law_enforcement_geolink', le_key);

build_roxie_keys := parallel(aca_key, business_key, sexoff_key, schools_key, colleges_key, fd_key, le_key);

// Move Keys
//Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::aca_institutions_geolink', Constants.KEY_PREFIX + filedate +'::aca_institutions_geolink',mv_aca_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::neighborhoodstats::geolink', Constants.KEY_PREFIX + filedate +'::neighborhoodstats::geolink',mv_stats_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::businesses_geolink', Constants.KEY_PREFIX + filedate +'::businesses_geolink',mv_business_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::sex_offender_geolink', Constants.KEY_PREFIX + filedate +'::sex_offender_geolink',mv_sexoff_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::schools::geolink', Constants.KEY_PREFIX + filedate +'::schools::geolink',mv_schools_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::colleges::geolink', Constants.KEY_PREFIX + filedate +'::colleges::geolink',mv_colleges_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::fbi_cius_city::address', Constants.KEY_PREFIX + filedate +'::fbi_cius_city::address',mv_cius_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::fire_department_geolink', Constants.KEY_PREFIX + filedate +'::fire_department_geolink',mv_fd_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::law_enforcement_geolink', Constants.KEY_PREFIX + filedate +'::law_enforcement_geolink',mv_le_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::geolink_to_geolink::geolink_dist_100th', Constants.KEY_PREFIX + filedate +'::geolink_to_geolink::geolink_dist_100th',mv_geodist_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::geoblk_latlon', Constants.KEY_PREFIX + filedate +'::geoblk_latlon',mv_latlon_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::geoblk_info_geolink', Constants.KEY_PREFIX + filedate +'::geoblk_info_geolink',mv_geoinfo_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::crime::geolink', Constants.KEY_PREFIX + filedate +'::crime::geolink',mv_crime_key);

move_keys	:=	parallel(mv_aca_key, mv_stats_key, mv_business_key, mv_sexoff_key, mv_schools_key, 
                       mv_colleges_key, mv_cius_key, mv_fd_key, mv_le_key, mv_geodist_key, mv_latlon_key, 
                       mv_geoinfo_key, mv_crime_key);


//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::aca_institutions_geolink','Q', mv_aca_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::neighborhoodstats::geolink','Q', mv_stats_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::businesses_geolink','Q', mv_business_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::sex_offender_geolink','Q', mv_sexoff_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::schools::geolink','Q', mv_schools_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::colleges::geolink','Q', mv_colleges_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::fbi_cius_city::address','Q', mv_cius_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::fire_department_geolink','Q', mv_fd_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::law_enforcement_geolink','Q', mv_le_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::geolink_to_geolink::geolink_dist_100th','Q', mv_geodist_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::geoblk_latlon','Q', mv_latlon_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::geoblk_info_geolink','Q', mv_geoinfo_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::crime::geolink','Q', mv_crime_QA);

move_to_qa	:=	parallel(mv_aca_QA, mv_stats_QA, mv_business_QA, mv_sexoff_QA, mv_schools_QA, mv_colleges_QA, mv_cius_QA, 
                       mv_fd_QA, mv_le_QA, mv_geodist_QA, mv_latlon_QA, mv_geoinfo_QA, mv_crime_QA);


//Make a copy of Prod key for prte::key::neighborhood::crime::geolink key
copy_key  := PRTE2_Neighborhood.Copy_Seeds(filedate);

//---------- making DOPS optional and only in PROD build -------------------------------

  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('NeighborhoodKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - NeighborhoodKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.  ipaddr_prod, 'NeighborhoodKeys', 'N'));

// -- Actions
buildKey  :=  sequential(
                          build_roxie_keys,
                          copy_key,
                          move_keys,
                          move_to_qa,
                          PerformUpdateOrNot,
                          ORBIT_Update,
                          Key_Validation
                        );

RETURN  buildKey;
END;


