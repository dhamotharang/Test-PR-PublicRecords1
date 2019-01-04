import STD, Relationship;

export Constants := module

  export unsigned2 RECS_PER_DID := 100;

  export unsigned2 MAX_NAMES_PER_PERSON := 20;
  export unsigned2 MAX_ADDRS_PER_PERSON := 20;
  export unsigned2 MAX_EMAILS_PER_PERSON := 20;

  export string1 NULL_EMAIL := '@';
  export string  HIGH := 'HIGH';

  export SearchType := module
    export string EIC := 'EIC';  // email identity check
    export string EIA := 'EIA';  // email identity append
    export string EAA := 'EAA';  // email address append

    export isEIC(string _searchtype) := STD.Str.ToUpperCase(_searchtype) = EIC;
    export isValid(string _searchtype) := STD.Str.ToUpperCase(_searchtype) IN [EIC, EIA, EAA];

  end;

  export string NoRelationship := 'No Relationship or Association Found';
  export string PossibleSubject := 'Possible Subject';
  export string RelationshipPrefix := 'Possible ';
  
  // below sources won't be considered for the purpose of EIC:
  setRestrictedRelationSources := [Relationship.Constants.cobankruptcy,
                                   Relationship.Constants.bcobankruptcy,
                                   Relationship.Constants.coforeclosure,
                                   Relationship.Constants.bcoforeclosure,
                                   Relationship.Constants.colien,
                                   Relationship.Constants.bcolien,
                                   Relationship.Constants.copolicy,
                                   Relationship.Constants.coclaim,
                                   Relationship.Constants.coecrash,
                                   Relationship.Constants.bcoecrash,
                                   Relationship.Constants.coclue
                                   ];
 
  export isRestrictedRelationSource(string __source) := __source IN setRestrictedRelationSources;	                           
end;