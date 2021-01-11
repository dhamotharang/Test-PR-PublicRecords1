IMPORT doxie, suppress, Census_Data, ut, watercraft, AutoStandardI, fcra, FFD, WatercraftV2_Services;

EXPORT get_owners(DATASET(WatercraftV2_Services.layouts.owner_raw_rec) owner_key_recs,
                  STRING in_ssn_mask_type,
                  BOOLEAN IsFCRA = FALSE) := MODULE

  // it is expected that FCRA compliance like suppressions/DUD was already applied to input owner_key_recs
  SHARED int_rec := WatercraftV2_Services.Layouts.int_raw_rec;

  EXPORT report(BOOLEAN isReport = FALSE) := FUNCTION
        
        ms := WatercraftV2_Services.Functions.ms;
        
        doxie.MAC_Header_Field_Declare(IsFCRA); // need it just for dppa_purpose AND penalty-stuff

        WatercraftV2_Services.Layouts.owner_raw_rec get_report(WatercraftV2_Services.Layouts.owner_raw_rec r) := TRANSFORM
            SELF.did := IF((UNSIGNED6) r.did = 0,'', r.did);
            SELF.bdid := IF((UNSIGNED6) r.bdid = 0,'', r.bdid);
            //Why do we need penalty calculation in the report???
            //-> penalty calculation in report because of possible search by name and address, see WatercraftReportService_ids.
            SELF.penalt:= IF (IsFCRA OR isReport, 0,
              doxie.FN_Tra_Penalty_DID((STRING) r.did) +
              doxie.FN_Tra_Penalty_SSN(ms(r.orig_ssn,r.ssn,ssn_value)) +
              doxie.FN_Tra_Penalty_Name(r.fname,r.mname,r.lname) +
              doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,
                r.suffix,r.postdir,r.sec_range,ms(r.p_city_name,r.v_city_name,city_value),ms(r.st,r.state_origin,state_value),r.zip5) +
              doxie.Fn_Tra_Penalty_Phone(ms(r.phone_1,r.phone_2,phone_value)) +
              doxie.FN_Tra_Penalty_DOB(r.dob) +
              doxie.FN_Tra_Penalty_BDID(r.bdid) +
              doxie.FN_Tra_Penalty_FEIN(ms(r.orig_fein,r.fein,fein_val)) +
              doxie.FN_Tra_Penalty_CNAME(r.company_name));
            SELF := r;
        END;
        
        report_recs_raw := PROJECT(owner_key_recs, get_report(LEFT));

        report_recs_srt := SORT(report_recs_raw((watercraft.sDPPA_ok(state_origin,dppa_purpose) OR dppa_flag='N') AND penalt<6), subject_did, state_origin, watercraft_key, sequence_key,penalt, fname,mname,lname,company_name,did,-date_last_seen);
        report_recs_dep := DEDUP(report_recs_srt, subject_did, state_origin, watercraft_key, sequence_key,penalt,fname,mname,lname,company_name,did);

        Census_Data.MAC_Fips2County_Keyed(report_recs_dep, st, county, county_name, owner_recs_unmsk)

        Suppress.MAC_Suppress(owner_recs_unmsk,did_pulled,application_type_value,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);
        Suppress.MAC_Suppress(did_pulled,ssn_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);

        // cannot use pullSSN in fcra-side:
        ssn_clean := IF (IsFCRA, owner_recs_unmsk, ssn_pulled);
        suppress.mac_mask(ssn_clean, owner_recs_0, ssn, blank, TRUE, FALSE, maskVal:=in_ssn_mask_type);
        suppress.mac_mask(owner_recs_0, owner_recs_1, orig_ssn, blank, TRUE, FALSE, maskVal:=in_ssn_mask_type);
                
        int_rec rollowners(int_rec l,DATASET(int_rec) r):=TRANSFORM
          SELF.owners := CHOOSEN(Normalize(r,LEFT.owners, TRANSFORM(RIGHT)),ut.limits.MAX_WATERCRAFT_OWNERS);
          SELF :=l;
        END;

        sorted_owner := SORT(
          PROJECT(owner_recs_1, TRANSFORM(int_rec,
            SELF.owners := PROJECT(LEFT, TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec, SELF:=LEFT));
            SELF :=LEFT;
            )),
          subject_did, state_origin,watercraft_key,sequence_key,penalt,-date_last_seen);
                                
        grouped_owners :=GROUP(sorted_owner, subject_did, state_origin,watercraft_key,sequence_key);
        pre_owner_recs_report := ROLLUP(grouped_owners,GROUP,
                                rollowners(LEFT,rows(LEFT)));
                                
        owner_recs_report := PROJECT(pre_owner_recs_report,
          TRANSFORM(int_rec,
            SELF.owners := DEDUP(SORT(LEFT.owners,lname,fname,RECORD),lname,fname,RECORD);
            SELF:=LEFT;
          ));
    
        RETURN owner_recs_report;
    END;


    EXPORT search() := FUNCTION
        
        outrec := WatercraftV2_Services.Layouts.search_out;
        inner_params := WatercraftV2_Services.Interfaces.ak_params;
        gm := AutoStandardI.GlobalModule(IsFCRA);

        temp_mod_one := MODULE(PROJECT(gm,inner_params,opt)) END;
        
        temp_mod_two := MODULE(PROJECT(gm,inner_params,opt))
          EXPORT firstname := gm.entity2_firstname;
          EXPORT middlename := gm.entity2_middlename;
          EXPORT lastname := gm.entity2_lastname;
          EXPORT unparsedfullname := gm.entity2_unparsedfullname;
          EXPORT allownicknames := gm.entity2_allownicknames;
          EXPORT phoneticmatch := gm.entity2_phoneticmatch;
          EXPORT companyname := gm.entity2_companyname;
          EXPORT addr := gm.entity2_addr;
          EXPORT city := gm.entity2_city;
          EXPORT state := gm.entity2_state;
          EXPORT zip := gm.entity2_zip;
          EXPORT zipradius := gm.entity2_zipradius;
          EXPORT phone := gm.entity2_phone;
          EXPORT fein := gm.entity2_fein;
          EXPORT bdid := gm.entity2_bdid;
          EXPORT did := gm.entity2_did;
          EXPORT ssn := gm.entity2_ssn;
        END;
        
        doxie.MAC_PruneOldSSNs(owner_key_recs, owners_rec_pruned1, ssn, did, isFCRA);
        doxie.MAC_PruneOldSSNs(owners_rec_pruned1, owners_rec_pruned, orig_ssn, did, isFCRA);
        
        WatercraftV2_Services.Layouts.owner_raw_rec get_owners(WatercraftV2_Services.Layouts.owner_raw_rec r) :=TRANSFORM
          pre_orig_ssn := r.orig_ssn;
          pre_ssn := r.ssn;
          SELF.did := IF((UNSIGNED6) r.did = 0,'', r.did);
          SELF.bdid := IF((UNSIGNED6) r.bdid = 0,'', r.bdid);
          temp_mod_one_penalty := WatercraftV2_Services.Functions.CalculatePenalty(temp_mod_one, r, pre_orig_ssn, pre_ssn);
          temp_mod_two_penalty := WatercraftV2_Services.Functions.CalculatePenalty(temp_mod_two, r, pre_orig_ssn, pre_ssn);
          SELF.penalt := IF(isFCRA, 0, IF(gm.TwoPartySearch,MAX(temp_mod_one_penalty,temp_mod_two_penalty),temp_mod_one_penalty));
          SELF :=r;
        END;
        dppa_purpose := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(PROJECT(gm, AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));

        search_recs_raw0 := PROJECT(owners_rec_pruned, get_owners(LEFT));
                                
        Suppress.MAC_Mask(search_recs_raw0, search_recs_raw1, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);
        Suppress.MAC_Mask(search_recs_raw1, search_recs_raw, orig_ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);

        search_recs_srt := SORT(search_recs_raw(watercraft.sDPPA_ok(state_origin,dppa_purpose) OR dppa_flag='N'), state_origin, watercraft_key, sequence_key,penalt,fname,mname,lname,company_name,name_suffix,did,-date_last_seen);
        search_recs_dep := DEDUP(search_recs_srt, state_origin, watercraft_key, sequence_key,penalt,fname,mname,lname,company_name,name_suffix,did);

        Census_Data.MAC_Fips2County_Keyed(search_recs_dep, st, county, county_name, owner_recs_unmsk)

        outrec rollowners(outrec l,DATASET(outrec) r):=TRANSFORM
          SELF.owners := CHOOSEN(Normalize(r,LEFT.owners, TRANSFORM(RIGHT)),ut.limits.MAX_WATERCRAFT_OWNERS);
          SELF.StatementIDs := [];
          SELF.isDisputed := FALSE;
          SELF :=l;
        END;

        sorted_owner_recs := SORT(
          PROJECT(owner_recs_unmsk,TRANSFORM(outrec,
            SELF.owners := PROJECT(LEFT,TRANSFORM(WatercraftV2_Services.Layouts.owner_search_rec,
              SELF:= LEFT));
            SELF := LEFT;
            SELF := [];
            )),
            state_origin,watercraft_key,sequence_key);

        owner_recs_search := ROLLUP(GROUP(sorted_owner_recs,state_origin,watercraft_key,sequence_key),
                                    GROUP,
                                    rollowners(LEFT,rows(LEFT)));

        RETURN owner_recs_search;
    END;
    
END;
