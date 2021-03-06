IMPORT iesp, Doxie_Raw, UT, PersonSlimReport_Services;
// suppression and minor checks are done before calling this
EXPORT Death_records (DATASET({unsigned6 did}) dids,
            PersonSlimReport_Services.IParams.PersonSlimReportOptions in_mod) := FUNCTION
 
  death_raw      := Doxie_Raw.death_raw(dids,,,in_mod.DPPAPurpose,in_mod.GLBPurpose,in_mod.ssn_mask);
  death_raw_bdod := death_raw(in_mod.IncludeBlankDOD or (unsigned)dod8 != 0);
  
  iesp.death.t_DeathReportRecord toDeathIesp(doxie_raw.Layout_Death_Raw L) := TRANSFORM
    self.statedeathid     := L.state_death_id;
    self.sourcestate      := L.source_state;
    self.county           := L.county_name;
    self.verifiedorproved := L.vorp_code;
    self.source           := L.src;
    self.decedent.name    := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,'');
    self.decedent.address := iesp.ECL2ESP.SetAddress(L.prim_name,L.prim_range,L.predir,L.postdir,L.addr_suffix,
                                                     L.unit_desig,L.sec_range,L.p_city_name,L.state,
                                                     L.zip5,L.zip4,L.county_name);
    self.decedent.dob                       := iesp.ECL2ESP.toDatestring8 (L.dob8);
    self.decedent.dod                       := iesp.ECL2ESP.toDatestring8 (L.dod8);
    self.decedent.sex                       := L.decedent_sex;
    self.decedent.race                      := L.decedent_race;
    self.decedent.uniqueid                  := L.did;
    self.decedent.ssn                       := L.ssn;
    self.decedent.birthplace                := L.birthplace;
    self.decedent.deathage                  := L.dead_age;
    self.decedent.deathageunit              := L.dead_age_unit;
    self.decedent.birthcertificatenumber    := L.birth_cert;
    self.decedent.birthvolyear              := L.birth_vol_year;
    self.decedent.education                 := L.education;
    self.decedent.armedforces               := ut.String2TriStateBool(L.us_armed_forces);
    self.decedent.occupation                := L.occupation;
    self.decedent.maritalstatus             := L.marital_status;
    self.family.father                      := L.father;
    self.family.mother                      := L.mother;
    self.deathinfo.issuingauthority         := L.death_rec_src;
    self.deathinfo.certificatenumber        := L.cert_number;
    self.deathinfo.certificatefiledate      := iesp.ECL2ESP.toDatestring8 (L.filedate);
    self.deathinfo.certificatevolnumber     := L.certificate_vol_no;
    self.deathinfo.certificatevolyear       := (integer)L.certificate_vol_year;
    self.deathinfo.localfilenumber          := L.local_file_no;
    self.deathinfo.funeralhomelicensenumber := L.est_lic_no;
    self.deathinfo.embalmerlicensenumber    := L.embalmer_lic_no;
    self.deathinfo.ziplastpayment           := L.zip_lastpayment;
    self.deathinfo.causeofdeath             := L.cause_of_death;
    self.deathinfo.timeofdeath              := L.time_death;
    self.deathinfo.deathlocation            := L.death_location;
    self.deathinfo.facilty                  := L.facility_death;
    self.deathinfo.deathtype                := L.death_type;
    self.deathinfo.disposition              := L.disposition;
    self.deathinfo.dispositiondate          := iesp.ECL2ESP.toDatestring8 (L.disposition_date);
    self.deathinfo.autopsy                  := L.autopsy;
    self.deathinfo.autopsyfindings          := L.autopsy_findings;
    self.deathinfo.medicalexamination       := L.med_exam;
    self.deathinfo.workinjury               := ut.String2TriStateBool(L.work_injury);
    self.deathinfo.injurydate               := iesp.ECL2ESP.toDatestring8 (L.injury_date);
    self.deathinfo.injurylocation           := L.injury_location;
    self.deathinfo.surgeryperformed         := ut.String2TriStateBool(L.surg_performed);
    self.deathinfo.surgerydate              := iesp.ECL2ESP.toDatestring8 (L.surgery_date);
    self.deathinfo.pregnancy                := L.pregnancy;
    self.deathinfo.certifier                := L.certifier;
    self.deathinfo.hospitalstatus           := L.hospital_status;
  END;
  
  death_iesp := PROJECT(death_raw_bdod,toDeathIesp(LEFT));
  RETURN death_iesp;
END;