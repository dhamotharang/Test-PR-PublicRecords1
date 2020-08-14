IMPORT AutoStandardI, infousa,Risk_Indicators,ut,doxie;
doxie.MAC_Selection_Declare()

EXPORT YellowPages_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  global_mod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

  ypr0 := doxie_cbrs.YellowPages_records(bdids);
    
  rec := RECORD
    UNSIGNED6 bdid := 0;
    STRING10 primary_key;
    STRING125 business_name;

    STRING10 orig_phone10;
    STRING10 phone10;
    STRING140 heading_string;

    STRING6 pub_date;
    STRING9 index_value;

    STRING1 addr_suffix_flag;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip;
    STRING4 zip4;

    STRING8 sic_code;
    STRING50 sic_code_description := '';

    STRING8 pub_date_decode;
    DATASET(Risk_Indicators.Layout_Desc) hri_Phone;
  END;

  xrec := RECORD
    STRING20 lname;
    STRING10 phone;
  END;

  fat_rec := RECORD
    rec;
    xrec;
  END;

  //**** SIC DECODE

  fat_rec tra(ypr0 l) := TRANSFORM
    SELF.sic_code_description := infousa.decode_SIC6(l.sic_code[1..6]);
    SELF.phone := l.phone10; //just to please the macro
    SELF.hri_Phone := [];
    SELF := l;
  END;

  ypr1 := PROJECT(ypr0, tra(LEFT));
    
  //**** HRI
  doxie.mac_AddHRIPhone(ypr1, ypr, mod_access)

  //**** get rid of the extra fields
  ut.MAC_Slim_Back(ypr, rec, ypr_slim)
    
  srtd := SORT(ypr_slim, business_name, prim_name, phone10, -pub_date_decode);
  RETURN DEDUP(srtd, business_name, prim_name, phone10, pub_date_decode);
END;
