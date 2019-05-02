IMPORT AutoStandardI,AutoHeaderI,doxie,PublicProfileServices, std;

autoStndGlbMod := AutoStandardI.GlobalModule();

EXPORT Functions := MODULE

	EXPORT FetchI_Hdr_Indv_do_hhid(PublicProfileServices.IParam.searchParams rptByMod) := FUNCTION
		glbMod := MODULE(PROJECT(rptByMod,autoStndGlbMod,OPT)),VIRTUAL
			EXPORT BOOLEAN   IncludeMinors := TRUE;
			EXPORT BOOLEAN   StrictMatch := TRUE;
			EXPORT UNSIGNED1 ScoreThreshold := 5;
			EXPORT BOOLEAN   AllowDateSeen := TRUE;
			EXPORT UNSIGNED  DateFirstSeen := (UNSIGNED)((STRING)Std.Date.Today())[1..6]-1000;
			EXPORT BOOLEAN   CurrentResidentsOnly := TRUE;
		END;
		tmpmod := MODULE(PROJECT(glbMod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
		END;
		RETURN AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tmpmod);
	END;

	EXPORT FetchI_Hdr_Indv_do(PublicProfileServices.IParam.searchParams rptByMod) := FUNCTION
		glbMod := MODULE(PROJECT(rptByMod,autoStndGlbMod,OPT)),VIRTUAL
			EXPORT BOOLEAN IncludeMinors := TRUE;
			EXPORT BOOLEAN UseOnlyBestDid := TRUE;
		END;
		tmpmod := MODULE(PROJECT(glbMod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
		END;
		RETURN PROJECT(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tmpmod), doxie.layout_references);
	END;

	EXPORT cntUnqSsnDob(DATASET(doxie.layout_presentation) hdrRecs) := FUNCTION
		hdrRec := doxie.layout_presentation;

		{UNSIGNED6 did,UNSIGNED2 SSNCount,UNSIGNED2 DOBCount} dobSsnCnt(hdrRec L,dataset(hdrRec) R) := TRANSFORM
			SELF.did := L.did;
			SELF.SSNCount := COUNT(DEDUP(SORT(R(did=l.did,ssn<>''),ssn),ssn));
			rollByDob := ROLLUP(SORT(R(did=l.did,dob<>0),-dob),
				((STRING)LEFT.dob)[1..4]=((STRING)RIGHT.dob)[1..4] AND (((STRING)LEFT.dob)[5..6]=((STRING)RIGHT.dob)[5..6] OR ((STRING)RIGHT.dob)[5..6]='00')
				AND (((STRING)LEFT.dob)[7..8]=((STRING)RIGHT.dob)[7..8] OR ((STRING)RIGHT.dob)[7..8]='00'),TRANSFORM(hdrRec,SELF:=LEFT));
			SELF.DOBCount := COUNT(DEDUP(rollByDob,dob));
		END;

		RETURN ROLLUP(GROUP(SORT(hdrRecs,did),did),GROUP,dobSsnCnt(LEFT,ROWS(LEFT)));
	END;

END;
