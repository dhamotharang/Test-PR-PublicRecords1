IMPORT doxie, business_header,ut, data_services, STD;

bf := business_header.File_Business_Header_Best;
rel := table(business_header.File_Business_Relatives(name OR name_Address OR name_phone),
             {bdid1, bdid2});

rec := RECORD
  UNSIGNED6 bdid;
  UNSIGNED1 seq;
  UNSIGNED6 bdid2;
END;

temprec := RECORD
  rec;
  QSTRING120 name;
END;

STRING cleanname(STRING n, UNSIGNED1 pos) :=
  IF(STD.STR.FilterOut(ut.word(n, pos),'X#1234567890') = '', '', ut.word(n, pos));

temprec addname(rel l, bf r) := TRANSFORM
  SELF.bdid := l.bdid1;
  SELF.seq := 255;
  SELF.bdid2 := l.bdid2;
  SELF.name := TRIM(
               cleanname(r.company_name, 1) + ' ' + cleanname(r.company_name, 2) + ' ' + cleanname(r.company_name, 3) + ' ' +
               cleanname(r.company_name, 4) + ' ' + cleanname(r.company_name, 5) + ' ' + cleanname(r.company_name, 6) + ' ' +
               cleanname(r.company_name, 7) + ' ' + cleanname(r.company_name, 8) + ' ' + cleanname(r.company_name, 9), LEFT, RIGHT);
END;

j := JOIN(rel, bf, LEFT.bdid2 = RIGHT.bdid, addname(LEFT, RIGHT), hash);
s := DEDUP(GROUP(SORT(DISTRIBUTE(j, hash(bdid)), bdid, name, local), bdid, local), name);

temprec iter(temprec l, temprec r) := TRANSFORM
  SELF.seq := IF(l.seq < 255, l.seq + 1, r.seq);
  SELF := r;
END;

i := ITERATE(s, iter(LEFT, RIGHT));

ut.MAC_Slim_Back(i,rec,islim)

EXPORT key_BDID_NameVariations := index(islim,
{bdid, seq},
{bdid2},
data_services.data_location.prefix() + 'thor_data400::key::cbrs.bdid_NameVariations_' + doxie.Version_SuperKey);
