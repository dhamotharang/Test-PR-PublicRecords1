IMPORT Text_Search,Text_FragV1,doxie,DeathV2_Services,AutoStandardI,suppress;

EXPORT Records(IParam.searchParams stdSrchArgs) := FUNCTION

	deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
  glb_ok := deathparams.isValidGlb();
	STRING stem := Constants.FILE_STEM;
	STRING sourceType	:= Constants.FILE_SRC_TYPE;
	STRING qual := Constants.FILE_QUAL;
	UNSIGNED maxResults := IF(stdSrchArgs.maxResults>0,stdSrchArgs.maxResults,Constants.MAX_RESULTS);

	info := Text_Search.FileName_Info_Instance(stem, sourceType, qual);
	m := Text_Search.Text_Search_V3(info,stdSrchArgs);

	ansIndxAlias:= Text_FragV1.FileName(info,Text_FragV1.Types.FileType.AnswerDocX);
	ansIndx := Text_FragV1.Indx_AnsRec(ansIndxAlias);

	answerHits := JOIN(m.answers,ansIndx,
		KEYED(LEFT.docRef.src=RIGHT.src AND LEFT.docRef.doc=RIGHT.doc),
		TRANSFORM(Layouts.answerRec,SELF.hitScore:=LEFT.score;SELF:=RIGHT;SELF:=[]),
		LIMIT(Constants.MAX_JOIN_RECS,SKIP));

	answerRecs := SORT(Functions.assignScores(answerHits,m.rpn_srch),-argScore,-hitScore,-dt_last_seen);

	clnPropAddr := PROJECT(answerRecs,Transforms.clnPropAddr(LEFT));

	answerDODs := JOIN(CHOOSEN(clnPropAddr,maxResults,FEW),
		doxie.key_death_masterV2_ssa_DID,KEYED(LEFT.did=RIGHT.l_did)
		and not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
		TRANSFORM(Layouts.answerRec,
		          SELF.dod:=RIGHT.dod8,
							self.deceased := if ((integer)right.did > 0,'Y','N'),
							SELF:=LEFT),
		LEFT OUTER,KEEP(1),LIMIT(0));

  suppress.MAC_Mask(answerDODs,answerMasked,SSN,NULL,TRUE,FALSE,,,,stdSrchArgs.ssnMask);

	RETURN PROJECT(answerMasked,Transforms.pwrSrchRec(LEFT));

END;