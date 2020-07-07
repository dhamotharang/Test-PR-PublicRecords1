import suppress;

export DATASET(bankruptcyv3_services.layouts.layout_party_ext)
  fn_mask_ssns(DATASET(bankruptcyv3_services.layouts.layout_party_ext) parties,
               string6 in_ssn_mask) := FUNCTION

      DATASET(bankruptcyv3_services.layouts.layout_name) maskPartySSNs(DATASET(bankruptcyv3_services.layouts.layout_name) ptys) := FUNCTION
        Suppress.MAC_Mask(ptys, ptys1, app_ssn, null, true, false, maskVal:=in_ssn_mask);
        Suppress.MAC_Mask(ptys1, ptys_masked, ssn, null, true, false, maskVal:=in_ssn_mask);
        RETURN ptys_masked;
      END;

      bankruptcyv3_services.layouts.layout_party_ext xt(bankruptcyv3_services.layouts.layout_party_ext l) := TRANSFORM
        SELF.names := maskPartySSNs(l.names);
        SELF := l
      END;

      // Mask the SSNs in the child dataset (names)
      parties_masked := project(parties, xt(LEFT));

      // Mask the top level SSNs
      Suppress.MAC_Mask(parties_masked, parties_masked1, app_ssn, null, true, false, maskVal:=in_ssn_mask);
      Suppress.MAC_Mask(parties_masked1, parties_masked2, ssn, null, true, false, maskVal:=in_ssn_mask);
      Suppress.MAC_Mask(parties_masked2, all_masked, ssnmatch, null, true, false, maskVal:=in_ssn_mask);

      return all_masked;
END;
