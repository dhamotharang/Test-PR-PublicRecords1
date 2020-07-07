IMPORT American_Student_Services, ATF_Services, DidVille, doxie, doxie_crs, iesp,
       PersonReports, PersonSlimReport_Services, SmartRollup, STD, ut;

EXPORT Functions(DATASET(doxie.layout_references_hh) in_did) := MODULE

  SHARED Ioptions := PersonSlimReport_Services.IParams.PersonSlimReportOptions;
  SHARED d2i(iesp.share.t_Date d) := iesp.ECL2ESP.DateToInteger(d);
  SHARED pickLatestDate (iesp.share.t_Date l, iesp.share.t_Date r) := if(d2i(l) > d2i(r), l, r);
  SHARED pickNonZeroDate(iesp.share.t_Date l, iesp.share.t_Date r) := if(d2i(l) > 0, l, r);
  SHARED pickLongestStr(string l, string r) := if ( length(trim(l)) > length(trim(r)), l, r );

  //get header recs and apply restrictions
  SHARED header_out := doxie.header_records_byDID(dids            := in_did,
                                                  include_dailies := true,
                                                  ReturnLimit     := ut.limits.HEADER_PER_DID,
                                                  DoSearch        := false);

    EXPORT addressRecsByDid() := FUNCTION
        addr_unrolled := project(header_out, TRANSFORM(doxie.Layout_Comp_Addresses,SELF:=LEFT,SELF:=[]));
        doxie.MAC_Address_Rollup(addr_unrolled, iesp.Constants.PersonSlim.MaxAddresses, addresses_rolled);

        addr_sorted  := sort(addresses_rolled,
                                prim_range, prim_name, sec_range, city_name, st, zip, -dt_last_seen, -dt_first_seen);
        addr_duped := dedup(addr_sorted, prim_range, prim_name, sec_range, city_name, st, zip);
        addr_duped_sorted := sort(addr_duped,st, city_name, prim_range, prim_name, sec_range,-dt_first_seen);

        addr_final := project(addr_duped_sorted,
                           TRANSFORM(iesp.personslimreport.t_PersonSlimReportAddress,
                              self.streetnumber        := LEFT.prim_range,
                              self.streetpredirection  := LEFT.predir,
                              self.streetname          := LEFT.prim_name,
                              self.streetsuffix        := LEFT.suffix,
                              self.streetpostdirection := LEFT.postdir,
                              self.unitdesignation     := LEFT.unit_desig,
                              self.unitnumber          := LEFT.sec_range,
                              self.streetaddress1      := '',
                              self.streetaddress2      := '',
                              self.city                := LEFT.city_name,
                              self.state               := LEFT.st,
                              self.zip5                := LEFT.zip,
                              self.zip4                := LEFT.zip4,
                              self.county              := LEFT.county_name,
                              self.postalcode          := '',
                              self.statecityzip        := ''));
        RETURN addr_final;
    END;

    EXPORT deathRecsByDid(boolean IncludeBlankDOD) := FUNCTION
       death_raw_bdod := header_out(IncludeBlankDOD or dod <> 0);
       death_raw_sorted:= sort(death_raw_bdod,-dod,-dt_last_seen);
       //there should be just 1 record.... either he is dead or alive
       death_duped := dedup(death_raw_sorted,dod);
       //this will put the latest rec on top
       death_duped_sorted := sort(death_duped, -dt_last_seen);
       death_final := project(death_duped_sorted,
                        TRANSFORM(iesp.personslimreport.t_PersonSlimReportDeath,
                          SELF.Year  := LEFT.DOD DIV 10000,
                          SELF.Month :=(LEFT.DOD % 10000) DIV 100,
                          SELF.Day   := LEFT.DOD % 100));
      RETURN death_final;
    END;

    EXPORT ssnRecsByDid() := FUNCTION
      ssn_raw := header_out((unsigned)ssn <> 0);
      ssn_raw_sorted:= sort(ssn_raw,ssn,-dt_last_seen);
      //there should be just 1 record
      ssn_duped := dedup(ssn_raw_sorted,ssn);
      //this will put the latest rec on top
      ssn_duped_sorted := sort(ssn_duped, -dt_last_seen);
      ssn_final := project(ssn_duped_sorted,
                     TRANSFORM(iesp.personslimreport.t_PersonSlimReportSSN,
                               SELF.SSN := LEFT.SSN));
      RETURN ssn_final;
    END;

    EXPORT akaRecsByDid(DATASET(iesp.bps_share.t_BpsReportIdentity) akas) := FUNCTION
      akas_raw_sorted:= sort(akas,Name.Last,Name.First,-Name.Middle,ssninfoex.ssn );
      akas_final := dedup(akas_raw_sorted,Name.Last,Name.First,ssninfoex.ssn);
      RETURN akas_final;
    END;

    EXPORT imposterRecsByDid(DATASET(iesp.bps_share.t_BpsReportImposter) imposters) := FUNCTION
       imps_raw := project(imposters.AKAs, iesp.bps_share.t_BpsReportIdentity);
       imps_final := akaRecsByDid(imps_raw);
       RETURN imps_final;
    END;

    //we build the name section from the AKA section
    EXPORT nameRecsByDid(DATASET(iesp.bps_share.t_BpsReportIdentity) akas) := FUNCTION
        names_raw := project(akas,
                      TRANSFORM(iesp.personslimreport.t_PersonSlimReportName,
                         SELF.Full   := LEFT.Name.Full,
                         SELF.First  := LEFT.Name.First,
                         SELF.Middle := LEFT.Name.Middle,
                         SELF.Last   := LEFT.Name.Last,
                         SELF.Suffix := LEFT.Name.Suffix,
                         SELF.Prefix := LEFT.Name.Prefix));
        names_raw_sorted:= sort(names_raw,Last,First,-Middle);
        names_final := dedup(names_raw_sorted,Last,First);
        RETURN names_final;
    END;

    EXPORT dobRecsByDid() := FUNCTION
      dob_raw_bdod := header_out(dob <> 0);
      dob_raw_sorted:= sort(dob_raw_bdod,-dob,-dt_last_seen);
      dob_duped := dedup(dob_raw_sorted,dob);
      dob_duped_sorted := sort(dob_duped, -dt_last_seen);
      dob_final := project(dob_duped_sorted,
                      TRANSFORM(iesp.personslimreport.t_PersonSlimReportDOB,
                            SELF.Year  := LEFT.DOB DIV 10000,
                            SELF.Month :=(LEFT.DOB % 10000) DIV 100,
                            SELF.Day   := LEFT.DOB % 100));
      RETURN dob_final;
    END;

    EXPORT phoneRecsByDid(doxie.phone_noreconn_param.searchParams phone_mod):= FUNCTION
       //get all free phone (no GW hits) recs (phone plus and gong) and apply restrictions
       phones_raw   := doxie.phone_noreconn_records(phone_mod, in_did);
       phones_raw_sorted:= sort(phones_raw, phone,-(unsigned4)dt_last_seen,-(unsigned4)dt_first_seen);
       phones_duped := dedup(phones_raw_sorted,phone);
       phones_duped_sorted := sort(phones_duped, -(unsigned4)dt_last_seen,-(unsigned4)dt_first_seen);
       phones_final := project(phones_duped_sorted,
                          TRANSFORM(iesp.personslimreport.t_PersonSlimReportPhone,
                                    SELF.Phone := LEFT.Phone));
       RETURN phones_final;
    END;

  EXPORT dlsRecsByDid():= FUNCTION
      dl_raw  := PersonReports.DL_records(in_did);
      //SmartRollup.fn_smart_rollup_dls
      dl_sorted := sort(dl_raw, OriginState, DriverLicense, -d2i(expirationDate),-d2i(issueDate));
      dl_duped  := dedup(dl_sorted, OriginState, DriverLicense);
      dl_duped_sorted := sort(dl_duped, -d2i(expirationDate),-d2i(issueDate), OriginState, DriverLicense);
      RETURN dl_duped_sorted;
  END;

  EXPORT profLicRecsByDid(Ioptions in_mod):= FUNCTION
      pl_mod  := PROJECT(in_mod, PersonReports.IParam.proflic, OPT);
      pl_raw  := PersonReports.proflic_records(in_did,pl_mod).proflicenses_v2;
      pl_clean := project(pl_raw,
                    TRANSFORM(iesp.proflicense.t_ProfessionalLicenseRecord,
                        SELF.licensenumber := ut.rmv_ld_0_alp_num(LEFT.licensenumber),
                        SELF := LEFT));
      pl_sorted := sort(pl_clean, sourcestate, licensenumber, -d2i(datelastseen));
      pl_duped  := dedup(pl_sorted, sourcestate, licensenumber);
      pl_duped_sorted := sort(pl_duped,-d2i(datelastseen));
      RETURN pl_duped_sorted;
  END;

 //this function also adds did's to the RTV records to be used in alerting platform
  SHARED getRealTimeVehicles(Ioptions in_mod, DATASET(doxie.layout_best) bestRecs = DATASET([],doxie.layout_best)) := FUNCTION
      mod_access:= PROJECT(in_mod, doxie.IDataAccess);

      rec_reg_seq := record(iesp.motorvehicle.t_MotorVehicleReportRegistrant)
        unsigned4 seq := 0;
        string25  vin := '';
      end;

      w_best_addr := project(bestRecs,TRANSFORM(doxie.Layout_Comp_Addresses,SELF:=LEFT,SELF:=[]));
      w_best_name := project(w_best_addr,doxie.layout_NameDID);

      //hit RTV GW - experian - DATASET(iesp.motorvehicle.t_MotorVehicleReport2Record)
      rtv_raw := doxie.Comp_RealTime_Vehicles(in_did,w_best_addr,w_best_name).do;
      rtv     := SmartRollup.fn_smart_rollup_veh(rtv_raw,in_did[1].did);

      //extract nested registrants portion and add outer vin to each record as identitifer
      registrants := NORMALIZE(rtv, LEFT.registrants,
                              TRANSFORM(rec_reg_seq,
                                SELF.vin := LEFT.vehicleinfo.vin,
                                SELF     := RIGHT));

      //add ordered sequence number before hitting ADL best,
      //can't add seq in normalize or it will group the sequence numbers
      reg_w_seq := ITERATE(registrants,
                          TRANSFORM(rec_reg_seq,
                             SELF.seq := counter,
                             SELF     := RIGHT));

      DidVille.Layout_Did_OutBatch prepare_layout(rec_reg_seq l) := TRANSFORM
          SELF.title        := l.registrantinfo.name.prefix;
          SELF.fname        := l.registrantinfo.name.first;
          SELF.mname        := l.registrantinfo.name.middle;
          SELF.lname        := l.registrantinfo.name.last;
          SELF.suffix       := l.registrantinfo.name.suffix;
          SELF.prim_range   := l.registrantinfo.address.streetnumber;
          SELF.predir       := l.registrantinfo.address.streetpredirection;
          SELF.prim_name    := l.registrantinfo.address.streetname;
          SELF.addr_suffix  := l.registrantinfo.address.streetsuffix;
          SELF.postdir      := l.registrantinfo.address.streetpostdirection;
          SELF.unit_desig   := l.registrantinfo.address.unitdesignation;
          SELF.sec_range    := l.registrantinfo.address.unitnumber;
          SELF.p_city_name  := l.registrantinfo.address.city;
          SELF.st           := l.registrantinfo.address.state;
          SELF.z5           := l.registrantinfo.address.zip5;
          SELF.zip4         := l.registrantinfo.address.zip4;
          SELF              := l;
          SELF              := [];
      END;

      //prepare the layout for ADL_BEST DID call
      ds_with_ADL_Layout := PROJECT(reg_w_seq,prepare_layout(LEFT));

      //we call ADL_BEST just to get the scored dids....not to get the best data
      recsWithScoredDIDs := didville.did_service_common_function(ds_with_ADL_Layout
                                                ,glb_flag          := mod_access.isValidGLB()
                                                ,glb_purpose_value := mod_access.glb
                                                ,appType           := mod_access.application_type
                                                ,IndustryClass_val := mod_access.industry_class);

      registrants_wdids := JOIN(reg_w_seq,recsWithScoredDIDs
                               ,LEFT.seq = RIGHT.seq
                               ,TRANSFORM(rec_reg_seq
                               ,SELF.registrantinfo.uniqueid := INTFORMAT(RIGHT.did,12,1)
                               ,SELF := LEFT)
                               ,LIMIT(0),KEEP(1));

      //Put inner registrants back into parent record
      rtv_w_dids := DENORMALIZE(rtv, registrants_wdids,
                                LEFT.vehicleinfo.vin = RIGHT.vin,
                                GROUP,
                                TRANSFORM(iesp.motorvehicle.t_MotorVehicleReport2Record,
                                   SELF.registrants := project(ROWS(RIGHT),
                                            iesp.motorvehicle.t_MotorVehicleReportRegistrant),
                                   SELF:=LEFT));
    RETURN rtv_w_dids;
  END;

  EXPORT vehicleRecsByDid(Ioptions in_mod,
                          DATASET(doxie.layout_best) bestRecs = DATASET([],doxie.layout_best)):= FUNCTION
      vehicles_mod  := PROJECT (in_mod, PersonReports.IParam.vehicles, OPT);
      vehicles_v2  := PersonReports.vehicle_records(in_did,vehicles_mod).vehicles_v2;
      //hit RTV GW - experian
      rtv := if(in_mod.IncludeRealTimeVehicles,getRealTimeVehicles(in_mod, bestRecs));

      //combine all vehicle recs
      vehicle_raw := vehicles_v2 + rtv;

      //cleanup and rollup data by - VehicleInfo.vin, VehicleInfo.make, VehicleInfo.model
      vehicle_duped := SmartRollup.fn_smart_rollup_veh(vehicle_raw,in_did[1].did);

      vehicle_final := project(vehicle_duped,
                        transform(iesp.motorvehicle.t_MotorVehicleReport2Record,
                          self.registrants := dedup(sort(left.registrants, registrantinfo.uniqueid),registrantinfo.uniqueid),
                          self.owners      := dedup(sort(left.owners,      ownerinfo.uniqueid),     ownerinfo.uniqueid),
                          self := left));
      RETURN vehicle_final;
  END;

  EXPORT acRecsByDid(Ioptions in_mod):= FUNCTION

      ac_mod := PROJECT(in_mod, PersonReports.IParam.aircrafts, OPT);

      ac_raw  := PersonReports.aircraft_records(in_did,ac_mod);
      ac_sorted := sort(ac_raw, aircraftnumber, -d2i(datelastseen));
      ac_duped  := dedup(ac_sorted, aircraftnumber);
      ac_duped_sorted := sort(ac_duped,-d2i(datelastseen));
      ac_final := project(ac_duped_sorted,iesp.faaaircraft.t_aircraftReportRecord);
      RETURN ac_final;
  END;

  EXPORT wcRecsByDid(Ioptions in_mod):= FUNCTION
      wc_mod := PROJECT(in_mod, PersonReports.IParam.watercrafts, OPT);
      wc_raw  := PersonReports.watercraft_records(in_did,wc_mod).wtr_recs;
      wc_sorted := sort(wc_raw, hullnumber, stateoforigin, -d2i(datelastseen));
      wc_duped  := dedup(wc_sorted, hullnumber, stateoforigin);
      wc_duped_sorted := sort(wc_duped,-d2i(datelastseen));
      wc_final := project(wc_duped_sorted,iesp.watercraft.t_WaterCraftReportRecord);
      RETURN wc_final;
  END;

  shared uccPersonDedup(DATASET(iesp.ucc.t_UCCPerson) ucc_persons) :=
    dedup(
      sort(ucc_persons,
              originname,
              -parsedParties[1].uniqueId,
              -addresses[1].zip5,
              -parsedParties[1].businessid
              ),
              originname);
    
  EXPORT uccRecsByDid(Ioptions in_mod):= FUNCTION
      ucc_mod := module (PROJECT(in_mod, PersonReports.IParam.ucc, OPT))
        EXPORT string1 ucc_party_type := in_mod.ucc_party_type;
      end;
      ucc_raw  := PersonReports.ucc_records(in_did,ucc_mod).ucc_v2;
      //SmartRollup.fn_smart_rollup_ucc
      ucc_sorted := sort(ucc_raw, filingJurisdiction, originFilingNumber, -d2i(OriginFilingDate));
      ucc_duped  := dedup(ucc_sorted, filingJurisdiction, originFilingNumber);
      ucc_duped_sorted := sort(ucc_duped,-d2i(OriginFilingDate));
      ucc_p := project(ucc_duped_sorted,
                      transform(iesp.ucc.t_UCCReport2Record,
                          self.Debtors    := uccPersonDedup(left.Debtors),
                          self.Debtors2   := uccPersonDedup(left.Debtors2),
                          self.Creditors  := uccPersonDedup(left.Creditors),
                          self.Creditors2 := uccPersonDedup(left.Creditors2),
                          self.Secureds   := uccPersonDedup(left.Secureds),
                          self.Secureds2  := uccPersonDedup(left.Secureds2),
                          self.Assignees  := uccPersonDedup(left.Assignees),
                          self.Assignees2 := uccPersonDedup(left.Assignees2),
                          self := left));
      RETURN ucc_p;
  END;

  EXPORT sexOffRecsByDid(Ioptions in_mod):= FUNCTION
      sexOff_mod := PROJECT(in_mod, PersonReports.IParam.sexoffenses);
      sexOff_raw := PersonReports.sexoffenses_records(in_did,sexOff_mod);
      sexOff_sorted := sort(sexOff_raw, primarykey, -d2i(datelastseen));
      sexOff_duped  := dedup(sexOff_sorted, primarykey);
      sexOff_duped_sorted := sort(sexOff_duped,-d2i(datelastseen));
      RETURN sexOff_duped_sorted;
  END;

  EXPORT crimRecsByDid(Ioptions in_mod):= FUNCTION
      crim_mod := PROJECT(in_mod, PersonReports.IParam.criminal, OPT);
      crim_raw := PersonReports.criminal_records(in_did,crim_mod);
      crim_sorted := sort(crim_raw, offenderid, -d2i(casefilingdate));
      crim_duped  := dedup(crim_sorted, offenderid);
      crim_duped_sorted := sort(crim_duped,-d2i(casefilingdate));
      RETURN crim_duped_sorted;
  END;

  EXPORT cWeaponsRecsByDid(Ioptions in_mod):= FUNCTION
       ccw_mod := PROJECT (in_mod, PersonReports.IParam.ccw);

       ccw_raw := PersonReports.ccw_records(in_did,ccw_mod);
       //SmartRollup.fn_smart_rollup_cweapons
       ccw_sorted := sort(ccw_raw, StateCode, Permit.PermitNumber,Permit.PermitType, -d2i(Permit.ExpirationDate));
       ccw_duped  := dedup(ccw_sorted, StateCode, Permit.PermitNumber,Permit.PermitType);
       ccw_duped_sorted := sort(ccw_duped,-d2i(Permit.ExpirationDate));
       ccw_final := project(ccw_duped_sorted,iesp.concealedweapon.t_WeaponRecord);
       RETURN ccw_final;
  END;

  EXPORT liensRecsByDid(Ioptions in_mod):= FUNCTION
      liens_mod := module (PROJECT(in_mod, PersonReports.IParam.liens, OPT))
         export string1 leins_party_type := PersonSlimReport_Services.Constants.DEBTOR;
      end;
      liens_raw := project(PersonReports.lienjudgment_records(in_did, liens_mod).liensjudgment_v2,
                    iesp.lienjudgement.t_LienJudgmentReportRecord);
      liens_duped := SmartRollup.fn_smart_rollup_liens(liens_raw);
      liens_final := project(liens_duped,
                      transform(iesp.lienjudgement.t_LienJudgmentReportRecord,
                          self.Debtors := dedup(sort(left.Debtors, ssn, originname),ssn),
                          self := left));
      RETURN liens_final;
  END;

  EXPORT huntFishRecsByDid():= FUNCTION
       hfish_raw   := doxie.hunting_records(in_did);
       hfish_clean := SmartRollup.fn_hunting_iesp(hfish_raw);
       //SmartRollup.fn_smart_rollup_hunting
       hfish_sorted := sort(hfish_clean, LicenseState, LicenseNumber, LicenseType, -d2i(LicenseDate));
       hfish_duped  := dedup(hfish_sorted, LicenseState, LicenseNumber, LicenseType);
       hfish_duped_sorted := sort(hfish_duped,-d2i(LicenseDate),LicenseState, licenseNumber, LicenseType);
       RETURN hfish_duped_sorted;
  END;

    EXPORT firearmRecsByDid(ATF_Services.IParam.search_params fire_mod):= FUNCTION
       firearms_raw := ATF_Services.SearchService_Records.report(fire_mod);
       //SmartRollup.fn_smart_rollup_atf
       firearms_raw_sorted:= sort(firearms_raw, LicenseIssueState,LicenseNumber,-d2i(LicenseExpireDate));
       firearms_duped := dedup(firearms_raw_sorted, LicenseIssueState, LicenseNumber);
       firearms_duped_sorted := sort(firearms_duped, -d2i(LicenseExpireDate), LicenseIssueState, LicenseNumber);
       firearms_final := project(firearms_duped_sorted,iesp.firearm.t_FirearmRecord);
       RETURN firearms_final;
    END;

    EXPORT studentRecsByDid(American_Student_Services.IParam.reportParams student_mod):= FUNCTION
      student_raw := American_Student_Services.Functions.get_report_recs(in_did,
                        student_mod,PersonSlimReport_Services.Constants.onlyCurrentStudentRecs);
      student_raw_sorted:= sort(student_raw, CollegeData.Name, -d2i(firstreported), -iscurrent);
      student_duped := dedup(student_raw_sorted, CollegeData.Name, firstreported.year, firstreported.month,
                             firstreported.day);
      student_duped_sorted := sort(student_duped, -d2i(lastreported ));
      RETURN student_duped_sorted;
    END;

    EXPORT marDivRecsByDid(Ioptions in_mod):= FUNCTION
      mardiv_mod := PROJECT(in_mod, PersonReports.IParam.mardiv);
      marDiv_raw := PersonReports.marriagedivorce_records(in_did, mardiv_mod);
      marDiv_raw_sorted:= sort(marDiv_raw, -FilingTypeCode,StateOrigin,FilingNumber,-d2i(marriagedate));
      marDiv_duped := dedup(marDiv_raw_sorted, FilingNumber, StateOrigin, FilingTypeCode);
      marDiv_duped_sorted := sort(marDiv_duped, -d2i(marriagedate));
      RETURN marDiv_duped_sorted;
    END;

    shared accidentRollup(DATASET(iesp.accident.t_AccidentReportRecord) accidents) :=
      rollup(accidents,
            (LEFT.investigation.investigationagent.agentreportnumber = RIGHT.investigation.investigationagent.agentreportnumber)
            OR
            (d2i(LEFT.accidentdate) = d2i(RIGHT.accidentdate) and
            LEFT.accidentstate= RIGHT.accidentstate)
            OR
            (LEFT.accidentdate.year = RIGHT.accidentdate.year and
            (
            LEFT.accidentlocation.stateroadhighwayname = RIGHT.accidentlocation.stateroadhighwayname
            OR
            LEFT.accidentlocation.ofintersectof = RIGHT.accidentlocation.ofintersectof
            ) and
            LEFT.conditions.investigationagent <> RIGHT.conditions.investigationagent)
            OR
            (d2i(LEFT.accidentdate) = d2i(RIGHT.accidentdate) and
            LEFT.accidentlocation.citytownname = RIGHT.accidentlocation.citytownname and
            LEFT.conditions.investigationagent <> RIGHT.conditions.investigationagent)
            OR
            (d2i(RIGHT.accidentdate)=0 and
            LEFT.accidentlocation.citytownname = RIGHT.accidentlocation.citytownname and
            LEFT.accidentlocation.stateroadhighwayname = RIGHT.accidentlocation.stateroadhighwayname and
            LEFT.accidentlocation.ofintersectof = RIGHT.accidentlocation.ofintersectof and
            LEFT.conditions.investigationagent <> RIGHT.conditions.investigationagent),
            TRANSFORM(iesp.accident.t_AccidentReportRecord,
                SELF.accidentdate := pickLatestDate(LEFT.accidentdate,RIGHT.accidentdate),
                SELF.accidentlocation.stateroadhighwayname :=
                     pickLongestStr(LEFT.accidentlocation.stateroadhighwayname,
                                    RIGHT.accidentlocation.stateroadhighwayname),
                SELF.accidentlocation.ofintersectof :=
                    pickLongestStr(LEFT.accidentlocation.ofintersectof,
                                   RIGHT.accidentlocation.ofintersectof),
                SELF.investigation.investigationagent.agentreportnumber :=
                    pickLongestStr(LEFT.investigation.investigationagent.agentreportnumber,
                                   RIGHT.investigation.investigationagent.agentreportnumber),
                SELF := LEFT)  );

    shared accVehiclesDuped(DATASET(iesp.accident.t_AccidentReportVehicle) vehicles) :=
         dedup(sort(vehicles,TagNumber,Make,Model,-(unsigned6)Owner.UniqueId),
                             TagNumber,Make,Model);

    EXPORT accidentRecsByDid(PersonReports.input.accidents acc_mod):= FUNCTION
      acc_raw   := PersonReports.accident_records(in_did, acc_mod);
      acc_clean := project(acc_raw,
                      TRANSFORM(iesp.accident.t_AccidentReportRecord,
                         SELF.accidentlocation.citytownname := STD.Str.FilterOut(LEFT.accidentlocation.citytownname, '"'),
                         SELF.accidentlocation.stateroadhighwayname := STD.Str.FilterOut(LEFT.accidentlocation.stateroadhighwayname, '"'),
                         SELF.accidentlocation.ofintersectof:= STD.Str.FilterOut(LEFT.accidentlocation.ofintersectof, '"'),
                         SELF := LEFT,));
      acc_raw_sorted_1:= sort(acc_clean, -d2i(accidentdate), accidentstate,
                             -investigation.investigationagent.agentreportnumber, -accidentlocation.citytownname);
      acc_rolled_1 :=  accidentRollup(acc_raw_sorted_1);
      acc_raw_sorted_2:= sort(acc_rolled_1, accidentstate,-accidentlocation.citytownname,
                             -investigation.investigationagent.agentreportnumber,-d2i(accidentdate));
      acc_rolled_2 :=  accidentRollup(acc_raw_sorted_2);
      acc_rolled_sorted := sort(acc_rolled_2,-d2i(accidentdate),-accidentlocation.stateroadhighwayname);
      //dedup each inner vehicle dataset
      acc_final := project(acc_rolled_sorted,
                     TRANSFORM(iesp.accident.t_AccidentReportRecord,
                               SELF.Vehicles := accVehiclesDuped(LEFT.Vehicles),
                               SELF := LEFT));
      RETURN acc_final;
    END;

    EXPORT pilotCertRecsByDid(Ioptions in_mod):= FUNCTION
      pil_mod := PROJECT (in_mod, PersonReports.IParam.faacerts, OPT);
      pil_raw  := PersonReports.faacert_records(in_did,pil_mod).bps_view;
      //one certification for each STATE/COUNTY
      //similar logic to - SmartRollup.fn_smart_rollup_faa_cert
      pil_sorted := sort(pil_raw, address.state, address.county, -d2i(DateCertifiedMedical));
      pil_duped  := dedup(pil_sorted, address.state, address.county);
      pil_duped_sorted := sort(pil_duped,-d2i(DateCertifiedMedical));
      pil_final := project(pil_duped_sorted,iesp.bpsreport.t_BpsFAACertification);
      RETURN pil_final;
  END;

  EXPORT propertyRecsByDid(Ioptions in_mod, doxie.IDataAccess mod_access):= FUNCTION
      prop_mod := PROJECT (in_mod, PersonReports.IParam.property, OPT);
      prop_raw   := PersonReports.Property_Records(in_did,mod_access,prop_mod).property_v2;
      prop_clean := project(prop_raw,
                     TRANSFORM(iesp.property.t_PropertyReport2Record,
                        SELF.parcelnumber:= STD.Str.FilterOut(LEFT.parcelnumber, '- '),
                        SELF := LEFT,));
      //field parcelnumber is deprecated in ESP and they use the equivalent Assessment/deed ParcelId
      prop_sorted := sort(prop_clean, recordtype, -parcelnumber,
                         -d2i(assessment.recordingdate),-d2i(deed.recordingdate));
      prop_duped := dedup(prop_sorted, recordtype, parcelnumber);
      prop_duped_sorted := sort(prop_duped, -parcelnumber,
                               -d2i(assessment.recordingdate),-d2i(deed.recordingdate));
      RETURN prop_duped_sorted;
     END;

  EXPORT deaConSubRecsByDid(Ioptions in_mod):= FUNCTION
       dea_mod := PROJECT(in_mod, PersonReports.IParam.dea);
       dea_raw  := PersonReports.dea_records(in_did,dea_mod);
       //SmartRollup.fn_smart_rollup_dea
       dea_sorted := sort(dea_raw, RegistrationNumber, -d2i(controlledSubstancesInfo[1].expirationDate));
       dea_duped  := dedup(dea_sorted, RegistrationNumber);
       dea_duped_sorted := sort(dea_duped,-d2i(controlledSubstancesInfo[1].expirationDate));
       //only keep first name per registration number.
       dea_final := project(dea_duped_sorted,
                      transform(iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record,
                         self.controlledSubstancesInfo := LEFT.controlledSubstancesInfo[1],
                         self := left ));
       RETURN dea_final;
  END;

  EXPORT voterRecsByDid(Ioptions in_mod):= FUNCTION
      vote_mod := PROJECT(in_mod, PersonReports.IParam.voters);
      voter_raw    := PersonReports.voter_records(in_did,vote_mod).voters_v2;
      voter_sorted := sort(voter_raw, RegistrateState, ResidentAddress.county, -d2i(LastVoteDate));
      voter_rolled := rollup(voter_sorted, //SmartRollup.fn_smart_rollup_voter
                        LEFT.RegistrateState = RIGHT.RegistrateState and
                        LEFT.ResidentAddress.county=RIGHT.ResidentAddress.county,
                          TRANSFORM(iesp.voter.t_VoterReport2Record,
                             SELF.dob := pickNonZeroDate(LEFT.dob, RIGHT.dob);
                             SELF     := LEFT));
      voter_rolled_sorted := sort(voter_rolled, -d2i(LastVoteDate),
                                 RegistrateState = '', RegistrateState,
                                 ResidentAddress.county = '', ResidentAddress.county);
      RETURN voter_rolled_sorted;
  END;

  EXPORT pawRecsByDid(Ioptions in_mod):= FUNCTION
       paw_mod := PROJECT(in_mod, PersonReports.IParam.peopleatwork, OPT);
       paw_raw := PersonReports.peopleatwork_records(in_did, paw_mod);

       paw_raw_sorted:= sort(paw_raw,-businessids.ultid,-businessids.orgid,-businessids.seleid,
                            -companyname,-title,-d2i(datelastseen),-d2i(datefirstseen));
       paw_rolled := rollup(paw_raw_sorted,
                            LEFT.businessids.ultid  = RIGHT.businessids.ultid and LEFT.businessids.orgid = RIGHT.businessids.orgid and
                            LEFT.businessids.seleid = RIGHT.businessids.seleid and
                            //this will ensure that empty companyname or title field values will not generate a new record alert
                            ((LEFT.companyname = RIGHT.companyname ) OR (LEFT.companyname <> '' AND RIGHT.companyname = '')) and
                            ((LEFT.title = RIGHT.title) OR (LEFT.title <> '' AND RIGHT.title = '')),
                            TRANSFORM(iesp.peopleatwork.t_PeopleAtWorkRecord,
                               SELF.datelastseen   := pickLatestDate(LEFT.datelastseen,  RIGHT.datelastseen);
                               SELF.datefirstseen  := pickLatestDate(LEFT.datefirstseen, RIGHT.datefirstseen);
                               SELF.companyname    := pickLongestStr(LEFT.companyname, RIGHT.companyname);
                               SELF.title          := pickLongestStr(LEFT.title, RIGHT.title);
                               SELF := LEFT)  );
       //put latest on top
       paw_rolled_sorted := sort(paw_rolled,-d2i(datelastseen),-d2i(datefirstseen));
       RETURN paw_rolled_sorted;
  END;

  EXPORT utilityRecsByDid(Ioptions in_mod):= FUNCTION
       utils := doxie.Util_records(in_did, in_mod.ssn_mask, in_mod.dl_mask > 0, in_mod.glb, in_mod.industry_class);
       iesp.personslimreport.t_PersonSlimReportUtility transUtil(doxie_crs.layout_utility.record_layout_slim L)  := TRANSFORM
       self.utiltype                := L.util_type;
       self.utilcategory            := L.util_category;
       self.utiltypedescription     := L.util_type_description;
       self.connectdate             := iesp.ECL2ESP.toDateString8 (L.connect_date);
       self.datefirstseen           := iesp.ECL2ESP.toDateString8 (L.date_first_seen);
       self.recorddate              := iesp.ECL2ESP.toDateString8 (L.record_date);
       self.name                    := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,'');
       self.ssn                     := L.ssn;
       self.dob                     := iesp.ECL2ESP.toDateString8 (L.dob);
       self.driverslicensestatecode := L.drivers_license_state_code;
       self.driverslicense          := L.drivers_license;
       self.workphone               := L.work_phone;
       self.phone                   := L.phone;
       self.addrdual                := L.addr_dual;
       self.addresses               := PROJECT(L.address_recs,
       TRANSFORM(iesp.share.t_Address,
           SELF := iesp.ECL2ESP.SetAddress(
           LEFT.prim_name,LEFT.prim_range,LEFT.predir,LEFT.postdir,
           LEFT.addr_suffix,LEFT.unit_desig,LEFT.sec_range,
           LEFT.city,LEFT.state,LEFT.zip,LEFT.zip4,LEFT.county_name)));
       END;
       util_raw    := PROJECT(utils,transUtil(LEFT));
       util_sorted := sort(util_raw, UtilType, -d2i(RecordDate));
       util_duped  := dedup(util_sorted, UtilType, RecordDate.Year,
       RecordDate.Month, RecordDate.Day);
       util_duped_sorted := sort(util_duped,-d2i(RecordDate));
       RETURN util_duped_sorted;
    END;

END;
