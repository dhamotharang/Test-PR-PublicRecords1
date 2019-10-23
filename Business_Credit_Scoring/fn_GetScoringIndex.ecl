IMPORT	Business_Credit_Scoring,	Codes,	ut, STD;
EXPORT	fn_GetScoringIndex(	STRING pVersion	=	(STRING8)Std.Date.Today())	:=	FUNCTION 

	dDBTAverage	:=	Business_Credit_Scoring.Files().DBTAverage;
	dScored			:=	Business_Credit_Scoring.Files().Scores;
		
		//	Combine DBTAverage and Scores
	dDBTAndScores	:=	JOIN(
											SORT(DISTRIBUTE(dDBTAverage,
												HASH(	UltID, OrgID, SeleID)),
															UltID, OrgID, SeleID, LOCAL),
											SORT(DISTRIBUTE(dScored,
												HASH(	UltID, OrgID, SeleID)),
															UltID, OrgID, SeleID, LOCAL),
												LEFT.UltID	=	RIGHT.UltID		AND
												LEFT.OrgID	=	RIGHT.OrgID		AND
												LEFT.SeleID	=	RIGHT.SeleID,
											TRANSFORM(RECORDOF(Business_Credit_Scoring.Layouts.rScoringIndex),
												SELF.Version			:=	pVersion;
												SELF.date_scored	:=	(STRING8)Std.Date.Today();
												SELF							:=	LEFT;
												SELF							:=	RIGHT;
												SELF							:=	[]),
											LEFT OUTER,
											LOCAL
										);

		//	Get Industry Averages for Score and DBT
	rIndustryAverages	:=	RECORD
		dDBTAndScores.Classification_Code;
		dDBTAndScores.Industry_Score_Avg;
		dDBTAndScores.Industry_DBT_Avg;
	END;														

	dIndustryAveragesGroup	:=	GROUP(SORT(DISTRIBUTE(dDBTAndScores(Classification_Code<>''),
																HASH(	Classification_Code)),
																			Classification_Code, LOCAL),
																			Classification_Code, LOCAL);

	rIndustryAverages	tGetIndustryAverages(dIndustryAveragesGroup L,	DATASET(RECORDOF(dIndustryAveragesGroup)) allRows)	:=	TRANSFORM
		SELF.Classification_Code	:=	L.Classification_Code;
		SELF.Industry_Score_Avg		:=	IF(COUNT(allRows)>=10,(STRING3)ROUND(AVE(allRows.Scores,allRows.Scores.Score)),'');
		SELF.Industry_DBT_Avg			:=	IF(COUNT(allRows(DBT<>''))>=10,(STRING3)ROUND(AVE(allRows(DBT<>''),(INTEGER)allRows.DBT)),'');
	END;

	dIndustryAverages	:=	ROLLUP(dIndustryAveragesGroup,GROUP,tGetIndustryAverages(LEFT,ROWS(LEFT)));

		//	Fill Industry Averages
	dFillIndustryAverages	:=	JOIN(
															SORT(DISTRIBUTE(dDBTAndScores(Classification_Code<>''),HASH(Classification_Code)),Classification_Code,LOCAL),
															SORT(DISTRIBUTE(dIndustryAverages,HASH(Classification_Code)),Classification_Code,LOCAL),
																LEFT.Classification_Code	=	RIGHT.Classification_Code,
															TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT;SELF:=LEFT),
															LEFT OUTER,
															LOCAL
														);
															
		//	Fill Classification Code Descriptions for SIC and NAICS
	dFillSICDescription	:=	JOIN(
														SORT(DISTRIBUTE(dFillIndustryAverages,HASH(Classification_Code)),Classification_Code,LOCAL),
														SORT(DISTRIBUTE(Codes.File_SIC4_Codes,HASH(SIC4_Code)),SIC4_Code,LOCAL),
															LEFT.Classification_Code	=	RIGHT.SIC4_Code,
														TRANSFORM(RECORDOF(LEFT),SELF.Classification_Code_Description:=ut.CleanSpacesAndUpper(RIGHT.SIC4_Description);SELF:=LEFT),
														LEFT OUTER,
														LOCAL																
													);
																		
	dFillNAICSDescription	:=	JOIN(
															SORT(DISTRIBUTE(dFillSICDescription(Classification_Code_Description=''),HASH(Classification_Code)),Classification_Code,LOCAL),
															SORT(DISTRIBUTE(PULL(Codes.Key_NAICS),HASH(naics_code)),naics_code,LOCAL),
																LEFT.Classification_Code	=	RIGHT.naics_code,
															TRANSFORM(RECORDOF(LEFT),SELF.Classification_Code_Description:=ut.CleanSpacesAndUpper(RIGHT.naics_description);SELF:=LEFT),
															LEFT OUTER,
															LOCAL																
														);
																			
	dFillDescriptions	:=	dFillNAICSDescription+
												dFillSICDescription(Classification_Code_Description<>'')+
												dDBTAndScores(Classification_Code='');
																		
	dScoringIndex			:=	SORT(DISTRIBUTE(
													dFillDescriptions+
													//	Add today's results to the last 24 months.
													Files().ScoringIndex(Version[1..8]>=ut.Month_Math(pVersion,-Constants().MonthsToKeep)[1..6]+'01'),
													HASH(	UltID, OrgID, SeleID)),
																UltID, OrgID, SeleID, -Version, LOCAL);
	
	RETURN	dScoringIndex;

END;
