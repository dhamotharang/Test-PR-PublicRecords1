IMPORT KELOtto;
IMPORT Std;
IMPORT AppendLexidToLexidAssociation;
   

// Take the sharing, join to customer people


EXPORT AddressPersonAssociations := MODULE
	SHARED DateOverLapThreshold := 360; // days
	SHARED BlankSsnSet := ['','000000000','199999999','799999999'];
	SHARED BlankIPAddressSet := [''];
	SHARED HighFrequencyAddressThreshold := 10;
	SHARED HighFrequencyIpThreshold := 20;
	SHARED HighFrequencyPhoneThreshold := 20;
	SHARED HighFrequencyBankThreshold := 20;
  SHARED HighFrequencyAddressCutoff := 20;
	SHARED LargeAssociationThreshold := 200; // this is the cutoff for associations for overconnected people.
  SHARED DemoHashes := [3977509724, 2727638882, 1139485299, 2459821998, 3635312545, 1026679856, 4401323, 3005794324, 866735130];

	SHARED Sharing := KELOtto.SharingRules;

  SHARED MatchElements(dsIn, JoinCondition) := FUNCTIONMACRO 

    MatchPrep := JOIN(dsIn, dsIn, 
										#EXPAND('LEFT.did != RIGHT.did AND LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND ' + JoinCondition),
										TRANSFORM({
											LEFT.AssociatedCustomerFileInfo,
											LEFT.customer_id_,
                      LEFT.industry_type_,											
											LEFT.AddressHash,    
											UNSIGNED EventMonth,
											IdentityRec Person,
											IdentityRec AssociatedPerson,
											INTEGER DistanceDays,
											INTEGER1 AddressMatch,
											INTEGER1 EmailMatch,
											INTEGER1 SsnMatch,
											INTEGER1 PhoneNumberMatch,
											INTEGER1 IPAddressMatch,
											INTEGER1 BankAccountMatch,
											INTEGER1 HighFrequencyAddressFlag
															},
											SELF.Person.AddressHash := LEFT.AddressHash,
											SELF.Person.address_1 := LEFT.address_1,
											SELF.Person.address_2 := LEFT.address_2,
											SELF.EventMonth := (UNSIGNED)LEFT.event_date DIV 100,
											SELF.Person.email_address := LEFT.email_address,
											SELF.Person.cell_phone := LEFT.cell_phone,
											SELF.Person.ssn := LEFT.ssn,
											SELF.Person.phone_number := LEFT.phone_number,
											SELF.Person.ip_address := LEFT.ip_address,
											SELF.Person.bank_routing_number_1 := LEFT.bank_routing_number_1, 
											SELF.Person.bank_account_number_1 := LEFT.bank_account_number_1,
											SELF.Person.bank_routing_number_2 := LEFT.bank_routing_number_2, 
											SELF.Person.bank_account_number_2 := LEFT.bank_account_number_2,
											SELF.Person.did := LEFT.did,
											SELF.Person.dob := LEFT.dob,
											SELF.Person.event_date := LEFT.event_date,
											SELF.AssociatedPerson.AddressHash := RIGHT.AddressHash,
											SELF.AssociatedPerson.address_1 := RIGHT.address_1,
											SELF.AssociatedPerson.address_2 := RIGHT.address_2,
											SELF.AssociatedPerson.email_address := RIGHT.email_address,
											SELF.AssociatedPerson.cell_phone := RIGHT.cell_phone,
											SELF.AssociatedPerson.ssn := RIGHT.ssn,
											SELF.AssociatedPerson.phone_number := RIGHT.phone_number,
											SELF.AssociatedPerson.ip_address := RIGHT.ip_address,
											SELF.AssociatedPerson.bank_routing_number_1 := RIGHT.bank_routing_number_1, 
											SELF.AssociatedPerson.bank_account_number_1 := RIGHT.bank_account_number_1,
											SELF.AssociatedPerson.bank_routing_number_2 := RIGHT.bank_routing_number_2, 
											SELF.AssociatedPerson.bank_account_number_2 := RIGHT.bank_account_number_2,											
											SELF.AssociatedPerson.did := RIGHT.did,
											SELF.AssociatedPerson.dob := RIGHT.dob,
											SELF.AssociatedPerson.event_date := RIGHT.event_date,
											SELF.DistanceDays  := ABS(Std.Date.ToDaysSince1900((UNSIGNED)LEFT.event_date) - Std.Date.ToDaysSince1900((UNSIGNED)RIGHT.event_date)),
											SELF.AddressMatch := MAP(LEFT.AddressHash = RIGHT.AddressHash => 1, 0),
											SELF.EmailMatch := MAP(LEFT.email_address != '' AND LEFT.email_address=RIGHT.email_address=>1, 0),
											SELF.SsnMatch := MAP(LEFT.SSN != '' AND LEFT.SSN NOT IN BlankSsnSet AND LEFT.SSN=RIGHT.SSN=>1, 0),
											// maybe need to strip and clean this first.
											SELF.PhoneNumberMatch := MAP((LEFT.phone_number != '' AND LEFT.phone_number = RIGHT.phone_number) OR (LEFT.phone_number != '' AND LEFT.phone_number=RIGHT.cell_phone) OR (LEFT.cell_phone != '' AND LEFT.cell_phone = RIGHT.phone_number)=>1, 0),
											SELF.IPAddressMatch := MAP(LEFT.OttoIpAddressId != 14695981039346656037 AND LEFT.OttoIpAddressId=RIGHT.OttoIpAddressId => 1, 0),
											SELF.BankAccountMatch := MAP((LEFT.bank_account_number_1 != '' AND (LEFT.OttoBankAccountId=RIGHT.OttoBankAccountId OR LEFT.OttoBankAccountId = RIGHT.OttoBankAccountId2)) OR (LEFT.bank_account_number_2 != '' AND (LEFT.OttoBankAccountId2=RIGHT.OttoBankAccountId2 OR LEFT.OttoBankAccountId2 = RIGHT.OttoBankAccountId)) => 1, 0),
											SELF := LEFT
										), LOCAL);
	  RETURN MatchPrep;
	ENDMACRO;

	SHARED IdentityRec := RECORD
		UNSIGNED8 AddressHash,
		KELOtto.fraudgov.address_1, 
		KELOtto.fraudgov.address_2,
		KELOtto.fraudgov.email_address,
		KELOtto.fraudgov.clean_phones.cell_phone,
		KELOtto.fraudgov.ssn,
		KELOtto.fraudgov.phone_number,
		KELOtto.fraudgov.ip_address,
		KELOtto.fraudgov.bank_routing_number_1, 
		KELOtto.fraudgov.bank_account_number_1,
		KELOtto.fraudgov.bank_routing_number_2, 
		KELOtto.fraudgov.bank_account_number_2,
		KELOtto.fraudgov.did,
		KELOtto.fraudgov.dob,
		KELOtto.fraudgov.event_date
	END;
 
  // JOIN All Shared Events
	
  // Addresses with a LOT of dids
	EXPORT HighFrequencyAddresses := TABLE(
															DEDUP(SORT(KELOtto.fraudgovshared(did > 0), AssociatedCustomerFileInfo, did, OttoAddressId), AssociatedCustomerFileInfo, did, OttoAddressId), 
															{AssociatedCustomerFileInfo, OttoAddressId, HighFrequencyAddressExclude := MAP(count(group)>HighFrequencyAddressCutoff => 1,0), HighFrequencyAddressFlag := MAP(count(group)>=HighFrequencyAddressThreshold=>1,0)}, 
															 AssociatedCustomerFileInfo, OttoAddressId, MERGE);
  EXPORT FraudgovSharedPrep1 := JOIN(KELOtto.fraudgovshared, HighFrequencyAddresses(HighFrequencyAddressFlag=1), 
	                              LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.OttoAddressId=RIGHT.OttoAddressId,
																TRANSFORM({RECORDOF(LEFT), RIGHT.HighFrequencyAddressFlag}, 
																SELF.OttoAddressId := MAP(RIGHT.HighFrequencyAddressExclude=1=> 0, LEFT.OttoAddressId), // Zero the address id if it is high frequency
																SELF := LEFT, SELF := RIGHT), LEFT OUTER, LOOKUP);	
	
	
	EXPORT HighFrequencyIps := TABLE(
															DEDUP(SORT(FraudgovSharedPrep1, did, OttoIpAddressId), AssociatedCustomerFileInfo, did, OttoIpAddressId), 
															{AssociatedCustomerFileInfo, OttoIpAddressId, HighFrequencyIpFlag := MAP(count(group)>=HighFrequencyIpThreshold=>1,0)}, 
															 AssociatedCustomerFileInfo, OttoIpAddressId, MERGE)(HighFrequencyIpFlag=1); 
  EXPORT FraudgovSharedPrep2 := JOIN(FraudgovSharedPrep1, HighFrequencyIps, 
	                              LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.OttoIpAddressId=RIGHT.OttoIpAddressId,
																TRANSFORM(RECORDOF(LEFT), 
																SELF.OttoIpAddressId := MAP(RIGHT.HighFrequencyIpFlag=1=> 0, LEFT.OttoAddressId), // Zero the address id if it is high frequency
																SELF := LEFT, SELF := RIGHT), LEFT OUTER, LOOKUP);	

	EXPORT HighFrequencyPhones := TABLE(
															DEDUP(SORT(FraudgovSharedPrep2, AssociatedCustomerFileInfo, did, phone_number), AssociatedCustomerFileInfo, did, phone_number), 
															{AssociatedCustomerFileInfo, phone_number, HighFrequencyPhoneFlag := MAP(count(group)>=HighFrequencyPhoneThreshold=>1,0)}, 
															 AssociatedCustomerFileInfo, phone_number, MERGE)(HighFrequencyPhoneFlag=1); 
  EXPORT FraudgovSharedPrep3 := JOIN(FraudgovSharedPrep2, HighFrequencyPhones, 
	                              LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.phone_number=RIGHT.phone_number,
																TRANSFORM(RECORDOF(LEFT), 
																SELF.phone_number := MAP(RIGHT.HighFrequencyPhoneFlag=1=> '', LEFT.phone_number), // Zero the address id if it is high frequency
																SELF := LEFT, SELF := RIGHT), LEFT OUTER, LOOKUP);	

	EXPORT HighFrequencyCells := TABLE(
															DEDUP(SORT(KELOtto.fraudgovshared(did > 0), AssociatedCustomerFileInfo, did, cell_phone), AssociatedCustomerFileInfo, did, cell_phone), 
															{AssociatedCustomerFileInfo, cell_phone, HighFrequencyPhoneFlag := MAP(count(group)>=HighFrequencyPhoneThreshold=>1,0)}, 
															 AssociatedCustomerFileInfo, cell_phone, MERGE)(HighFrequencyPhoneFlag=1); 
  EXPORT FraudgovSharedPrep4 := JOIN(FraudgovSharedPrep3, HighFrequencyCells, 
	                              LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.cell_phone=RIGHT.cell_phone,
																TRANSFORM(RECORDOF(LEFT), 
																SELF.cell_phone := MAP(RIGHT.HighFrequencyPhoneFlag=1=> '', LEFT.cell_phone), // Zero the address id if it is high frequency
																SELF := LEFT, SELF := RIGHT), LEFT OUTER, LOOKUP);	

	EXPORT HighFrequencyBank1 := TABLE(
															DEDUP(SORT(KELOtto.fraudgovshared(did > 0), AssociatedCustomerFileInfo, did, OttoBankAccountId), AssociatedCustomerFileInfo, did, OttoBankAccountId), 
															{AssociatedCustomerFileInfo, OttoBankAccountId, HighFrequencyBankFlag := MAP(count(group)>=HighFrequencyBankThreshold=>1,0)}, 
															 AssociatedCustomerFileInfo, OttoBankAccountId, MERGE)(HighFrequencyBankFlag=1); 

  EXPORT FraudgovSharedPrep5 := JOIN(FraudgovSharedPrep4, HighFrequencyBank1, 
	                              LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.OttoBankAccountId=RIGHT.OttoBankAccountId,
																TRANSFORM(RECORDOF(LEFT), 
																SELF.OttoBankAccountId := MAP(RIGHT.HighFrequencyBankFlag=1=> 0, LEFT.OttoBankAccountId), // Zero the address id if it is high frequency
																SELF := LEFT, SELF := RIGHT), LEFT OUTER, LOOKUP);	

	EXPORT HighFrequencyBank2 := TABLE(
															DEDUP(SORT(KELOtto.fraudgovshared(did > 0), AssociatedCustomerFileInfo, did, OttoBankAccountId2), AssociatedCustomerFileInfo, did, OttoBankAccountId2), 
															{AssociatedCustomerFileInfo, OttoBankAccountId2, HighFrequencyBankFlag := MAP(count(group)>=HighFrequencyBankThreshold=>1,0)}, 
															 AssociatedCustomerFileInfo, OttoBankAccountId2, MERGE)(HighFrequencyBankFlag=1); 

  EXPORT FraudgovSharedPrep6 := JOIN(FraudgovSharedPrep5, HighFrequencyBank2, 
	                              LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.OttoBankAccountId2=RIGHT.OttoBankAccountId2,
																TRANSFORM(RECORDOF(LEFT), 
																SELF.OttoBankAccountId2 := MAP(RIGHT.HighFrequencyBankFlag=1=> 0, LEFT.OttoBankAccountId2), // Zero the address id if it is high frequency
																SELF := LEFT, SELF := RIGHT), LEFT OUTER, LOOKUP);	

	EXPORT SharedEvents := JOIN(FraudgovSharedPrep6, DEDUP(SORT(Sharing, targetcustomerhash), targetcustomerhash),
                              LEFT.associatedcustomerfileinfo = RIGHT.targetcustomerhash,
											TRANSFORM({RECORDOF(LEFT), INTEGER customer_id_,	INTEGER industry_type_, IdentityRec, STRING CleanAddressString, UNSIGNED EventMonth}, 
																SELF.customer_id_ := (INTEGER)RIGHT.inclusion_id,
																SELF.industry_type_ := (INTEGER)RIGHT.ind_type,
																SELF.AddressHash := LEFT.OttoAddressId;//HASH32(LEFT.clean_address.prim_range,LEFT.clean_address.predir,LEFT.clean_address.prim_name,LEFT.clean_address.addr_suffix,LEFT.clean_address.postdir,LEFT.clean_address.unit_desig,LEFT.clean_address.sec_range,LEFT.clean_address.p_city_name,LEFT.clean_address.st,LEFT.clean_address.zip),
																SELF.EventMonth := (UNSIGNED)LEFT.event_date DIV 100,
																SELF.CleanAddressString := TRIM(LEFT.clean_address.prim_range) + ' ' + TRIM(LEFT.clean_address.predir) + ' ' + TRIM(LEFT.clean_address.prim_name) + ' ' + TRIM(LEFT.clean_address.addr_suffix) + ' ' + TRIM(LEFT.clean_address.sec_range) + ' ' + TRIM(LEFT.clean_address.p_city_name),
																SELF.cell_phone := LEFT.clean_phones.cell_phone,
																SELF := LEFT), LOOKUP);
	
	DistributedAddressEventsPrep1 := DISTRIBUTE(SharedEvents, AddressHash);
  // Dedup so we have one row per transaction
	EXPORT DistributedAddressEvents := DEDUP(SORT(DistributedAddressEventsPrep1, AssociatedCustomerFileInfo, record_id, LOCAL), AssociatedCustomerFileInfo, record_id, LOCAL);
 
//	EXPORT DistributedAddressEvents := JOIN(DistributedAddressEventsPrep, HighFrequencyAddresses(HighFrequencyAddressExclude=0),
//																LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.OttoAddressId=RIGHT.OttoAddressId AND LEFT.EventMonth=RIGHT.EventMonth,
//																TRANSFORM({RECORDOF(LEFT), RIGHT.HighFrequencyAddressFlag}, SELF := LEFT, SELF := RIGHT), LOOKUP);

  EXPORT EmailMatchPrep := MatchElements(DISTRIBUTE(DistributedAddressEvents(OttoEmailId != 14695981039346656037), HASH64(AssociatedCustomerFileInfo,OttoEmailId)), 'LEFT.OttoEmailId = RIGHT.OttoEmailId');
	EXPORT AddressMatchPrep := MatchElements(DistributedAddressEvents(AddressHash NOT IN [0,14695981039346656037]), 'LEFT.AddressHash != 14695981039346656037 AND LEFT.AddressHash = RIGHT.AddressHash AND ABS(Std.Date.ToDaysSince1900((UNSIGNED)LEFT.event_date) - Std.Date.ToDaysSince1900((UNSIGNED)RIGHT.event_date)) < MAP(LEFT.AssociatedCustomerFileInfo IN DemoHashes => 30, DateOverLapThreshold)');
  EXPORT PhoneMatchPrep := MatchElements(DISTRIBUTE(DistributedAddressEvents(cell_phone != '' OR phone_number != ''), HASH64(AssociatedCustomerFileInfo,cell_phone)), '(LEFT.cell_phone = RIGHT.cell_phone OR LEFT.cell_phone = RIGHT.phone_number)');
	EXPORT IpWithoutHf := JOIN(DistributedAddressEvents, HighFrequencyIps, LEFT.OttoIpAddressId=RIGHT.OttoIpAddressId, LEFT ONLY, LOOKUP);
  EXPORT IpMatchPrep := MatchElements(DISTRIBUTE(IpWithoutHf(OttoIpAddressId NOT IN [0,14695981039346656037]), HASH64(AssociatedCustomerFileInfo,OttoIpAddressId)), 'LEFT.OttoIpAddressId = RIGHT.OttoIpAddressId AND ABS(Std.Date.ToDaysSince1900((UNSIGNED)LEFT.event_date) - Std.Date.ToDaysSince1900((UNSIGNED)RIGHT.event_date)) < MAP(LEFT.AssociatedCustomerFileInfo IN DemoHashes => 30, DateOverLapThreshold)');
  EXPORT Bank1MatchPrep := MatchElements(DISTRIBUTE(DistributedAddressEvents(OttoBankAccountId NOT IN [0,12638153115695167395] OR OttoBankAccountId2 NOT IN [0,12638153115695167395]), HASH64(AssociatedCustomerFileInfo,OttoBankAccountId)), '(LEFT.OttoBankAccountId = RIGHT.OttoBankAccountId OR LEFT.OttoBankAccountId = RIGHT.OttoBankAccountId2)');

// Reduce to 1 row per did per customer, day with the flags aggregated.
EXPORT Matches := AddressMatchPrep+EmailMatchPrep+IpMatchPrep+Bank1MatchPrep+PhoneMatchPrep;

EXPORT AddressMatch := TABLE(Matches, 
                    {AssociatedCustomerFileInfo,
										 customer_id_,
                     industry_type_,											
										 EventMonth,
										 Person,
										 AssociatedPerson,
										 UNSIGNED1 HighFrequencyAddressFlag := MAX(GROUP, HighFrequencyAddressFlag),
										 UNSIGNED2 DistanceDays := MAX(GROUP, DistanceDays),
										 UNSIGNED1 AddressMatch := MAX(GROUP, AddressMatch),
										 UNSIGNED1 EmailMatch := MAX(GROUP, EmailMatch),
										 UNSIGNED1 SsnMatch := MAX(GROUP, SsnMatch),
										 UNSIGNED1 PhoneNumberMatch := MAX(GROUP, PhoneNumberMatch),
										 UNSIGNED1 IPAddressMatch := MAX(GROUP, IPAddressMatch),
										 UNSIGNED1 BankAccountMatch :=MAX(GROUP, BankAccountMatch)},
										 AssociatedCustomerFileInfo,
										 Person.did,
										 AssociatedPerson.did,
										 Person.event_date, MERGE);// : PERSIST('~temp::deleteme30');
																
	EXPORT PersonAddressMatches := TABLE(AddressMatch((AddressMatch=1 AND DistanceDays <= DateOverLapThreshold) OR AddressMatch=0), 
													 {
														AssociatedCustomerFileInfo,
														customer_id_,
														industry_type_,
														FromPersonLexId := person.did,
														ToPersonLexId := associatedperson.did,
														HighFrequencyAddressFlag,
														INTEGER1 SameAddressEmailMatch := COUNT(GROUP, EmailMatch=1 AND AddressMatch=1),
														INTEGER1 SameAddressSsnMatch := COUNT(GROUP, SsnMatch=1 AND AddressMatch=1),
														INTEGER1 SameAddressPhoneNumberMatch := COUNT(GROUP, PhoneNumberMatch=1 AND AddressMatch=1),
														INTEGER1 SameAddressMinDistanceDays := MIN(GROUP, DistanceDays),
														INTEGER1 SameAddressSameDay := MAP(COUNT(GROUP, AddressMatch=1 AND HighFrequencyAddressFlag = 0 AND DistanceDays = 0) > 0 => 1, 0),
														INTEGER1 HighFrequencySameAddressSameDay := MAP(COUNT(GROUP, AddressMatch=1 AND HighFrequencyAddressFlag = 1 AND DistanceDays = 0) > 0 => 1, 0), 
														INTEGER1 EmailMatch := MAX(GROUP, EmailMatch),
														INTEGER1 SsnMatch := MAX(GROUP, SsnMatch),
														INTEGER1 PhoneNumberMatch := MAX(GROUP, PhoneNumberMatch),
														INTEGER1 IPAddressMatch := MAX(GROUP, IPAddressMatch),
														INTEGER1 BankAccountMatch :=MAX(GROUP, BankAccountMatch),
														FromPersonEntityContextUid := '_01' + (STRING)person.did,
														ToPersonEntityContextUid := '_01' + (STRING)associatedperson.did,
                            STRING Label := TRIM(Person.address_1) + ', ' + TRIM(Person.address_2),
													 },
														AssociatedCustomerFileInfo, person.AddressHash, person.did,associatedperson.did, MERGE);

													 
	EXPORT PersonAddressMatchStatsPrep1 := TABLE(PersonAddressMatches, {
														ContributoryRecords := 1,
														// Switching it back to the fdn_file_info_id for consistency in the KEL
														AssociatedCustomerFileInfo,
														customer_id_,
														industry_type_,
														FromPersonLexId,
														ToPersonLexId,
														INTEGER1 SelfMatch := 0;
														INTEGER1 SameAddressEmailMatch := MAX(GROUP, SameAddressEmailMatch),
														INTEGER1 SameAddressSsnMatch := MAX(GROUP, SameAddressSsnMatch),
														INTEGER1 SameAddressPhoneNumberMatch := MAX(GROUP, SameAddressPhoneNumberMatch),
														UNSIGNED2 NonHighFrequencyAddressCount := COUNT(GROUP, HighFrequencyAddressFlag=0),
														UNSIGNED2 NonHighFrequencySameAddressSameDayCount := COUNT(GROUP, SameAddressSameDay=1 AND HighFrequencyAddressFlag=0),
														UNSIGNED2 HighFrequencySameAddressSameDayCount := SUM(GROUP, HighFrequencySameAddressSameDay),

														UNSIGNED2 EmailMatchCount := SUM(GROUP, EmailMatch),
														UNSIGNED2 SsnMatchCount := SUM(GROUP, SsnMatch),
														UNSIGNED2 PhoneNumberMatchCount := SUM(GROUP, PhoneNumberMatch),
														UNSIGNED2 IPAddressMatchCount := SUM(GROUP, IPAddressMatch),
														UNSIGNED2 BankAccountMatchCount := SUM(GROUP, BankAccountMatch),														
														
														SharedAddressCount := COUNT(GROUP),
														FromPersonEntityContextUid,
														ToPersonEntityContextUid
														},
														AssociatedCustomerFileInfo, FromPersonLexId, ToPersonLexId, MERGE);

  // Unique List of Customer People
	
  EXPORT CustomerDids := TABLE(KELOtto.fraudgovshared(did > 0), {AssociatedCustomerFileInfo, INTEGER customer_id_ := customer_id,	industry_type_ := classification_permissible_use_access.Ind_type, did, PersonEntityContextUid := '_01' + (STRING)did}, 
	                           customer_id,classification_permissible_use_access.Ind_type, associatedcustomerfileinfo, did, MERGE);
										
	// SELF associations so that cluster attributes can include themselves.									
  SHARED PersonAddressMatchStatsPrep2 := PROJECT(CustomerDids, TRANSFORM(RECORDOF(PersonAddressMatchStatsPrep1), 
	                                    SELF.SelfMatch := 1,
                                      SELF.FromPersonLexId := LEFT.did,
														          SELF.FromPersonEntityContextUid := LEFT.PersonEntityContextUid,
                                      SELF.ToPersonLexId := LEFT.did,
														          SELF.ToPersonEntityContextUid := LEFT.PersonEntityContextUid,
																			SELF := LEFT, SELF := []));


//	EXPORT PersonAddressMatchStatsPrep3 := PersonAddressMatchStatsPrep1 + PersonAddressMatchStatsPrep2 : PERSIST('~temp::deleteme31'); // JP

//  output(KELOtto.AddressPersonAssociations.PersonAddressMatchStatsPrep3,, '~temp::PersonAddressMatchStatsPrep3', overwrite, EXPIRE(7));
  SHARED tempAssociations := DATASET('~foreign::10.173.14.201::temp::PersonAddressMatchStatsPrep3', RECORDOF(PersonAddressMatchStatsPrep2), THOR);
  EXPORT PersonAddressMatchStatsPrep3 := tempAssociations;
									
  EXPORT PersonAddressMatchStatsPrep4 := PersonAddressMatchStatsPrep3(
			// Rules for a valid association
			SelfMatch = 1 OR
			sameaddressemailmatch = 1 OR 
			sameaddressssnmatch = 1 OR 
			sameaddressphonenumbermatch = 1 OR
			NonHighFrequencyAddressCount > 2 OR (AssociatedCustomerFileInfo = 2481802344 AND NonHighFrequencyAddressCount > 0) OR
			NonHighFrequencySameAddressSameDayCount > 0 OR
			HighFrequencySameAddressSameDayCount > 5 OR
			EmailMatchCount > 0 OR
			SsnMatchCount > 0 OR
			PhoneNumberMatchCount > 0 OR
			IPAddressMatchCount > 0 OR
			BankAccountMatchCount > 0
																	
			 );          

//	EXPORT PersonAddressMatchStats := PersonAddressMatchStatsPrep4;                	
   /*    
  SHARED LexidAssociationsPrep := AppendLexidToLexidAssociation.MacAppendLexidToLexidAssociations(PersonAddressMatchStatsPrep4, FromPersonLexId, ToPersonLexId, 'VerifiedPR', 2, 25000000) 
         : PERSIST('~deletemefraudgov1');
         
  EXPORT HighFrequencyFroms := TABLE(LexidAssociationsPrep, {AssociatedCustomerFileInfo, FromPersonLexId, recs := COUNT(GROUP)}, AssociatedCustomerFileInfo, FromPersonLexId, MERGE);
  // Remove high frequency matches.
	EXPORT PersonAddressMatchStatsPrep := DEDUP(SORT(DISTRIBUTE(LexidAssociationsPrep, HASH32(FromPersonLexId, ToPersonLexId)), FromPersonLexId, ToPersonLexId, LOCAL), FromPersonLexId, ToPersonLexId, LOCAL);
  */
	EXPORT PersonAddressMatchStats := PersonAddressMatchStatsPrep4; //JOIN(LexidAssociationsPrep, HighFrequencyFroms(recs > LargeAssociationThreshold), LEFT.AssociatedCustomerFileInfo=RIGHT.AssociatedCustomerFileInfo AND LEFT.FromPersonLexId=RIGHT.FromPersonLexId, LEFT ONLY, LOOKUP);
												 
	//   Same Day or within 7 days?Veep1234!
	//   Multiple Distinct addresses (non-high fequency, within time threshold?)
	//   

	// Use the same email address (high fequency emails? the SNAP office email address?)
	// Use the same phone number (within a time period? High Fequency numbers? Do they use the church's phone or the SNAP office etc..)


	//fdn_ind_type_gc_id_inclusion, unsigned6 fdn_file_info_id});
  
END;