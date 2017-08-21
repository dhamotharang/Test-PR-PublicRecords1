IMPORT Business_header,mdr, NID;

/* The rule for new score
1.For records with Did >0 and Bdid>0, score=sourceScore1+sourceScore2+.. records in different sources. 
  Ex: record did=280045777 and Bdid=29722348 come from two different sources C and BR
      C and BR are both in High confidence score so this record get the score =9+9=18

2.For record with did+bdid>0 and did= or bdid=0, score= sourcescore1-1+ sourcescore2-1+&.. 
  Ex: Record bdid=7144031 and did=0 with same  company name and address comes from two different source D and Y
      D is in medium score group and Y is high so that score =6-1+9-1=15

3.For record with did=0 and bdid=0. score =sourcescore1-2+sourcescore2-2+&..
  Matching by contact name , company name and company address.

 
*/

EXPORT fBusinessContactsStats(
	
	// sort is being done in order to assign a sequence number to the file - we need this file & the PAW.File_contact_plus_seq_in file to be sequenced in the same order. 
	 dataset(layout.paw_stats)	pPawStats			= sort(File_Business_Contact_Stats_in,RECORD)
	,string											pPersistname	= persistnames().f_BusinessContactsStats

) :=
function

	Sourceislowconfidence(string psource)	:=
			MDR.sourceTools.SourceIsExperianVehicle				(psource)
	or	MDR.sourceTools.SourceIsATF										(psource)
	or	MDR.sourceTools.SourceIsWC										(psource)
	or	MDR.sourceTools.SourceIsEmployee_Directories	(psource)
	or	MDR.sourceTools.SourceIsAircrafts							(psource)
	or	MDR.sourceTools.SourceIsFL_FBN								(psource)
	or	MDR.sourceTools.SourceIsFDIC									(psource)
	or	MDR.sourceTools.SourceIsProfessional_License	(psource)
	or	MDR.sourceTools.SourceIsPhones_Plus						(psource)
	or	MDR.sourceTools.SourceIsSDAA									(psource)
	or	MDR.sourceTools.SourceIsDummy_Records					(psource)
	or	MDR.sourceTools.SourceIsSpoke									(psource)
	or	MDR.sourceTools.SourceIsAccurint_Trade_Show		(psource)
	or	MDR.sourceTools.SourceIsLnPropertyV2					(psource)
	or	MDR.sourceTools.SourceIsUCCS									(psource)
	or	MDR.sourceTools.SourceIsLiens_v2							(psource)
	;

	Sourceismediumconfidence(string psource)	:=
			MDR.sourceTools.SourceIsCorpV2								(psource)
	or	MDR.sourceTools.SourceIsACF										(psource)
	or	MDR.sourceTools.SourceIsLiquor_Licenses				(psource)
	or	MDR.sourceTools.SourceIsCredit_Unions					(psource)
	or	MDR.sourceTools.SourceIsEdgar									(psource)
	or	MDR.sourceTools.SourceIsFCC_Radio_Licenses		(psource)
	or	MDR.sourceTools.SourceIsGong_Business					(psource)
	or	MDR.sourceTools.SourceIsGong_Government				(psource)
	or	MDR.sourceTools.SourceIsIRS_5500							(psource)
	or	MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(psource)
	or	MDR.sourceTools.SourceIsFBNV2									(psource)
	or	MDR.sourceTools.SourceIsINFOUSA_IDEXEC				(psource)
	or	MDR.sourceTools.SourceIsJigsaw 								(psource)
	or	MDR.sourceTools.SourceIsLobbyists							(psource)
	or	MDR.sourceTools.SourceIsAMIDIR								(psource)
	or	MDR.sourceTools.SourceIsLnPropertyV2					(psource)
	or	MDR.sourceTools.SourceIsEq_Employer						(psource)
	or	MDR.sourceTools.SourceIsSEC_Broker_Dealer			(psource)
	or	MDR.sourceTools.SourceIsSKA										(psource)
	or	MDR.sourceTools.SourceIsState_Sales_Tax				(psource)
	or	MDR.sourceTools.SourceIsTax_practitioner			(psource)
	or	MDR.sourceTools.SourceIsVickers								(psource)
	or	MDR.sourceTools.SourceIsWhois_domains					(psource)
	or	MDR.sourceTools.SourceIsWorkmans_Comp					(psource)
	or	MDR.sourceTools.SourceIsWither_and_Die				(psource)
	or	MDR.sourceTools.SourceIsZOOM									(psource)
	;

		Sourceishighconfidence(string psource)	:=
			MDR.sourceTools.SourceIsBankruptcy						(psource)
	or	MDR.sourceTools.SourceIsBBB										(psource)
	or	MDR.sourceTools.SourceIsBusiness_Registration	(psource)
	or	MDR.sourceTools.SourceIsDunn_Bradstreet				(psource)
	or	MDR.sourceTools.SourceIsDunn_Bradstreet_Fein	(psource)
	or	MDR.sourceTools.SourceIsDCA										(psource)
	or	MDR.sourceTools.SourceIsDEA										(psource)
	or	MDR.sourceTools.SourceIsEBR										(psource)
	or	MDR.sourceTools.SourceIsFL_Non_Profit					(psource)
	or	MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ	(psource)
	or	MDR.sourceTools.SourceIsIRS_Non_Profit				(psource)
	or	MDR.sourceTools.SourceIsIngenix_Sanctions			(psource)
	or	MDR.sourceTools.SourceIsLiens_and_Judgments		(psource)
	or	MDR.sourceTools.SourceIsMartinDale_Hubbell		(psource)
	or	MDR.sourceTools.SourceIsSDA										(psource)
	or	MDR.sourceTools.SourceIsSheila_Greco					(psource)
	or	MDR.sourceTools.SourceIsYellow_Pages					(psource)
	;

	getdefaultscore(STRING pSource,string pFrom_hdr) :=MAP(
																		 SourceIsLowConfidence		(pSource) or pFrom_hdr = 'Y' =>	3
																		,SourceIsMediumConfidence	(pSource)	=>	6
																		,SourceIsHighConfidence		(pSource) =>	9
																		,																				0
																	);

	//first, assign default scores from_hdr='N' is not direct business_source
	
	// pPAWStatsSrted	:= sort(pPAWStats,vendor_id,lname,fname,source,record_type,company_title);
	
	Layout.Business_Contact_Stats_Seq	AddSequenceNbr(pPAWStats l, unsigned c)	:=	transform
				self.seqNum    				:=c;
				self 									:= l;
			end;
	
	pPawStatsSeq	:=	project(pPawStats, AddSequenceNbr(left,counter));
	
	Layout.Business_Contact_Stats_Seq tAddDefaultScore(pPawStatsSeq l) := 
		TRANSFORM
			new_score 			  			:=-IF(l.did>0 and l.bdid>0,0,
																			IF(l.did=0 and l.Bdid=0,2,1))+getdefaultscore(l.source,l.from_hdr);
			SELF.combined_new_score := IF(new_score>0,new_score,3-new_score);							
			SELF.fname              := IF(l.did=0,NID.PreferredFirstVersionedStr(l.fname, NID.version),l.fname); 
				SELF   				  			:= l;
		END;

	DefaultScore        	:= PROJECT(pPawStatsSeq, tAddDefaultScore(LEFT));

	//first, take RECORDs with did AND bdid
	Bc_With_Did_Bdid			:= DISTRIBUTE(DefaultScore(did != 0, bdid != 0),HASH(did, bdid));
	BC_Bdid_0DID          := DISTRIBUTE(DefaultScore(did  = 0, bdid!= 0),HASH(Bdid,lname,fname,mname,name_suffix ));
	BC_did_0BDID          := DISTRIBUTE(DefaultScore(did != 0,bdid= 0),HASH(did,company_name,company_zip,company_prim_name,company_prim_range));
	Bc_rest								:= DISTRIBUTE(DefaultScore(did = 0, bdid  = 0),HASH(company_name,company_zip,company_prim_name,company_prim_range,
														lname,fname,mname,name_suffix));
		 
	Bc_With_Did_Bdid_source	:= DEDUP(SORT(Bc_With_Did_Bdid,did, bdid,source,local)
																	,did, bdid,source,local);
	BC_Bdid_0DID_source     := DEDUP(SORT(BC_Bdid_0DID,Bdid,lname,fname,mname,name_suffix,source,local)
									,lname,fname,mname,name_suffix,source,local);
	BC_did_0BDID_source     := DEDUP(SORT(BC_did_0BDID,did,company_name,company_zip,company_prim_name,company_prim_range,source,local)
									,did,company_name,company_zip,company_prim_name,company_prim_range,source,local);
	Bc_rest_source			:= DEDUP(SORT(Bc_rest,company_name,company_zip,company_prim_name,company_prim_range,lname,fname,mname,name_suffix,source,local)
												 ,company_name,company_zip,company_prim_name,company_prim_range,lname,fname,mname,name_suffix,source,local);

	//how many different sources exist for that contact at that company?
	source_RECORD_both 		:=
		RECORD
			Bc_With_Did_Bdid_source.did;
			Bc_With_Did_Bdid_source.bdid;
			UNSIGNED1 source_count:= COUNT(GROUP);
			UNSIGNED1 total_score := SUM(GROUP,Bc_With_Did_Bdid.combined_new_score);
		END;
	source_RECORD_Bdid 		:=
		RECORD
			BC_Bdid_0DID_source.Bdid; 
			BC_Bdid_0DID_source.lname;
			BC_Bdid_0DID_source.fname; 
			BC_Bdid_0DID_source.mname; 
			BC_Bdid_0DID_source.name_suffix;
			UNSIGNED1 source_count:= COUNT(GROUP);
			UNSIGNED1 total_score := SUM(GROUP,BC_Bdid_0DID_source.combined_new_score);
		END;
	source_RECORD_did 		:=
		RECORD
			BC_did_0BDID_source.did; 
			BC_did_0BDID_source.company_name, 
			BC_did_0BDID_source.company_zip, 
			BC_did_0BDID_source.company_prim_name, 
			BC_did_0BDID_source.company_prim_range,  
			UNSIGNED1 source_count:= COUNT(GROUP);
			UNSIGNED1 total_score := SUM(GROUP,BC_did_0BDID_source.combined_new_score);
		END;
	source_RECORD_rest 		:=
		RECORD
			
			Bc_rest_source.company_name, 
			Bc_rest_source.company_zip, 
			Bc_rest_source.company_prim_name, 
			Bc_rest_source.company_prim_range, 
			Bc_rest_source.lname, 
			Bc_rest_source.fname, 
			Bc_rest_source.mname, 
			Bc_rest_source.name_suffix, 
			UNSIGNED1 source_count:= COUNT(GROUP);
			UNSIGNED1 total_score := SUM(GROUP,Bc_rest_source.combined_new_score);
		END;
		
		
	Bc_With_Did_Bdid_total_score := TABLE(Bc_With_Did_Bdid_source, source_RECORD_both, did, bdid,LOCAL);
	Bc_With_Bdid_total_score     := TABLE(BC_Bdid_0DID_source,source_RECORD_Bdid, Bdid,lname,fname,mname,name_suffix,LOCAL);
	Bc_With_Did_total_score      := TABLE(BC_did_0BDID_source  , source_RECORD_did, did,company_name,company_zip,company_prim_name,company_prim_range,LOCAL);
	Bc_rest_total_score          := TABLE(Bc_rest_source, source_RECORD_rest, company_name,company_zip,company_prim_name,company_prim_range,lname,fname,mname,name_suffix,LOCAL);


	//match back to input business contacts on did, bdid, AND modify score										             
	Layout.Business_Contact_Stats_Seq tGetScores(Layout.Business_Contact_Stats_Seq l, source_RECORD_both r) :=
		TRANSFORM
			SELF.combined_new_score := r.total_score;
			SELF.source_count       := r.source_count;
			SELF                    := l;
		END;
		
	Layout.Business_Contact_Stats_Seq tGetScoresB(Layout.Business_Contact_Stats_Seq l, source_RECORD_Bdid  r) :=
		TRANSFORM
			SELF.combined_new_score := r.total_score;
			SELF.source_count       := r.source_count;
			SELF                    := l;
		END;
	Layout.Business_Contact_Stats_Seq tGetScoresd(Layout.Business_Contact_Stats_Seq l, source_RECORD_did  r) :=
		TRANSFORM
			SELF.combined_new_score := r.total_score;
			SELF.source_count       := r.source_count;
			SELF                    := l;
		END;
	Layout.Business_Contact_Stats_Seq tGetScoresr(Layout.Business_Contact_Stats_Seq l, source_RECORD_rest  r) :=
		TRANSFORM
			SELF.combined_new_score := r.total_score;
			SELF.source_count       := r.source_count;
			SELF                    := l;
		END;
	//rule 1.
	bc_scores_both 	:= JOIN(Bc_With_Did_Bdid
							 ,Bc_With_Did_Bdid_total_score
							 ,LEFT.did = RIGHT.did AND LEFT.bdid = RIGHT.bdid
							 ,tGetScores(LEFT,right)
							 ,LOCAL
							);
	//rule 2.
	bc_scores_Bdid 	:= JOIN(Bc_Bdid_0DID 
							 ,Bc_With_Bdid_total_score
							 ,LEFT.bdid = RIGHT.bdid AND 
								LEFT.lname=RIGHT.lname AND
							LEFT.fname=RIGHT.fname AND
							LEFT.mname=RIGHT.MNAME AND
							LEFT.name_suffix = RIGHT.name_suffix 
							 ,tGetScoresB(LEFT,right)
							 ,LOCAL
							);	
	//rule 2.
	bc_scores_did 	:= JOIN(Bc_Did_0BDID 
							 ,Bc_With_Did_total_score
							 ,LEFT.did = RIGHT.did AND 
								LEFT.company_name=RIGHT.company_name AND
							LEFT.company_zip=RIGHT.company_zip AND
							LEFT.company_prim_name=RIGHT.company_prim_name AND
							LEFT.company_prim_range=RIGHT.company_prim_range
							 ,tGetScoresd(LEFT,right)
							 ,LOCAL
							); 
	//rule 3.
	bc_scores_REST 	:= JOIN(Bc_rest 
							 ,Bc_REST_total_score
							 ,LEFT.company_name=RIGHT.company_name AND
							LEFT.company_zip=RIGHT.company_zip AND
							LEFT.company_prim_name=RIGHT.company_prim_name AND
							LEFT.company_prim_range=RIGHT.company_prim_range AND
								LEFT.lname=RIGHT.lname AND
							LEFT.fname=RIGHT.fname AND
							LEFT.mname=RIGHT.MNAME AND
							LEFT.name_suffix = RIGHT.name_suffix
							,tGetScoresR(LEFT,right)
							 ,LOCAL
							 );
							 
	result := bc_scores_Bdid+bc_scores_both +bc_scores_did+bc_scores_REST:persist(pPersistname);

	return result;

end;