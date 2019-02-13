import iesp, seed_files;

// returns sample output by hash based on the user input
ifr := iesp.identityfraudreport;
ts := Seed_Files.layout_identityreport;

out_rec := iesp.identityfraudreport.t_IdentityFraudReportResponse;

EXPORT out_rec IdentityFraudReportTest (dataset (ts.rec_in_slim) ds_match) := FUNCTION

  // dataset (ifr.t_ColoredRiskIndicator) SetIndicators (ts.rec_info L) := function
    // all_ind := dataset (L.RI_1) + dataset (L.RI_2) + dataset (L.RI_3) + dataset (L.RI_4);
    // return all_ind (all_ind.Rank != 0);
  // end;
    
  // dataset (ifr.t_IFRLinkIdSources) SetSources (ts.rec_info L) := function
    // s := L.SRC;
    // all_src := dataset (s.src_1) + dataset (s.src_2) + dataset (s.src_3) + dataset (s.src_4) + dataset (s.src_5) +
               // dataset (s.src_6) + dataset (s.src_7) + dataset (s.src_8) + dataset (s.src_9) + dataset (s.src_10);
    // return all_src (all_src.Count > 0);
  // end;

  MAC_SetCommon () := MACRO
    info := project (L, transform (ts.rec_info, Self := Left));
    all_ind := dataset (info.RI_1) + dataset (info.RI_2) + dataset (info.RI_3) + dataset (info.RI_4);
    Self.RiskIndicators := all_ind (all_ind.Rank != 0);
    s := info.SRC;
    all_src := dataset (s.src_1) + dataset (s.src_2) + dataset (s.src_3) + dataset (s.src_4) + dataset (s.src_5) +
               dataset (s.src_6) + dataset (s.src_7) + dataset (s.src_8) + dataset (s.src_9) + dataset (s.src_10);
    Self.Sources := all_src (all_src.Count > 0);
    // Self.RiskIndicators := SetIndicators (info);
    // Self.Sources := SetSources (info);
  ENDMACRO;
 
  ifr.t_IFRLinkId SetLinkID (Seed_Files.layout_identityreport.rec_linkid L) := transform
    MAC_SetCommon ();
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [UniqueId, _Type]
  end;

  ifr.t_IFRName SetName (Seed_Files.layout_identityreport.rec_name L) := transform
    MAC_SetCommon ();
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [Name]
  end;

  ifr.t_IFRSSN SetSSN (Seed_Files.layout_identityreport.rec_ssn L) := transform
    MAC_SetCommon ();
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [SSNData]
  end;

  ifr.t_IFRAddress SetAddress (Seed_Files.layout_identityreport.rec_address L) := transform
    MAC_SetCommon ();
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [Address]
  end;

  ifr.t_IFRPhone SetPrimaryPhone (Seed_Files.layout_identityreport.rec_phone L) := transform
    MAC_SetCommon ();
    Self.ListingTypes := dataset ([L.ListingType], iesp.share.t_StringArrayItem)(value != '');
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [phone]
  end;

  ifr.t_IFRDOB SetDOB (Seed_Files.layout_identityreport.rec_dob L) := transform
    MAC_SetCommon ();
    iesp.share.t_MaskableDate xform (iesp.share.t_Date L) := transform
      Self.Year := (string) L.Year;
      Self.Month := (string) L.Month;
      Self.Day := (string) L.Day;
    end;
    Self.DOB2 := row (xform (L.DOB));
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [DOB]
  end;

  ifr.t_IFRDriverLicense SetPrimaryDL (Seed_Files.layout_identityreport.rec_dl L) := transform
    MAC_SetCommon ();
    Self := L; // DateFirstSeen, DateLastSeen, SourceCount, [DL]
  end;

  ifr.t_IFRPrimaryIdentity SetPrimaryIdentity (ts.rec_prim_identity L) := transform
    Self.LinkIdInfo := project (L.LII, SetLinkID (Left));
    Self.NameInfo := project (L.NI, SetName (Left));
    Self.SSNInfo := project (L.SI, SetSSN (Left));
    Self.AddressInfo := project (L.AI, SetAddress (Left));
    Self.PhoneInfo := (project (L.PI_1, SetPrimaryPhone (Left)) + 
                      project (L.PI_2, SetPrimaryPhone (Left))) (Phone10 != '');
    Self.DOBInfo := project (L.DI, SetDOB (Left));
    Self.DriverLicense := project (L.DL, SetPrimaryDL (Left));
    Self := L;
		Self := [];
  end;

  ifr.t_IFRAssociatedIdentity SetImposterIdentity (ts.rec_assoc_identity L) := transform
    Self.LinkIdInfo := project (L.LII, SetLinkID (Left));
    Self.NameInfo := project (L.NI, SetName (Left));
    Self.SharedSSNs := project (L.SI, SetSSN (Left));
    Self.AddressInfo := project (L.AI, SetAddress (Left));
    Self.PhoneInfo := project (L.PI, SetPrimaryPhone (Left));
    Self.DOBInfo := project (L.DI, SetDOB (Left));
    Self.IsLimitedAccessDMF := False;
    Self := L;
  end;
    
  // ========================================================================
  // Get report together
  // ========================================================================
  out_rec Format (ts.rec_in L) := TRANSFORM
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();

    Self.ReportSummary.RiskIndicators := []; // it is deprecated now; assigned only by explicit request

    Self.PrimaryIdentity := project (L.pi, SetPrimaryIdentity (Left));

    name_1 := project (L.AD_N_1, SetName (Left)); 
    name_2 := project (L.AD_N_2, SetName (Left)); 
    Self.AssociatedData.Names := (name_1 + name_2) (NAME.last != '');

    Self.AssociatedData.SSNs := project (L.AD_SSN, SetSSN (Left));
    Self.AssociatedData.DOBs := project (L.AD_DOB, SetDOB (Left));

    address_1 := project (L.AD_ADDR_1, SetAddress (Left)); 
    address_2 := project (L.AD_ADDR_2, SetAddress (Left)); 
    Self.AssociatedData.Addresses := (address_1 + address_2) (Address.zip5 != '');

		Self.AssociatedData.EmailAddresses := [];
		
    imp_1 := project (L.imposter_1, SetImposterIdentity (Left));
    imp_2 := project (L.imposter_2, SetImposterIdentity (Left));
    Self.AssociatedIdentities := (imp_1 + imp_2)(LinkIdInfo.UniqueID != '');

    Self.MoreAssociatedIdentities := L.MoreAssociatedIdentities;
  END;

  ds_wide := project (ds_match, transform (ts.rec_in, Self := Left, Self := [];));
  return project (ds_wide, Format (Left)); // at most one row

end;
