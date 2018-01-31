﻿EXPORT Layout_GetRelationship := MODULE

// Relationship interface layouts
export DIDs_layout := record
  unsigned6 DID;
end;

export DIDS_Pairs_layout := record(DIDs_Layout)
	typeof(DIDs_layout.DID) DID2;
end;

export TransactionalFlags_layout   := record 
 	boolean VehicleFlag                            {xpath('Vehicle')} := FALSE;
	boolean BankruptcyDirectRelationshipFlag       {xpath('BankruptcyDirectRelationship')}   := FALSE;
	boolean BankruptcyInDirectRelationshipFlag     {xpath('BankruptcyInDirectRelationship')} := FALSE;
	boolean PropertyDirectRelationshipFlag         {xpath('PropertyDirectRelationship')}     := FALSE;
	boolean PropertyInDirectRelationshipFlag       {xpath('PropertyInDirectRelationship')}   := FALSE;
	boolean ExperianFlag                           {xpath('Experian')}   := FALSE;
	boolean EnclarityFlag                          {xpath('Enclarity')}  := FALSE;
	boolean TransunionFlag                         {xpath('Transunion')} := FALSE;
	boolean ForeclosureDirectRelationshipFlag      {xpath('ForeclosureDirectRelationship')}   := FALSE;
	boolean ForeclosureInDirectRelationshipFlag    {xpath('ForeclosureInDirectRelationship')} := FALSE;
	boolean LienDirectRelationshipFlag             {xpath('LienDirectRelationship')}          := FALSE;
	boolean LienInDirectRelationshipFlag           {xpath('LienInDirectRelationship')}        := FALSE;
	boolean ECrashSameVehicleFlag                  {xpath('ECrashSameVehicle')}               := FALSE;
	boolean ECrashDifferentVehicleFlag             {xpath('ECrashDifferentVehicle')}          := FALSE;
	boolean WatercraftFlag                         {xpath('Watercraft')}      := FALSE;
	boolean AircraftFlag                           {xpath('Aircraft')}        := FALSE;
	boolean UCCFlag                                {xpath('UCC')}             := FALSE;
	boolean MarriageDivorceFlag                    {xpath('MarriageDivorce')} := FALSE;
	boolean PolicyFlag                             {xpath('Policy')}  := FALSE;
	boolean SSNFlag                                {xpath('SSN')}     := FALSE;
	boolean ClaimFlag                              {xpath('Claim')}   := FALSE;
	boolean CohabitFlag                            {xpath('Cohabit')} := FALSE;
	boolean AptFlag                                {xpath('Apt')}     := FALSE;
	boolean POBoxFlag                              {xpath('POBox')}   := FALSE;
end;

export RelationshipInterface := record
	DATASET(DIDs_layout)          DID_ds;
	boolean RelativeFlag                 := FALSE;
	boolean AssociateFlag                := FALSE;
	boolean AllFlag                      := FALSE;
	boolean TransactionalOnlyFlag        := FALSE;
	unsigned2 MaxCount                   := 500;
  unsigned2 TopNCount                  := 100;
  boolean   doSkip                     := FALSE;
  boolean   doFail                     := FALSE;
  boolean   doAtmost                   := FALSE;
  boolean   doTopN                     := FALSE;
  boolean   sameLname                  := FALSE;  
  unsigned2 minScore                   := 0;
  unsigned4 recentRelative             := 0;
  unsigned8 person2                    := 0;
	boolean   runBatch                   := FALSE;
	TransactionalFlags_layout     txflag;
end;
	
export RelativeRec    := record
  unsigned6 did1;
  string15 type;
  string10 confidence;
  unsigned6 did2;
  integer2 cohabit_score;
  integer2 cohabit_cnt;
  integer2 coapt_score;
  integer2 coapt_cnt;
  integer2 copobox_score;
  integer2 copobox_cnt;
  integer2 cossn_score;
  integer2 cossn_cnt;
  integer2 copolicy_score;
  integer2 copolicy_cnt;
  integer2 coclaim_score;
  integer2 coclaim_cnt;
  integer2 coproperty_score;
  integer2 coproperty_cnt;
  integer2 bcoproperty_score;
  integer2 bcoproperty_cnt;
  integer2 coforeclosure_score;
  integer2 coforeclosure_cnt;
  integer2 bcoforeclosure_score;
  integer2 bcoforeclosure_cnt;
  integer2 colien_score;
  integer2 colien_cnt;
  integer2 bcolien_score;
  integer2 bcolien_cnt;
  integer2 cobankruptcy_score;
  integer2 cobankruptcy_cnt;
  integer2 bcobankruptcy_score;
  integer2 bcobankruptcy_cnt;
  integer2 covehicle_score;
  integer2 covehicle_cnt;
  integer2 coexperian_score;
  integer2 coexperian_cnt;
  integer2 cotransunion_score;
  integer2 cotransunion_cnt;
  integer2 coenclarity_score;
  integer2 coenclarity_cnt;
  integer2 coecrash_score;
  integer2 coecrash_cnt;
  integer2 bcoecrash_score;
  integer2 bcoecrash_cnt;
  integer2 cowatercraft_score;
  integer2 cowatercraft_cnt;
  integer2 coaircraft_score;
  integer2 coaircraft_cnt;
  integer2 comarriagedivorce_score;
  integer2 comarriagedivorce_cnt;
  integer2 coucc_score;
  integer2 coucc_cnt;
  integer2 lname_score;
  integer2 phone_score;
  integer2 dl_nbr_score;
  unsigned2 total_cnt;
  integer2 total_score;
  string10 cluster;
  string2 generation;
  string1 gender;
  unsigned4 lname_cnt;
  unsigned4 rel_dt_first_seen;
  unsigned4 rel_dt_last_seen;
  unsigned2 overlap_months;
  unsigned4 hdr_dt_first_seen;
  unsigned4 hdr_dt_last_seen;
  unsigned2 age_first_seen;
  boolean isanylnamematch;
  boolean isanyphonematch;
  boolean isearlylnamematch;
  boolean iscurrlnamematch;
  boolean ismixedlnamematch;
  string9 ssn1;
  string9 ssn2;
  unsigned4 dob1;
  unsigned4 dob2;
  string28 current_lname1;
  string28 current_lname2;
  string28 early_lname1;
  string28 early_lname2;
  string2 addr_ind1;
  string2 addr_ind2;
  unsigned6 r2rdid;
  unsigned6 r2cnt;
  boolean personal;
  boolean business;
  boolean other;
  unsigned1 title;
end;

export InterfaceOuput := record
  RelativeRec;
	string1   title_type;
	integer2  source_type;
	boolean   isRelative;
	boolean   isAssociate;
	boolean   isBusiness;
end;	

export relativeRecNeutral := layout_output.key;

export interfaceOutputNeutral := record
	relativeRecNeutral;
	string1   title_type;
	integer2  source_type;
	boolean   isRelative;
	boolean   isAssociate;
	boolean   isBusiness;
end;

END;