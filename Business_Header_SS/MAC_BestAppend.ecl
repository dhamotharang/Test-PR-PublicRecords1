EXPORT MAC_BestAppend
(
  infile,
  best_flags,
  verify_flags,
  outfile,
  dpm,
  drm,
  bool_use_keyed_joins = 'false'
) := MACRO

IMPORT business_header, STD, did_add, doxie;

#uniquename(bhfb)
%bhfb% :=
#if(bool_use_keyed_joins)
  Business_Header.Key_BH_Best;
#else
  Business_Header.File_Business_Header_Best_Plus;
#end


#uniquename(has_best)
BOOLEAN %has_best%(STRING flags, STRING flag) := NOT (
    (STD.Str.Find(flags, 'BEST_ALL', 1)) = 0 AND
    (STD.Str.Find(flags, flag, 1) = 0));

#uniquename(os)
%os%(STRING s) := IF(s = '', '', TRIM(s) + ' ');

#uniquename(append_best)
TYPEOF(infile) %append_best%(infile l, %bhfb% r) := TRANSFORM
  SELF.best_phone := IF(%has_best%(best_flags, 'BEST_PHONE'), IF (0 = r.phone, '', INTFORMAT(r.phone, 10, 1)), '');
  SELF.best_fein := IF(%has_best%(best_flags, 'BEST_FEIN'), IF(0 = r.fein, '', INTFORMAT(r.fein, 9, 1)), '');
  SELF.best_CompanyName := IF(%has_best%(best_flags, 'BEST_NAME'), r.company_name, '');
  SELF.best_addr1 := IF(%has_best%(best_flags, 'BEST_ADDR'),
      %os%(r.prim_range) +
      %os%(r.predir) +
      %os%(r.prim_name) +
      %os%(r.addr_suffix) +
      %os%(r.postdir) +
        IF(Std.Str.EndsWith (r.prim_name, %os%(r.unit_desig) + %os%(r.sec_range)),
          '',
          %os%(r.unit_desig) + %os%(r.sec_range)), '');
/*
  SELF.best_addr2 := IF(%has_best%(best_flags, 'BEST_ADDR'),
      %os%(r.city) +
      %os%(r.state) +
      IF(r.zip = 0, '', INTFORMAT(r.zip, 5, 1)) +
        IF(r.zip4 != 0, '-' + INTFORMAT(r.zip4, 4, 1), ''), '');
*/
  SELF.best_city := IF(%has_best%(best_flags, 'BEST_ADDR'), r.city, '');
  SELF.best_state := IF(%has_best%(best_flags, 'BEST_ADDR'), r.state, '');
  SELF.best_zip := IF(%has_best%(best_flags, 'BEST_ADDR'), IF(r.zip = 0, '', INTFORMAT(r.zip, 5, 1)), '');
  SELF.best_zip4 := IF(%has_best%(best_flags, 'BEST_ADDR'), IF(r.zip4 = 0, '', INTFORMAT(r.zip4, 4, 1)), '');
  SELF.verify_best_phone := IF(%has_best%(verify_flags, 'BEST_PHONE'), did_add.phone_match_score(l.phone10, IF(r.phone = 0, '', INTFORMAT(r.phone, 10, 1))), 255);
  SELF.verify_best_fein := IF(%has_best%(verify_flags, 'BEST_FEIN'), did_add.ssn_match_score(l.fein, IF(r.fein = 0, '', INTFORMAT(r.fein, 9, 1))), 255);
  SELF.verify_best_CompanyName := IF(%has_best%(verify_flags, 'BEST_NAME'), did_add.company_name_match_score(l.company_name, r.company_name), 255);
  SELF.verify_best_address := IF(%has_best%(verify_flags, 'BEST_ADDR'), did_add.Address_Match_Score(
      l.prim_range, l.prim_name, l.sec_range, l.z5,
      r.prim_range, r.prim_name, r.sec_range, IF(r.zip = 0, '', INTFORMAT(r.zip, 5, 1))), 255);
  SELF := l;
END;

#uniquename(best_joined)
%best_joined% := JOIN(infile, %bhfb%,
          (UNSIGNED6) LEFT.bdid != 0 AND
          (UNSIGNED6) LEFT.bdid = RIGHT.bdid AND 
          doxie.compliance.isBusHeaderSourceAllowed(right.source, dpm, drm),
          %append_best%(LEFT, RIGHT),
          LEFT OUTER,
#if(not bool_use_keyed_joins)
          HASH
#else
          KEEP (1), LIMIT (0)
#end
          );

outfile := %best_joined%;

ENDMACRO;
