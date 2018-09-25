import BIPV2_LGID3;

//Add Underlink LGIDs
newCandidates := dataset([{49004037,1},{114008550185,1}], BIPV2_LGID3.ManualUnderLinks.recLayout);
BIPV2_LGID3.ManualUnderLinks.addCandidates(newCandidates);

//Remove Underlink LGIDs
// BIPV2_LGID3.ManualUnderLinks.removeCandidates(1);

