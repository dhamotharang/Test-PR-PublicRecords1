EXPORT ValidateInput := MODULE

  SHARED boolean hasTxt(string s1) := TRIM(s1)<>'';
  SHARED boolean hasNum(integer n1) := n1>0;

  EXPORT BuildValidityRecs(
    DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in
  ) := FUNCTION

    FraudShared_Services.Layouts.BatchIn_Valid_rec xfm_ValidRecs(FraudShared_Services.Layouts.BatchIn_rec L) := TRANSFORM

      boolean hasFullName := hasTxt(L.name_first) AND hasTxt(L.name_last);
      boolean hasPhysicalAddress := hasTxt(L.z5) OR hasTxt(L.st) OR hasTxt(L.p_city_name);
      boolean hasMailingAddress := hasTxt(L.mailing_z5) OR hasTxt(L.mailing_st) OR hasTxt(L.mailing_p_city_name);
      boolean hasSSN := hasTxt(L.ssn);
      boolean hasDOB := hasTxt(L.dob);
      boolean hasPhone := hasTxt(L.phoneno);
      boolean hasPerson := hasNum(L.did);
      boolean hasBusiness := hasNum(L.seleid) AND hasNum(L.orgid) AND hasNum(L.ultid);
      boolean hasEmailAddress := hasTxt(L.email_address);
      boolean hasDevice := hasTxt(L.device_id);
      boolean hasIpAddress := hasTxt(L.ip_address);
      boolean hasProfessionalid := hasTxt(L.professionalid);
      boolean hasLnpid := hasNum(L.lnpid);
      boolean hasNpi := hasTxt(L.npi);
      boolean hasAppendedproviderid := hasNum(L.appendedproviderid);
      boolean hasTin := hasTxt(L.tin);
      boolean hasGeo := hasTxt(L.geo_lat) AND hasTxt(L.geo_long);
      boolean hasBankAccount := hasTxt(L.bank_account_number);
      boolean hasDL := hasTxt(L.dl_state) AND hasTxt(L.dl_number);

      SELF.hasFullName           := hasFullName;
      SELF.hasPhysicalAddress    := hasPhysicalAddress;
      SELF.hasMailingAddress     := hasMailingAddress;
      SELF.hasSSN                := hasSSN;
      SELF.hasDOB                := hasDOB;
      SELF.hasPhone              := hasPhone;
      SELF.hasPerson             := hasPerson;
      SELF.hasBusiness           := hasBusiness;
      SELF.hasEmailAddress       := hasEmailAddress;
      SELF.hasDevice             := hasDevice;
      SELF.hasIpAddress          := hasIpAddress;
      SELF.hasProfessionalid     := hasProfessionalid;
      SELF.hasLnpid              := hasLnpid;
      SELF.hasNpi                := hasNpi;
      SELF.hasAppendedproviderid := hasAppendedproviderid;
      SELF.hasTin                := hasTin;
      SELF.hasGeo                := hasGeo;
      SELF.hasBankAccount        := hasBankAccount;
      SELF.hasDL                 := hasDL;
      SELF.hasValidInput         := (hasFullName OR hasPhysicalAddress OR hasMailingAddress OR hasSSN OR hasDOB OR hasPhone 
                                     OR hasPerson OR hasBusiness OR hasEmailAddress OR hasDevice OR hasIpAddress OR hasProfessionalid
                                     OR hasLnpid OR hasNpi OR hasAppendedproviderid OR hasTin OR hasGeo OR hasBankAccount OR hasDL);
      SELF := L,    
    END;

    ds_validRecs := PROJECT (ds_batch_in, xfm_ValidRecs(LEFT));
    RETURN ds_validRecs;

  END;

END;