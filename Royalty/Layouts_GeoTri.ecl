// NOTE: Cloned from Royalty.GetBatchRoyalties and modified for use by new GeoTriangulation_Services.BatchService in the 
// 08/25/2020 RR via JIRA RR-19445.  Until the near future (Sept 2020) when all queries using the 
// Royalty.Layouts.RoyaltyForBatch record layout can be researched and tested. 
// Then the GeoTriangulation_Services.BatchService and Royalty.NetAcuity_Ipmetadata attrs using this temp attribute 
// can be revised and this att can be deleted.

EXPORT Layouts_GeoTri := module

  // the standard royalty dataset layout for batch
 export RoyaltyForBatch := record
   string20  acctno;
   unsigned2 royalty_type_code;
   string20  royalty_type; 
   unsigned2 royalty_count;
   unsigned2 non_royalty_count;
   string50  count_entity := '';  //20200825 RR-19445 change length to store full 39 character IPv6 format ip_address
   string1   source_type := ''; // 'I' - inhouse; 'G' - gateway
 end;

end;