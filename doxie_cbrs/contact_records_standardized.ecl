IMPORT census_data, doxie_cbrs;

EXPORT contact_records_standardized(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

conr := CHOOSEN(SORT(doxie_cbrs.contact_records(bdids),-did,bdid),1000); //help memory consumption

doxie_cbrs.layout_contact.standardized_rec trans_recs(conr L,Census_Data.Key_Fips2County R) := TRANSFORM
  SELF.company_zip := IF(l.company_zip > 0, INTFORMAT(l.company_zip,5,1), '');
  SELF.company_zip4 := IF(l.company_zip4 > 0, INTFORMAT(l.company_zip4,5,1), '');
  SELF.company_phone := IF(l.company_phone > 0, (STRING)l.company_phone, '');
  SELF.company_fein := IF(l.company_fein > 0, (STRING)l.company_fein, '');
  SELF.zip := IF(l.zip > 0, INTFORMAT(l.zip,5,1), '');
  SELF.zip4 := IF(l.zip4 > 0, INTFORMAT(l.zip4,4,1), '');
  SELF.phone := IF(l.phone > 0, (STRING)l.phone, '');
  SELF.msaDesc := IF(L.msa <> '' AND L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
  SELF.county_name := IF (L.county <> '', R.county_name, '');
  SELF.msa := IF(L.msa <> '0000', L.msa, '');
  SELF := l;
END;

RETURN JOIN(conr,Census_Data.Key_Fips2County,
            KEYED(LEFT.state = RIGHT.state_code AND
            LEFT.county = RIGHT.county_fips),
            trans_recs(LEFT,RIGHT), LEFT OUTER, KEEP (1));
END;
