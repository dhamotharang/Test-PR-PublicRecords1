IMPORT ut, suppress, doxie, Prof_LicenseV2;
doxie_cbrs.mac_Selection_Declare()

EXPORT proflic_records_dayton(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  outrec := doxie_cbrs.layouts.proflic_record;
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  //GET ADDRESSES AND COMPANY NAME TUPLES FOR THE BDID
  subadd := doxie_Cbrs.best_address_full(bdids)(Include_ProfessionalLicenses_val);

  // TRANSFORM TO PUT A SEQUENCE NUMBER ON THE ADDRESS-NAME TUPLES
  {subadd,UNSIGNED seq2} projbaf(subadd l, UNSIGNED c) := TRANSFORM
    SELF.seq2 := c;
    SELF := l;
  END;

  // ADD SEQUENCE NUMBER TO ADDRESS-NAME TUPLES
  baf := PROJECT(subadd,projbaf(LEFT,COUNTER));

  // if you are wondering why I did this and didn't reuse the existing proflic_records
  // attribute, see bugzilla 14832.
  BOOLEAN companies_match (STRING l, STRING r) := IF (ut.CompanySimilar100(l,r) <=30, TRUE, FALSE);

  // TRANSFORM TO CAPTURE THE SEQUENCE NUMBERS OF THOSE ADDRESS-NAME TUPLES DEEMED "CLOSE MATCHES" TO OTHERS
  {UNSIGNED seq2} trimbaf(baf r) := TRANSFORM
    SELF := r;
  END;

  // CAPTURE THE SEQUENCE NUMBERS TO ELIMINATE
  baf2 := DEDUP(SORT(JOIN(baf,baf,
              LEFT.seq2 < RIGHT.seq2 AND
              LEFT.prim_name <> '' AND
              LEFT.prim_name = RIGHT.prim_name AND
              LEFT.prim_range = RIGHT.prim_range AND
              LEFT.zip = RIGHT.zip AND
              ut.nneq(LEFT.sec_range,RIGHT.sec_range) AND
              companies_match(LEFT.company_name,RIGHT.company_name),
              trimbaf(RIGHT),LEFT OUTER),RECORD),RECORD);

  // TRANSFORM TO CAPTURE THE NON-ELIMINATED ADDRESS-NAME TUPLES
  subadd keepbaf(baf r) := TRANSFORM
    SELF := r;
  END;

  // RIGHT OUTER JOIN TO GET ONLY THOSE ADDRESS-NAME TUPLES NOT ELIMINATED
  baf3 := JOIN(baf2,baf,LEFT.seq2=RIGHT.seq2,keepbaf(RIGHT),RIGHT only);

  // KEY INTO PROFESSIONAL LICENSES
  kap := Prof_LicenseV2.key_addr_proflic;

  // TRANSFORM TO CAPTURE PROLIC RECORDS MATCHING OUR ADDR-NAME TUPLES
  Prof_LicenseV2.Layouts_ProfLic.Layout_Base keepk(kap r) := TRANSFORM
    SELF := r;
  END;

  // USE ADDR-NAME TO CAPTURE PROFESSIONAL LICENSES
  _sn := JOIN(baf3, kap,
            LEFT.prim_name<>'' AND
            KEYED(LEFT.prim_name = RIGHT.prim_name) AND
            KEYED(LEFT.prim_range = RIGHT.prim_range) AND
            KEYED(LEFT.zip = RIGHT.zip) AND
            companies_match(LEFT.company_name,RIGHT.company_name) AND
            ut.NNEQ(LEFT.sec_range, RIGHT.sec_range),
            keepk(RIGHT),
            LIMIT(50000, SKIP));

  sn_suppressed := Suppress.MAC_SuppressSource(_sn, mod_access);
  sn := PROJECT(sn_suppressed, outrec);

  // MASK SSN
  doxie_Cbrs.mac_mask_ssn(sn, msk1, best_ssn)

  // SORT ON PROLIC IDENTIFIER AND ADDRESS
  srtd := SORT(msk1, prolic_key, prim_range, prim_name, zip);

  // TRANSFORM TO ROLL UP DATE FIRST SEEN AND DATE LAST SEEN
  srtd rollem(srtd l, srtd r) := TRANSFORM
    ut.mac_roll_dfs(date_first_seen)
    ut.mac_roll_dls(date_last_seen)
    SELF := l;
  END;

  // ROLLUP DFS AND DLS ON PROLIC ID AND ADDRESS
  rlld := ROLLUP(srtd,
                LEFT.prolic_key = RIGHT.prolic_key AND
                LEFT.prim_range = RIGHT.prim_range AND
                LEFT.prim_name = RIGHT.prim_name AND
                LEFT.zip = RIGHT.zip,
                rollem(LEFT, RIGHT));


  // PICK THE FIRST N AFTER SORTING BY LICENSEE NAME
  RETURN CHOOSEN(SORT(rlld, lname, fname, mname),Max_ProfessionalLicenses_val);
END;
