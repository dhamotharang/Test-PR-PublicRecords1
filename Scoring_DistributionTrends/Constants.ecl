EXPORT Constants := MODULE
	
	//File Tags
	EXPORT FileTag := '_1';
	EXPORT CopyFileTag := '_1_scoringcopy';
	
	//Prefix
	EXPORT ScoringQA := '~scoringqa::out::';
	EXPORT NonFCRA := 'nonfcra::';
	EXPORT FCRA := 'fcra::';
	EXPORT forblank := '';

	EXPORT Auto := 'Auto_';
	EXPORT Bank := 'Bank_';
	EXPORT Retail := 'Retail_';
	EXPORT Telecom := 'Telecom_';
	EXPORT Money := 'Money_';
	EXPORT Prescreen := 'Prescreen_';
	EXPORT ShortTermLending := 'short_term_lending_';
	EXPORT Crossindustry := 'crossindustry_';
	EXPORT FDScore := 'fd_score_';
	EXPORT FPScore := 'fp_score_';
	EXPORT bnap := 'bnap_';
	EXPORT bnas := 'bnas_';
	EXPORT bnat := 'bnat_';
	EXPORT bvi := 'bvi_';
	EXPORT cvi := 'cvi_';
	EXPORT nap := 'nap_';
	EXPORT nas := 'nas_';
	EXPORT CBBLfd := 'ecovariables_';
	EXPORT CBBLfp := 'cmpyaddrscore_';
	EXPORT fp_score := 'fp_score_';
	
	//score names in files
	EXPORT Genbnap := 'bnap';
	EXPORT Genbnas := 'bnas';
	EXPORT Genbnat := 'bnat';
	EXPORT Genbvi := 'bvi';
	EXPORT RV_Auto := 'rv_score_auto';
	export RV_Bank := 'rv_score_bank';
	export RV_Retail := 'rv_score_retail';
	export RV_Telecom := 'rv_score_telecom';
	export RV_Money := 'rv_score_money';
	export RV_Prescreen := 'rv_score_prescreen';
	export RV5_ShortTermLending := 'short_term_lending_score';
	export RV5_Crossindustry := 'crossindustry_score';
	export RV5_Auto := 'auto_score';	
	export RV5_Bank := 'bankcard_score';	
	export RV5_Telecom := 'telecommunications_score';	
	export BNK4 := 'ecovariables';
	export PI02 := 'estincome';
	export LIv4 := 'score';
	EXPORT CBBL_fd := 'ecovariables';
	EXPORT CBBL_fp := 'cmpyaddrscore';
	EXPORT FP := 'fp_score';
	EXPORT IT61 := 'score';
	EXPORT Gencvi := 'cvi';
	EXPORT Gennap := 'nap_summary';
	EXPORT Gennas := 'nas_summary';

	//HistoryFile
	EXPORT HistoryFile_Prefix := '~distributionTrend::rawScores::';
	EXPORT HistoryFile_Tag := '_1';
	
	//NTileFile
	EXPORT NTileFile_Prefix := '~distributionTrend::NTile::';
	EXPORT NTileFile_Tag := '_1';
	
	//ProportionFile
	EXPORT ProportionFile_Prefix := '~distributionTrend::Proportion::';
	EXPORT ProportionFile_10_Tag := '_10_1';
	EXPORT ProportionFile_50_Tag := '_50_1';
END;