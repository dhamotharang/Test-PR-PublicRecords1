import UCCV2;
export Count_UCC(

	dataset(UCCV2.Layout_UCC_Common.Layout_Party		) pUCCs	= UCCV2.File_UCC_Party_Base
) :=
module

	shared laycount := layouts.temporary.counts;

	export fBdid(
	
		string pPersistname = Persistnames().CountUCCfBdid
	
	) :=
	function
	
		dbkslim := table(pUCCs((unsigned8)bdid != 0,party_type = 'D')	,{tmsid,bdid},tmsid,bdid);
		
		dbk_counts := table(dbkslim, {bdid, unsigned8 cnt := count(group)},bdid);
		
		dreturn := project(dbk_counts,transform(laycount,self.id := left.bdid;self.Count_filings := left.cnt))
			: persist(pPersistname);
		
		return dreturn;
	
	end;

	export fDid(
	
		string pPersistname = Persistnames().CountUCCfDid
	
	) :=
	function
	
		dbkslim := table(pUCCs((unsigned8)Did != 0,party_type = 'D')	,{tmsid,DID},tmsid,DID);
		
		dbk_counts := table(dbkslim, {DID, unsigned8 cnt := count(group)},Did);
		
		dreturn := project(dbk_counts,transform(laycount,self.id := left.Did;self.Count_filings := left.cnt))
			: persist(pPersistname);
		
		return dreturn;
	
	end;

end;