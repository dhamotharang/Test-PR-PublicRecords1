import DayBatchPCNSR,ut;
ScrubsInput:=DayBatchPCNSR.File_PCNSR_keybuild;
ut.CleanFields(ScrubsInput,ScrubsInputClean);
EXPORT in_PCNSR := ScrubsInputClean;