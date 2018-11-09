import  UCCV2,RoxieKeyBuild,ut,autokey,doxie,fcra;

export Key_DID_w_Type (boolean  IsFCRA = false) := function
		KeyName       := cluster.cluster_out+'Key::ucc::';
		// dMain					:= dedup(sort(distribute(File_UCC_Main_Base(ut.DaysApart (orig_filing_date, ut.getDate) <= 365*7 and orig_filing_date != ''),hash(tmsid,rmsid)),tmsid,rmsid,local),tmsid,rmsid,local);
		dMain					:= dedup(sort(distribute(UCCV2.File_UCC_Main_Base_FCRA,hash(tmsid,rmsid)),tmsid,rmsid,local),tmsid,rmsid,local);
		dParty				:= distribute(UCCV2.File_UCC_Party_Base_FCRA.Party_Base_Slim,hash(tmsid,rmsid));
			
		uccv2.Layout_UCC_Common.Layout_Party	joinFCRA(uccv2.Layout_UCC_Common.Layout_Party lInput, dmain rInput)	:= transform
			self	:=	lInput;
		end;
		
		JoinedFCRA		:= join(dParty,
													dMain,
													left.tmsid = right.tmsid and 
													left.rmsid = right.rmsid,
													joinFCRA(left,right),
													local
													);
													
		dpartyBase 	  := IF (isFCRA,
														JoinedFCRA,
														File_UCC_Party_Base
												 );

		dSlim		  		:= TABLE(dPartyBase(did>0), {did,tmsid,rmsid,party_type});
		dDist      		:= distribute(dSlim,hash(did,tmsid,rmsid)); 
		dSort         := sort(dDist, did,tmsid,rmsid,party_type,local);
		dDedup        := dedup(DSort ,did,tmsid,rmsid,party_type,local);

	  return_file		:= IF (IsFCRA
												,INDEX(dataset([], RECORDOF(dDedup))  ,{did,party_type},{tmsid,rmsid},KeyName +'fcra::did_w_Type_' + Doxie.Version_SuperKey)
												,INDEX(dDedup  ,{did,party_type},{tmsid,rmsid},KeyName +'did_w_Type_' + Doxie.Version_SuperKey)
												);
		return(return_file); 
		
end;