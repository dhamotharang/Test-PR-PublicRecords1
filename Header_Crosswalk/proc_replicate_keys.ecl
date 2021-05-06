// Replicate keys built in BOCA to Alpha and HC environment
EXPORT proc_replicate_keys(str_version) := FUNCTIONMACRO
  IMPORT _Control;
  IMPORT Workman;
  IMPORT WsWorkunits;
  IMPORT STD;
  IMPORT tools;
  IMPORT dx_Header_Crosswalk;
  IMPORT Header_Crosswalk;

  // Generate STD.File.Copy code for copying @str_filename to @str_target_cluster
  STRING fn_copyFromBoca(STRING str_filename, STRING str_target_cluster) := FUNCTION
      // Delete older version. Backups will be available on building environment
      str_sf := 'IF(STD.File.SuperFileExists(' + '\'' + str_filename + '\'' + '), STD.File.ClearSuperFile('+ '\'' + str_filename + '\'' + ', del := TRUE));';
      str_copy := 'STD.File.Copy('
        + 'sourceLogicalName := \'' + str_filename + '\','
        + 'destinationLogicalName := \'' + str_filename + '\','
        + 'destinationGroup := \'' + str_target_cluster + '\','
        + 'sourceDali := \'' + _Control.IPAddress.prod_thor_dali + ':7070\','
        + 'asSuperfile := TRUE,'
        + 'preserveCompression := TRUE'
        + 'allowOverwrite := TRUE' // Copy the superfile again, with new content
      + ');';

      RETURN 'SEQUENTIAL('
      + str_sf
      + str_copy
      + ');';
  END;
  
  // Stage 1) Trigger copy process in Alpha Prod

  str_log_alpha := '~thor::header_crosswalk::copy_log::alpha::' + str_version;
  proc_alpha_copy := Workman.mac_WorkMan(
    pECL := 'IMPORT STD, dops; SEQUENTIAL('
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lnpid_2_lexid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lexid_2_lnpid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lexid_2_seleid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_seleid_2_lexid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_seleid_2_lnpid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lnpid_2_seleid, 'thor400_112')
    // DOPS update
    + Header_Crosswalk.mod_build_update.fn_update_dops(str_version, Header_Crosswalk.Constants.str_dops_non_fcra_environment)
    + ');',
    pStartIteration := 1,
    pNumMaxIterations := 1,
    pversion := str_version,
    pcluster := Header_Crosswalk.Constants.str_alpha_target,
    pNotifyEmails := Header_Crosswalk.Constants.str_default_email_list,
    pESP := Header_Crosswalk.Constants.str_alpha_esp,
    pOutputFilename := Header_Crosswalk.Constants.str_copy_sf + '::' + str_version + '::alpha',
    pOutputSuperfile := Header_Crosswalk.Constants.str_copy_sf
  );

  // Stage 2) Trigger copy process in HC Prod
  str_log_hc := '~thor::header_crosswalk::copy_log::hc::' + str_version;
  proc_hc_copy := Workman.mac_WorkMan(
    pECL := 'IMPORT STD, dops; SEQUENTIAL('
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lnpid_2_lexid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lexid_2_lnpid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lexid_2_seleid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_seleid_2_lexid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_seleid_2_lnpid, 'thor400_112')
    + fn_copyFromBoca(dx_Header_Crosswalk.Names.str_lnpid_2_seleid, 'thor400_112')
    // DOPS update
    + Header_Crosswalk.mod_build_update.fn_update_dops(str_version, Header_Crosswalk.Constants.str_dops_hc_environment)
    + ');',
    pStartIteration := 1,
    pNumMaxIterations := 1,
    pversion := str_version,
    pcluster := Header_Crosswalk.Constants.str_hc_target,
    pNotifyEmails := Header_Crosswalk.Constants.str_default_email_list,
    pESP := Header_Crosswalk.Constants.str_hc_esp,
    pOutputFilename := Header_Crosswalk.Constants.str_copy_sf + '::' + str_version + '::hc',
    pOutputSuperfile := Header_Crosswalk.Constants.str_copy_sf
  );

  RETURN PARALLEL(
    proc_alpha_copy;
    proc_hc_copy;
  );

ENDMACRO;