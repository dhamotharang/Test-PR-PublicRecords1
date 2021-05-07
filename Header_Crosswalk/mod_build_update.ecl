IMPORT orbit;
IMPORT Header_Crosswalk.Constants;
IMPORT Workman;

EXPORT mod_build_update := MODULE

  /*
    - Updates orbit with @str_version
  */
  EXPORT proc_update_orbit(STRING str_version) := FUNCTION

    // Declare orbit return for @str_version
    new_orbit_build := orbit.CreateBuild(
      MasterBuildName := Constants.str_orbit_masterbuild,
      BuildName := Constants.str_orbit_build,
      BuildVersion := str_version,
      Platforms := Constants.str_orbit_platforms,
      ptoken := orbit.GetToken()
    ) : INDEPENDENT;

    BOOLEAN orbit_update_success := new_orbit_build[1].retcode = 'Success';
    STRING  orbit_update_description := new_orbit_build[1].retDesc;

    RETURN Workman.Send_Email(
      pTo := Constants.str_orbit_email_list,
      pSubject := Constants.str_orbit_build + ' Orbit Build',
      pBody := Constants.str_orbit_platforms + ' for ' + Constants.str_orbit_build + ' - Version ' + str_version + IF(orbit_update_success, ':SUCCESS', ':FAILED due to ' + orbit_update_description)
    );

  END;

  /*
    - Return dops update for @str_version as string code
  */
  EXPORT STRING fn_update_dops(STRING str_version, STRING str_environment) := FUNCTION
    RETURN 'dops.updateversion('
      + 'l_datasetname := \'' + Constants.str_dops_dataset + '\''
      + ',l_uversion := \'' + str_version + '\''
      + ',l_email_t := \'' + Constants.str_default_email_list + '\''
      + ',l_inenvment := \'' + str_environment + '\''
    + ');';
  END;

  /*
    - Updates PR dops for @str_version
  */
  EXPORT proc_update_public_records_dops(str_version) := FUNCTIONMACRO
    IMPORT dops;
    IMPORT Header_Crosswalk;
    RETURN #EXPAND(Header_Crosswalk.mod_build_update.fn_update_dops(str_version, Header_Crosswalk.Constants.str_dops_non_fcra_environment))
  ENDMACRO;

END;