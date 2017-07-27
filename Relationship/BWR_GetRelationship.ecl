did_ds := dataset([
158783930225
,2536085855
,2443130406
],Relationship.Layout_GetRelationship.DIDs_layout);

result := Relationship.proc_GetRelationship(did_ds,,,,,10,10,,,TRUE).result;
// result := Relationship.proc_GetRelationship(did_ds,,,,,jc_ds).legacy;

output(result);

/* The input to the interface consists of
   1.  A dataset of Lexids that you are requesting relationships for

       RELATIONSHIP TYPE FLAGS
   2.  Relatives Only;		default is to return relatives and associates
	 3.  Associates Only;		default is to return relatives and associates
	 4.  All Relationships;
	 5.  Transactional Relationships Only;

       JOIN CONDITIONS
   6.  The maximum number of relationship candidate records you want returned (Default 500)
   7.  The maximum number of relationships you want per did (best records)
   8.  doSkip; Eliminates records once maximum count is exceeded
	 9.  doFail; Fails job if maximum count is exeeded
	10.  doAtmost; Eliminates records once maximum count is exceeded
	
       KEY FILTERS
  11.  SameLname; Return only records where the isanylnamematch flag is true
	12.  minScore; Return only records that have a total score greater than or equal to this value
	13.  recentRelative; Return only records that have a rel_dt_last_seen greater or equal to this value (can by 4-6-8 digit date)
	14.  person2; Return only record where the did2 equals this value

	     ADDITIONAL RELATIONSHIP FLAGS
  13.  Relationships that share a Vehicle record;
	14.  Relationships that are on the same side of a bankruptcy;
	15.  Relationships that are on the opposite side of a bankruptcy;
	16.  Relationships that share a Property record and are buyer/buyer or seller/seller;
	17   Relationships that share a Property record and are buyer/seller or seller/buyer;
	18.  Relationships that share an Experian inquiry record;
	19.  Relationships that share an Enclarity record;
	20.  Relationships that share a Transunion inquiry record;
	21.  Relationships that are on the same side of a foreclosure;
	22.  Relationships that are on the opposite side of a foreclosure;
	23.  Relationships that are on the same side of a lien;
	24.  Relationships that are on the opposite side of a lien;
	25.  Relationships that share an ECrash record and are in the same vehicles;
	26.  Relationships that share an ECrash record but are in different vehicles;
	27.  Relationships that share a watercraft;
	28.  Relationships that share an aircraft;
	29.  Relationships that share an UCC record;
	30.  Relationships that share a marriage/divorce record;
	31.  Relationships that share an insurance policy;
	32.  Relationships that share a SSN;
	33.  Relationships that share an insurance claim;
	34.  Relationships that share an address;
	35.  Relationships that share an apartment;
	36.  Relationships that share a PO Box;
	*/