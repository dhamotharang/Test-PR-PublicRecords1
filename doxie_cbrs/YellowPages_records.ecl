IMPORT YellowPages, doxie, business_header, ut, doxie_cbrs_raw, std;

doxie_cbrs.mac_Selection_Declare()

EXPORT YellowPages_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  krecs := doxie_cbrs_raw.YellowPage(bdids,Include_YellowPages_val,Max_YellowPages_val).records;

  krec := RECORD
    krecs;
    STRING8 pub_date_decode;
  END;

  UNSIGNED4 thisyear := (UNSIGNED4)(((STRING)Std.Date.Today())[1..4]);

  STRING8 checkflip(STRING6 dt) :=
    IF(ABS(thisyear - (UNSIGNED4)(dt[1..4])) < ABS(thisyear - (UNSIGNED4)(dt[3..6])),
    dt + '00',
    dt[3..6] + dt[1..2] + '00');

  krec keepk(krecs r):= TRANSFORM
    SELF.index_value := IF ((INTEGER)R.index_value = 0, '', R.index_value);
    SELF.pub_date_decode := checkflip(r.pub_date);
    SELF := r;
  END;

  RETURN PROJECT(krecs, keepk(LEFT));
END;
