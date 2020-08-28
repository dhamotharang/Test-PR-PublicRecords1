import doxie, ut, vehicle_wildcard, doxie_raw, NID, VehicleV2_Services, suppress;

// BUG# 177155 MODULE to FUNCTION with INTERFACE
EXPORT Wildcard_Search_Local(Vehicle_Wildcard.IParam.wildcardParams inMod, BOOLEAN noFail) := FUNCTION

mod_access := PROJECT(inMod, doxie.IDataAccess);
wildfile := vehicle_wildcard.file_veh_hole;

WILDFILE_READ_LIMIT := 50000; // to avoid excessive reading before postfiltering

boolean doWildTag := LENGTH(StringLib.StringFilter(inMod.LicensePlateNum,'*?')) > 0;
boolean doWildVIN := LENGTH(StringLib.StringFilter(inMod.Vin_in,'*?')) > 0;
boolean doWildZip := LENGTH(StringLib.StringFilter(inMod.Zip,'*?')) > 0;

// simplify wild inputs where possible, and detect excessive complexity
string wild_tag := ut.mod_WildSimplify.do(inMod.LicensePlateNum);
string wild_vin := ut.mod_WildSimplify.do(inMod.Vin_in);
string wild_zip := ut.mod_WildSimplify.do(inMod.Zip);
boolean wild_bad := (doWildTag and ut.mod_WildSimplify.isBad(wild_tag)) or (doWildVIN and ut.mod_WildSimplify.isBad(wild_vin)) or (doWildZip and ut.mod_WildSimplify.isBad(wild_zip));

// matching the plate #
string tag_blur := ut.blur(inMod.LicensePlateNum);
platematch :=
  MAP(inMod.LicensePlateNum='' or inMod.LicensePlateNum=wildfile.wd_plate_number => true,
    inMod.UseTagBlur      => StringLib.StringFind(ut.blur(wildfile.wd_plate_number), tag_blur, 1) > 0,
                            // blur is too loose for contains or wild; so we'll search for a substring instead and do so all the time
    inMod.containsSearch  => StringLib.StringContains(wildfile.wd_plate_number, inMod.LicensePlateNum, TRUE),
    doWildTag             => stringlib.StringWildMatch(wildfile.wd_plate_number, wild_tag, true),
    false);

// matching the VIN
vinmatch :=
  MAP(inMod.Vin_in = '' => TRUE,
    // NOTE: We don't do a "contains" search in VIN, to aid in efficiency
    doWildVIN => stringlib.StringWildMatch(wildfile.wd_VIN, wild_vin, true),
    inMod.Vin_in = wildfile.wd_VIN);

// Zip5 wildcard matching
WildZipMatch := MAP(
  doWildZip => stringlib.StringWildMatch((string5)wildfile.wd_zip, wild_zip, true),
  true);

// matching the age range
CurrentYear := IF(inMod.CurrentYear!=0,inMod.CurrentYear,(INTEGER)(stringlib.GetDateYYYYMMDD()[1..4]));
AgeFrom1900 := CurrentYear - (1900 + wildfile.wd_years_since_1900);
agematch := inMod.ageRangeStart = 0 OR inMod.ageRangeEnd = 0 OR
        (inMod.ageRangeStart-1 <= AgeFrom1900 AND
         inMod.ageRangeEnd+1 >= AgeFrom1900);

// matching the car year range
yearMatch := inMod.modelYearStart = 0 OR inMod.modelYearEnd = 0 OR
        (inMod.modelYearStart <= wildfile.wd_YEAR_MAKE AND
         inMod.modelYearEnd >= wildfile.wd_YEAR_MAKE);

genderMatch := inMod.gender NOT IN ['M', 'F'] OR inMod.gender = wildfile.wd_gender;

county_bad := if(
  inMod.County<>'' and inMod.State='' and ~noFail,
  error(301, doxie.ErrorCodes(301) + ' - State required to search by County'),
  false);

unacceptable_inputs := doxie.fn_wildcard_badinput(inMod.State,inMod.regState,inMod.makeCodes,
inMod.zipCodes,inMod.modelCodes,inMod.majorColorCodes,inMod.ageRangeStart,inMod.ageRangeEnd,inMod.modelYearStart,
inMod.modelYearEnd,inMod.gender,inMod.LicensePlateNum,inMod.Vin_in) or wild_bad or county_bad;


// Combine matches
pre_filtered := LIMIT (wildfile (
 keyed(inMod.StateCodes = []  OR    wd_state IN inMod.StateCodes),
 keyed(inMod.regState = ''    OR    wd_orig_state = inMod.regStateCode),
 keyed(inMod.Makes = []       OR    wd_make_code IN inMod.makeCodes),
 keyed(inMod.zipCodes = []    OR    wd_zip IN inMod.zipCodes),
 keyed(inMod.Models = []      OR    wd_model_description IN inMod.modelCodes),
 keyed(inMod.Bodys = []       OR    wd_body_code IN inMod.bodyCodes),
 keyed(inMod.majorColorCodes = [] OR  wd_major_color_code IN inMod.majorColorCodes),
 agematch,
 yearmatch,
 gendermatch,
 platematch,
 vinmatch,
 WildZipMatch,

 mod_access.isValidDppa(),
 TRUE), WILDFILE_READ_LIMIT, ONFAIL(TRANSFORM(vehicle_wildcard.layout_hole_veh,SELF.Vehicle_Key:='FAILED',SELF:=[])));

limitFailed := pre_filtered[1].Vehicle_Key='FAILED';

filtered := if((unacceptable_inputs or limitFailed) and ~noFail,Fail(wildfile,11,doxie.ErrorCodes(11)),pre_filtered);

pre_Filtered_wseq := project(filtered,transform(recordof(filtered),
    self.wd_veh_id := counter,self:=left));//:persist('doxie_wildcardsearch_local3');

// It's tempting to narrow down to MaxResults_val records early for efficiency,
// but we can't do so until we're done with all filtering of the results.
unsigned2 UPPER_LIMIT := 2000;
unsigned2 REAL_LIMIT := ut.Min2(inMod.MaxResultsVal,UPPER_LIMIT);

dup_pre_filtered_wseq := dedup(sort(pre_Filtered_wseq,vehicle_key,iteration_key,sequence_key),
    vehicle_key,iteration_key,sequence_key);

unsigned1 dppa_purpose := mod_access.dppa; // defined for macro use
VehicleV2_Services.Mac_DppaCheck(dup_pre_filtered_wseq,dup_pre_filtered_wdppa)

no_postfiltering := inMod.FirstName='' and inMod.MiddleName='' and inMod.LastName='' and inMod.RegistrationType=VehicleV2_services.Constant.HISTORY.USE_ALL and inMod.County='';
filtered_wseq := group(if(no_postfiltering,choosen(dup_pre_filtered_wdppa,UPPER_LIMIT*5), dup_pre_filtered_wdppa),
  vehicle_key,iteration_key,sequence_key);

fname_pref := NID.PreferredFirstNew (stringlib.stringtouppercase(inMod.FirstName));
mname_pref := NID.PreferredFirstNew (stringlib.stringtouppercase(inMod.MiddleName));


F := project(filtered_wseq,transform(doxie_Raw.Layout_VehRawBatchInput.input_w_keys,
  self := left,self.input.seq := left.wd_veh_id, self :=[]));


FT := VehicleV2_Services.Fn_Find(F,mod_access,TRUE,,TRUE,inMod.IncludeCriminalIndicators,inMod.IncludeNonRegulatedSources);

boolean FullNameMatched (FT R, string f_name, string m_name, string l_name) := FUNCTION
  return ((f_name = '' OR f_name = R.own_1_fname) AND
          (m_name = '' OR m_name = R.own_1_mname) AND
          (l_name = '' OR l_name = R.own_1_lname)) OR
         ((f_name = '' OR f_name = R.own_2_fname) AND
          (m_name = '' OR m_name = R.own_2_mname) AND
          (l_name = '' OR l_name = R.own_2_lname)) OR
         ((f_name = '' OR f_name = R.reg_1_fname) AND
          (m_name = '' OR m_name = R.reg_1_mname) AND
          (l_name = '' OR l_name = R.reg_1_lname)) OR
         ((f_name = '' OR f_name = R.reg_2_fname) AND
          (m_name = '' OR m_name = R.reg_2_mname) AND
          (l_name = '' OR l_name = R.reg_2_lname));
END;

boolean NameMatched (FT R) := FUNCTION
  return FullNameMatched (R, inMod.FirstName, inMod.MiddleName, inMod.LastName) OR
         FullNameMatched (R, fname_pref, mname_pref, inMod.LastName);
END;


//check if user requests historical, expired, or current records
timelineMatch (string1 hist) := hist in inMod.RegistrationTypeAllow;

// NOTE: logic of EXPIRED records found to be different between wildcard and vehicle party:
// Wildcard Expired logic: "An Expired Registration is defined as a registration that has an expiration date in the past at the time of the build, but no more than twelve months in the past"
// Vehicle Party Expired logic: "An Expired flag will be set when no current record for same vehicle_key and iteration key and registration latest effective date within 12 months at the time of build"
// as a result expired records in wild file pulls flag from party record that could be either 'E' or 'H'
// So, we expect wildfile to contain only CURRENT('') or EXPIRED('E','H') records
FT hname(FT L) := transform
  historyConstant := VehicleV2_services.Constant.HISTORY;
  self.history := if(L.history not in historyConstant.CURRENT,'E',L.history);
  self.history_name := if(L.history not in historyConstant.CURRENT,'EXPIRED',L.history_name);
  self := L;
end;

toOut := project(FT(
  NameMatched(FT) and
  mod_access.isValidDPPAState(orig_state, , source_code) and
  timelineMatch(history) and
  inMod.State in [reg_1_state,''] and
  inMod.County in [reg_1_county_name,'']
), hname(left));

results_out := SORT(CHOOSEN (toOut, REAL_LIMIT),seq);

ssn_mask_value := mod_access.ssn_mask; // defined for macro use
dl_mask_value  := mod_access.dl_mask = 1; // defined for macro use

suppress.MAC_Mask(results_out, outf_c, own_1_ssn, OWN_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_c, outf_d, own_2_ssn, OWN_2_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_d, outf_e, reg_1_ssn, REG_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_e, results_cleaned, reg_2_ssn, REG_2_DRIVER_LICENSE_NUMBER, true, true);


RETURN results_cleaned;

End;
