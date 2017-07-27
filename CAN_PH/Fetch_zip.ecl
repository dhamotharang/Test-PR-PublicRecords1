IMPORT doxie, AutoKey, CanadianPhones, NID, ut;

// !!! COMPARE WITH autokey.Fetch_Zip
EXPORT Fetch_Zip (string t, boolean workHard, boolean noFail = true) := FUNCTION

  doxie.MAC_Header_Field_Declare ();

  d := DATASET([], CanadianPhones.layouts.zip);

  ind := if (stringlib.stringfind (trim(t),'::qa::',1) > 0,
             INDEX(d, {d}, TRIM(t)+'Zip'), INDEX(d, {d}, TRIM(t)+'Zip' + '_' + doxie.Version_SuperKey));

  // use trim/length in one place only:
	castFname := trim(ut.cast2keyfield(ind.fname,fname_value));
  unsigned1 fname_value_len := length (castFname);
  pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);

  f_raw := ind ((pname_value='' OR addr_error_value) AND 
                (workHard or lname_value <> ''),//dont allow blank lname if this is really a company search
                keyed (zip = can_poscode_value),
                keyed (dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6] OR (lname_value='' and workHard)),
                keyed ((lname=(STRING20)lname_value OR ((phonetics OR lname_value='') and workHard))),
                keyed (pfe (pfname, fname_value) OR (fname_value_len < 2) and workHard),
                keyed (fname [1..fname_value_len] = castFname OR nicknames), 
                wild (minit));

  f := project (f_raw, AutoKey.layout_fetch);
		
  AutoKey.mac_Limits(f,f_ret)	

  RETURN f_ret;
END;