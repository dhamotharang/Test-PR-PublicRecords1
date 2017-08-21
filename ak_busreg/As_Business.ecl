export As_Business(
   boolean pUseInBusinessHeader = true
) :=
module
   shared basefile := if(pUseInBusinessHeader = true   
                        ,files().base.BusinessHeader
                        ,files().base.qa
                        );
   export Header := ak_busreg.fAs_business.fHeader(basefile)
      : PERSIST(persistnames.asbusinessheader);
   export Contact := ak_busreg.fAs_business.fContact(basefile)
      : PERSIST(persistnames.asbusinessContact);
   
end;
