IMPORT $;

EXPORT Raw :=
MODULE

  // Equifax Phones
  EXPORT EquifaxPhones :=
  MODULE

      EXPORT ByPhone(dIn, fldPhone = 'phone', leftOuter = TRUE) :=
      FUNCTIONMACRO
        IMPORT PhoneMart;

        rEquifaxPhone_Layout :=
        RECORD(RECORDOF(dIn))
          RECORDOF(PhoneMart.key_phonemart_phone) equifax_phone;
        END;

        dEquifaxPhones := JOIN( dIn,
                                PhoneMart.key_phonemart_phone,
                                KEYED(LEFT.fldPhone = RIGHT.phone),
                                TRANSFORM(rEquifaxPhone_Layout,
                                  SELF.equifax_phone := RIGHT,
                                  SELF               := LEFT),
                                #IF(leftOuter)
                                  LEFT OUTER, ATMOST(1000));
                                #ELSE
                                  LIMIT(1000, SKIP));
                                #END
        
        RETURN dEquifaxPhones;
      ENDMACRO;

  END;

END;