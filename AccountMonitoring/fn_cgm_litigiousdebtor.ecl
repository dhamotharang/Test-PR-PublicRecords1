IMPORT Courtlink, NID;
 
EXPORT DATASET(layouts.history) fn_cgm_litigiousdebtor(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.litigiousdebtor.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.litigiousdebtor.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
			
		// Grab monitor_key file.
		monitor_key := AccountMonitoring.product_files.litigiousdebtor.litigiousdebtor_key;
		// Temporary Join Layout
		temp_layout := record
			in_portfolio.pid;
			in_portfolio.rid;
			unsigned6 did  := 0;
			unsigned6 bdid := 0;
			monitor_key.debtor_fname;
			monitor_key.debtor_mname;
			monitor_key.debtor_lname;
			monitor_key.debtor_suffix;
			monitor_key.docketnumber;
		end;
			
		// Pivot on debtor_lname, debtor_fname, st, to get all docket numbers associated with portfolio records.
		temp_port_dist_1 := DISTRIBUTE(in_portfolio(name_last != ''),HASH32(name_last,NID.PreferredFirstNew(name_first),st));
		temp_srch_dist_1 := DEDUP(SORT( DISTRIBUTED(monitor_key, HASH32(debtor_lname,NID.PreferredFirstNew(debtor_fname),courtstate)),
																		debtor_lname, NID.PreferredFirstNew(debtor_fname), courtstate, docketnumber, LOCAL ),
															debtor_lname, NID.PreferredFirstNew(debtor_fname), courtstate, docketnumber, LOCAL);
		temp_join_1 := 
			JOIN(temp_port_dist_1, temp_srch_dist_1, 
				LEFT.name_last != '' AND 
				LEFT.name_last = RIGHT.debtor_lname AND
				NID.PreferredFirstNew(LEFT.name_first) = NID.PreferredFirstNew(RIGHT.debtor_fname) AND 
				LEFT.st = RIGHT.courtstate,
				TRANSFORM(temp_layout,
					SELF.pid  := LEFT.pid,
					SELF.rid  := LEFT.rid,
					SELF.did  := LEFT.did,
					SELF.bdid := LEFT.bdid,
					SELF      := RIGHT), 
				INNER, LOCAL );
		temp_all_deduped := DEDUP(SORT(DISTRIBUTE(temp_join_1,HASH64(pid,rid)),
																	 pid,rid,docketnumber,LOCAL),
															pid,rid,docketnumber,LOCAL);
		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_layout).
		temp_unrolled_hashes := PROJECT(temp_all_deduped,
			TRANSFORM(layouts.history,
				SELF.hid          := 0,
				SELF.timestamp    := '',
				SELF.product_mask := AccountMonitoring.Constants.pm_litigiousdebtor,
				SELF.hash_value   := HASH64(LEFT.debtor_fname, LEFT.debtor_mname, LEFT.debtor_lname, LEFT.debtor_suffix, LEFT.docketnumber),
				SELF := LEFT
				)); 
				
		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := ROLLUP(temp_unrolled_hashes,
			TRANSFORM(layouts.history,
				SELF.hash_value   := LEFT.hash_value + RIGHT.hash_value,
				SELF              := LEFT),
			pid,rid,LOCAL);
				
		return temp_rolled_hashes;
		
	end;
/* NOTES.....:
The Possible Litigious Debtor (PLD) base file we have contains the Case summary information: 
court info, case info, judge info, and attorney(s) info. But the only information it contains 
about the litigant/plaintiff is his/her name. And if the litigant/plaintiff is a company, only 
the company name. No address, no SSN; nothing else. This means two things: (1) we can?t match 
on a ADL/DID, and (2) we can?t ever monitor to determine whether somebody?s name has changed, 
because we have no other information to corroborate that person?s identity. In short, we cannot 
monitor PLD in the manner described in the requirements specification.
But, here?s what we can do: the system can take the portfolio records and match against PLDs on 
Name and CourtState; this will determine initially who is Possibly Litigious. While we?re doing 
that, we can make note of any docket numbers that are associated with that portfolio record. In 
future monitoring jobs, we can determine:
 o  if anybody new was added to the docket number, or 
 o  whether a new docket number has become associated with that portfolio record 
 
Either of these events could signal that there has been a change that has taken place with 
respect to a particular portfolio record. (Email sent to Emilie Peterson 2 June 2010)
________________________________________
From: Noll, David A. (LNG-DAY) 
Sent: Wednesday, June 02, 2010 3:04 PM
To: Peterson, Emilie B. (LNG-HBE); Albee, Christopher D. (LNG-DAY)
Cc: L'Heureux Jr, George C. (LNG-DAY)
Subject: RE: Question about Account Monitoring--Possible Litigious Debtors
Overall, it makes sense to look for new Dockets by Docket Number, or to be exact - 
ld_docket_case_number. Showing new hits may expose a new case type, or more recent activity, etc.
 
A customer may choose to drop a debtor once a hit is made and clear them from the monitoring 
portfolio all together, but I believe it makes more sense to flag a hit or additional hits on 
the debtor.
________________________________________
From: Albee, Christopher D. (LNG-DAY) 
Sent: Wednesday, June 09, 2010 2:37 PM
To: Noll, David A. (LNG-DAY); Peterson, Emilie B. (LNG-HBE)
Subject: RE: Question about Account Monitoring--Possible Litigious Debtors
Dave, Emilie,
Sorry it?s taken me a week to reply to your last email, below.
Okay, so what I will do for Possible Litigious Debtors is:
1.	On the first run ever of this monitoring service, look for any docket numbers that appear 
    to be associated with Portfolio entities.
2.	On subsequent monitoring runs, look for any new docket numbers that appear to be newly 
    associated with Portfolio entities.
The service will not look for new persons associated with docket numbers already identified as 
being associated with Portfolio entities. I described this as being possible, given the data we 
have available, but this is not desirable.
Correct? 
*/