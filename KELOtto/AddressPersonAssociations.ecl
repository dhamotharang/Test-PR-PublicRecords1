IMPORT KELOtto;
IMPORT Std;

// Take the sharing, join to customer people

EXPORT AddressPersonAssociations := MODULE
	DateOverLapThreshold := 30; // days
	BlankSsnSet := ['','000000000','199999999','799999999'];
	HighFrequencyAddressThreshold := 10;
	HighFrequencyAddressCutoff := 50;

	Sharing := KELOtto.SharingRules;

	IdentityRec := RECORD
		UNSIGNED8 AddressHash,
		KELOtto.fraudgov.address_1, 
		KELOtto.fraudgov.address_2,
		KELOtto.fraudgov.email_address,
		KELOtto.fraudgov.clean_phones.cell_phone,
		KELOtto.fraudgov.ssn,
		KELOtto.fraudgov.phone_number,
		KELOtto.fraudgov.did,
		KELOtto.fraudgov.dob,
		KELOtto.fraudgov.event_date
	END;

	SharedEvents := JOIN(KELOtto.fraudgov(did > 0 and clean_address.prim_range != '' and clean_address.prim_name != '' and clean_address.p_city_name != ''), Sharing, 
											RIGHT.fdn_file_info_id=LEFT.classification_permissible_use_access.fdn_file_info_id, 
											TRANSFORM({RECORDOF(RIGHT), IdentityRec, STRING CleanAddressString, UNSIGNED2 EventMonth}, 
																SELF.AddressHash := LEFT.OttoAddressId;//HASH32(LEFT.clean_address.prim_range,LEFT.clean_address.predir,LEFT.clean_address.prim_name,LEFT.clean_address.addr_suffix,LEFT.clean_address.postdir,LEFT.clean_address.unit_desig,LEFT.clean_address.sec_range,LEFT.clean_address.p_city_name,LEFT.clean_address.st,LEFT.clean_address.zip),
																SELF.EventMonth := (UNSIGNED)LEFT.event_date DIV 100,
																SELF.CleanAddressString := TRIM(LEFT.clean_address.prim_range) + ' ' + TRIM(LEFT.clean_address.predir) + ' ' + TRIM(LEFT.clean_address.prim_name) + ' ' + TRIM(LEFT.clean_address.addr_suffix) + ' ' + TRIM(LEFT.clean_address.sec_range) + ' ' + TRIM(LEFT.clean_address.p_city_name),
																SELF.cell_phone := LEFT.clean_phones.cell_phone,
																SELF := LEFT, SELF := RIGHT),
											LOOKUP);

	DistributedAddressEventsPrep := DISTRIBUTE(SharedEvents, AddressHash);

	HighFrequencyAddresses := TABLE(
															DEDUP(SORT(SharedEvents, fdn_ind_type_gc_id_inclusion, did), fdn_ind_type_gc_id_inclusion, did), 
															{fdn_ind_type_gc_id_inclusion, AddressHash, CleanAddressString, EventMonth, HighFrequencyAddressExclude := MAP(count(group)>HighFrequencyAddressCutoff => 1,0), HighFrequencyAddressFlag := MAP(count(group)>=HighFrequencyAddressThreshold=>1,0)}, 
															 fdn_ind_type_gc_id_inclusion, AddressHash, CleanAddressString, EventMonth, MERGE);

	DistributedAddressEvents := JOIN(DistributedAddressEventsPrep, HighFrequencyAddresses(HighFrequencyAddressExclude=0),
																LEFT.fdn_ind_type_gc_id_inclusion=RIGHT.fdn_ind_type_gc_id_inclusion AND LEFT.AddressHash=RIGHT.AddressHash AND LEFT.EventMonth=RIGHT.EventMonth,
																TRANSFORM({RECORDOF(LEFT), RIGHT.HighFrequencyAddressFlag}, SELF := LEFT, SELF := RIGHT), LOOKUP);


	AddressMatch := JOIN(DistributedAddressEvents, DistributedAddressEvents, 
										LEFT.did != RIGHT.did AND LEFT.fdn_ind_type_gc_id_inclusion=RIGHT.fdn_ind_type_gc_id_inclusion AND LEFT.AddressHash = RIGHT.AddressHash AND 
										ABS(Std.Date.ToDaysSince1900((UNSIGNED)LEFT.event_date) - Std.Date.ToDaysSince1900((UNSIGNED)RIGHT.event_date)) < DateOverLapThreshold,
										TRANSFORM({
											LEFT.fdn_ind_type_gc_id_inclusion,
											LEFT.AddressHash,    
											UNSIGNED2 EventMonth,
											IdentityRec Person,
											IdentityRec AssociatedPerson,
											LEFT.HighFrequencyAddressFlag,
											INTEGER DistanceDays,
											INTEGER1 EmailMatch,
											INTEGER1 SsnMatch,
											INTEGER1 PhoneNumberMatch
															},
											SELF.Person.AddressHash := LEFT.AddressHash,
											SELF.Person.address_1 := LEFT.address_1,
											SELF.Person.address_2 := LEFT.address_2,
											SELF.EventMonth := (UNSIGNED)LEFT.event_date DIV 100,
											SELF.Person.email_address := LEFT.email_address,
											SELF.Person.cell_phone := LEFT.cell_phone,
											SELF.Person.ssn := LEFT.ssn,
											SELF.Person.phone_number := LEFT.phone_number,
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
											SELF.AssociatedPerson.did := RIGHT.did,
											SELF.AssociatedPerson.dob := RIGHT.dob,
											SELF.AssociatedPerson.event_date := RIGHT.event_date,
											SELF.DistanceDays  := ABS(Std.Date.ToDaysSince1900((UNSIGNED)LEFT.event_date) - Std.Date.ToDaysSince1900((UNSIGNED)RIGHT.event_date)),
											SELF.EmailMatch := MAP(LEFT.email_address != '' AND LEFT.email_address=RIGHT.email_address=>1, 0),
											SELF.SsnMatch := MAP(LEFT.SSN != '' AND LEFT.SSN NOT IN BlankSsnSet AND LEFT.SSN=RIGHT.SSN=>1, 0),
											// maybe need to strip and clean this first.
											SELF.PhoneNumberMatch := MAP((LEFT.phone_number != '' AND LEFT.phone_number = RIGHT.phone_number) OR (LEFT.phone_number != '' AND LEFT.phone_number=RIGHT.cell_phone) OR (LEFT.cell_phone != '' AND LEFT.cell_phone = RIGHT.phone_number)=>1, 0),
											SELF := LEFT
										), LOCAL) : PERSIST('~temp::deleteme30');
															

	EXPORT PersonAddressMatches := TABLE(AddressMatch(DistanceDays <= DateOverLapThreshold), 
													 {
														fdn_ind_type_gc_id_inclusion,
														UNSIGNED8 AddressHash := Person.AddressHash,                         
														FromPersonLexId := person.did,
														ToPersonLexId := associatedperson.did,
														HighFrequencyAddressFlag,
														INTEGER1 SameAddressEmailMatch := MAX(GROUP, EmailMatch),
														INTEGER1 SameAddressSsnMatch := MAX(GROUP, SsnMatch),
														INTEGER1 SameAddressPhoneNumberMatch := MAX(GROUP, PhoneNumberMatch),
														INTEGER1 SameAddressMinDistanceDays := MIN(GROUP, DistanceDays),
														INTEGER1 SameAddressSameDay := MAP(COUNT(GROUP, HighFrequencyAddressFlag = 0 AND DistanceDays = 0) = 0 => 1, 0),
														INTEGER1 HighFrequencySameAddressSameDay := MAP(COUNT(GROUP, HighFrequencyAddressFlag = 1 AND DistanceDays = 0) > 0 => 1, 0), 
														FromPersonEntityContextUid := '_01' + (STRING)person.did,
														ToPersonEntityContextUid := '_01' + (STRING)associatedperson.did,
                            STRING Label := TRIM(Person.address_1) + ', ' + TRIM(Person.address_2),
													 },
														person.AddressHash, person.did,associatedperson.did, MERGE);

														 
	PersonAddressMatchStatsPrep := TABLE(PersonAddressMatches, {
														ContributoryRecords := 1,
														// Switching it back to the fdn_file_info_id for consistency in the KEL
														fdn_ind_type_gc_id_inclusion,
														FromPersonLexId,
														ToPersonLexId,
														INTEGER1 SameAddressEmailMatch := MAX(GROUP, SameAddressEmailMatch),
														INTEGER1 SameAddressSsnMatch := MAX(GROUP, SameAddressSsnMatch),
														INTEGER1 SameAddressPhoneNumberMatch := MAX(GROUP, SameAddressPhoneNumberMatch),
														UNSIGNED2 NonHighFrequencyAddressCount := COUNT(GROUP, HighFrequencyAddressFlag=0),
														UNSIGNED2 NonHighFrequencySameAddressSameDayCount := COUNT(GROUP, SameAddressSameDay=1 AND HighFrequencyAddressFlag=0),
														UNSIGNED2 HighFrequencySameAddressSameDayCount := SUM(GROUP, HighFrequencySameAddressSameDay),
														SharedAddressCount := COUNT(GROUP),
														FromPersonEntityContextUid,
														ToPersonEntityContextUid
														},
														fdn_ind_type_gc_id_inclusion, FromPersonLexId, ToPersonLexId, MERGE) : PERSIST('~temp::deleteme31');
														 
	EXPORT PersonAddressMatchStats := PersonAddressMatchStatsPrep(
			// Rules for a valid association
			sameaddressemailmatch = 1 OR 
			sameaddressssnmatch = 1 OR 
			sameaddressphonenumbermatch = 1 OR
			NonHighFrequencyAddressCount > 2 OR 
			NonHighFrequencySameAddressSameDayCount > 0 OR
			HighFrequencySameAddressSameDayCount > 5
			 );                          	
												 
	//   Same Day or within 7 days?
	//   Multiple Distinct addresses (non-high fequency, within time threshold?)
	//   

	// Use the same email address (high fequency emails? the SNAP office email address?)
	// Use the same phone number (within a time period? High Fequency numbers? Do they use the church's phone or the SNAP office etc..)


	//fdn_ind_type_gc_id_inclusion, unsigned6 fdn_file_info_id});


END;