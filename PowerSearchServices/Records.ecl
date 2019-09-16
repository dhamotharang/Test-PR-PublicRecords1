IMPORT AutoStandardI,DeathV2_Services,doxie,dx_death_master,PowerSearchServices,
       suppress,Text_FragV1,Text_Search;

EXPORT Records(PowerSearchServices.IParam.searchParams stdSrchArgs) := FUNCTION

	death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
  glb_ok := death_params.isValidGlb();
	STRING stem := PowerSearchServices.Constants.FILE_STEM;
	STRING sourceType	:= PowerSearchServices.Constants.FILE_SRC_TYPE;
	STRING qual := PowerSearchServices.Constants.FILE_QUAL;
	UNSIGNED maxResults := IF(stdSrchArgs.maxResults>0,stdSrchArgs.maxResults,PowerSearchServices.Constants.MAX_RESULTS);

	info := Text_Search.FileName_Info_Instance(stem, sourceType, qual);
	m := Text_Search.Text_Search_V3(info,stdSrchArgs);

	ansIndxAlias:= Text_FragV1.FileName(info,Text_FragV1.Types.FileType.AnswerDocX);
	ansIndx := Text_FragV1.Indx_AnsRec(ansIndxAlias);

	answerHits := JOIN(m.answers,ansIndx,
		KEYED(LEFT.docRef.src=RIGHT.src AND LEFT.docRef.doc=RIGHT.doc),
		TRANSFORM(PowerSearchServices.Layouts.answerRec,SELF.hitScore:=LEFT.score;SELF:=RIGHT;SELF:=[]),
		LIMIT(PowerSearchServices.Constants.MAX_JOIN_RECS,SKIP));

	answerRecs := SORT(PowerSearchServices.Functions.assignScores(answerHits,m.rpn_srch),-argScore,-hitScore,-dt_last_seen);

	clnPropAddrOrg := PROJECT(answerRecs,PowerSearchServices.Transforms.clnPropAddr(LEFT));

	clnPropAddr := CHOOSEN(clnPropAddrOrg,maxResults,FEW);

	answerDODsAppend := dx_death_master.Append.byDid(clnPropAddr, did, death_params);
 
  answerDODs := 
    PROJECT(answerDODsAppend,
      TRANSFORM(PowerSearchServices.Layouts.answerRec,
		    SELF.dod := LEFT.death.dod8;
				SELF.deceased := IF(LEFT.death.is_deceased, 'Y', 'N');
				SELF:=LEFT;
        ));
      
  suppress.MAC_Mask(answerDODs,answerMasked,SSN,NULL,TRUE,FALSE,,,,stdSrchArgs.ssnMask);

	RETURN PROJECT(answerMasked,PowerSearchServices.Transforms.pwrSrchRec(LEFT));

END;