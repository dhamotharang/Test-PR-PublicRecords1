import ut, watchdog;

export fnPropagateADLs(
			dataset(layout_history) inhistory = File_GongHistory,		// = dataset('~thor_data400::base::gong_history',layout_historyaid, flat, __compressed__), 
			intmax_nm_match_score = 2, // higher match score allows lenient matches
			dataset( recordof(Watchdog.Layout_Gong_DID)) gongbase = Gong_Neustar.File_Gong_DID) 
		:= module

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export NoDID_Layout := record
	string10 phone10, 
	string2 flag, 
	string name_last,  
	string name_first,  
	string name_middle,  
	unsigned6 did,  
	unsigned6 new_did := 0,  
	string5 pDID := '',  
	unsigned cnt := 1, 
	string60 matchnm := '', 
end;


/////////////////////////////ASSIGN PHONE7 PHONE10 FLAGS for VERIFICATION///////////////////////////////////////////////////////
							   
shared flaggedGdPh := /* flags phones as good for matching (either all 10 digits or last 7 and did populated) */
	project(inhistory,
		transform({recordof(inhistory), unsigned6 new_did := 0, unsigned cnt := 1, string2 flag, string60 matchnm := ''}, 
			  phone10 := if(left.phone10[1..3] in ['000','XXX','xxx'], '   ', left.phone10[1..3])+ left.phone10[4..10]; /* empty area codes standardized */
			  NPAg := phone10[1..3] in ['800','811','822','833','844','855','866','877','888','899'] or phone10[1..3] between '200' and '999'; /* toll free area codes */
			  NXXg := phone10[4..6] between '001' and '999'; /* valid nxx */
			  TBg  := phone10[7..10] between '0000' and '9999'; /* valid tb+ */
			self.flag := map(NPAg and NXXg and TBg => '10', 				/* 10 is valid npa, nxx, tb */
							 NXXg and TBg => '07', 							/* 07 is valid nxx only */
							 '00');											/* 00 is bad phone default */
			self.pDID := if(left.did > 0, '0001', '');						/* 0001 is when DID is already populated */
			self := left));

/////////////////////////////PREPARE DID and NON-DID FILES FOR JOINING//////////////////////////////////////////////////////////

/* records with names and phones only */
shared distHist := distribute(flaggedGdPh(name_first <> '' and name_last <> '' and flag <> '00'), hash64(phone10)); 
									
/* Records for Propogation - did'ed records that are not superfluous by name and address*/
	srtDID := sort(distHist(did > 0), phone10, flag, name_last, name_first, name_middle, did, local);
shared seqDID := table(dedup(srtDID, phone10, flag, name_last, name_first, name_middle, did, local), 
				{phone10, flag, name_last, name_first, name_middle, did, new_did, pDID, cnt, matchnm, cntDID := count(group)}, 
					phone10, flag, name_last, name_first, name_middle, did, new_did, pDID, cnt, matchnm, local)(cntDID = 1);	

/* Records for Propogation - not did'ed records */
	srtNoDID := sort(distHist(did = 0), phone10, flag, name_last, name_first, name_middle, local);
seqNoDID := project(dedup(srtNoDID, phone10, flag, name_last, name_first, name_middle, local), 
						NoDID_Layout);
						
//////////////////////////////JOIN Phone 10, First Name, Last Name///////////////////////////////////////////////////////////////////
jp10NMHmatches := join(seqNoDID(flag = '10'), seqDID(flag = '10'), 
						  left.phone10 = right.phone10
						  and left.name_first[1] = right.name_first[1]
						  and left.name_last[1] = right.name_last[1]
						,transform({recordof(seqNoDID)},
								/* score for name match for pDID */
								name_match_score := (string4)intformat(DataLib.NameMatch(left.name_first,left.name_middle,left.name_last, right.name_first,right.name_middle,right.name_last), 3, 1);
								/* score for phone match for pDID */
								name_match_type := map(left.name_last = right.name_last and left.name_first = right.name_first => '1', 
														left.name_last[1] = right.name_last[1] and left.name_first[1] = right.name_first[1] => '2', 
														'');
							self.pDID := map(name_match_type <> '' and name_match_score between '000' and '002' => 
											   name_match_type + name_match_score, /* pDID is name match score and name match type if there is a match */
											   '');
							self.new_DID := if(self.pDID <> '', right.did, 0);
							self.matchnm :=  stringlib.stringfindreplace(stringlib.stringcleanspaces(right.name_last + ', ' + right.name_first + ' ' + right.name_middle), ' ,', ',');
							self := left), 
							left outer, local);
							

sort_matches := sort(jp10NMHmatches, record, except flag, cnt, matchnm, local);
dedup_matches := dedup(sort_matches, record, except flag, pdid, cnt, matchnm, local);

rollup1s := rollup(dedup_matches(pdid[1] = '1'), transform(recordof(seqNoDID),
						self.cnt := left.cnt + if(left.new_did = 0 or right.new_did = 0 or ut.NNEQ((string)left.new_did, (string)right.new_did), 0, right.cnt);
						self.pdid := map(left.pDID < right.pDID => left.pDID, right.pDID);
						self.matchnm := map(left.pDID < right.pDID => left.matchnm, right.matchnm);
						self := right), 
					record, except flag, new_did, pdid, cnt, matchnm, local);

resort_matches := sort(rollup1s + dedup_matches(pdid[1] <> '1'), record, except flag, cnt, matchnm, local);

/* Final Rollup for History */	
jnt_roll := project(rollup(resort_matches , transform(NoDID_Layout,
						self.cnt := left.cnt + if(left.new_did = 0 or right.new_did = 0 or ut.NNEQ((string)left.new_did, (string)right.new_did), 0, right.cnt);
						self.pdid := map(left.pDID[1] > '0' and left.pDID < right.pDID => left.pDID, right.pDID);
						self.matchnm := map(left.pDID[1] > '0' and left.pDID < right.pDID => left.matchnm, right.matchnm);
						self := right), 
					record, except flag, new_did, pdid, cnt, matchnm, local), 
						transform(NoDID_Layout,
							self.pdid := map(left.cnt > 1 and left.pdid[1] <> '1' => (string5)intformat(left.cnt, 4, 1), left.pdid); 
							self.new_did := map(left.cnt > 1 => 0 , left.new_did);
							self.matchnm := map(left.cnt > 1 or left.pdid = ''  => '', left.matchnm);
							self := left));
							
shared rollup_matches := jnt_roll;
														
joinBack := join(distHist(did = 0), rollup_matches(pdid <> ''),
					left.phone10 = right.phone10 and
					left.name_first = right.name_first and
					left.name_last = right.name_last and
					left.name_middle = right.name_middle,
					transform(recordof(inhistory),
							self.did := right.new_did,
							self.pdid := right.pdid,
							self := left), left outer, local, skew(1.0));
						
export history := project(distHist(did > 0) + flaggedGdPh(name_first = '' or name_last = '' or flag = '00'), {recordof(joinBack)}) + joinBack;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tbMatches := table(seqDID((pdid = '0001' or pdid >= '1000') and did > 0), {phone10, name_first, name_last, name_middle, did}, phone10, name_first, name_last, name_middle, did);

joinBackBase := join(DISTRIBUTE(gongbase(did = 0),hash32(phone10)), tbMatches,
					left.phone10 = right.phone10 and
					left.name_first = right.name_first and
					left.name_last = right.name_last and
					left.name_middle = right.name_middle,
					transform(recordof(gongbase),
							self.did := right.did,
							self := left), left outer, skew(0.1));

export base := project(gongbase(did > 0), {recordof(joinBackBase)}) + joinBackBase;


end;
