import LiensV2;
export Count_LJs(

	dataset(LiensV2.Layout_liens_party_ssn					) pLiensV2		= LiensV2.file_liens_party

) :=
module

	shared laycount := layouts.temporary.counts;

	export fBdid(
	
		string pPersistname = Persistnames().CountLJsfBdid
	
	) :=
	function
	
		dbkslim := table(pLiensV2((unsigned8)bdid != 0,regexfind('D',name_type,nocase))	,{tmsid,bdid},tmsid,bdid);
		
		dbk_counts := table(dbkslim, {bdid, unsigned8 cnt := count(group)},bdid);
		
		dreturn := project(dbk_counts,transform(laycount,self.id := (unsigned8)left.bdid;self.Count_filings := left.cnt))
			: persist(pPersistname);
		
		return dreturn;
	
	end;

	export fDid(
	
		string pPersistname = Persistnames().CountLJsfDid
	
	) :=
	function
	
		dbkslim := table(pLiensV2((unsigned8)Did != 0,regexfind('D',name_type,nocase))		,{tmsid,DID},tmsid,DID);
		
		dbk_counts := table(dbkslim, {DID, unsigned8 cnt := count(group)},Did);
		
		dreturn := project(dbk_counts,transform(laycount,self.id := (unsigned8)left.Did;self.Count_filings := left.cnt))
			: persist(pPersistname);
		
		return dreturn;
	
	end;

end;