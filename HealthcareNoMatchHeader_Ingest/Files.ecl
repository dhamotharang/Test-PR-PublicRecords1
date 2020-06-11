IMPORT  HealthcareNoMatchHeader_Ingest, HealthcareNoMatchHeader_InternalLinking, DID_Add, STD;
EXPORT Files( STRING	pSrc      = '',
              STRING  pVersion  = '',
              BOOLEAN	pUseProd  = FALSE) :=  MODULE

	EXPORT	AsHeaderTemp  :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Input.AsHeaderTemp,HealthcareNoMatchHeader_Ingest.Layout_Base,THOR);
	EXPORT	BaseTemp      :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Input.BaseTemp,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR);

	EXPORT	AllRecords        :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Base.AllRecords.QA,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR);
	EXPORT	AllRecords_Father :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Base.AllRecords.Father,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR);
	EXPORT	History           :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Base.History.QA,HealthcareNoMatchHeader_InternalLinking.Layout_History,THOR,OPT);
	EXPORT	History_Father    :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Base.History.Father,HealthcareNoMatchHeader_InternalLinking.Layout_History,THOR,OPT);
	EXPORT	Linking(STRING it='1') :=  MODULE
    EXPORT  Iteration         :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Linking(it).Iteration.QA,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR);
    EXPORT  Iteration_Father  :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Linking(it).Iteration.Father,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR);
    EXPORT  Changes           :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Linking(it).Changes.QA,HealthcareNoMatchHeader_InternalLinking.Layout_Changes,THOR);
    EXPORT  Changes_Father    :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Linking(it).Changes.Father,HealthcareNoMatchHeader_InternalLinking.Layout_Changes,THOR);
  END;
	EXPORT	CRK               :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Append.CRK.QA,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR);
	EXPORT	CRK_Father        :=  DATASET(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion,pUseProd).Append.CRK.Father,HealthcareNoMatchHeader_InternalLinking.Layout_Header,THOR,OPT);
END;