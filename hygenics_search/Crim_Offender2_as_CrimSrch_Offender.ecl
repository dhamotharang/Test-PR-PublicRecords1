/*2014-09-08T14:35:26Z (vchikte)
C:\Users\chiktevp\AppData\Roaming\HPCC Systems\eclide\vchikte\dataland_EOSS_Proxy\hygenics_search\Crim_Offender2_as_CrimSrch_Offender\2014-09-08T14_35_26Z.ecl
*/
import  corrections, hygenics_crim,CrimSrch,  crim_expunctions;

integer1 fGetScoreRank(string2 pScore)
	:= case(pScore,
			'F ' => 7,
			'S ' => 6,
			'M ' => 5,
			'I ' => 4,
			'V ' => 3,
			'T ' => 2,
			'U ' => 1,
			0);

	string2 fGetHighestScore(string2 pLeftScore, string2 pRightScore)
	:= if(fGetScoreRank(pLeftScore) > fGetScoreRank(pRightScore),
			pLeftScore,
			pRightScore);

	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tRollupOffensesToScore(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pLeft, hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pRight):= transform
		self				:= pLeft;
	end;


	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tRollupOffensesFlags(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pLeft, hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pRight) := transform
		self.Offender_Key					:= pLeft.Offender_Key;
		self.FCRA_Conviction_Flag	:= if(pLeft.FCRA_Conviction_Flag='Y' or pRight.FCRA_Conviction_Flag='Y',
																		'Y',
																	if(pLeft.FCRA_Conviction_Flag='D' or pRight.FCRA_Conviction_Flag='D',
																		'D',
																		'N')
																		);
		self.FCRA_Traffic_Flag		:= if(pLeft.FCRA_Traffic_Flag='Y' or pRight.FCRA_Traffic_Flag='Y',
																		'Y',
																		'N'
																		);																		
		self.FCRA_Date						:= if(pLeft.FCRA_Date='',
																		pRight.FCRA_Date,
																	if(pRight.FCRA_Date > pLeft.FCRA_Date,
																		pRight.FCRA_Date,
																		pLeft.FCRA_Date)
																		);
		self.FCRA_Date_Type				:= if(self.FCRA_Date = pRight.FCRA_Date,
																	pRight.FCRA_Date_Type,
																	pLeft.FCRA_Date_type
																		);
		self.Conviction_Override_Date		:= if(pLeft.Conviction_Override_Date='',
												  pRight.Conviction_Override_Date,
												  if(pRight.Conviction_Override_Date > pLeft.Conviction_Override_Date,
													 pRight.Conviction_Override_Date,
													 pLeft.Conviction_Override_Date
													)
												 );
		self.Conviction_Override_Date_Type	:= if(self.Conviction_Override_Date = pRight.Conviction_Override_Date,
																						pRight.Conviction_Override_Date_Type,
																						pLeft.Conviction_Override_Date_type
																						);
		self.offense_score									:= fGetHighestScore(pLeft.offense_score,pRight.offense_score);
		self																:= pLeft;
	end;

	hygenics_crim.layout_crimpunishment tRollupPunishmentDates(hygenics_crim.layout_crimpunishment pLeft, hygenics_crim.layout_crimpunishment pRight) := transform

		self.Conviction_Override_Date				:= if(pLeft.Conviction_Override_Date='',
																						pRight.Conviction_Override_Date,
																					if(pRight.Conviction_Override_Date > pLeft.Conviction_Override_Date,
																						pRight.Conviction_Override_Date,
																						pLeft.Conviction_Override_Date));
		self.Conviction_Override_Date_Type	:= if(self.Conviction_Override_Date = pRight.Conviction_Override_Date,
																						pRight.Conviction_Override_Date_Type,
																						pLeft.Conviction_Override_Date_type);
																						
		self.FCRA_Date						:= if(pLeft.FCRA_Date='',
																		pRight.FCRA_Date,
																	if(pRight.FCRA_Date > pLeft.FCRA_Date,
																		pRight.FCRA_Date,
																		pLeft.FCRA_Date)
																		);
		self.FCRA_Date_Type				:= if(self.FCRA_Date = pRight.FCRA_Date,
																	pRight.FCRA_Date_Type,
																	pLeft.FCRA_Date_type
																		);																						
		self																:= pLeft;
	end;


dCrimMinusVendorsToOmit	:= hygenics_crim.File_Offenders;//File_Crim_Offender2;//(Vendor not in sCourt_Vendors_To_Omit);
offense_join						:= Offenses_Joined;

///////////////////////////////////////////////////////////
//Remove Expunctions
///////////////////////////////////////////////////////////
offns := offense_join;
offnd := dCrimMinusVendorsToOmit;

///////////////////////////////////////////////////////////
//Court Ventures Expunction List -- ttg 4/20/2009
///////////////////////////////////////////////////////////
cvExp := Crim_Expunctions.File_Court_Venture_Suppressions;
newLayout1 := record
string cvExp_source_file;
string20 cvExp_lname;
string20 cvExp_fname;
string20 cvExp_mname;
offns.offender_key;
offns.court_case_number;
end;
	
newLayout1 trecs(offns L, cvExp R) := transform
self.cvExp_source_file := R.source_file;
self.cvExp_lname := R.lname;
self.cvExp_fname := R.fname;
self.cvExp_mname := R.mname;
self := L;
end;

jrecs := join(offns(court_case_number<>''), cvExp, // get expunged offense record
				left.court_case_number = right.cau_nbr,
				trecs(left,right),lookup);
//------------------------------------------------------
newLayout2 := record   //expunction table layout
jrecs.cvExp_source_file;
string35 offns_court_case_number;
offnd.offender_key;
string60 offns_offender_key;
offnd.lname;
jrecs.cvExp_lname;
offnd.fname;
jrecs.cvExp_fname;
offnd.mname;
jrecs.cvExp_mname;
end;
				
newLayout2 trecs2(offnd L, jrecs R) := transform
self.cvExp_source_file := R.cvExp_source_file;
self.cvExp_lname := R.cvExp_lname;
self.cvExp_fname := R.cvExp_fname;
self.cvExp_mname := R.cvExp_mname;
self.offns_offender_key := R.offender_key;
self.offns_court_case_number := R.court_case_number;
self := L;
end;

jrecs2 := join(distribute(offnd(lname+fname<>''),hash(offender_key)), distribute(jrecs,hash(offender_key)),  // get corresponding offender record 
				left.offender_key = right.offender_key and
				left.lname = right.cvExp_lname and 
				left.fname = right.cvExp_fname,
				trecs2(left,right),local):INDEPENDENT;
				
output(jrecs2,,'~thor_data400::base::cv_suppressions::found',overwrite);
				
///////////////////////////////////////////////////////////
//--- EXPUNGE RECORDS 20070111 CN
///////////////////////////////////////////////////////////
dedup_expunge_offender_key:= dedup(Crim_Expunctions.File_MiscflaggedinNameField, ALL);

jrecs2 cmbnRecs(dedup_expunge_offender_key L) := transform

self := L;
self := [];
end;

precs := project(dedup_expunge_offender_key,cmbnRecs(Left));

//Combine Expunction Files	
allExp := precs+jrecs2;

corrections.layout_offender JoinKeys(corrections.layout_offender L, allExp R) 
 := TRANSFORM
	self := L;
 end;

offnd_dMoxieFileDedup2 :=
	JOIN(offnd, allExp, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys(left, right), left only, lookup);

offnd_hard_code_did_removals := offnd_dMoxieFileDedup2;//hygenics_crim.fn_blank_the_did(offnd_dMoxieFileDedup2);			
//END EXPUNGE -- Offender////////////////////////////////////////////////////////////////////////////////////////////////

expungedOffenders				:= offnd_hard_code_did_removals;
dCrimOffender2Dist			:= distribute(expungedOffenders,hash(Offender_Key));
dCrimOffender2Sorted		:= sort(dCrimOffender2Dist,Offender_Key,local);

dCrimSrchOffensesDist		:= distribute(Offenses_Joined,hash(Offender_Key));
dCrimSrchOffensesSorted	:= sort(dCrimSrchOffensesDist,Offender_Key,local);

dOffensesRolledUpOffenderKey 		:= rollup(dCrimSrchOffensesSorted,
																		left.Offender_Key=right.Offender_Key,
																		tRollupOffensesFlags(left,right),local);

dCrimSrchPunishmentDist					:= distribute(Punishment_Joined,hash(Offender_Key));
dCrimSrchPunishmentSorted				:= sort(dCrimSrchPunishmentDist,Offender_Key,local);

dPunishmentRolledUpOffenderKey 	:= rollup(dCrimSrchPunishmentSorted,
																		left.Offender_Key=right.Offender_Key,
																		tRollupPunishmentDates(left,right),local);

	corrections.layout_offender tCrimOffender2AndOffensestoOffender(corrections.layout_offender pCrimOffender2, hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pOffenses):= transform
		self.fcra_conviction_flag		:= if(pOffenses.FCRA_Conviction_Flag<>'',
																		if(pOffenses.FCRA_Conviction_Flag='D'
																		or (pCrimOffender2.Data_Type='1' and
																		pCrimOffender2.Vendor not in CrimSrch.sDOC_Vendors_Conviction_Unknown 	and
																		pCrimOffender2.Vendor not in CrimSrch.sDOC_Vendors_NoOffense_NoConviction
																		),
											 'Y',
											 pOffenses.FCRA_Conviction_Flag
											),
										  if(pCrimOffender2.Data_Type='1' 												and
											  pCrimOffender2.Vendor not in CrimSrch.sDOC_Vendors_Conviction_Unknown 	and
											  pCrimOffender2.Vendor not in CrimSrch.sDOC_Vendors_NoOffense_NoConviction,
											'Y',
											'N'
											)
										 );
		self.fcra_traffic_flag		:= if(pCrimOffender2.data_type='1',
										  'N',
										  if(pOffenses.FCRA_Traffic_Flag<>'',
											 pOffenses.FCRA_Traffic_Flag,
											 'U'
											)
										 );
		self.fcra_date				:= if((integer4)pOffenses.FCRA_Date<>0,
										             pOffenses.FCRA_Date,''
										  //if((integer4)pCrimOffender2.Case_date<>0, //VC: Commented for Bug: 162725  
											// pCrimOffender2.Case_date,
											// if(pCrimOffender2.Data_Type='1'
											//and pCrimOffender2.Vendor not in sDOC_Vendors_Conviction_Unknown
											//and	pCrimOffender2.Vendor not in sDOC_Vendors_NoOffense_NoConviction,
											//	pCrimOffender2.process_date,
											//	''
											//   )
											//)
										 );
		self.fcra_date_type			:= if((integer4)pOffenses.FCRA_Date<>0,
										              pOffenses.FCRA_Date_Type,
										              //'F' //VC: Commented for Bug: 162725  
																	''
										              );
		self.conviction_override_date		:= if((integer4)pOffenses.Conviction_Override_Date<>0,
												  pOffenses.Conviction_Override_Date,
												  if(pCrimOffender2.Vendor in sDOC_Vendors_Conviction_Unknown,
													 '',
													 if(pCrimOffender2.Vendor in sDOC_Vendors_NoOffense_NoConviction,
														pOffenses.Conviction_Override_date,
														pCrimOffender2.Case_Date
													   )
													)
												 );
		self.conviction_override_date_type	:= if(pOffenses.Conviction_Override_Date_Type<>'',
												  pOffenses.Conviction_Override_Date_Type,	
												  if((integer4)self.Conviction_Override_Date<>0,
													 pOffenses.Conviction_Override_Date_Type,
													 'F'
													)
												 );
		self.offense_score					:= if(pOffenses.offense_score<>'',
												  pOffenses.offense_score,
												  ' '
												 );
		//self.image_link 					:= '';
		self											:= pCrimOffender2;
		self											:= pOffenses;
	end;

dCrimOffender2WithOffenseFlags					:= join(dCrimOffender2Sorted,dOffensesRolledUpOffenderKey,
																						left.Offender_Key = right.Offender_Key,
																						tCrimOffender2AndOffensestoOffender(left,right),
																						left outer,local);

	corrections.layout_offender tOffenderAndPunishmenttoOffender(corrections.layout_offender pOffender, hygenics_crim.layout_crimpunishment pPunishment) :=transform
		self.conviction_override_date				:= if(pPunishment.Conviction_Override_Date > pOffender.Conviction_Override_Date,
																						pPunishment.Conviction_Override_Date,
																						pOffender.Conviction_Override_Date);
		self.conviction_override_date_type	:= if(pPunishment.Conviction_Override_Date > pOffender.Conviction_Override_Date,
																						pPunishment.Conviction_Override_Date_Type,
																						pOffender.Conviction_Override_Date_Type);
																						
		//Added to use punishment fields also for FCRA date	Bug: 162725  																
	  self.fcra_date				:= if((integer4)pOffender.FCRA_Date<>0,
										             pOffender.FCRA_Date,pPunishment.FCRA_Date 								  
										           );
		self.fcra_date_type			:= if((integer4)pOffender.FCRA_Date<>0,
										              pOffender.FCRA_Date_Type,
										              pPunishment.FCRA_Date_Type
										             );																						
		self																:= pOffender;
	end;


dCrimOffender2WithAllFlags		:= join(dCrimOffender2WithOffenseFlags,dPunishmentRolledUpOffenderKey,
																		left.Offender_Key = right.Offender_Key,
																		tOffenderAndPunishmenttoOffender(left,right),
																		left outer,local): persist('thor_data20::persist::Crim_Offender2_as_CrimSrch_Offender');



export Crim_Offender2_as_CrimSrch_Offender := dCrimOffender2WithAllFlags; 
