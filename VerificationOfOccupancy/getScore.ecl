import doxie, mdr, drivers, dx_header, suppress, riskwise, Relationship, VerificationOfOccupancy;

EXPORT getScore(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOBatchOut) VOO_attr,
								DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOO_shell, 
																		string50 DataRestrictionMask, 
																		boolean glb_ok,
																		integer dppa,
																		boolean isUtility,
																		boolean dppa_ok,
                                    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
    	
VerificationOfOccupancy.Layouts.Layout_VOOBatchOut appendScore(VOO_attr le) := transform

	nonowner := 0 <= (integer)le.attributes.version1.AddressOwnershipHistoryIndex AND (integer)le.attributes.version1.AddressOwnershipHistoryIndex <= 2;

	voo_nonown_subscore0 := map(
    0 <= (integer)le.attributes.version1.AddressReportingSourceIndex AND (integer)le.attributes.version1.AddressReportingSourceIndex <= 1 	=> -0.638074,
    2 <= (integer)le.attributes.version1.AddressReportingSourceIndex AND (integer)le.attributes.version1.AddressReportingSourceIndex <= 5 	=> 0.633342,
																																																																							 -0.000000);

	voo_nonown_subscore1 := map(
    1 <= (integer)le.attributes.version1.AddressReportingHistoryIndex AND (integer)le.attributes.version1.AddressReportingHistoryIndex <= 4 => -0.266380,
    (integer)le.attributes.version1.AddressReportingHistoryIndex = 5                                        																=> -0.774922,
    (integer)le.attributes.version1.AddressReportingHistoryIndex = 6                                        																=> 1.803694,
																																																																							 0.000000);

	voo_nonown_subscore2 := map(
    (integer)le.attributes.version1.AddressSearchHistoryIndex = 0                                     																			=> 0.857399,
    1 <= (integer)le.attributes.version1.AddressSearchHistoryIndex AND (integer)le.attributes.version1.AddressSearchHistoryIndex <= 4 			=> -2.442365,
    5 <= (integer)le.attributes.version1.AddressSearchHistoryIndex AND (integer)le.attributes.version1.AddressSearchHistoryIndex <= 6 			=> 0.690903,
																																																																							 -0.000000);

	voo_nonown_subscore3 := map(
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = -1                                     																		=> -0.000000,
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = 0                                      																		=> -1.550355,
    1 <= (integer)le.attributes.version1.AddressUtilityHistoryIndex AND (integer)le.attributes.version1.AddressUtilityHistoryIndex <= 2 		=> 0.128488,
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = 3                                      																		=> 0.326541,
    4 <= (integer)le.attributes.version1.AddressUtilityHistoryIndex AND (integer)le.attributes.version1.AddressUtilityHistoryIndex <= 5 		=> 0.603514,
    6 <= (integer)le.attributes.version1.AddressUtilityHistoryIndex AND (integer)le.attributes.version1.AddressUtilityHistoryIndex <= 7 		=> 1.976346,
																																																																							 -0.000000);

	voo_nonown_subscore4 := map(
    (integer)le.attributes.version1.PriorAddressMoveIndex = 0                                 																							=> -0.000000,
    1 <= (integer)le.attributes.version1.PriorAddressMoveIndex AND (integer)le.attributes.version1.PriorAddressMoveIndex <= 4 							=> -0.602273,
    (integer)le.attributes.version1.PriorAddressMoveIndex = 5                                 																							=> 0.146374,
    6 <= (integer)le.attributes.version1.PriorAddressMoveIndex AND (integer)le.attributes.version1.PriorAddressMoveIndex <= 8 							=> 0.269886,
																																																																							 -0.000000);

	voo_nonown_subscore5 := map(
    (integer)le.attributes.version1.PriorResidentMoveIndex = 0               																																=> 0.000000,
    (integer)le.attributes.version1.PriorResidentMoveIndex = 2               																																=> -0.696425,
    ((integer)le.attributes.version1.PriorResidentMoveIndex in [1, 5])       																																=> -0.104292,
    ((integer)le.attributes.version1.PriorResidentMoveIndex in [3, 4, 6, 7]) 																																=> 0.401559,
																																																																							 0.000000);

	voo_nonown_scaledscore := 100 * (voo_nonown_subscore0 +
    voo_nonown_subscore1 +
    voo_nonown_subscore2 +
    voo_nonown_subscore3 +
    voo_nonown_subscore4 +
    voo_nonown_subscore5);

	voo_subscore0 := map(
    (integer)le.attributes.version1.AddressReportingHistoryIndex = -1                                       																=> 0.000000,
    1 <= (integer)le.attributes.version1.AddressReportingHistoryIndex AND (integer)le.attributes.version1.AddressReportingHistoryIndex <= 5 => -0.293665,
    (integer)le.attributes.version1.AddressReportingHistoryIndex = 6                                        																=> 1.420608,
																																																																							 0.000000);

	voo_subscore1 := map(
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = -1                                     																		=> 0.000000,
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = 0                                      																		=> -0.320004,
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = 1                                      																		=> -0.123982,
    (integer)le.attributes.version1.AddressUtilityHistoryIndex = 2                                      																		=> -0.023230,
    3 <= (integer)le.attributes.version1.AddressUtilityHistoryIndex AND (integer)le.attributes.version1.AddressUtilityHistoryIndex <= 4 		=> 0.127505,
    5 <= (integer)le.attributes.version1.AddressUtilityHistoryIndex AND (integer)le.attributes.version1.AddressUtilityHistoryIndex <= 7 		=> 0.295083,
																																																																							 0.000000);

	voo_subscore2 := map(
    (integer)le.attributes.version1.PriorAddressMoveIndex = -1              																																=> 0.000000,
    (integer)le.attributes.version1.PriorAddressMoveIndex = 0               																																=> 0.000000,
    ((integer)le.attributes.version1.PriorAddressMoveIndex in [1, 3, 4])    																																=> -0.235265,
    ((integer)le.attributes.version1.PriorAddressMoveIndex in [2, 5, 6, 7]) 																																=> 0.039622,
    (integer)le.attributes.version1.PriorAddressMoveIndex = 8               																																=> 0.383272,
																																																																							 0.000000);

	voo_subscore3 := map(
    (integer)le.attributes.version1.AddressReportingSourceIndex = -1                                      																	=> -0.000000,
    0 <= (integer)le.attributes.version1.AddressReportingSourceIndex AND (integer)le.attributes.version1.AddressReportingSourceIndex <= 1 	=> -0.327236,
    2 <= (integer)le.attributes.version1.AddressReportingSourceIndex AND (integer)le.attributes.version1.AddressReportingSourceIndex <= 5 	=> 0.093413,
																																																																							 -0.000000);

	voo_subscore4 := map(
    (integer)le.attributes.version1.AddressOwnerMailingAddressIndex = -1                                          																=> -0.000000,
    (integer)le.attributes.version1.AddressOwnerMailingAddressIndex = 0                                           																=> -0.332759,
    1 <= (integer)le.attributes.version1.AddressOwnerMailingAddressIndex AND (integer)le.attributes.version1.AddressOwnerMailingAddressIndex <= 4 => -0.251751,
    5 <= (integer)le.attributes.version1.AddressOwnerMailingAddressIndex AND (integer)le.attributes.version1.AddressOwnerMailingAddressIndex <= 6 => 0.106405,
																																																																										 -0.000000);

	voo_subscore5 := map(
    (integer)le.attributes.version1.PriorResidentMoveIndex = -1           																																	=> 0.000000,
    (integer)le.attributes.version1.PriorResidentMoveIndex = 0            																																	=> 0.234090,
    ((integer)le.attributes.version1.PriorResidentMoveIndex in [1, 2, 5]) 																																	=> -0.159173,
    ((integer)le.attributes.version1.PriorResidentMoveIndex in [3, 4, 6]) 																																	=> -0.047227,
    (integer)le.attributes.version1.PriorResidentMoveIndex = 7            																																	=> 0.266560,
																																																																							 0.000000);

	voo_subscore6 := map(
    (integer)le.attributes.version1.AddressOwnershipHistoryIndex = -1           																														=> -0.000000,
    (integer)le.attributes.version1.AddressOwnershipHistoryIndex = 0            																														=> -0.000000,
    ((integer)le.attributes.version1.AddressOwnershipHistoryIndex in [1, 2, 4]) 																														=> -0.061193,
    ((integer)le.attributes.version1.AddressOwnershipHistoryIndex in [3, 5])    																														=> 0.209296,
																																																																							 -0.000000);

	voo_subscore7 := map(
    (integer)le.attributes.version1.AddressSearchHistoryIndex = -1                                    																			=> -0.000000,
    ((integer)le.attributes.version1.AddressSearchHistoryIndex in [0, 5, 6])                          																			=> 0.027621,
    1 <= (integer)le.attributes.version1.AddressSearchHistoryIndex AND (integer)le.attributes.version1.AddressSearchHistoryIndex <= 4 			=> -0.391741,
																																																																							 -0.000000);

	voo_scaledscore := 100 * (voo_subscore0 +
    voo_subscore1 +
    voo_subscore2 +
    voo_subscore3 +
    voo_subscore4 +
    voo_subscore5 +
    voo_subscore6 +
    voo_subscore7);

	unscorable := (integer)le.attributes.version1.OccupancyOverride > 0 or (integer)le.attributes.version1.AddressReportingHistoryIndex = -1 or (integer)le.attributes.version1.AddressPropertyTypeIndex = 3;

	worst_arsi := (integer)le.attributes.version1.AddressReportingSourceIndex <= 1;

	worst_arhi := (integer)le.attributes.version1.AddressReportingHistoryIndex = 1;

	worst_ashi := 1 <= (integer)le.attributes.version1.AddressSearchHistoryIndex AND (integer)le.attributes.version1.AddressSearchHistoryIndex <= 2;

	worst_auhi := (integer)le.attributes.version1.AddressUtilityHistoryIndex <= 1;

	worst_apti := 1 <= (integer)le.attributes.version1.AddressPropertyTypeIndex AND (integer)le.attributes.version1.AddressPropertyTypeIndex <= 3;

	worst_avi := 1 <= (integer)le.attributes.version1.AddressValidityIndex AND (integer)le.attributes.version1.AddressValidityIndex <= 2;

	worst_rcai := (integer)le.attributes.version1.RelativesConfirmingAddressIndex = 1;

	worst_aomai := (integer)le.attributes.version1.AddressOwnerMailingAddressIndex = 1;

	worst_pami := (integer)le.attributes.version1.PriorAddressMoveIndex = 1;

	worst_prmi := (integer)le.attributes.version1.PriorResidentMoveIndex = 1;

	worst_total := (integer)worst_arsi +
    (integer)worst_arhi +
    (integer)worst_ashi +
    (integer)worst_auhi +
    (integer)worst_apti +
    (integer)worst_avi +
    (integer)worst_rcai +
    (integer)worst_aomai +
    (integer)worst_pami +
    (integer)worst_prmi;

	owner_score := map(
    unscorable                                                                              => 0,
    voo_scaledscore >= 144 and worst_total = 0                                              => 90,
    voo_scaledscore >= 29 and worst_total = 0 or voo_scaledscore >= 110 and worst_total = 1 => 80,
    voo_scaledscore >= -11 and worst_total <= 1                                             => 70,
    voo_scaledscore >= -28                                                                  => 60,
    voo_scaledscore >= -46                                                                  => 50,
    voo_scaledscore >= -62                                                                  => 40,
    voo_scaledscore >= -81                                                                  => 30,
    voo_scaledscore >= -109                                                                 => 20,
                                                                                               10);

	nonowner_score := map(
    unscorable                                                                                             => 0,
    voo_nonown_scaledscore >= 357 and worst_total = 0                                                      => 90,
    voo_nonown_scaledscore >= 171 and worst_total = 0 or voo_nonown_scaledscore >= 357 and worst_total = 1 => 80,
    voo_nonown_scaledscore >= 55 and worst_total <= 1                                                      => 70,
    voo_nonown_scaledscore >= 41                                                                           => 60,
    voo_nonown_scaledscore >= 22                                                                           => 50,
    voo_nonown_scaledscore >= -53                                                                          => 40,
    voo_nonown_scaledscore >= -146                                                                         => 30,
    voo_nonown_scaledscore >= -295                                                                         => 20,
                                                                                                              10);

	voo_score := if(nonowner, nonowner_score, owner_score);
	//if insufficient input (all other attributes will be blank) set the score to blank as well
	self.attributes.version1.VerificationOfOccupancyScore := if(le.attributes.version1.AddressReportingHistoryIndex = '', '', (string)voo_Score);
	self := le;
end;

wScore := project(VOO_attr, appendScore(left));

voshell_dedp := dedup(sort(ungroup(VOO_shell),did), did);
RelativeMax := 500;
voshell_dids := PROJECT(voshell_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

rellyids := Relationship.proc_GetRelationshipNeutral(voshell_dids,TopNCount:=RelativeMax,
		RelativeFlag:=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RelativeMax).result; 
		
//use the new relatives key to get all DIDs that are related to our input subject
VerificationOfOccupancy.Layouts.Layout_VOOShell GetRelatInfo(VOO_shell le, rellyids ri, integer degree) := TRANSFORM
		self.infer_own_relatedDID := ri.did2;
		self 											:= le;
END;

//set a new keep of 500
relatedDIDs :=  join(VOO_shell, rellyids, left.did = right.did1,
                     GetRelatInfo(left, right, 1), left outer);

dk := choosen(dx_header.key_max_dt_last_seen(), 1);
hdrBuildDate01 := ((string)dk[1].max_date_last_seen)[1..6];

//get all DIDs associated with our target input address
Key_Header_Address := dx_header.key_header_address();
   VerificationOfOccupancy_CCPA := RECORD
   VerificationOfOccupancy.Layouts.Layout_VOOShell;
	 Unsigned4 Global_sid;
   end;
VerificationOfOccupancy_CCPA getDIDs(VOO_shell le, Key_Header_Address ri) := TRANSFORM
	SELF.global_sid := ri.global_sid;
  SELF.infer_own_targetDID 			:= ri.DID;
	SELF.infer_own_current 				:= trim((string)ri.dt_last_seen) >= hdrBuildDate01 OR ri.dt_last_seen >= le.historydate; // Need to make sure our "current" calculation still works in history mode
	SELF 													:= le;
END;

targetDIDs_unsuppressed := join(VOO_shell, Key_Header_Address,
												keyed(left.prim_name = right.prim_name) and
												keyed(left.z5 = right.zip) and
												keyed(left.prim_range = right.prim_range) and
												keyed(left.sec_range = right.sec_range) and
												left.predir = right.predir and left.addr_suffix = right.suffix and left.postdir = right.postdir and 
												(RIGHT.dt_first_seen < LEFT.historydate AND RIGHT.dt_first_seen <> 0) and 
												left.did <> right.did AND  //we are looking for unrelated people here, so no need to keep the subject's recs
												glb_ok AND
												(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
												(~mdr.Source_is_DPPA(RIGHT.src) OR 
													(dppa_ok AND drivers.state_dppa_ok(dx_header.functions.translateSource(RIGHT.src),DPPA,RIGHT.src))),
								getDIDs(LEFT,RIGHT), left outer, ATMOST(riskwise.max_atmost));
                
    targetDIDs_flagged := Suppress.MAC_FlagSuppressedSource(targetDIDs_unsuppressed, mod_access);

	targetDIDs := PROJECT(targetDIDs_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
    SELF.infer_own_targetDID 			:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.infer_own_targetDID);
    SELF.infer_own_current 				:= IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.infer_own_current);
	SELF := LEFT;
	)); 
//keep only those DIDs that are currently updating for the target address
dedupTargetDIDs := dedup(sort(targetDIDs(infer_own_current), seq, infer_own_targetDID), seq, infer_own_targetDID);

//join target DIDs to related DIDs and keep the non-matches (we want to know if there are unrelated entities currently reporting at the target address)
VerificationOfOccupancy.Layouts.Layout_VOOShell getUnrelated(dedupTargetDIDs le, relatedDIDs ri) := TRANSFORM
	SELF.infer_own_unrelated 			:= true;
	SELF 													:= le;
END;

unrelatedDIDs := join(dedupTargetDIDs, relatedDIDs, 
			left.seq = right.seq and
			left.infer_own_targetDID = right.infer_own_relatedDID,
			getUnrelated(left,right),left only); //left only join - keep target DIDs that do not match to the relative DIDs (unrelated)

// Join unrelated DIDs back to VOO shell
VerificationOfOccupancy.Layouts.Layout_VOOShell addUnrelated(VOO_shell le, unrelatedDIDs ri) := TRANSFORM
		 self.infer_own_targetDID		:= ri.infer_own_targetDID;
		 self.infer_own_current			:= ri.infer_own_current;
		 self.infer_own_unrelated		:= ri.infer_own_unrelated;
		 self := le;
END;	

with_unrelated := join(VOO_shell, unrelatedDIDs, 
			left.seq = right.seq,
			addUnrelated(left,right),left outer, keep(1));  //if more than one unrelated entity exists for target, just keep one

//join the attributes to the VOO shell and apply the Inferred Ownership attribute, now that we have the info we need to compute it
VerificationOfOccupancy.Layouts.Layout_VOOBatchOut getInferredOwner(wScore le, VOO_shell ri) := TRANSFORM
	validInput := trim(ri.in_streetAddress) <> '' and trim(ri.in_city) <> '' and trim(ri.in_state) <> '' and trim(ri.fname) <> '' and trim(ri.lname) <> ''; 
	self.attributes.version1.InferredOwnershipTypeIndex			:= if(validInput,
																																map(ri.DID = 0																															=> '-1',
																																		ri.target_addr_owned='1' and ri.target_addr_sold<>'1' and 
																																			(integer)le.attributes.version1.VerificationOfOccupancyScore > 60 		=> '4', //owns target and score > 60
																																		ri.target_addr_owned='1' and ri.target_addr_sold<>'1' and 
																																			ri.other_prox_distance <> 9999999 and //indicates owner of another property
																																			(integer)le.attributes.version1.VerificationOfOccupancyScore <= 60 and
																																			(le.attributes.version1.AddressValidityIndex = '3' or
																																			~ri.infer_own_unrelated) 																							=> '3', //owns target and owns other and score <= 60 and (target is seasonal or no non-relatives are associated)
																																		ri.target_addr_owned='1' and ri.target_addr_sold<>'1' and
																																			(integer)le.attributes.version1.VerificationOfOccupancyScore <= 60 and
																																			ri.infer_own_unrelated																								=> '2', //owns target and score <= 60 and non-relatives are associated
																																		ri.target_addr_owned='1' and ri.target_addr_sold<>'1' and
																																			(integer)le.attributes.version1.VerificationOfOccupancyScore <= 60 		=> '1', //owns target and score <= 60
																																		ri.target_addr_owned<>'1'																								=> '0',
																																																																							 '0'), 
																																'');
		SELF 																									:= le;
	END;	

with_InferredOwner := join(wScore, with_unrelated, 
			left.seq = right.seq,
			getInferredOwner(left,right),left outer);



// output(wScore, named('wScore'));
// output(relatedDIDs, named('relatedDIDs'));
// output(targetDIDs, named('targetDIDs'));
// output(dedupTargetDIDs, named('dedupTargetDIDs'));
// output(unrelatedDIDs, named('unrelatedDIDs'));
// output(with_unrelated, named('with_unrelated'));
// output(with_InferredOwner, named('with_InferredOwner'));

return with_InferredOwner;	
	
END;
