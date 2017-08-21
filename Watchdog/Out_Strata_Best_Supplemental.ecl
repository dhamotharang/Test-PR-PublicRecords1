EXPORT Out_Strata_Best_Supplemental(DATASET(RECORDOF(Watchdog.Layout_Supplemental.Base))sInput) := MODULE
statBestSuppRecFmt := RECORD
	CountGroup							:=	COUNT(GROUP);
		string nogrouping     := 'nogrouping';
	Gender_CountNonBlank		:=	SUM(GROUP,IF(EXISTS(sInput.gender),1,0));
	HairColor_CountNonBlank	:=	SUM(GROUP,IF(EXISTS(sInput.hair_color),1,0));
	EyeColor_CountNonBlank	:=	SUM(GROUP,IF(EXISTS(sInput.eye_color),1,0));
	Height_CountNonBlank		:=	SUM(GROUP,IF(EXISTS(sInput.height),1,0));
	Weight_CountNonBlank		:=	SUM(GROUP,IF(EXISTS(sInput.weight),1,0));
	Race_CountNonBlank			:=	SUM(GROUP,IF(EXISTS(sInput.race),1,0));
	SMT_CountNonBlank				:=	SUM(GROUP,IF(EXISTS(sInput.SMT),1,0));
END;

EXPORT Stats_Best_Supplemental := TABLE(sInput,statBestSuppRecFmt,FEW);
END;
