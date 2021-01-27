IMPORT doxie,iesp,PersonReports, MDR, Codes, ut;
EXPORT fn_smart_getSourceCounts := MODULE

SHARED address_did_rec :=   record
  iesp.share.t_Address Address;
  integer2 SourceCount;
  dataset(iesp.smartlinxreport.t_SLRSources) Sources {MAXCOUNT(iesp.Constants.SLR.MaxSourceTypes)};
  unsigned6 did;
  end;

 SHARED	Source_rec := iesp.smartlinxreport.t_SLRSources;

 SHARED	source_rec GetSources (dataset ( PersonReports.layouts.header_recPlusSource) header_recDS) := function

    _src := dedup (group (sort (header_recDS, _type, src), _type), src);
    src_categories:=rollup (_src, group, transform (Source_rec, Self._Type := Left._Type, Self.Count := count (rows (left))));
    // when sorting sources bring Credit Bureaus records on top, then alphabetically
    src_srt := sort (src_categories, _Type[1..25] != 'CONSUMER REPORTING AGENCY', _Type);
    return src_srt;
  end;
  
export  GetAddressIndicators (
  dataset(PersonReports.layouts.header_recPlusSource) Tmpheader_ext,
  PersonReports.IParam._smartlinxreport Mod_smartLinx
  ) := FUNCTION

  ValDID :=  tmpHeader_ext[1].did;
  // START of getting header recs ********************************************
  input_dids := dataset([{ValDid}], doxie.layout_references);

  mod_access := PROJECT(Mod_smartLinx, doxie.IDataAccess);

  header_obj := doxie.mod_header_records (
                     false, true, false, //DoSearch, include dailies, allow_wildcard
                     true,               // include_gong
                     false,              // suppress_gong_noncurrent
                     [], false, false, true,    // daily_autokey_skipset, AllowGongFallBack, ApplyBpsFilter, GongByDidOnly
                     mod_access
                );

  header_all_subj := header_obj.Results (project (input_dids, doxie.layout_references_hh));
  header_all :=  header_all_subj(src != mdr.sourceTools.src_ZUtilities);

  // attach source category -- Assets, Bureau, etc. -- to each record and initialize counts
  data_categories := limit (Codes.Key_Codes_V3 (keyed (file_name = 'DATA_FAMILIES')), 1000, fail ('too many sources'));
  PersonReports.layouts.header_recPlusSource AssignCategory (recordof (header_all) L, data_categories R) := transform
     // in case if there are some sources not included into codes v3
     local_category := if (L.src = 'PH', 'PHONE', '');
     descript := trim (R.long_desc);
     Self._Type := if (descript != '', descript, local_category);
     Self.Count := 1;
     // For the purpose of this service sources EQ == QH, so I will common them up just once here
     // Later I count data by category + source, and these two should be counted as same.
     Self.src := if (L.src = 'QH', 'EQ', L.src);

     // in case of Gong records use first/last as vendor's first/last
     Self.dt_vendor_first_reported := if (L.src = 'PH', L.dt_first_seen, L.dt_vendor_first_reported);
     Self.dt_vendor_last_reported := if (L.src = 'PH', L.dt_last_seen, L.dt_vendor_last_reported);
     Self := L;
   end;

  // header_all is the set of recs that has a src code in it.
  //
  header_ext := JOIN (header_all, data_categories,
                           Left.src = Right.code,
                           AssignCategory (Left, Right),
                           left outer, LOOKUP);
  // END of getting header recs info **************************************

  src_rec := record
    PersonReports.layouts.header_recPlusSource.src;
    PersonReports.layouts.header_recPlusSource._type;
  end;
  addr_slim_rec := record
    PersonReports.layouts.header_recPlusSource and not [rid, src, phone, fname, mname, lname, name_suffix,
                        county, valid_ssn, hhid, count];
    dataset (src_rec) sources {maxcount ( iesp.Constants.SLR.MaxSourceTypes)};
  end;

  // Latest revision: same address = same address_line_1 AND (same city&state OR same zip)
  // This can be easily changed later; the main point is that indicators are fetched AFTER roll up,
  // which indeed affects content

  // save source as a dataset
  addr_slim_rec SetSourceAsDataset (PersonReports.layouts.header_recPlusSource L) := transform
    Self.sources := dataset ([{L.src, L._type}], src_rec);
      Self := L;
     end;
  header_addr := project (header_ext (zip != '' or (city_name != '' and st != '')), SetSourceAsDataset (Left));
     did_grouped := group (sort (header_addr, did), did);

  // ----------------------------------------------------------------------
  // ------------------------ ADDRESS ROLLUP ------------------------------
  // ----------------------------------------------------------------------
  // equality of address line 1 (is copy from doxie/mac_address_rollup)
  MAC_LineOneIsTheSame := MACRO
    (left.prim_range=right.prim_range) and
    (left.prim_name=right.prim_name or
      (left.zip4<>'' and right.zip4='') and  //only rollup a mismatched prim_name when one is better than the other
      (ut.StringSimilar(left.prim_name,right.prim_name)<3 or length(trim(left.prim_range))>2)
    ) and
    ut.nneq(left.predir, right.predir) and
    ut.Sec_Range_Eq(left.sec_range, right.sec_range)<10
  ENDMACRO;

  addr_slim_rec RollSameAddreses (addr_slim_rec L, addr_slim_rec R) := transform
    Self.sources := choosen (L.sources + R.sources,   iesp.Constants.SLR.MaxSourceTypes);
    // ... and the rest is about the same as in doxie/tra_address_rollup
    Self.dt_first_seen := if (R.dt_first_seen = 0 or (L.dt_first_seen < R.dt_first_seen  and L.dt_first_seen>0), L.dt_first_seen, R.dt_first_seen);
    self.dt_last_seen := if (L.dt_last_seen > R.dt_last_seen, L.dt_last_seen, R.dt_last_seen);
    self.sec_range := if (length(trim(L.sec_range)) > length(trim(R.sec_range)), L.sec_range, R.sec_range);
    Self := L;
  end;

  // by ZIP
  sort_by_zip := sort (did_grouped, zip,
                                    prim_range,prim_name, -sec_range, -predir, suffix='', zip4='', -dt_last_seen);
  rolled_by_zip := rollup (sort_by_zip,
                           (Left.zip = Right.zip) and
                           MAC_LineOneIsTheSame(), RollSameAddreses (Left, Right));

  // By CITY+STATE
  sort_by_city := sort (rolled_by_zip, st, city_name,
                                       prim_range,prim_name, -sec_range, -predir, suffix='', zip4='', -dt_last_seen);
  rolled_by_city := rollup (sort_by_city,
                            (Left.st = Right.st) and (Left.city_name = Right.city_name) and
                            MAC_LineOneIsTheSame(), RollSameAddreses (Left, Right));

  addr_slim_rec ToAddressxform (addr_slim_rec L) := transform
      Self.sources :=  dedup (L.sources, src, all);
      Self := L;
  end;
     header_addresses := project (rolled_by_city, ToAddressXform (Left));

  address_did_rec SetAssociatedAddresses ( addr_slim_rec L) := transform
                Self.did := L.did;
      Self.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                     L.suffix, L.unit_desig, L.sec_range, L.city_name,
                     L.st, L.zip, L.zip4, L.county_name);

                // get source categories' counts:
        R := project (L.sources, transform (PersonReports.layouts.header_recPlusSource, Self := Left, Self := []));
        Self.Sources := choosen ( GetSources (R), iesp.Constants.SLR.MaxSourceTypes);
                // overall count:
      Self.SourceCount :=  count (dedup (R, src, all));
    end;

   addresses  := project( header_addresses, setAssociatedAddresses(left));

   // output(header_all, named('header_all'));
  // output(did_grouped, named('did_grouped'));
  return addresses;
  
  END;   
  
  END;
  