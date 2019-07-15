IMPORT KELOtto;
CustomerDid := DISTRIBUTE(TABLE(KELOtto.fraudgovshared, {AssociatedCustomerFileInfo, did}, AssociatedCustomerFileInfo, did, MERGE))
               : PERSIST('~temp::deleteme28');

EXPORT CustomerLexId := CustomerDid;