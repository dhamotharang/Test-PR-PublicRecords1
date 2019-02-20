import DeathV2_Services, BatchShare;

/*
Deceased matching needs to be very tight â€“ The query should allow the passing of match codes, 
along with a post process check against DOB.The post process DOB check will only need to be a Month/Year match

Deceased : 
AddSupplemental: true
ExtraMatchCodes: true
DID_Score_Threshold: 80
PartialNameMatchCodes: true

Default Match Codes: 
SN,SNC,SNZ,SNZC ,ANZC,ANS,ANSC,ANSZ,ANSZC,AWSZC, SWZC, AWSC, 
AWS, SWZC, SWCZ, SWC, SWZ, SW, AVSZC, SVZC, AVSC, AVS, SVZC, 
SVCZ, SVC, SVZ, SV, AXSZC, SXZC, AXSC, AXS, SXZC, SXCZ, SXC, 
SXZ, SX, AYSZC, SYZC, AYSC, AYS, SYZC, SYCZ, SYC, SYZ, SY

Add in a DOB check on all matched records and if the DOB matches append D to the match code.

Multiple hits will be returned on Deceased â€“ return the strongest match for each record based on the 
following  sort order â€“ the unique and return the strongest match:

*/

EXPORT dataset(MemberPoint.Layouts.DeceasedOut) getDeceasedInfo (dataset (MemberPoint.Layouts.BatchInter) dsInterE, 
									MemberPoint.IParam.BatchParams BParams, boolean isMinor = false) := function	
		
			DeathV2_Services.Layouts.BatchIn 
										xformInterExToDec(MemberPoint.Layouts.BatchInter L) := transform
					guardian						:= MemberPoint.Constants.LNSearchNameType.Guardian;
					self.acctno					:=	L.acctno;
					self.did						:=	if(not isMinor , L.computed_did,0);
					self.ssn						:=	if(L.LN_search_name_type = guardian, L.guardian_ssn,L.ssn);
					self.dob						:=	if(L.LN_search_name_type = guardian, L.guardian_dob,L.dob);
					self.name_first			:=	if(L.LN_search_name_type = guardian, L.guardian_name_first,L.name_first);
					self.name_middle		:=	if(L.LN_search_name_type = guardian, '',L.name_middle);
					self.name_last			:=	if(L.LN_search_name_type = guardian, L.guardian_name_last,L.name_last);
					self.name_suffix		:=	if(L.LN_search_name_type = guardian, '',L.name_suffix);
					self.prim_range			:=	L.prim_range;
					self.predir 				:=	L.predir;
					self.prim_name 			:=	L.prim_name;
					self.addr_suffix 		:=	L.addr_suffix;
					self.postdir 				:=	L.postdir;
					self.unit_desig 		:=	L.unit_desig;
					self.sec_range 			:=	L.sec_range;
					self.p_city_name 		:=	L.p_city_name;
					self.st 						:=	L.st;
					self.z5 						:=	L.z5;
					self.zip4 					:=	L.zip4;
					self.score					:= 	if(not isMinor ,L.computed_did_score,0);
					self								:=  []; 
			end; 
				
		BatchInCommon 	:= project(dsInterE,xformInterExToDec(left));
			
		mod_batch := BatchShare.IParam.GetFromLegacy(BParams);
		deathBatchParams := module(project(mod_batch, DeathV2_Services.IParam.BatchParams, opt))
			EXPORT STRING MatchCodeIncludes:= BParams.DeceasedMatchCodes;
		END;
		dsDeathPre := DeathV2_Services.BatchRecords(BatchInCommon, deathBatchParams);
		
		// add D matchcode to the output 
		dsDeathWithDMatchCode := project(dsDeathPre,transform(DeathV2_Services.layouts.BatchOut,
					self.matchcode 	:=	if( (BParams.UseDOBDeathMatch = true) and (left.dob8 = dsInterE(acctno = left.acctno)[1].dob),
																	trim(left.matchcode) + 'D',left.matchcode),
					self := left;
		));
		
		dsDeathSortable :=  join(dsDeathWithDMatchCode,MemberPoint.Constants.dsForSort,left.matchcode = right.matchcode,transform(MemberPoint.Layouts.DeceasedOut,
		self := left, self :=right ) ,left outer);
		dsDeath := dedup(sort(dsDeathSortable,acctno,-MatchcodeScore),acctno);
		return dsDeath;
	end;