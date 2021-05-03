import doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_search_delta_rid
// ---------------------------------------------------------------

df := Prof_License_Mari.file_mari_search(license_nbr != '' and license_nbr != 'NR');

KeyName := 'thor_data400::key::proflic_mari::';

Prof_License_Mari.layouts.final  	xformLicense(Prof_License_Mari.layouts.final L) := transform
  //Filter out leading zeroes, leading alphas, trailing alphas, and trailing zeoroes w/ seperator(.-*/)
  // self.license_nbr				:= Prof_license_mari.fCleanLicenseNbr(trim(L.license_nbr));
  
  // Blank out DEFAULT DATE
  self.CURR_ISSUE_DTE 		:= IF(L.curr_issue_dte = '17530101','',L.curr_issue_dte);
  self.ORIG_ISSUE_DTE			:= IF(L.orig_issue_dte = '17530101','',L.orig_issue_dte);
  self.EXPIRE_DTE					:= IF(L.expire_dte = '17530101','',L.expire_dte);	
  self.INST_BEG_DTE				:= IF(L.inst_beg_dte = '17530101','',L.inst_beg_dte);
  self.START_DTE					:= IF(L.START_DTE = '17530101','',L.start_dte);
  // self.STATUS_EFFECT_DTE 	:= IF(L.status_effect_dte = '17530101','',L.status_effect_dte);
  self	:=L;
end;

ds_license_nbr := project(df, xformLicense(left));
dsLicenseNbr_dedup := dedup(ds_license_nbr ,RECORD);
dsLicenseNbr_filter := dsLicenseNbr_dedup(cln_license_nbr != '');

export key_license_nbr := 	index(dsLicenseNbr_filter
                                  ,{cln_license_nbr, license_state}
                                  ,{dsLicenseNbr_filter} - enh_did_src
                                  ,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::license_nbr');
