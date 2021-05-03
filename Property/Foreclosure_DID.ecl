import _control, bipv2, MDR, ut, MDR, BKForeclosure, Std, dx_Property;

foreclosureIn 				:= property.File_Foreclosure_In;  //contains both new and base file data
addGSForeclosureIn		:= MDR.macGetGlobalSid(foreclosureIn,'Foreclosure','','global_sid'); //DF-25926: Add Global_SID

layout_foreclosureIn 	:= recordof(addGSForeclosureIn);
normalizeDIDLayout 		:= recordof(Property.File_Foreclosure_Normalized);

layout_foreclosureIn denormalizeRecords(addGSForeclosureIn l, normalizeDIDLayout r) := transform
	self.name1_did 				:= if(r.name_indicator=1, intformat(r.did,12,1), l.name1_did);
	self.name1_did_score 	:= if(r.name_indicator=1, (string)r.did_score, l.name1_did_score);
	self.name1_ssn 				:= if(r.name_indicator=1, r.ssn, l.name1_ssn);
	self.name1_bdid 			:= if(r.name_indicator=1, intformat(r.bdid,12,1), l.name1_bdid);
	self.name1_bdid_score := if(r.name_indicator=1, (string)r.bdid_score, 	  l.name1_bdid_score);
	self.name1.DotID		  := if(r.name_indicator=1, r.DotID, 		  0);
	self.name1.DotScore		:= if(r.name_indicator=1, r.DotScore,	  0);
	self.name1.DotWeight	:= if(r.name_indicator=1, r.DotWeight,  0);
	self.name1.EmpID		  := if(r.name_indicator=1, r.EmpID, 		  0);
	self.name1.EmpScore		:= if(r.name_indicator=1, r.EmpScore,   0);
	self.name1.EmpWeight	:= if(r.name_indicator=1, r.EmpWeight,  0);
	self.name1.POWID		  := if(r.name_indicator=1, r.POWID, 		  0);
	self.name1.POWScore		:= if(r.name_indicator=1, r.POWScore,   0);
	self.name1.POWWeight	:= if(r.name_indicator=1, r.POWWeight,  0);;
	self.name1.ProxID		  := if(r.name_indicator=1, r.ProxID, 	  0);
	self.name1.ProxScore	:= if(r.name_indicator=1, r.ProxScore,  0);
	self.name1.ProxWeight	:= if(r.name_indicator=1, r.ProxWeight, 0);
	self.name1.SeleID		  := if(r.name_indicator=1, r.SeleID, 	  0);
	self.name1.SeleScore	:= if(r.name_indicator=1, r.SeleScore,  0);
	self.name1.SeleWeight	:= if(r.name_indicator=1, r.SeleWeight, 0);	
	self.name1.OrgID		  := if(r.name_indicator=1, r.OrgID,			0);
	self.name1.OrgScore		:= if(r.name_indicator=1, r.OrgScore, 	0);
	self.name1.OrgWeight	:= if(r.name_indicator=1, r.OrgWeight,  0);
	self.name1.UltID		  := if(r.name_indicator=1, r.UltID, 		 	0);
	self.name1.UltScore		:= if(r.name_indicator=1, r.UltScore, 	0);
	self.name1.UltWeight	:= if(r.name_indicator=1, r.UltWeight,  0);


	self.name2_did 				:= if(r.name_indicator=2, intformat(r.did,12,1), l.name2_did);
	self.name2_did_score 	:= if(r.name_indicator=2, (string)r.did_score, l.name2_did_score);
	self.name2_ssn 				:= if(r.name_indicator=2, r.ssn, l.name2_ssn);
	self.name2_bdid 			:= if(r.name_indicator=2, intformat(r.bdid,12,1), l.name2_bdid);
	self.name2_bdid_score := if(r.name_indicator=2, (string)r.bdid_score, l.name2_bdid_score);
	self.name2.DotID		  := if(r.name_indicator=2, r.DotID, 		  0);
	self.name2.DotScore		:= if(r.name_indicator=2, r.DotScore,	  0);
	self.name2.DotWeight	:= if(r.name_indicator=2, r.DotWeight,  0);
	self.name2.EmpID		  := if(r.name_indicator=2, r.EmpID, 		  0);
	self.name2.EmpScore		:= if(r.name_indicator=2, r.EmpScore,   0);
	self.name2.EmpWeight	:= if(r.name_indicator=2, r.EmpWeight,  0);
	self.name2.POWID		  := if(r.name_indicator=2, r.POWID, 		  0);
	self.name2.POWScore		:= if(r.name_indicator=2, r.POWScore,   0);
	self.name2.POWWeight	:= if(r.name_indicator=2, r.POWWeight,  0);
	self.name2.ProxID		  := if(r.name_indicator=2, r.ProxID, 	  0);
	self.name2.ProxScore	:= if(r.name_indicator=2, r.ProxScore,  0);
	self.name2.ProxWeight	:= if(r.name_indicator=2, r.ProxWeight, 0);
	self.name2.SeleID		  := if(r.name_indicator=2, r.SeleID, 	  0);
	self.name2.SeleScore	:= if(r.name_indicator=2, r.SeleScore,  0);
	self.name2.SeleWeight	:= if(r.name_indicator=2, r.SeleWeight, 0);		
	self.name2.OrgID		  := if(r.name_indicator=2, r.OrgID, 			0);
	self.name2.OrgScore		:= if(r.name_indicator=2, r.OrgScore, 	0);
	self.name2.OrgWeight	:= if(r.name_indicator=2, r.OrgWeight,  0);
	self.name2.UltID		  := if(r.name_indicator=2, r.UltID, 		 	0);
	self.name2.UltScore		:= if(r.name_indicator=2, r.UltScore, 	0);
	self.name2.UltWeight	:= if(r.name_indicator=2, r.UltWeight,  0);
	
	self.name3_did 				:= if(r.name_indicator=3, intformat(r.did,12,1), l.name3_did);
	self.name3_did_score 	:= if(r.name_indicator=3, (string)r.did_score, l.name3_did_score);
	self.name3_ssn 				:= if(r.name_indicator=3, r.ssn, l.name3_ssn);
	self.name3_bdid 			:= if(r.name_indicator=3, intformat(r.bdid,12,1), l.name3_bdid);
	self.name3_bdid_score := if(r.name_indicator=3, (string)r.bdid_score, l.name3_bdid_score);
	self.name3.DotID			:= if(r.name_indicator=3, r.DotID, 		  0);
	self.name3.DotScore		:= if(r.name_indicator=3, r.DotScore,	  0);
	self.name3.DotWeight	:= if(r.name_indicator=3, r.DotWeight,  0);
  self.name3.EmpID			:= if(r.name_indicator=3, r.EmpID,      0);
	self.name3.EmpScore		:= if(r.name_indicator=3, r.EmpScore,   0);
	self.name3.EmpWeight	:= if(r.name_indicator=3, r.EmpWeight,  0);
	self.name3.POWID			:= if(r.name_indicator=3, r.POWID, 		  0);
	self.name3.POWScore		:= if(r.name_indicator=3, r.POWScore,   0);
	self.name3.POWWeight	:= if(r.name_indicator=3, r.POWWeight,  0);
	self.name3.ProxID			:= if(r.name_indicator=3, r.ProxID, 	  0);
	self.name3.ProxScore	:= if(r.name_indicator=3, r.ProxScore,  0);
	self.name3.ProxWeight	:= if(r.name_indicator=3, r.ProxWeight, 0);
	self.name3.SeleID		  := if(r.name_indicator=3, r.SeleID, 	  0);
	self.name3.SeleScore	:= if(r.name_indicator=3, r.SeleScore,  0);
	self.name3.SeleWeight	:= if(r.name_indicator=3, r.SeleWeight, 0);		
	self.name3.OrgID			:= if(r.name_indicator=3, r.OrgID,			0);
	self.name3.OrgScore		:= if(r.name_indicator=3, r.OrgScore, 	0);
	self.name3.OrgWeight	:= if(r.name_indicator=3, r.OrgWeight,  0);
	self.name3.UltID			:= if(r.name_indicator=3, r.UltID, 		 	0);
	self.name3.UltScore		:= if(r.name_indicator=3, r.UltScore, 	0);
	self.name3.UltWeight	:= if(r.name_indicator=3, r.UltWeight,  0);
	
	self.name4_did 				:= if(r.name_indicator=4, intformat(r.did,12,1), l.name4_did);
	self.name4_did_score 	:= if(r.name_indicator=4, (string)r.did_score, l.name4_did_score);
	self.name4_ssn 				:= if(r.name_indicator=4, r.ssn, l.name4_ssn);
	self.name4_bdid 			:= if(r.name_indicator=4, intformat(r.bdid,12,1), l.name4_bdid);
	self.name4_bdid_score := if(r.name_indicator=4, (string)r.bdid_score, l.name4_bdid_score);
	self.name4.DotID			:= if(r.name_indicator=4, r.DotID, 		  0);
	self.name4.DotScore		:= if(r.name_indicator=4, r.DotScore,	  0);
	self.name4.DotWeight	:= if(r.name_indicator=4, r.DotWeight,  0);
  self.name4.EmpID			:= if(r.name_indicator=4, r.EmpID,      0);
	self.name4.EmpScore		:= if(r.name_indicator=4, r.EmpScore,   0);
	self.name4.EmpWeight	:= if(r.name_indicator=4, r.EmpWeight,  0);
	self.name4.POWID			:= if(r.name_indicator=4, r.POWID, 		  0);
	self.name4.POWScore		:= if(r.name_indicator=4, r.POWScore,   0);
	self.name4.POWWeight	:= if(r.name_indicator=4, r.POWWeight,  0);
	self.name4.ProxID			:= if(r.name_indicator=4, r.ProxID, 	  0);
	self.name4.ProxScore	:= if(r.name_indicator=4, r.ProxScore,  0);
	self.name4.ProxWeight	:= if(r.name_indicator=4, r.ProxWeight, 0);
	self.name4.SeleID		  := if(r.name_indicator=4, r.SeleID, 	  0);
	self.name4.SeleScore	:= if(r.name_indicator=4, r.SeleScore,  0);
	self.name4.SeleWeight	:= if(r.name_indicator=4, r.SeleWeight, 0);			
	self.name4.OrgID			:= if(r.name_indicator=4, r.OrgID,			0);
	self.name4.OrgScore		:= if(r.name_indicator=4, r.OrgScore, 	0);
	self.name4.OrgWeight	:= if(r.name_indicator=4, r.OrgWeight,  0);
	self.name4.UltID			:= if(r.name_indicator=4, r.UltID, 		 	0);
	self.name4.UltScore		:= if(r.name_indicator=4, r.UltScore, 	0);
	self.name4.UltWeight	:= if(r.name_indicator=4, r.UltWeight,  0);
	
	self.name5_did 				:= if(r.name_indicator=5, intformat(r.did,12,1), l.name5_did);
	self.name5_did_score 	:= if(r.name_indicator=5, (string)r.did_score, l.name5_did_score);
	self.name5_ssn 				:= if(r.name_indicator=5, r.ssn, l.name5_ssn);
	self.name5_bdid 			:= if(r.name_indicator=5, intformat(r.bdid,12,1), l.name5_bdid);
	self.name5_bdid_score := if(r.name_indicator=5, (string)r.bdid_score, l.name5_bdid_score);
	self.name5.DotID			:= if(r.name_indicator=5, r.DotID, 		  0);
	self.name5.DotScore		:= if(r.name_indicator=5, r.DotScore,	  0);
	self.name5.DotWeight	:= if(r.name_indicator=5, r.DotWeight,  0);
  self.name5.EmpID			:= if(r.name_indicator=5, r.EmpID,      0);
	self.name5.EmpScore		:= if(r.name_indicator=5, r.EmpScore,   0);
	self.name5.EmpWeight	:= if(r.name_indicator=5, r.EmpWeight,  0);
	self.name5.POWID			:= if(r.name_indicator=5, r.POWID, 		  0);
	self.name5.POWScore		:= if(r.name_indicator=5, r.POWScore,   0);
	self.name5.POWWeight	:= if(r.name_indicator=5, r.POWWeight,  0);
	self.name5.ProxID			:= if(r.name_indicator=5, r.ProxID, 	  0);
	self.name5.ProxScore	:= if(r.name_indicator=5, r.ProxScore,  0);
	self.name5.ProxWeight	:= if(r.name_indicator=5, r.ProxWeight, 0);
	self.name5.SeleID		  := if(r.name_indicator=5, r.SeleID, 	  0);
	self.name5.SeleScore	:= if(r.name_indicator=5, r.SeleScore,  0);
	self.name5.SeleWeight	:= if(r.name_indicator=5, r.SeleWeight, 0);			
	self.name5.OrgID			:= if(r.name_indicator=5, r.OrgID,			0);
	self.name5.OrgScore		:= if(r.name_indicator=5, r.OrgScore, 	0);
	self.name5.OrgWeight	:= if(r.name_indicator=5, r.OrgWeight,  0);
	self.name5.UltID			:= if(r.name_indicator=5, r.UltID, 		 	0);
	self.name5.UltScore		:= if(r.name_indicator=5, r.UltScore, 	0);
	self.name5.UltWeight	:= if(r.name_indicator=5, r.UltWeight,  0);	
	
	self.name6_did 				:= if(r.name_indicator=6, intformat(r.did,12,1), l.name6_did);
	self.name6_did_score 	:= if(r.name_indicator=6, (string)r.did_score, l.name6_did_score);
	self.name6_ssn 				:= if(r.name_indicator=6, r.ssn, l.name6_ssn);
	self.name6_bdid 			:= if(r.name_indicator=6, intformat(r.bdid,12,1), l.name6_bdid);
	self.name6_bdid_score := if(r.name_indicator=6, (string)r.bdid_score, l.name6_bdid_score);
	self.name6.DotID			:= if(r.name_indicator=6, r.DotID, 		  0);
	self.name6.DotScore		:= if(r.name_indicator=6, r.DotScore,	  0);
	self.name6.DotWeight	:= if(r.name_indicator=6, r.DotWeight,  0);
  self.name6.EmpID			:= if(r.name_indicator=6, r.EmpID,      0);
	self.name6.EmpScore		:= if(r.name_indicator=6, r.EmpScore,   0);
	self.name6.EmpWeight	:= if(r.name_indicator=6, r.EmpWeight,  0);
	self.name6.POWID			:= if(r.name_indicator=6, r.POWID, 		  0);
	self.name6.POWScore		:= if(r.name_indicator=6, r.POWScore,   0);
	self.name6.POWWeight	:= if(r.name_indicator=6, r.POWWeight,  0);
	self.name6.ProxID			:= if(r.name_indicator=6, r.ProxID, 	  0);
	self.name6.ProxScore	:= if(r.name_indicator=6, r.ProxScore,  0);
	self.name6.ProxWeight	:= if(r.name_indicator=6, r.ProxWeight, 0);
	self.name6.SeleID		  := if(r.name_indicator=6, r.SeleID, 	  0);
	self.name6.SeleScore	:= if(r.name_indicator=6, r.SeleScore,  0);
	self.name6.SeleWeight	:= if(r.name_indicator=6, r.SeleWeight, 0);			
	self.name6.OrgID			:= if(r.name_indicator=6, r.OrgID,			0);
	self.name6.OrgScore		:= if(r.name_indicator=6, r.OrgScore, 	0);
	self.name6.OrgWeight	:= if(r.name_indicator=6, r.OrgWeight,  0);
	self.name6.UltID			:= if(r.name_indicator=6, r.UltID, 		 	0);
	self.name6.UltScore		:= if(r.name_indicator=6, r.UltScore, 	0);
	self.name6.UltWeight	:= if(r.name_indicator=6, r.UltWeight,  0);

	self.name7_did 				:= if(r.name_indicator=7, intformat(r.did,12,1), l.name7_did);
	self.name7_did_score 	:= if(r.name_indicator=7, (string)r.did_score, l.name7_did_score);
	self.name7_ssn 				:= if(r.name_indicator=7, r.ssn, l.name7_ssn);
	self.name7_bdid 			:= if(r.name_indicator=7, intformat(r.bdid,12,1), l.name7_bdid);
	self.name7_bdid_score := if(r.name_indicator=7, (string)r.bdid_score, l.name7_bdid_score);
	self.name7.DotID			:= if(r.name_indicator=7, r.DotID, 		  0);
	self.name7.DotScore		:= if(r.name_indicator=7, r.DotScore,	  0);
	self.name7.DotWeight	:= if(r.name_indicator=7, r.DotWeight,  0);
  self.name7.EmpID			:= if(r.name_indicator=7, r.EmpID,      0);
	self.name7.EmpScore		:= if(r.name_indicator=7, r.EmpScore,   0);
	self.name7.EmpWeight	:= if(r.name_indicator=7, r.EmpWeight,  0);
	self.name7.POWID			:= if(r.name_indicator=7, r.POWID, 		  0);
	self.name7.POWScore		:= if(r.name_indicator=7, r.POWScore,   0);
	self.name7.POWWeight	:= if(r.name_indicator=7, r.POWWeight,  0);
	self.name7.ProxID			:= if(r.name_indicator=7, r.ProxID, 	  0);
	self.name7.ProxScore	:= if(r.name_indicator=7, r.ProxScore,  0);
	self.name7.ProxWeight	:= if(r.name_indicator=7, r.ProxWeight, 0); 
	self.name7.SeleID		  := if(r.name_indicator=7, r.SeleID, 	  0);
	self.name7.SeleScore	:= if(r.name_indicator=7, r.SeleScore,  0);
	self.name7.SeleWeight	:= if(r.name_indicator=7, r.SeleWeight, 0);			
	self.name7.OrgID			:= if(r.name_indicator=7, r.OrgID,			0);
	self.name7.OrgScore		:= if(r.name_indicator=7, r.OrgScore, 	0);
	self.name7.OrgWeight	:= if(r.name_indicator=7, r.OrgWeight,  0);
	self.name7.UltID			:= if(r.name_indicator=7, r.UltID, 		 	0);
	self.name7.UltScore		:= if(r.name_indicator=7, r.UltScore, 	0);
	self.name7.UltWeight	:= if(r.name_indicator=7, r.UltWeight,  0);

	self.name8_did 				:= if(r.name_indicator=8, intformat(r.did,12,1), l.name8_did);
	self.name8_did_score 	:= if(r.name_indicator=8, (string)r.did_score, l.name8_did_score);
	self.name8_ssn 				:= if(r.name_indicator=8, r.ssn, l.name8_ssn);
	self.name8_bdid 			:= if(r.name_indicator=8, intformat(r.bdid,12,1), l.name8_bdid);
	self.name8_bdid_score := if(r.name_indicator=8, (string)r.bdid_score, l.name8_bdid_score);	
	self.name8.DotID			:= if(r.name_indicator=8, r.DotID, 		  0);
	self.name8.DotScore		:= if(r.name_indicator=8, r.DotScore,	  0);
	self.name8.DotWeight	:= if(r.name_indicator=8, r.DotWeight,  0);
  self.name8.EmpID			:= if(r.name_indicator=8, r.EmpID,      0);
	self.name8.EmpScore		:= if(r.name_indicator=8, r.EmpScore,   0);
	self.name8.EmpWeight	:= if(r.name_indicator=8, r.EmpWeight,  0);
	self.name8.POWID			:= if(r.name_indicator=8, r.POWID, 		  0);
	self.name8.POWScore		:= if(r.name_indicator=8, r.POWScore,   0);
	self.name8.POWWeight	:= if(r.name_indicator=8, r.POWWeight,  0);
	self.name8.ProxID			:= if(r.name_indicator=8, r.ProxID, 	  0);
	self.name8.ProxScore	:= if(r.name_indicator=8, r.ProxScore,  0);
	self.name8.ProxWeight	:= if(r.name_indicator=8, r.ProxWeight, 0);
	self.name8.SeleID		  := if(r.name_indicator=8, r.SeleID, 	  0);
	self.name8.SeleScore	:= if(r.name_indicator=8, r.SeleScore,  0);
	self.name8.SeleWeight	:= if(r.name_indicator=8, r.SeleWeight, 0);			
	self.name8.OrgID			:= if(r.name_indicator=8, r.OrgID,			0);
	self.name8.OrgScore		:= if(r.name_indicator=8, r.OrgScore, 	0);
	self.name8.OrgWeight	:= if(r.name_indicator=8, r.OrgWeight,  0);
	self.name8.UltID			:= if(r.name_indicator=8, r.UltID, 		 	0);
	self.name8.UltScore		:= if(r.name_indicator=8, r.UltScore, 	0);
	self.name8.UltWeight	:= if(r.name_indicator=8, r.UltWeight,  0);
	
	self := l;
end;

//Distribute the data before denormalize to avoid skewing
foreclosureInDist					:=	DISTRIBUTE(addGSForeclosureIn, HASH32(sequence));
foreclosureNormalizedDist	:=	DISTRIBUTE(Property.foreclosure_normalized(source = 'FR'), HASH32(sequence)); //only want CL data as BK is appended at the end

foreclosureBase := denormalize(foreclosureInDist, foreclosureNormalizedDist,
									left.sequence = right.sequence,
									denormalizeRecords(left,right), LOCAL);


//Combine BlackKnight base files, mapped to Foreclosure_base layout, with Core Logic base file. Project CL into base and add source code
ForceclosureBaseV2 := PROJECT(foreclosureBase,TRANSFORM(dx_property.Layout_Fares_Foreclosure_v2, 
																												SELF.SOURCE := IF(TRIM(LEFT.SOURCE) IN ['B7','I5'],LEFT.SOURCE,MDR.sourceTools.src_Foreclosures); //make sure not overwritting BK records although there shouldn't be any
																												SELF := LEFT; SELF := [])); //To combine BK and CL

BKforeclosureBase	:= BKForeclosure.Fn_Map_BK2Foreclosure;

CombineAll	:= DEDUP(SORT(ForceclosureBaseV2 + BKforeclosureBase,foreclosure_id,-process_date),ALL);

ut.mac_suppress_by_phonetype(CombineAll,		attorney_phone_nbr,state,                   phone_out1);
ut.mac_suppress_by_phonetype(phone_out1,     lender_phone,      lender_beneficiary_state,phone_out2);
ut.mac_suppress_by_phonetype(phone_out2,     trustee_phone,     trustee_state,           phone_out3);

f1 := foreclosurebase(attorney_phone_nbr<>'' or lender_phone<>'' or trustee_phone<>'');

r1 := record
 f1.foreclosure_id;
 f1.attorney_phone_nbr;
 f1.lender_phone;
 f1.trustee_phone;
end;

ta1 := distribute(table(f1,r1),hash32(foreclosure_id));
phone_out3_dist := distribute(phone_out3,hash32(foreclosure_id));

r1 t1(ta1 le, phone_out3_dist ri) := transform
 self := le;
end;

j1 := join(ta1,phone_out3_dist,left.foreclosure_id=right.foreclosure_id and 
                               (left.attorney_phone_nbr<>right.attorney_phone_nbr or
							    left.lender_phone      <>right.lender_phone       or
								left.trustee_phone     <>right.trustee_phone
							   ),
							   t1(left,right),local);
							   
output(choosen(j1,100),named('phones_that_should_be_suppressed_in_the_output'));

FC_proj := phone_out3;

export Foreclosure_DID := FC_proj; // : persist('~thor_data400::persist::foreclosure_did');