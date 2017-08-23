IMPORT DueDiligence;

EXPORT LayoutsInternal := MODULE


	EXPORT SicNaicLayout := RECORD
		UNSIGNED4 seq;
		UNSIGNED4 ultID;
		UNSIGNED4 orgID;
		UNSIGNED4 seleID;
		DATASET(DueDiligence.Layouts.LayoutSICNAIC) sources;
	END;
	
	EXPORT SicNaicUniqueIndustryLayout := RECORD
	UNSIGNED4 Seq;
	UNSIGNED4 ultID;
	UNSIGNED4 orgID;
	UNSIGNED4 seleID;
	DueDiligence.Layouts.LayoutSICNAIC;
	DueDiligence.Layouts.SicNaicRiskLayout;
	END;


END;