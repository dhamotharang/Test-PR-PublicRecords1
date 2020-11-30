//	Needed in file_liens_fcra_main
IMPORT	LiensV2_SrcInfoRpt, LiensV2;
EXPORT	fn_SuppressedFCRALiensMain	:=	FUNCTION

	dSuppJurisdictions	:=	LiensV2_SrcInfoRpt.Files().SuppressedJurisdictions;

	rSuppJurisdictionsNormalized	:=	RECORD
		STRING7	CourtID;
		STRING2	FILETYPEID;
	END;
	
	rSuppJurisdictionsNormalized	tSuppJurisdictionsNormalized(dSuppJurisdictions pInput, INTEGER cnt)	:=	TRANSFORM
		SELF.CourtID				:=	CHOOSE(cnt, pInput.LNCourtID, pInput.CustCourt);
		SELF.FILETYPEID	    :=	pInput.FILETYPEID;
	END;
	
	dSuppJurisdictionsNormalized	:=	NORMALIZE(dSuppJurisdictions,2,tSuppJurisdictionsNormalized(LEFT,COUNTER));
	dSuppJurisdictionsNormalizedDedup	:=	DEDUP(SORT(DISTRIBUTE(dSuppJurisdictionsNormalized),RECORD,LOCAL),RECORD,LOCAL);
	
	dFCRAMain									:=	LiensV2.file_liens_main(tmsid[..2]	IN	['HG']);
	//DF-25415 - Prevent suppression of released cases.																					
  dFCRAMain_released := table(dFCRAMain(release_date <> ''),{TMSID},TMSID,few);	

  dFCRAMain_withoutreleased := join(distribute(dFCRAMain_released,HASH(TMSID)),distribute(dFCRAMain,HASH(TMSID)),left.tmsid=right.tmsid, right only ,local);


	rFCRAMainWithCourtID	:=	RECORD
		dFCRAMain,
		STRING7	CourtID;
		STRING2	FILETYPEID;
	END;

	dFCRAMainWithCourtID	:=	PROJECT(dFCRAMain_withoutreleased,
															TRANSFORM(
																rFCRAMainWithCourtID,
																SELF.CourtID		:=	LEFT.AgencyID; //LEFT.tmsid[LENGTH(TRIM(LEFT.tmsid,LEFT,RIGHT))-6..];
                                
                                //DF-27756 VC - Fixing under suppression																
                                // SELF.FILETYPEID	:=	LEFT.rmsid[LENGTH(TRIM(LEFT.rmsid,LEFT,RIGHT))-1..];                                 
                                // filetype        :=  MAP(~regexfind('[0-9]',LEFT.rmsid[LENGTH(TRIM(LEFT.rmsid,LEFT,RIGHT))-1..]) => LEFT.rmsid[LENGTH(TRIM(LEFT.rmsid,LEFT,RIGHT))-1..],
                                                        // Left.filing_type_id );    
                                filetype        :=  Left.filing_type_id;
                                lookupFileType	:=  DICTIONARY(LiensV2_SrcInfoRpt.File_FileType_to_ActionGroup, {FILETYPEID => ActionGroup});
                                SELF.FILETYPEID	:=	IF (lookupFileType[filetype].ActionGroup <> '',lookupFileType[filetype].ActionGroup,filetype) ;
																SELF						:=	LEFT;
															)
														);

	dSuppressedFCRALiensMain	:=	JOIN(
																DISTRIBUTE(dFCRAMainWithCourtID,HASH(CourtID,FILETYPEID)),
																DISTRIBUTE(dSuppJurisdictionsNormalizedDedup,HASH(CourtID,FILETYPEID)),
																	LEFT.CourtID				=	RIGHT.CourtID	AND
																	LEFT.FILETYPEID	=	RIGHT.FILETYPEID,
																TRANSFORM(LEFT),
																LOCAL
															);

	RETURN dSuppressedFCRALiensMain;
	
END;
