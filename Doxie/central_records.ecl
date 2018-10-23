IMPORT doxie, doxie_crs, doxie_ln, moxie_phonesplus_server,gateway, 
  LN_PropertyV2_Services, Business_Risk, iesp, CriminalRecords_Services,
  ATF_Services, American_Student_Services, AutoStandardI, suppress, fcra, doxie_raw, ut, EmailService,
  FFD;

export central_records(boolean IsFCRA, string1 in_party_type,
                       dataset (doxie.layout_central_header) header_data,
                       integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
                       dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,                        
                       integer8 inFFDMask = 0,
                       dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile
                       ) := 
FUNCTION

con := doxie_crs.constants;

doxie.MAC_Header_Field_Declare(IsFCRA);
doxie.MAC_Selection_Declare();

// header data (remote or local) we need for calculations of single-sources 
besr          := normalize (choosen (header_data,1), left.best_information_children, transform(right));
csa_names     := normalize (choosen (header_data,1), left.subject_names, transform(right));
csa_addresses := normalize (choosen (header_data,1), left.subject_addresses, transform(right));

dids := project (besr, doxie.layout_references); //dids has no more than 1 record here.

// contains global input parameters
global_mod := AutoStandardI.GlobalModule (IsFCRA);

// Individual single-source data (use version, include, etc. selectors here)
PatA := if(IncludePatriot_val,doxie.CompPatriotSearch);
dlaa := if(IncludeDriversAtAddress_val,doxie.DlsAtAddress(csa_addresses));
fbnr := if(IncludeFBN_val, doxie.Comp_FBN2Search(dids));
rtvDids := if(IncludeRTVeh_val, dids, dataset ([0], doxie.layout_references)); // force the gateway call to not take place work around for #8414  
rtvr := if(IncludeRTVeh_val,doxie.Comp_RealTime_Vehicles(rtvDids).do);  

uccr := if(Include_UCCFilings_val and UccVersion in [0,1], doxie.UCC_legacy_records(dids, ssn_mask_value, in_party_type));
uccr2:= if(Include_UCCFilings_val and UccVersion in [0,2], doxie.UCC_v2_Records(dids, ssn_mask_value, in_party_type));
precorr := doxie.corp_affiliations_records(dids);
corr := if(Include_CorporateAffiliations_val, precorr);
empl := if(Include_PeopleAtWork_val, doxie.employment_records (dids));

// TODO: fcra version used skipAddressRollup = false; why?
pre_prop := doxie_ln.property_records(besr, csa_addresses, csa_names, IsFCRA, true, nonss, ds_flags, slim_pc_recs, inFFDMask);
prop := if(Include_Properties_val and PropertyVersion in [0,1],pre_prop);
preprop2 := LN_PropertyV2_Services.Ownership.get_CRS_records(dids, csa_addresses, csa_names, application_type_value);
prop2 := if(Include_Properties_val and PropertyVersion in [0,2], preprop2);

flcr := if (Include_Accidents_val, doxie.flcrash_search_records (dids));

votr  := IF (Include_VoterRegistrations_val and VoterVersion in [0,1], doxie.voter_records (dids));
votr2 := IF (Include_VoterRegistrations_val and VoterVersion in [0,2], doxie.voters_v2_records(dids, ssn_mask_value));

ccwr := if(Include_WeaponPermits_val, doxie.ccw_records(dids, IsFCRA, ds_flags(file_id = FCRA.FILE_ID.CCW), slim_pc_recs, inFFDMask));
plrr := if(Include_ProfessionalLicenses_val, doxie.pl_records (dids, IsFCRA, ds_flags (file_id = FCRA.FILE_ID.PROFLIC), slim_pc_recs, inFFDMask));

sanc := if(Include_Sanctions_val, doxie.Sanc_records(dids));
prov := if(Include_Providers_val, doxie.Prov_records(dids));

util := if(Include_Utility_val, doxie.Util_records(dids, ssn_mask_value, dl_mask_value, GLB_Purpose, industry_class_val));

aMod := module(project (global_mod,ATF_Services.IParam.search_params,opt)) 
  export string14 did := (string) dids[1].did;
  export unsigned1 non_subject_suppression := nonSS;
  export integer8 FFDOptionsMask := inFFDMask;
end;
atfr := if(Include_FirearmsAndExplosives_val, ATF_Services.SearchService_Records.report (aMod, isFCRA, ds_flags, slim_pc_recs));

hunr := if(Include_HuntingFishingLicenses_val, doxie.hunting_records(dids, isFCRA, ds_flags(file_id = FCRA.FILE_ID.HUNTING_FISHING), slim_pc_recs, inFFDMask));

pilr := if(Include_FAACertificates_val, doxie.pilot_records(dids, dateVal, ssn_mask_value, IsFCRA, 
                            ds_flags(file_id = FCRA.FILE_ID.PILOT_REGISTRATION), slim_pc_recs, inFFDMask));

cerr := if(Include_FAACertificates_val, Doxie_Raw.Pilot_cert_raw(dids, dateVal, IsFCRA, ds_flags, slim_pc_recs, inFFDMask));
faar := if(Include_FAAAircrafts_val, doxie.Faa_Aircraft_records (dids, IsFCRA, ds_flags, slim_pc_recs, inFFDMask));

// bankruptcy: fcra and versioning
boolean suppress_withdrawn_bankruptcy := false : stored('SuppressWithdrawnBankruptcy');
bkkr_reg := project(doxie.bk_records (dids, in_party_type, isReport := true), transform(doxie.Layout_BK_output_ext, self := left, self := []));
bk_v3_mod := doxie.bk_records_v3 (dids, ssn_mask_value, party_type_bk, IsFCRA, ds_flags, nonSS, slim_pc_recs, inFFDMask, suppress_withdrawn_bankruptcy);
bkkr_fcra := bk_v3_mod.format_v1;
bkrr  := IF (Include_Bankruptcies_val and BankruptcyVersion in [0,1], if (IsFCRA, bkkr_fcra, bkkr_reg));

prebkrr2 := doxie.bk_records_v2 (dids,,in_party_type);
bkrr2 := IF (Include_Bankruptcies_val and BankruptcyVersion in [0,2], prebkrr2);
// v3 is returned only on FCRA side and only if version #3 was explicitly requested
bkrr3 := IF (Include_Bankruptcies_val and IsFCRA and BankruptcyVersion=3, bk_v3_mod.format_v3);

lier  := IF (Include_LiensJudgments_val, doxie.Liens_Judgments_records (dids, in_party_type));
lier2 := IF (Include_LiensJudgments_val, doxie.liens_v2_records (dids, in_party_type, IsFCRA, ds_flags, nonSS, slim_pc_recs, inFFDMask));
derr := IF (Include_DEA_Val and DeaVersion in [0,1], doxie.dea_records (dids));
derr2 := IF (Include_DEA_Val and DeaVersion in [0,2], doxie.DeaV2_records(dids));
wtcr := IF (Include_Watercrafts_val, doxie.watercraft_records (dids, ssn_mask_value,IsFCRA, ds_flags, IncludeNonRegulatedWatercraftSources, slim_pc_recs, inFFDMask));
idom := IF (Include_InternetDomains_val, CHOOSEN (doxie_raw.WhoIs_raw (dids,,, dateVal, dppa_purpose, glb_purpose), 100)); // hardcoded, since this shall be change in the future anyway
nod_for := nod_foreclosure_records (dids, ssn_mask_value, application_type_value, industry_class_val);
nod := if(include_NoticeOfDefaults_val, nod_for.nod);
frcl := if(include_foreclosures_val, nod_for.foreclosure);
phpl := if(Include_PhonesPlus_val, 
           moxie_phonesplus_server.phonesplus_did_records(dids, con.max_phonesplus, score_threshold_value,glb_purpose,dppa_purpose,,true,true).w_timezone);
email := map(Include_Email_Addresses_val and email_dedup_val => doxie.fn_dedup_email(dids,ssn_mask_value,application_type_value,industry_class_value), // checking if to dedup emails
             Include_Email_Addresses_val  => doxie.email_records(dids,ssn_mask_value,application_type_value,,industry_class_value),
             dataset([],EmailService.Assorted_Layouts.layout_report_rollup));
// Premium Phones
dedup_phones:=dataset(dedupPremiumPhones,doxie.premium_phone.phone_rec)+
project(phpl,transform(doxie.premium_phone.phone_rec,self.phone:=left.phoneno));
prph := if(Include_PremiumPhones_val,doxie.premium_phone.get_records(dids,dedup_phones,gateway.configuration.get(),global_mod.DataRestrictionMask,true));

// Business Instant ID - input verification and to get business name and address
// TODO: hide into header_field_declare along with other selectors
boolean Include_Verification := false : stored('IncludeVerification');
Include_Verification_val := Include_Them_All or Include_Verification;
boolean Include_PhoneSummary := false : stored('IncludePhoneSummary');
Include_PhoneSummary_val := Include_Them_All or Include_PhoneSummary;
#stored('RepresentativeSSN',ssn_value);
#stored('RepresentativeDOB',dob_val);
#stored('RepresentativeFirstName',fname_value);
#stored('RepresentativeLastName',lname_value);
#stored('RepresentativeMiddleName',mname_value);
biid := Business_Risk.business_instantid_records;
verification := if (Include_Verification_val, doxie.fn_get_verification(biid, fname_val, lname_val));
phone_summary := if (Include_PhoneSummary_val, doxie.fn_get_phone_summary(biid));
american_student_input := MODULE(PROJECT(global_mod, American_Student_Services.IParam.reportParams,opt)) end;
boolean onlyCurrent := true;  //request only current student records.
american_studentV2 := if(include_StudentInformation_val,
     choosen(American_Student_Services.Functions.get_report_recs(dids,american_student_input, onlyCurrent),iesp.Constants.MaxCountASLSearch));
american_student := if(include_StudentInformation_val,American_Student_Services.Functions.get_report_slim(american_studentV2));

check_cond := ~IsFCRA and ~ ut.IndustryClass.is_knowx;

// get crim indicators
recsIn := DATASET([{(string)dids[1].did,false,false}],{string12 UniqueID,boolean hasCriminalConviction,boolean isSexualOffender});
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
crimIndicators := IF(includeCriminalIndicators,recsOut,recsIn);

// if a datatable is not "fcra-neutral", it should be fetched at fcra-side (for fcra queries only)
doxie.layout_central_records tra (layout_central_header l) := transform
  self.RealTime_Vehicle_children          := IF (~IsFCRA,global(rtvr));
  self.driversAtAddress_children          := IF (~IsFCRA,global(dlaa));
  self.PatriotSearch_children             := IF (~IsFCRA,global(PatA));
  self.FBNSearch_children                 := IF (~IsFCRA,global(fbnr));
  // UCC V1 should be phased out, so we won't return it on FCRA side
  self.ucc_children                       := IF (~IsFCRA, global(uccr));
  self.uccv2_children                     := IF (~IsFCRA, global(uccr2));
  self.corporate_affiliations_children    := IF (~IsFCRA, global(corr));
  self.property_children                  := global(prop);
  self.propertyV2_children                := IF (~IsFCRA, global(prop2));
  self.voter_children                     := IF (~IsFCRA, global(votr));
  self.voterv2_children                   := IF (~IsFCRA, global(votr2));

  self.concealed_weapon_licenses_children := global(ccwr);
  self.professional_licenses_children     := global(plrr);
  self.sanction_children                  := IF (~IsFCRA, global(sanc));
  self.provider_children                  := IF (~IsFCRA, global(prov)); 
  self.utility_children                   := IF (~IsFCRA, global(util)); 
  self.firearms_and_explosives_children   := global(atfr);
  self.hunting_licenses_children          := global(hunr);
  self.pilot_licenses_children            := global(pilr);
  self.pilot_certificates_children        := global(cerr);
  self.pilot_aircraft_children            := global(faar);
  self.bankruptcies_children              := global(bkrr);
  self.bankruptcies_v2_children           := IF (~IsFCRA, global(bkrr2));
  self.bankruptcies_v3_children           := global(bkrr3);
  // liens V1 should be phased out, so we won't return it on FCRA side
  self.liens_judgements_children          := IF (~IsFCRA, global(lier));
  self.liens_judgements_v2_children       := global(lier2);
  self.dea_children                       := IF (~IsFCRA, global(derr));
  self.deaV2_children                     := IF (~IsFCRA, global(derr2));
  self.watercraft_children                := global(wtcr);
  self.netdomain_children                 := IF (check_cond, global(idom));
  self.employment_children                := IF (check_cond, global(empl));
  self.fl_crash_children                  := IF (~IsFCRA, global(flcr));
  self.nod_children                       := IF (check_cond, if(not doxie.DataRestriction.Fares, global(nod)));
  self.foreclosure_children               := IF (check_cond, if(not doxie.DataRestriction.Fares, global(frcl)));
  self.phonesplus_children                := IF (check_cond, choosen(phpl, con.max_phonesplus));
  self.premium_phone_children             := IF (check_cond, choosen(prph, con.max_phonesplus));
  self.Email_children                     := IF (~ISFCRA, global(email));

  self.verification                       := IF (~ISFCRA, verification);
  self.phone_summary                      := IF (~ISFCRA, phone_summary);

  // Note: on FCRA side indicators are calculated only if actual data are returned, i.e. "include" was specified;
  //   this is different from non-FCRA, where indicators are calculated even if data were not requested.
  // Note: we will reuse same field names on FCRA side, even for different bk or property versions;
  bk_flag_fcra := (BankruptcyVersion in [0,1] and exists (bkrr)) or (BankruptcyVersion=3 and exists (bkrr3));
  self.bankruptcies_v2_indicator          := IF (~IsFCRA, exists(prebkrr2), bk_flag_fcra);
  self.corporate_affiliations_indicator   := ~IsFCRA and exists(precorr);
  // NB: assumption: properties on FCRA side are necessarily owned (or used to be owned) by subject
  self.propertyV2__indicator              := IF (~IsFCRA, exists (preprop2(owned)), exists(prop));
  self.student_information                := IF (~IsFCRA, global(american_student)); 
  self.studentV2_information              := IF (~IsFCRA, global(american_studentV2)); 
  
  self.hasCriminalConviction              := IF (~IsFCRA, crimIndicators[1].hasCriminalConviction,false);
  self.isSexualOffender                   := IF (~IsFCRA, crimIndicators[1].isSexualOffender,false);
    // subject's names, addresses, relatives, neighbors, etc. are all taken from header_data
  Self := l;
  self := [];
end;

return project (header_data, tra(left));

END;


