import riskwise, ut, fcra, ibehavior, risk_indicators;

export Boca_Shell_iBehavior(GROUPED DATASET(layout_bocashell_neutral) clam_pre_iBehavior, boolean isFCRA,
	unsigned8 BSOptions, boolean onThor=false) := FUNCTION

// after July 30, 2017 this option will be hard coded to always exclude the iBehavior data
exclude_ibehavior := (BSOptions & Risk_Indicators.iid_constants.BSOptions.exclude_iBehavior) > 0;

consumerKey := if(isFCRA, ibehavior.Key_DID_FCRA, ibehavior.Key_DID); 
behaviorKey := if(isFCRA, ibehavior.key_purchase_behavior_FCRA, ibehavior.key_purchase_behavior);	


LayoutBehaviorTemp := record
	layout_bocashell_neutral;

	// fields from the consumer key for output in the shell
	// string8		first_seen_date
	// string8		last_seen_date
	// fields from the behavior key for output in the shell
	// string9		Average_Amount_Per_Order;
	// string4		Average_Days_Between_Orders;
	// string3		number_of_sources;
	// string9		Offline_Average_Amount_Per_Order;
	// string4		Offline_Orders;
	// string9		Offline_Dollars;
	// string9		Online_Average_Amount_Per_Order;
	// string4		Online_Orders;
	// string9		Online_Dollars;
	// string9		Retail_Average_Amount_Per_Order;
	// string4		Retail_Orders;
	// string9		Retail_Dollars;
	// string9		Total_Dollars;
	// string4		Total_Number_of_Orders;
	// string8		First_Order_Date;
	// string8		Last_Order_Date;
	
	// keep for joining to behavior key
	string10  ib_individual_id;
	string8   date_first_seen;	// from behavior key for keeping newest record, not consumer date (which are stored for output in ibehavior section)
	string8   date_last_seen;		// from behavior key for keeping newest record, not consumer date (which are stored for output in ibehavior section)
end;



// SEARCH THE CORRECTIONS FILE FOR THE CONSUMER, IF CORRECTION HIT, NEVER USE THE REAL RESULTS AT ALL
LayoutBehaviorTemp getConsumerCorrections(clam_pre_iBehavior le, FCRA.key_override_ibehavior.consumer ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.seq := le.seq;
	self.ib_individual_id := ri.ib_individual_id;	// keep for searching to behavior key
	self.ibehavior.Cnsmr_date_first_seen := ri.date_first_seen;
	self.ibehavior.Cnsmr_date_last_seen := if(ri.date_last_seen>myGetDate, myGetDate, ri.date_last_seen);
	self := le;
	self := [];	
end;
CnsmrCorrectionsFCRA_roxie := join(clam_pre_iBehavior(EXISTS(iBehavior_correct_ffid)), FCRA.key_override_ibehavior.consumer,	// only search records with a consumer correction/suppression
						keyed(right.flag_file_id in left.iBehavior_correct_ffid) and
						(unsigned)right.date_first_seen[1..6] < left.historydate,
						getConsumerCorrections(left, right),
						atmost(riskwise.max_atmost), keep(riskwise.max_atmost));
						
CnsmrCorrectionsFCRA_thor := join(clam_pre_iBehavior(EXISTS(iBehavior_correct_ffid)), // only search records with a consumer correction/suppression
						pull(FCRA.key_override_ibehavior.consumer),	
						right.flag_file_id in left.iBehavior_correct_ffid and
						(unsigned)right.date_first_seen[1..6] < left.historydate,
						getConsumerCorrections(left, right)
						, keep(riskwise.max_atmost), LOCAL, ALL);
					
CnsmrCorrectionsFCRA := if(onThor, CnsmrCorrectionsFCRA_thor, CnsmrCorrectionsFCRA_roxie);

// Get ib_individual_id from the consumer key.  could be many records per DID
LayoutBehaviorTemp getConsumer(clam_pre_ibehavior le, consumerKey ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	self.seq := le.seq;
	self.ib_individual_id := ri.ib_individual_id;	// keep for searching the behavior key
	self.ibehavior.Cnsmr_date_first_seen := ri.date_first_seen;
	self.ibehavior.Cnsmr_date_last_seen := if(ri.date_last_seen>myGetDate, myGetDate, ri.date_last_seen);
	self := le;	//shell fields
	self := [];	
end;
CnsmrNonFCRA_roxie := join(clam_pre_ibehavior, consumerKey,
						left.did<>0 and 
						keyed(left.did=right.did) 
						and (unsigned)right.date_first_seen[1..6] < left.historydate,	
						getConsumer(left, right),
						atmost(riskwise.max_atmost), keep(riskwise.max_atmost));
						
CnsmrNonFCRA_thor := join(distribute(clam_pre_ibehavior(did<>0), hash64(did)), 
						distribute(pull(consumerKey), hash64(did)),
						(left.did=right.did) 
						and (unsigned)right.date_first_seen[1..6] < left.historydate,	
						getConsumer(left, right),
						atmost(riskwise.max_atmost), keep(riskwise.max_atmost), LOCAL);

CnsmrNonFCRA := if(onThor, CnsmrNonFCRA_thor, CnsmrNonFCRA_roxie);

consumerFCRA_roxie := join(clam_pre_ibehavior(~EXISTS(iBehavior_correct_ffid)), consumerKey,	// only search records that dont have a consumer correction/suppression
						left.did<>0 and 
						keyed(left.did=right.did) and
						(unsigned)right.date_first_seen[1..6] < left.historydate,
						getConsumer(left, right),
						atmost(riskwise.max_atmost), keep(riskwise.max_atmost));

consumerFCRA_thor := join(distribute(clam_pre_ibehavior(~EXISTS(iBehavior_correct_ffid) and did<>0), hash64(did)), 	// only search records that dont have a consumer correction/suppression
						distribute(pull(consumerKey), hash64(did)),
						(left.did=right.did) and
						(unsigned)right.date_first_seen[1..6] < left.historydate,
						getConsumer(left, right),
						keep(riskwise.max_atmost), LOCAL);

consumerFCRA := if(onThor, consumerFCRA_thor, consumerFCRA_roxie);

CnsmrFCRA := 	consumerFCRA + CnsmrCorrectionsFCRA;


CnsmrRecs := ungroup(if(isFCRA, CnsmrFCRA, CnsmrNonFCRA));
						
						
// sort the cnsumer results so that we can dedup by ib_individual_id.  not sure that this will happen, but preventative
sortedCnsmr := group(dedup(sort(CnsmrRecs, seq, ib_individual_id, -ibehavior.Cnsmr_date_last_seen), seq, ib_individual_id), seq); //added descending Cnsmr_date_last_seen to keep most recent



// now search the behavior key to get info on the behavior for output in the shell
// IF CORRECTION RECORD EXISTS, NEVER USE RESULTS FROM THE REAL KEY
LayoutBehaviorTemp getBehaviorCorrections(sortedCnsmr le, FCRA.key_override_ibehavior.purchase ri) := transform
	myGetDate := iid_constants.myGetDate(le.historydate);
	SELF.seq := le.seq;	
	SELF.iBehavior := ri;
	self.date_first_seen := ri.date_first_seen;
	self.date_last_seen := if(ri.date_last_seen>myGetDate, myGetDate, ri.date_last_seen);
	self.ib_individual_id := ri.ib_individual_id;
	SELF := le;
end;
BehaviorCorrectionsFCRA_roxie := join(sortedCnsmr(EXISTS(iBehavior_correct_ffid)), FCRA.key_override_ibehavior.purchase,	// only search records with a consumer correction/suppression
						keyed(right.flag_file_id in left.iBehavior_correct_ffid) and
						(unsigned)right.date_first_seen[1..6] < left.historydate,
						getBehaviorCorrections(left, right), left outer,
						atmost(riskwise.max_atmost), keep(riskwise.max_atmost));
						
BehaviorCorrectionsFCRA_thor := join(sortedCnsmr(EXISTS(iBehavior_correct_ffid)), pull(FCRA.key_override_ibehavior.purchase),	// only search records with a consumer correction/suppression
						(right.flag_file_id in left.iBehavior_correct_ffid) and
						(unsigned)right.date_first_seen[1..6] < left.historydate,
						getBehaviorCorrections(left, right), left outer, 
						keep(riskwise.max_atmost), LOCAL, ALL);

BehaviorCorrectionsFCRA := if(onThor, BehaviorCorrectionsFCRA_thor, BehaviorCorrectionsFCRA_roxie);

LayoutBehaviorTemp getBehavior(sortedCnsmr le, behaviorKey ri) := TRANSFORM
	myGetDate := iid_constants.myGetDate(le.historydate);
	SELF.seq := le.seq;	
	SELF.iBehavior := ri;
	self.date_first_seen := ri.date_first_seen;
	self.date_last_seen := if(ri.date_last_seen>myGetDate, myGetDate, ri.date_last_seen);
	SELF := le;
END;
behaviorNonFCRA_roxie := join(sortedCnsmr, behaviorKey, 
												keyed(left.ib_individual_id = right.ib_individual_id) and
												(unsigned)right.date_first_seen[1..6] < left.historydate,	
												getBehavior(LEFT, RIGHT), left outer,
												ATMOST(riskwise.max_atmost), keep(riskwise.max_atmost));

behaviorNonFCRA_thor := join(distribute(sortedCnsmr, hash64(ib_individual_id)), 
												distribute(pull(behaviorKey), hash64(ib_individual_id)), 
												(left.ib_individual_id = right.ib_individual_id) and
												(unsigned)right.date_first_seen[1..6] < left.historydate,	
												getBehavior(LEFT, RIGHT), left outer,
												ATMOST(riskwise.max_atmost), keep(riskwise.max_atmost), LOCAL);
												
behaviorNonFCRA := if(onThor, behaviorNonFCRA_thor, behaviorNonFCRA_roxie);

behaviorFCRA_roxie := join(sortedCnsmr(~EXISTS(iBehavior_correct_ffid)), behaviorKey, 
												keyed(left.ib_individual_id = right.ib_individual_id) and
												(unsigned)right.date_first_seen[1..6] < left.historydate,
												getBehavior(LEFT, RIGHT), left outer,
												ATMOST(riskwise.max_atmost), keep(riskwise.max_atmost));	
												
behaviorFCRA_thor := join(distribute(sortedCnsmr(~EXISTS(iBehavior_correct_ffid)), hash64(ib_individual_id)), 
												distribute(pull(behaviorKey), hash64(ib_individual_id)), 
												left.ib_individual_id = right.ib_individual_id and
												(unsigned)right.date_first_seen[1..6] < left.historydate,
												getBehavior(LEFT, RIGHT), left outer,
												keep(riskwise.max_atmost), LOCAL);	
												
behaviorFCRA := if(onThor, behaviorFCRA_thor, behaviorFCRA_roxie);

BehaviorRecsFCRA := 	behaviorFCRA + BehaviorCorrectionsFCRA;

BehaviorRecs := ungroup(if(isFCRA, BehaviorRecsFCRA, behaviorNonFCRA));

						
						
// sort the cnsumer results so that we can dedup by ib_individual_id.  not sure that this will happen, but preventative
sortedBehavior := group(sort(BehaviorRecs, seq, -date_last_seen, -date_first_seen, ib_individual_id), seq);				


LayoutBehaviorTemp keepMostRecent(LayoutBehaviorTemp le, LayoutBehaviorTemp ri) := transform
	self.ibehavior.Cnsmr_date_first_seen := if(le.ibehavior.Cnsmr_date_first_seen > ri.ibehavior.Cnsmr_date_first_seen, ri.ibehavior.Cnsmr_date_first_seen, le.ibehavior.Cnsmr_date_first_seen);
	self.ibehavior.Cnsmr_date_last_seen  := if(le.ibehavior.Cnsmr_date_last_seen  < ri.ibehavior.Cnsmr_date_last_seen,  ri.ibehavior.Cnsmr_date_last_seen, le.ibehavior.Cnsmr_date_last_seen);
	self := le;	// always keep the most recent
end;
behaviorRoll := rollup(sortedBehavior, true, keepMostRecent(left, right));								
												
												
// output(clam_pre_iBehavior, named('clam_pre_iBehavior'));
// output(CnsmrCorrectionsFCRA, named('CnsmrCorrectionsFCRA'));	
// output(cnsmrRecs, named('cnsmrRecs'));
// output(sortedCnsmr, named('sortedCnsmr'));
// output(behaviorFCRA, named('behaviorFCRA'));
// output(behaviorCorrectionsFCRA, named('BehaviorCorrectionsFCRA'));
// output(behaviorRecsFCRA, named('BehaviorRecsFCRA'));
// output(behaviorRecs, named('behaviorRecs'));
// output(sortedBehavior, named('sortedBehavior'));

behaviorRollFinal := if(exclude_iBehavior, group(dataset([], LayoutBehaviorTemp ), seq), behaviorRoll);

return behaviorRollFinal;


end;