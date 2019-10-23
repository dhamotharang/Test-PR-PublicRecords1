/* -- To pull possible candidate Header records by proxid -- */
// OUTPUT(BIPV2.ManualSuppression.candidatesByProxID(DATASET([
    // {990}
		// ],BIPV2.ManualSuppression.inRec2)),ALL);					
		
/* -- To pull possible candidate Header records by seleid -- */
// OUTPUT(BIPV2.ManualSuppression.candidatesBySeleID(DATASET([
    // {407}
		// ],BIPV2.ManualSuppression.inRec2)),ALL);		
		
/* -- To pull possible candidate Header records by lgid3 -- */
// OUTPUT(BIPV2.ManualSuppression.candidatesByLGID3(DATASET([
    // {407}
		// ],BIPV2.ManualSuppression.inRec2)),ALL);					
		
/* -- To remove candidates from the Suppression file using rcid. -- */
buildVersion := '20190206';
BIPV2.ManualSuppression.removeCandidates(DATASET([
    {82957356270}
		],BIPV2.ManualSuppression.inRec),buildVersion);					

// /* -- To add candidates to the Suppression file using rcid -- */
// buildVersion := '20190206';
// BIPV2.ManualSuppression.addCandidates(DATASET([
    // {82957356270}],BIPV2.ManualSuppression.inRec),buildVersion);					

/* -- To View Current Suppressions -- */
// BIPV2.ManualSuppression.viewSuppressionList();		
		
//407
