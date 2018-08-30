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
// BIPV2.ManualSuppression.removeCandidates(DATASET([
    // {163052000}
		// ],BIPV2.ManualSuppression.inRec));					

/* -- To add candidates to the Suppression file using rcid -- */
// BIPV2.ManualSuppression.addCandidates(DATASET([
    // {163052000}
		// ],BIPV2.ManualSuppression.inRec));					
		
		// 407	407q
