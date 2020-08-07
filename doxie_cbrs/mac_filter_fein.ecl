EXPORT mac_filter_fein(indata, infein, outdata) :=
MACRO
IMPORT Risk_Indicators;

#uniquename(filtFeins)
#uniquename(le)
#uniquename(ri)

indata %filtFeins%(indata %le%, Risk_Indicators.key_ssn_table_v4_2 %ri%) :=
TRANSFORM
  SELF.infein := IF(%le%.infein=%ri%.ssn,'',%le%.infein);
  SELF := %le%;
END;
outdata :=
  IF(doxie_cbrs.stored_ShowPersonalData_value,
     indata,
     JOIN(indata, Risk_Indicators.key_ssn_table_v4_2,
          KEYED (LEFT.infein=RIGHT.ssn),
          %filtFeins%(LEFT,RIGHT),
          LEFT OUTER, ATMOST (1)));
                                                        
ENDMACRO;
