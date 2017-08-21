import marketing_best, govdata, versioncontrol,paw,Risk_Indicators,aca;

// -- promote all files and keys to qa versions

export Promote2QA :=
sequential(
	 Promote().Built2QA
	,paw.Promote().Built2QA
	,Marketing_Best.Promote().Built2QA
	,govdata.Promote().Built2QA
	,Risk_Indicators.Promote().Built2QA
	,ACA.Promote().Built2QA
);
