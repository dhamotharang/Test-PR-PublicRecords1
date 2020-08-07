IMPORT Business_Header,doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

EXPORT best_rest(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

srcrec := RECORD
  BOOLEAN isRel := FALSE;
  BOOLEAN isOAA := FALSE;
  BOOLEAN isByC := FALSE;
  BOOLEAN isNMV := FALSE; //name variations
  doxie_cbrs.Layout_BH_Best_String;
  UNSIGNED6 did := 0;
  UNSIGNED2 score := 0;
  //Business_Header.Layout_BH_Best
END;

//***** others at address
relbdids := doxie_cbrs.Associated_Business_bdids();
srcrec markem1(relbdids l) := TRANSFORM
  SELF.isOAA := TRUE;
  SELF.bdid := l.bdid;
  SELF := [];
END;

wsource1 := PROJECT(relbdids(doxie_Cbrs.is_InOAA(relbdids)), markem1(LEFT));


//***** name variations
nmvbdids := doxie_cbrs_raw.name_variations(Include_NameVariations_val, Max_NameVariations_val).records;
srcrec marknmv(nmvbdids l) := TRANSFORM
  SELF.isNMV := TRUE;
  SELF.bdid := l.bdid;
  SELF := [];
END;

wsourcenmv := PROJECT(nmvbdids, marknmv(LEFT));


//***** contact affiliation
bycbdids := doxie_cbrs.Associated_Business_byContact_bdids(bdids);
srcrec markem2(bycbdids l) := TRANSFORM
  SELF.isByC := TRUE;
  SELF.bdid := l.bdid;
  SELF.did := l.did;
  SELF.score := l.score;
  SELF := [];
END;

wsource2 := PROJECT(bycbdids, markem2(LEFT));

wsource := DEDUP(SORT(wsource1 & wsourcenmv & wsource2, bdid, isByC), bdid); //this drops the ByC where already
doxie_cbrs.mac_best_records(wsource, best_info, srcrec)

RETURN best_info;
END;
