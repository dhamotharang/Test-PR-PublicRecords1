export As_Business :=
module
   export Header := ENB.fAs_business.fHeader(files().base.BusinessHeader)
      : PERSIST(persistnames.asbusinessheader);
   export Contact := ENB.fAs_business.fContact(files().base.BusinessHeader)
      : PERSIST(persistnames.asbusinessContact);
   
end;
