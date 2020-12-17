IMPORT doxie, LN_PropertyV2, Census_Data, Suppress, ut, AutoStandardI;

k_fips			:= Census_Data.Key_Fips2County;

l_raw				:= layouts.parties.raw_source;
l_fid				:= layouts.fid;
l_tmp1			:= {
  layouts.parties.tmp1;
  unsigned2 county_pen_1;
  unsigned2 county_pen_2;
  unsigned2 penalt_1;
  unsigned2 penalt_2;
  unsigned2 cPenalt_1;
  unsigned2 cPenalt_2;
  unsigned8 persistent_record_id;  //added so that two sellers that are both restricted do not get deduped to one
  };
l_tmp2			:= {
  layouts.parties.tmp2;
  unsigned2 county_pen_1;
  unsigned2 county_pen_2;
  unsigned2 penalt_1;
  unsigned2 penalt_2;
  unsigned2 cPenalt_1;
  unsigned2 cPenalt_2;
  unsigned8 persistent_record_id;
  };
l_entity		:= layouts.parties.entity;
l_pparty		:= layouts.parties.pparty;
l_rolled		:= layouts.parties.rolled;
l_out				:= l_rolled;

max_raw			:= consts.max_raw;
max_parties	:= consts.max_parties;

max_penalt	:= 100;
min_penalt	:= 0;

boolean TwoPartySearch := FALSE : stored('TwoPartySearch');

export dataset(l_out) fn_get_parties(
  dataset(l_raw) ds_raw,
  boolean isFCRA = false
) := function

gm := AutoStandardI.GlobalModule(isFCRA);

//$.input module doesn't allow to pass isFCRA to clean input ssn, so defined it here
string9 ssn := AutoStandardI.InterfaceTranslator.ssn_value.val(project(gm,AutoStandardI.InterfaceTranslator.ssn_value.params));

temp_mod_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI.base,opt))
end;
temp_mod_2 := module(project(temp_mod_1,AutoStandardI.LIBIN.PenaltyI.base,opt))
  export firstname := gm.entity2_firstname;
  export middlename := gm.entity2_middlename;
  export lastname := gm.entity2_lastname;
  export unparsedfullname := gm.entity2_unparsedfullname;
  export allownicknames := gm.entity2_allownicknames;
  export phoneticmatch := gm.entity2_phoneticmatch;
  export companyname := gm.entity2_companyname;
  export addr := gm.entity2_addr;
  export city := gm.entity2_city;
  export state := gm.entity2_state;
  export zip := gm.entity2_zip;
  export zipradius := gm.entity2_zipradius;
  export phone := gm.entity2_phone;
  export fein := gm.entity2_fein;
  export bdid := gm.entity2_bdid;
  export did := gm.entity2_did;
  export ssn := gm.entity2_ssn;
end;

  // compute penalties for property addresses (i.e. those records whose type is 'P')
  ds_pa := dedup( sort( ds_raw(source_code_2='P'), ln_fares_id, search_did, -dt_last_seen, record ), ln_fares_id, search_did );

  l_paPen := { layouts.fid; unsigned2 penalt_1; unsigned2 penalt_2; unsigned2 cPenalt_1; unsigned2 cPenalt_2; }; // fid, panalt, cPenalt

  l_paPen addPen(ds_pa L) := transform
    temp_addr_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
      export predir_field := L.predir;
      export prange_field := L.prim_range;
      export pname_field := L.prim_name;
      export suffix_field := L.suffix;
      export postdir_field := L.postdir;
      export city_field := L.v_city_name;
      export city2_field := L.p_city_name;
      export state_field := L.st;
      export zip_field := L.zip;
      export allow_wildcard := false;
    end;
    self.penalt_1 := AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_addr_mod(temp_mod_1));
    self.penalt_2 := IF (TwoPartySearch, AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_addr_mod(temp_mod_2)), 0);
    self.cPenalt_1 := if(input.cname='', max_penalt, min_penalt);
    self.cPenalt_2 := IF (TwoPartySearch, if(input.cname_2='', max_penalt, min_penalt), max_penalt);
    self := L;
  end;

  paPen := project(ds_pa, addPen(left));


  // add computed fields
  l_tmp1 addValue(ds_raw L) := transform

    // DID/BDID ---------------------------------------
    self.did	:= if(L.did<>0,		(string12)L.did,	'');
    self.bdid	:= if(L.bdid<>0,	(string12)L.bdid,	'');


    // Penalty ----------------------------------------
    // pen_addr_1	:= if(input.paSearch, max_penalt, doxie.FN_Tra_Penalty_Addr(
                    // L.predir, L.prim_range, L.prim_name, L.suffix, L.postdir, L.sec_range,
                    // L.v_city_name, L.st, L.zip, , L.p_city_name));
    // paRec_1			:= paPen(ln_fares_id=L.ln_fares_id);
    // pen_paddr_1	:= if(exists(paRec), paRec[1].penalt, max_penalt);
    paRec				:= paPen(ln_fares_id=L.ln_fares_id);
    temp_ssn_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
      export ssn_field := L.app_ssn;
    end;
    temp_did_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
      export did_field := (string)L.did;
    end;
    temp_bdid_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
      export bdid_field := (string)L.bdid;
    end;
    temp_indvname_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
      export fname_field := L.fname;
      export mname_field := L.mname;
      export lname_field := L.lname;
      export allow_wildcard := false;
    end;
    temp_phone_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
      export phone_field := L.phone_number;
    end;
    temp_bizname_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
      export cname_field := L.cname;
    end;
    temp_addr_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
      export predir_field := L.predir;
      export prange_field := L.prim_range;
      export pname_field := L.prim_name;
      export suffix_field := L.suffix;
      export postdir_field := L.postdir;
      export city_field := L.v_city_name;
      export city2_field := L.p_city_name;
      export state_field := L.st;
      export zip_field := L.zip;
      export allow_wildcard := false;
    end;

    // Enhancement/Bug: 64514 -- fn_penaltySourceCode is a new penalty
    // 20101015 - Created for a USLM enhancement
    // If the source_code is in the filter set, then we don't
    // want to impact the penalty.  However, if the souce_code is
    // not in the filter set, then we want the penalty to be high
    // enough so that even if the customer raises their threshold,
    // the record will never be in the output.  Therefore, we add
    // one to that threshold to ensure it will not be returned.

    set_AddressFilters := LN_PropertyV2_Services.input.Set_AddressFilters;

    fn_penaltySourceCode (string2 sc) := IF (sc IN set_AddressFilters, 0,  input.pThresh + 1);  // ensuring this record won't be included

    pen_ssn_1		:= AutoStandardI.LIBCALL_PenaltyI_SSN.val(temp_ssn_mod(temp_mod_1));
    pen_did_1		:= AutoStandardI.LIBCALL_PenaltyI_DID.val(temp_did_mod(temp_mod_1));
    pen_bdid_1	:= AutoStandardI.LIBCALL_PenaltyI_BDID.val(temp_bdid_mod(temp_mod_1));
    pen_name_1	:= AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(temp_indvname_mod(temp_mod_1));
    pen_phone_1	:= AutoStandardI.LIBCALL_PenaltyI_Phone.val(temp_phone_mod(temp_mod_1));
    pen_cname_1	:= AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(temp_bizname_mod(temp_mod_1));
    pen_addr_1	:= if(input.paSearch, max_penalt, AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_addr_mod(temp_mod_1)));
    pen_paddr_1	:= if(exists(paRec), paRec[1].penalt_1, max_penalt);
    pen_ssn_2		:= AutoStandardI.LIBCALL_PenaltyI_SSN.val(temp_ssn_mod(temp_mod_2));
    pen_did_2		:= AutoStandardI.LIBCALL_PenaltyI_DID.val(temp_did_mod(temp_mod_2));
    pen_bdid_2	:= AutoStandardI.LIBCALL_PenaltyI_BDID.val(temp_bdid_mod(temp_mod_2));
    pen_name_2	:= AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(temp_indvname_mod(temp_mod_2));
    pen_phone_2	:= AutoStandardI.LIBCALL_PenaltyI_Phone.val(temp_phone_mod(temp_mod_2));
    pen_cname_2	:= AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(temp_bizname_mod(temp_mod_2));
    pen_addr_2	:= if(input.paSearch, max_penalt, AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_addr_mod(temp_mod_2)));
    pen_paddr_2	:= if(exists(paRec), paRec[1].penalt_2, max_penalt);
    self.penalt_1 := pen_ssn_1 + pen_did_1 + pen_bdid_1 + pen_name_1 + pen_phone_1 + pen_cname_1 + fn_penaltySourceCode(L.source_code) + if(pen_addr_1<pen_paddr_1,pen_addr_1,pen_paddr_1);
    self.penalt_2 := IF (TwoPartySearch,
                         pen_ssn_2 + pen_did_2 + pen_bdid_2 + pen_name_2 + pen_phone_2 + pen_cname_2 + if(pen_addr_2<pen_paddr_2,pen_addr_2,pen_paddr_2),
                         0);
    self.cPenalt_1 := map(
      input.cname=''	=> 0,
      L.cname=''			=> 100,
      ut.stringsimilar100(L.cname,input.cname));
    self.cPenalt_2 := map(
      ~TwoPartySearch => 0,
      input.cname_2=''	=> 0,
      L.cname=''			=> 100,
      ut.stringsimilar100(L.cname,input.cname_2));


    // Types -------------------------------------------
    ft := LN_PropertyV2.fn_fid_type(L.ln_fares_id);
    pt := L.source_code_1;
    at := L.source_code_2;

    self.fid_type					:= ft;
    self.fid_type_desc		:= fn_fid_type_desc(ft);

    self.addr_type				:= at;
    // self.addr_type_name		:= map(
      // at in ['O','S','B'] => 'Mailing Address',
      // at='P'=> 'Property Address',
      // ''
    // );

    self.party_type				:= pt;
    self.party_type_name	:= party_type_named(ft,pt);

    // Lookup Codes -----------------------------------
    vsource := fn_vendor_source(L.vendor_source_flag);
    self.vendor_source_desc := vsource;
    self.vendor_source_flag := fn_vendor_source_obscure(L.vendor_source_flag);


    // Placeholders (populated below) -----------------
    self.county_name	:= '';
    temp_county_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_County.full,opt))
      export county_field := '';
    end;
    self.county_pen_1	:= AutoStandardI.LIBCALL_PenaltyI_County.val(temp_county_mod(temp_mod_1));
    self.county_pen_2	:= IF (TwoPartySearch, AutoStandardI.LIBCALL_PenaltyI_County.val(temp_county_mod(temp_mod_2)), 0);
    self.entity				:= dataset([],l_entity);
    self.orig_names 	:= dataset([], layouts.parties.orig);
    self.orig_addr		:= '';
    self.orig_unit		:= '';
    self.orig_csz			:= '';
    self.current_record := '';

    // Everything else --------------------------------
    self := L;
    self := [];

  end;
  ds_value1 := project(ds_raw, addValue(left));


  // populate county name & penalty
  ds_value2 := join(
    ds_value1, k_fips,
    left.st<>'' and
      left.county<>'' and
      keyed(left.st = right.state_code) and
      keyed(left.county[3..5] = right.county_fips),
    transform(
      l_tmp1,
      self.county_name	:= right.county_name,
      temp_county_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_County.full,opt))
        export county_field := right.county_name;
      end;
      self.county_pen_1	:= AutoStandardI.LIBCALL_PenaltyI_County.val(temp_county_mod(temp_mod_1));
      self.county_pen_2	:= IF (TwoPartySearch, AutoStandardI.LIBCALL_PenaltyI_County.val(temp_county_mod(temp_mod_2)), 0);
      self:=left),
    left outer, limit(max_raw), keep(1)
  );
  // NOTE: Similar to Census_Data.MAC_Fips2County_Keyed, but based on a fractional field


  // party/property addr cleaning
  l_tmp1 stripParsedAddr(l_tmp1 L) := transform
      self.prim_range		:= '';
      self.predir				:= '';
      self.prim_name		:= '';
      self.suffix				:= '';
      self.postdir			:= '';
      self.unit_desig		:= '';
      self.sec_range		:= '';
      self.p_city_name	:= '';
      self.v_city_name	:= '';
      self.st						:= '';
      self.zip					:= '';
      self.zip4					:= '';
      self.cart					:= '';
      self.cr_sort_sz		:= '';
      self.lot					:= '';
      self.lot_order		:= '';
      self.dbpc					:= '';
      self.chk_digit		:= '';
      self.rec_type			:= '';
      self.county				:= '';
      self.county_name	:= '';
      self.geo_lat			:= '';
      self.geo_long			:= '';
      self.msa					:= '';
      self.geo_blk			:= '';
      self.geo_match		:= '';
      self := L;
  end;
  ds_value2 cleanProp2(ds_value2 L) := transform
    self.penalt_1					:= max_penalt;
    self.cPenalt_1				:= max_penalt;
    self.penalt_2					:= max_penalt;
    self.cPenalt_2				:= max_penalt;
    self.party_type				:= 'P';
    self.party_type_name	:= 'Property';
    // self.nameasis					:= '';
    self.phone_number			:= '';
    self.title						:= '';
    self.fname						:= '';
    self.mname						:= '';
    self.lname						:= '';
    self.name_suffix			:= '';
    self.cname						:= '';
    self.did							:= '';
    self.bdid							:= '';
    self.app_ssn					:= '';
    self := L;
  end;
  ds_value3_p := ds_value2(addr_type='P');		// property addrs
  ds_value3_n := ds_value2(addr_type<>'P');		// non-property addrs
  ds_value3_x := join(												// propagated addrs with no alternative
        ds_value3_p, ds_value3_n,
        left.ln_fares_id = right.ln_fares_id and
        left.party_type = right.party_type and
        left.search_did = right.search_did,
        stripParsedAddr(left),left only
      );
  ds_value3 := project(ds_value3_p,cleanProp2(left)) + ds_value3_n + ds_value3_x;
  ds_value4 := dedup(ds_value3,except persistent_record_id, all);

  // SSN masking
  doxie.MAC_Header_Field_Declare(isFCRA);
  Suppress.MAC_Mask(ds_value4, ds_masked, app_ssn, null, true, false);

  // rollup entities by party
  l_tmp2 xf_roll_entities( l_tmp1 L, dataset(l_tmp1) R) := transform
    self.entity := if( L.party_type='P', dataset([],l_entity), project(R,l_entity) );
    self.penalt_1 := min(R,penalt_1);
    self.penalt_2 := min(R,penalt_2);
    self.cPenalt_1 := min(R,cPenalt_1);
    self.cPenalt_2 := min(R,cPenalt_2);
    self.county_pen_1 := min(R,county_pen_1);
    self.county_pen_2 := min(R,county_pen_2);
    self := L;
  end;
  eroll1 := sort(ds_masked, ln_fares_id, search_did, party_type, if(TwoPartySearch,penalt_1 + penalt_2,penalt_1), if(TwoPartySearch,cPenalt_1 + cPenalt_2,cPenalt_1), -dt_last_seen, -prim_name, record); // added prim_name to ensure not getting a blank addr based on NonSubject Suppression.
  eroll2 := dedup(group(eroll1, ln_fares_id, search_did, party_type),ln_fares_id,search_did,party_type,keep(consts.max_entities));
  eroll3 := rollup(eroll2, group, xf_roll_entities(left,rows(left)));


  // sort & dedup
  ds_sort := dedup(
    sort(eroll3, ln_fares_id, search_did, if(TwoPartySearch,penalt_1 + penalt_2,penalt_1), if(TwoPartySearch,cPenalt_1 + cPenalt_2,cPenalt_1), -dt_last_seen, -dt_vendor_last_reported, record ),
    except penalt_1, penalt_2, cPenalt_1, cPenalt_2, dt_last_seen, dt_vendor_last_reported,persistent_record_id,
    all
  );

  // rollup parties by ln_fares_id
  //
  // Note (01 Dec 2008): In the case where the user provides a person's name, the penalty seems to be applied
  // well enough; for the case where only an address is provided, the penalty is applied somewhat pell-mell.
  // So, until penalties are straightened out, I'm gonna use an ugly hack to recalculate penalties for all
  // parties where an address-only search is indicated for matched parties ('mp').
  l_rolled xf_roll_parties(l_tmp2 L, dataset(l_tmp2) R) := transform
    par		:= choosen(sort(R,if(TwoPartySearch, (unsigned2) (penalt_1 + penalt_2), penalt_1),
                            if(TwoPartySearch, (unsigned2) (cPenalt_1 + cPenalt_2), cPenalt_1),record),max_parties);
    par_s	:= sort(par, if(party_type='P',0,1), party_type_name,
                       if (TwoPartySearch, (unsigned2) (penalt_1 + penalt_2), penalt_1),
                       if (TwoPartySearch, (unsigned2) (cPenalt_1 + cPenalt_2),cPenalt_1), -dt_last_seen, -dt_vendor_last_reported, record);

    temp_addr_mod(AutoStandardI.LIBIN.PenaltyI.base in_mod,
      string in_predir, string in_prim_range, string in_prim_name, string in_suffix, string in_postdir,
      string in_v_city_name, string in_p_city_name, string in_st, string in_zip) :=
      module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
        export predir_field := in_predir;
        export prange_field := in_prim_range;
        export pname_field := in_prim_name;
        export suffix_field := in_suffix;
        export postdir_field := in_postdir;
        export city_field := in_v_city_name;
        export city2_field := in_p_city_name;
        export state_field := in_st;
        export zip_field := in_zip;
        export allow_wildcard := false;
    end;

    mp := IF( TRIM(input.lname) = '' AND TRIM(input.cname) = '' and TRIM(ssn) = '' and input.did = 0 and input.bdid = 0 and
              (NOT TwoPartySearch OR (
              TRIM(input.lname_2) = '' AND TRIM(input.cname_2) = '' and TRIM(input.ssn_2) = '' and input.did_2 = 0 and input.bdid_2 = 0))
             ,SORT(par, /* by */
                    AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_addr_mod(temp_mod_1,
                      predir, prim_range, prim_name, suffix, postdir, v_city_name, p_city_name, st, zip)) +
                    if (TwoPartySearch, AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_addr_mod(temp_mod_2,
                      predir, prim_range, prim_name, suffix, postdir, v_city_name, p_city_name, st, zip)), 0),

                   if(party_type='P',0,1),
                   record)
             ,SORT(par(party_type<>'P'), if (TwoPartySearch, (unsigned2) (penalt_1 + penalt_2), penalt_1),
                                         if (TwoPartySearch, (unsigned2) (cPenalt_1 + cPenalt_2), cPenalt_1),
                                         if(party_type='O',0,1),record)
             )[1];
    self.matched_party.entity := IF(input.DisplayMatchedParty_val,mp.entity[1]);
    self.matched_party := IF(input.DisplayMatchedParty_val,mp);
    self.parties	:= project(par_s, l_pparty);
    self.penalt := if(TwoPartySearch,max(min(R,penalt_1),min(R,penalt_2)),min(R,penalt_1));
    self.cpenalt := if(TwoPartySearch,max(min(R,cpenalt_1),min(R,cpenalt_2)),min(R,cPenalt_1));
    self.county_pen := if(TwoPartySearch,max(min(R,county_pen_1),min(R,county_pen_2)),min(R,county_pen_1));
    self	:= L;
  end;

  roll1 := sort(ds_sort, ln_fares_id, search_did, if(TwoPartySearch,penalt_1 + penalt_2,penalt_1), if(TwoPartySearch,cPenalt_1 + cPenalt_2,cPenalt_1), record);
  roll2 := group(roll1, ln_fares_id, search_did);
  roll3 := rollup(roll2, group, xf_roll_parties(left,rows(left)) );

    // DEBUG
  // output(ds_raw,			named('ds_raw'));
  // output(ds_pa,			named('ds_pa'));
  // output(paPen,			named('paPen'));
  // output(ds_value1,	named('ds_value1'));
  // output(ds_value2,	named('ds_value2'));
  // output(ds_value3,	named('ds_value3'));
  // output(ds_value4,	named('ds_value4'));
  // output(ds_masked,	named('ds_masked'));
  // output(eroll1,			named('eroll1'));
  // output(eroll2,			named('eroll2'));
  // output(eroll3,			named('eroll3'));
  // output(ds_sort,		named('ds_sort'));
  // output(roll1,			named('roll1'));
  // output(roll2,			named('roll2'));
  // output(roll3,			named('roll3'));
  // OUTPUT(set_AddressFilters);  // For QA to see filter
  return roll3;
end;
