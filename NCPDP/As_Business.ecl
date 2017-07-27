EXPORT As_Business := MODULE

  EXPORT Header := NCPDP.fAs_business.fHeader(Files().keybuild_base.BusinessHeader)
                      : PERSIST(Persistnames.AsBusinessHeader);

	EXPORT Contact := NCPDP.fAs_business.fContact(Files().keybuild_base.BusinessHeader)
                       : PERSIST(Persistnames.AsBusinessContact);

END;