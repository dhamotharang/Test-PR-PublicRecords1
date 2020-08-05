IMPORT Address, Census_data, DeathV2_Services, DidVille, doxie, doxie_crs, dx_death_master, header,
       IdentityManagement_Services, iesp, ut;

EXPORT iesp.identitymanagementreport.t_IdmNeighborAddress NeighborsRecords(IdentityManagement_Services.IParam._report in_params, DATASET (doxie.layout_references) dids) := FUNCTION

mod_access := PROJECT (in_params, doxie.IDataAccess);

doxie_nbrs := doxie_crs.nbr_records(mode = 'C');
nbr_dids := DEDUP(SORT(
                      PROJECT(UNGROUP(doxie_nbrs),TRANSFORM(doxie.layout_references, SELF.did := LEFT.did)),
                  did),did);

best_akas := doxie.best_records (nbr_dids, , , , TRUE, header.constants.checkRNA, modAccess := mod_access);

subject_ssn_ds:= JOIN(dids, DidVille.key_did_ssn, KEYED(LEFT.did = RIGHT.did),
                      LIMIT(0), KEEP(IdentityManagement_Services.Constants.MaxSSNperDID));

subject_ssn_set := SET(subject_ssn_ds, ssn);
aka_src := best_akas(~(ssn_unmasked IN subject_ssn_set) OR fname = '' OR lname = ''); // 28 vs 27 records for did = 189036092.

UNSIGNED1 GetAge (INTEGER4 dob) := IF (dob<>0, ut.Age(dob), 0); //Quick function to get age

iesp.identitymanagementreport.t_IdmIdentity resident_section (aka_src L) := TRANSFORM
  SELF.UniqueId := (STRING)L.DID;
  SELF.Name     := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,L.title);
  SELF.DOB      := iesp.ECL2ESP.toDate(L.DOB);
  SELF.age      := getage(L.DOB);
  SELF.ssn      := L.ssn;
  SELF.Gender   := iesp.ECL2ESP.GetGender (L.title);
  SELF          := []; //AKAs (so far are only returned for Relatives)
END;

fill_identities := PROJECT(aka_src,resident_section(LEFT)); // Lets fill identity info from best records.

rna_glb_ok := mod_access.isValidGLB(header.constants.checkRNA);
death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);

nbrs_correct_age_w_d_appended := dx_death_master.Append.byDid(fill_identities, UniqueId, death_params,/*skip_glb_check=*/TRUE);
nbrs_correct_age_w_d_glb_ok := nbrs_correct_age_w_d_appended(rna_glb_ok OR death.glb_flag <> 'Y');

iesp.identitymanagementreport.t_IdmIdentity GetDead (RECORDOF(nbrs_correct_age_w_d_glb_ok) L):=TRANSFORM
  // there can be different DOB in death_master index and best records, thus take DOB from the left side, if dead, get age at death
  left_dob := (STRING4) L.DOB.year + INTFORMAT (L.DOB.month, 2, 1) + INTFORMAT (L.DOB.day, 2, 1);
  SELF.Age := IF( L.death.is_deceased, ut.Age((UNSIGNED8)left_dob, (UNSIGNED8)L.death.dod8), L.Age);
  SELF := L; // copy about 25 fields
END;

nbrs_correct_age := PROJECT(nbrs_correct_age_w_d_glb_ok, GetDead(LEFT));

GetLocationID (iesp.share.t_Address addr) := FUNCTION
  STRING str_addr :=  TRIM (addr.City) + ';' + TRIM (addr.State) + ';' + TRIM (addr.StreetName) + ';' + TRIM (addr.StreetNumber) + ';' +
                      TRIM (addr.StreetPostDirection) + ';' + TRIM (addr.StreetSuffix) + ';' + TRIM (addr.UnitDesignation) + ';' +
                      TRIM (addr.StreetPreDirection) + ';' +  TRIM (addr.UnitNumber) + ';'  +  TRIM (addr.Zip5) + ';' + TRIM (addr.Zip4);
   // ESP in addition encodes it, but cleaned input address shouldn't contain XML-invalid characters.
  RETURN str_addr;
END;

countyName(STRING2 st,STRING3 county) := Census_data.Key_Fips2County(KEYED(st=state_code AND county=county_fips))[1].county_name;

temp_nbrs_iesp:= RECORD
  iesp.identitymanagementreport.t_IdmNeighborAddress;
  UNSIGNED2    seqTarget;
  UNSIGNED2    seqNPA;
  UNSIGNED2    seqNbr;
END;

temp_nbrs_iesp SetNeighborsAddresses (doxie_nbrs L, nbrs_correct_age R) := TRANSFORM
  SELF.Residents      := R;
  SELF.DateLastSeen   := iesp.ECL2ESP.toDateYM(L.dt_last_seen);
  SELF.DateFirstSeen  := iesp.ECL2ESP.toDateYM(L.dt_First_seen);
  addr := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                                         L.suffix, L.unit_desig, L.sec_range,
                                         L.city_name, L.st, L.zip, L.zip4,
                                         IF(L.st!='' AND L.county_name!='',countyName(L.st,L.county_name[3..5]),''),
                                         '',// Postal Code,
                                         Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix,
                                                                     l.postdir, l.unit_desig, l.sec_range), // addr1
                                         '', //addr2
                                         Address.Addr2FromComponents(l.city_name, l.st, l.zip));// statecityzip
  SELF.Address         := addr;
  SELF.LocationId      := GetLocationID(addr);
  SELF                 := L;
END;

// Now lets fill in address and other fields
_neighbors := JOIN(doxie_nbrs, nbrs_correct_age, LEFT.did = (INTEGER)RIGHT.UniqueId, SetNeighborsAddresses(LEFT, RIGHT), LIMIT(0), KEEP(1));

// join does not quarantee the sorting order so need to sort back. We loose 1 (out of 4) column on which it was sorted : bestCN_reduced
neighbors := PROJECT(DEDUP(SORT(_neighbors, seqTarget, seqNPA, seqNbr),record),iesp.identitymanagementreport.t_IdmNeighborAddress);

  RETURN neighbors;
END;
