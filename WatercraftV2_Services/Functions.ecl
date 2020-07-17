IMPORT AutoStandardI, ut;

EXPORT Functions := MODULE

  EXPORT ms(STRING70 a, STRING70 b, STRING70 c) :=MAP(a=''=>b,b=''=>a,ut.StringSimilar(a,c)<=ut.StringSimilar(b,c)=>a,b);
  
  SHARED owner_rec := WatercraftV2_Services.layouts.owner_raw_rec;
  SHARED inner_params := WatercraftV2_Services.Interfaces.ak_params;
  
  EXPORT CalculatePenalty(inner_params in_mod, owner_rec in_owner_rec, STRING orig_ssn, STRING ssn) := FUNCTION
    it := AutoStandardI.InterfaceTranslator;
    
    penaltyDID(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_DID.full, OPT))
        EXPORT did := it.did_value.val(in_mod);
        EXPORT did_field := (STRING) r.did;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tm);
    END;

    penaltySSN(inner_params in_mod, owner_rec r, STRING orig_ssn, STRING ssn) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_SSN.full, OPT))
        EXPORT ssn_value := it.ssn_value.val(in_mod);
        EXPORT ssn_field := ms(orig_ssn,ssn, '');
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(tm);
    END;

    penaltyName(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
        EXPORT lastname := it.lname_value.val(in_mod);
        EXPORT middlename := it.mname_value.val(in_mod);
        EXPORT firstname := it.fname_value.val(in_mod);
        EXPORT allow_wildcard := FALSE;
        EXPORT lname_field := r.lname;
        EXPORT mname_field := r.mname;
        EXPORT fname_field := r.fname;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
    END;

    penaltyAddr(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
          
        // The 'input' address:
          EXPORT predir := it.predir_value.val(in_mod);
          EXPORT prim_name := it.pname_value.val(in_mod);
          EXPORT prim_range := it.prange_value.val(in_mod);
          EXPORT postdir := it.postdir_value.val(in_mod);
          EXPORT addr_suffix := it.addr_suffix_value.val(in_mod);
          EXPORT sec_range := it.sec_range_value.val(in_mod);
          EXPORT p_city_name := it.city_value.val(in_mod);
          EXPORT st := it.state_value.val(in_mod);
          EXPORT z5 := it.zip_val.val(in_mod);
        
          // The address in the matching record:
          EXPORT allow_wildcard := FALSE;
          EXPORT city_field := r.v_city_name;
          EXPORT city2_field := '';
          EXPORT pname_field := r.prim_name;
          EXPORT postdir_field := r.postdir;
          EXPORT prange_field := r.prim_range;
          EXPORT predir_field := r.predir;
          EXPORT state_field := r.st;
          EXPORT suffix_field := r.suffix;
          EXPORT zip_field := r.zip5;
          EXPORT sec_range_field := r.sec_range;
          EXPORT useGlobalScope := FALSE;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tm);
    END;

    penaltyPhone(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Phone.full, OPT))
        EXPORT phone := it.phone_value.val(in_mod);
        EXPORT phone_field := ms(r.phone_1,r.phone_2,'');
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_Phone.val(tm);
    END;

    penaltyDOB(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_DOB.full, OPT))
        EXPORT dob := it.dob_val.val(in_mod);
        EXPORT dob_field := r.dob;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_DOB.val(tm);
    END;

    penaltyBDID(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_BDID.full, OPT))
        EXPORT bdid := it.bdid_val.val(in_mod);
        EXPORT bdid_field := r.bdid;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_BDID.val(tm);
    END;
    
    penaltyFEIN(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_FEIN.full, OPT))
        EXPORT fein := it.fein_val.val(in_mod);
        // EXPORT fein_field := ms(r.orig_fein,r.fein,'');
        EXPORT fein_field := r.fein;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tm);
    END;

    penaltyCName(inner_params in_mod, owner_rec r) := FUNCTION
      tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full, OPT))
        EXPORT companyname := it.comp_name_value.val(in_mod);
        EXPORT cname_field := r.company_name;
      END;

      RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tm);
    END;
        
    penalt := penaltyDID(in_mod, in_owner_rec) +
      penaltyName(in_mod, in_owner_rec) +
      penaltySSN(in_mod,in_owner_rec,orig_ssn,ssn) +
      penaltyCNAME(in_mod, in_owner_rec)+
      penaltyAddr(in_mod,in_owner_rec) +
      penaltyPhone(in_mod,in_owner_rec) +
      penaltyBDID(in_mod,in_owner_rec) +
      penaltyDOB(in_mod,in_owner_rec) +
      penaltyFEIN(in_mod,in_owner_rec);
                    
    RETURN penalt;
  END;
  
  EXPORT penalize_batch_records(WatercraftV2_Services.Layouts.batch_in input_rec,
                                WatercraftV2_Services.Layouts.WCReportEX match_rec) := FUNCTION
                                
    gm := AutoStandardI.GlobalModule();
    temp_mod := MODULE(PROJECT(gm, inner_params, opt))
      EXPORT firstname := input_rec.name_first;
      EXPORT middlename := input_rec.name_middle;
      EXPORT lastname := input_rec.name_last;
      EXPORT unparsedfullname := '';
      EXPORT companyname := input_rec.comp_name;
      EXPORT city := input_rec.p_city_name;
      EXPORT state := input_rec.st;
      EXPORT zip := input_rec.z5;
      EXPORT phone := input_rec.homephone;
      EXPORT fein := input_rec.fein;
      EXPORT dob := (INTEGER)input_rec.dob;
      EXPORT did := (STRING)input_rec.did;
      EXPORT ssn := input_rec.ssn;
    END;
      
    owners := PROJECT(match_rec.owners, TRANSFORM(owner_rec, SELF := LEFT, SELF := []));
    //Calculate penalty for the first two owners since we are only keeping two owners in batch at the most
    penalt_owner1 := CalculatePenalty(temp_mod, owners[1], owners[1].orig_ssn, owners[1].ssn);
    penalt_owner2 := IF(COUNT(owners)>1, CalculatePenalty(temp_mod, owners[2], owners[2].orig_ssn, owners[2].ssn), penalt_owner1);
    
    //Take the minimum penalty between both owners (minimum penalty should correspond to subject)
    penalt := MIN(penalt_owner1, penalt_owner2);

    RETURN penalt;
  END;
END;
