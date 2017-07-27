import CrimSrch, hygenics_crim, crim_common;

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

	crimsrch.Layout_Moxie_Offenses_temp tRollupOffensesToScore(crimsrch.Layout_Moxie_Offenses_temp pLeft, crimsrch.Layout_Moxie_Offenses_temp pRight):= transform
		self				:= pLeft;
	end;


	crimsrch.Layout_Moxie_Offenses_temp tRollupOffensesFlags(crimsrch.Layout_Moxie_Offenses_temp pLeft, crimsrch.Layout_Moxie_Offenses_temp pRight) := transform
		self.Offender_Key			:= pLeft.Offender_Key;
		self.FCRA_Conviction_Flag	:= if(pLeft.FCRA_Conviction_Flag='Y' or pRight.FCRA_Conviction_Flag='Y',
										  'Y',
										  if(pLeft.FCRA_Conviction_Flag='D' or pRight.FCRA_Conviction_Flag='D',
											 'D',
											 'N'
											)
										 );
		self.FCRA_Traffic_Flag		:= if(pLeft.FCRA_Traffic_Flag='Y' or pRight.FCRA_Traffic_Flag='Y','Y','N');
		self.FCRA_Date				:= if(pLeft.FCRA_Date='',
										  pRight.FCRA_Date,
										  if(pRight.FCRA_Date > pLeft.FCRA_Date,
											 pRight.FCRA_Date,
											 pLeft.FCRA_Date
											)
										 );
		self.FCRA_Date_Type			:= if(self.FCRA_Date = pRight.FCRA_Date,
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
		self.offense_score					:= fGetHighestScore(pLeft.offense_score,pRight.offense_score);
		self								:= pLeft;
	end;

	Layout_Moxie_Punishment tRollupPunishmentDates(Layout_Moxie_Punishment pLeft, Layout_Moxie_Punishment pRight) := transform
		self.Conviction_Override_Date		:= if(pLeft.Conviction_Override_Date='',
												  pRight.Conviction_Override_Date,
												  if(pRight.Conviction_Override_Date > pLeft.Conviction_Override_Date,
													 pRight.Conviction_Override_Date,
													 pLeft.Conviction_Override_Date));
		self.Conviction_Override_Date_Type	:= if(self.Conviction_Override_Date = pRight.Conviction_Override_Date,
												  pRight.Conviction_Override_Date_Type,
												  pLeft.Conviction_Override_Date_type);
		self								:= pLeft;
	end;

dCrimMinusVendorsToOmit	:= File_Crim_Offender2(Vendor not in sCourt_Vendors_To_Omit);
dCrimOffender2Dist		:= distribute(dCrimMinusVendorsToOmit,hash(Offender_Key));
dCrimOffender2Sorted	:= sort(dCrimOffender2Dist,Offender_Key,local);

dCrimSrchOffensesDist	:= distribute(Offenses_Joined,hash(Offender_Key));
dCrimSrchOffensesSorted	:= sort(dCrimSrchOffensesDist,Offender_Key,local);

dOffensesRolledUpOffenderKey := rollup(dCrimSrchOffensesSorted,
									left.Offender_Key=right.Offender_Key,
									tRollupOffensesFlags(left,right),local);

dCrimSrchPunishmentDist		:= distribute(Punishment_Joined,hash(Offender_Key));
dCrimSrchPunishmentSorted	:= sort(dCrimSrchPunishmentDist,Offender_Key,local);

dPunishmentRolledUpOffenderKey := rollup(dCrimSrchPunishmentSorted,
		 left.Offender_Key=right.Offender_Key,
		 tRollupPunishmentDates(left,right),local);

	crimsrch.Layout_Moxie_Offender_temp tCrimOffender2AndOffensestoOffender(Crim_Common.Layout_Moxie_Crim_Offender2.previous pCrimOffender2, crimsrch.Layout_Moxie_Offenses_temp pOffenses):= transform
		self.date_first_reported	:= pCrimOffender2.process_date;
		self.date_last_reported		:= pCrimOffender2.process_date;
		self.offender_key			:= pCrimOffender2.offender_key;
		self.vendor					:= pCrimOffender2.vendor;
		self.state_of_origin		:= pCrimOffender2.state_origin;
		self.data_type				:= pCrimOffender2.data_type;
		self.source_file			:= pCrimOffender2.source_file;
		self.off_name				:= pCrimOffender2.pty_nm;
		self.orig_lname				:= pCrimOffender2.orig_lname;
		self.orig_fname				:= pCrimOffender2.orig_fname;
		self.orig_mname				:= pCrimOffender2.orig_mname;
		self.orig_name_suffix		:= pCrimOffender2.orig_name_suffix;
		self.off_name_type			:= pCrimOffender2.pty_typ;
		self.place_of_birth			:= pCrimOffender2.place_of_birth;
		self.dob					:= pCrimOffender2.dob;
		self.dob_alias				:= pCrimOffender2.dob_alias;
		self.orig_ssn				:= pCrimOffender2.orig_ssn;
		self.offender_id_num_1		:= pCrimOffender2.dle_num;
		self.offender_id_num_type_1	:= if(pCrimOffender2.dle_num<>'','DLE No','');
		self.offender_id_num_2		:= pCrimOffender2.doc_num;
		self.offender_id_num_type_2	:= if(pCrimOffender2.doc_num<>'','DOC No','');
		self.sor_date_1				:= '';
		self.sor_date_type_1		:= '';
		self.sor_date_2				:= '';
		self.sor_date_type_2		:= '';
		self.sor_date_3				:= '';
		self.sor_date_type_3		:= '';
		self.sor_status				:= '';
		self.sor_offender_category	:= '';
		self.sor_risk_level_code	:= '';
		self.sor_risk_level_desc	:= '';
		self.sor_registration_type	:= '';
		self.offender_status		:= pCrimOffender2.party_status;
		self.offender_address_1		:= pCrimOffender2.street_address_1;
		self.offender_address_2		:= pCrimOffender2.street_address_2;
		self.offender_address_3		:= pCrimOffender2.street_address_3;
		self.offender_address_4		:= pCrimOffender2.street_address_4;
		self.offender_address_5		:= pCrimOffender2.street_address_5;
		self.case_number			:= pCrimOffender2.case_number;
		self.case_court				:= pCrimOffender2.case_court;
		self.case_name				:= pCrimOffender2.case_name;
		self.case_type				:= pCrimOffender2.case_type;
		self.case_type_desc			:= pCrimOffender2.case_type_desc;
		self.case_filing_date		:= pCrimOffender2.case_filing_dt;
		self.race_desc				:= pCrimOffender2.race_desc;
		self.sex					:= pCrimOffender2.sex;
		self.hair_color_desc		:= pCrimOffender2.hair_color_desc;
		self.eye_color_desc			:= pCrimOffender2.eye_color_desc;
		self.skin_color_desc		:= pCrimOffender2.skin_color_desc;
		self.height					:= pCrimOffender2.height;
		self.weight					:= pCrimOffender2.weight;
		self.ethnicity				:= '';
		self.age					:= '';
		self.build_type				:= '';
		self.scars_marks_tattoos	:= '';
		self.did					:= pCrimOffender2.did;
		self.ssn					:= pCrimOffender2.ssn;
		self.cleaning_score			:= pCrimOffender2.cleaning_score;
		self.name_suffix			:= pCrimOffender2.name_suffix;
		self.lname					:= pCrimOffender2.lname;
		self.mname                  := pCrimOffender2.mname;
		self.fname					:= pCrimOffender2.fname;
		self.title					:= pCrimOffender2.title;
		self.err_stat				:= pCrimOffender2.err_stat;
		self.geo_match				:= pCrimOffender2.geo_match;
		self.geo_blk				:= pCrimOffender2.geo_blk;
		self.msa					:= pCrimOffender2.msa;
		self.geo_long				:= pCrimOffender2.geo_long;
		self.geo_lat				:= pCrimOffender2.geo_lat;
		self.ace_fips_county		:= pCrimOffender2.ace_fips_county;
		self.ace_fips_st			:= pCrimOffender2.ace_fips_st;
		self.rec_type				:= pCrimOffender2.rec_type;
		self.chk_digit				:= pCrimOffender2.chk_digit;
		self.dpbc					:= pCrimOffender2.dpbc;
		self.lot_order				:= pCrimOffender2.lot_order;
		self.lot					:= pCrimOffender2.lot;
		self.cr_sort_sz				:= pCrimOffender2.cr_sort_sz;
		self.cart					:= pCrimOffender2.cart;
		self.zip4					:= pCrimOffender2.zip4;
		self.zip5					:= pCrimOffender2.zip5;
		self.state					:= pCrimOffender2.state;
		self.v_city_name			:= pCrimOffender2.v_city_name;
		self.p_city_name			:= pCrimOffender2.p_city_name;
		self.sec_range				:= pCrimOffender2.sec_range;
		self.unit_desig				:= pCrimOffender2.unit_desig;
		self.postdir				:= pCrimOffender2.postdir;
		self.addr_suffix			:= pCrimOffender2.addr_suffix;
		self.prim_name				:= pCrimOffender2.prim_name;
		self.predir					:= pCrimOffender2.predir;
		self.prim_range				:= pCrimOffender2.prim_range;
		self.fcra_conviction_flag	:= if(pOffenses.FCRA_Conviction_Flag<>'',
										  if(pOffenses.FCRA_Conviction_Flag='D'
										  or (pCrimOffender2.Data_Type='1' 												and
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
										  pOffenses.FCRA_Date,
										  if((integer4)pCrimOffender2.Case_Filing_Dt<>0,
											 pCrimOffender2.Case_Filing_Dt,
											 if(pCrimOffender2.Data_Type='1'
											and pCrimOffender2.Vendor not in sDOC_Vendors_Conviction_Unknown
											and	pCrimOffender2.Vendor not in sDOC_Vendors_NoOffense_NoConviction,
												pCrimOffender2.process_date,
												''
											   )
											)
										 );
		self.fcra_date_type			:= if((integer4)pOffenses.FCRA_Date<>0,
										  pOffenses.FCRA_Date_Type,
										  'F'
										 );
		self.conviction_override_date		:= if((integer4)pOffenses.Conviction_Override_Date<>0,
												  pOffenses.Conviction_Override_Date,
												  if(pCrimOffender2.Vendor in sDOC_Vendors_Conviction_Unknown,
													 '',
													 if(pCrimOffender2.Vendor in sDOC_Vendors_NoOffense_NoConviction,
														pOffenses.Conviction_Override_date,
														pCrimOffender2.Case_Filing_Dt
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
		self.image_link 					:= '';
			
			//mapping for temporary fields added to facilitate LIfe EIR project
			self.orig_state 							:= self.state_of_origin;
			self.file_date 								:= self.case_filing_date;
			self.county_name							:= self.ace_fips_county;
			self.ssn_appended							:= pCrimOffender2.ssn;
			self.case_num									:= self.case_number;
			self.case_date								:= self.case_filing_date;
			self 													:= pCrimOffender2;
			self													:= [];
	end;

dCrimOffender2WithOffenseFlags	:= join(dCrimOffender2Sorted,dOffensesRolledUpOffenderKey,
										left.Offender_Key = right.Offender_Key,
										tCrimOffender2AndOffensestoOffender(left,right),
										left outer,local);

	crimsrch.Layout_Moxie_Offender_temp tOffenderAndPunishmenttoOffender(crimsrch.Layout_Moxie_Offender_temp pOffender,Layout_Moxie_Punishment pPunishment) :=transform
		self.conviction_override_date		:= if(pPunishment.Conviction_Override_Date > pOffender.Conviction_Override_Date,
												  pPunishment.Conviction_Override_Date,
												  pOffender.Conviction_Override_Date);
		self.conviction_override_date_type	:= if(pPunishment.Conviction_Override_Date > pOffender.Conviction_Override_Date,
												  pPunishment.Conviction_Override_Date_Type,
												  pOffender.Conviction_Override_Date_Type);
		self								:= pOffender;
	end;


dCrimOffender2WithAllFlags		:= join(dCrimOffender2WithOffenseFlags,dPunishmentRolledUpOffenderKey,
										left.Offender_Key = right.Offender_Key,
										tOffenderAndPunishmenttoOffender(left,right),
										left outer,local);

	crimsrch.Layout_Moxie_Offender_temp tFixNameType(crimsrch.Layout_Moxie_Offender_temp pLeft, crimsrch.Layout_Moxie_Offender_temp pRight):= transform
		self.Off_Name_Type	:= if(pLeft.Offender_Key='','0','2');
		self				:= pRight;
	end;

dCrimOffender2FixedDist 	:= distribute(dCrimOffender2WithAllFlags,hash(Offender_Key));
// Sort gives us filled DIDs first, and if no DIDs filled, name type "0" first
// by default.  Keep in mind that "2" record types would not have DID'd anyway.
dCrimOffender2FixedSorted	:= sort(dCrimOffender2FixedDist,Offender_Key,-DID,Off_Name_Type,local);
dCrimOffender2FixedGrouped	:= group(dCrimOffender2FixedSorted,Offender_Key);
dCrimOffender2FixedTypeSet	:= iterate(dCrimOffender2FixedGrouped,tFixNameType(left,right));
dCrimOffender2FixedReady	:= ungroup(dCrimOffender2FixedTypeSet);

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
	export Crim_Offender2_as_CrimSrch_Offender := dCrimOffender2FixedReady : persist('persist::Crim_Offender2_as_CrimSrch_Offender');
#else
	export Crim_Offender2_as_CrimSrch_Offender := dCrimOffender2FixedReady;
#end