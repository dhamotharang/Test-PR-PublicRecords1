IMPORT SuspectAddressVisualization;

EXPORT Results(
    DATASET(SuspectAddressVisualization.Layouts.ScoredOutRec)                    			Score = DATASET([], SuspectAddressVisualization.Layouts.ScoredOutRec),
    DATASET(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord)  			Provider = DATASET([], SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord),
    DATASET(SuspectAddressVisualization.Layouts.FinalAddressLayout)              			Address,
    DATASET(SuspectAddressVisualization.Layouts.FacilityRec)                     			Facility,
    DATASET(SuspectAddressVisualization.Layouts.ScoredWithFlagFilterLayout)      			ScoreWithFlagFilter = DATASET([], SuspectAddressVisualization.Layouts.ScoredWithFlagFilterLayout),
    DATASET(SuspectAddressVisualization.Layouts.SpecialtyLayout)      					 			SpecialtyStatsDs,		
		DATASET(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord)  			AllSpecialtyDs,
		DATASET(SuspectAddressVisualization.Layouts.ProviderFlagLayout)							 			ProviderFlagDs,
		DATASET(SuspectAddressVisualization.Layouts.AddressFlagLayout)							 			AddressFlagDs,
		DATASET(SuspectAddressVisualization.Layouts.SummaryLayout)									 			SummaryDs,
    DATASET(SuspectAddressVisualization.Layouts.ScoredCCPAOutRec)                			ScoreCCPA = DATASET([], SuspectAddressVisualization.Layouts.ScoredCCPAOutRec),
    DATASET(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord) 	ProviderCCPA = DATASET([], SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord),    
		DATASET(SuspectAddressVisualization.Layouts.ScoredWithFlagFilterCCPALayout)   		ScoreWithFlagCCPAFilter = DATASET([], SuspectAddressVisualization.Layouts.ScoredWithFlagFilterCCPALayout),
		DATASET(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord)  	AllSpecialtyCCPADs = DATASET([], SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord)
) := MODULE

    EXPORT ScoreDataset                 		:= Score;
    EXPORT ScoreCCPADataset                 := ScoreCCPA;
    EXPORT ProviderDataset              		:= Provider;
    EXPORT ProviderCCPADataset              := ProviderCCPA;
    EXPORT AddressDataset               		:= Address;
    EXPORT FacilityDataset              		:= Facility;
    EXPORT ScoreWithFlagFilterDataset   		:= ScoreWithFlagFilter;
    EXPORT ScoreWithFlagFilterCCPADataset   := ScoreWithFlagCCPAFilter;
    EXPORT SpecialtyStatsDataset			  		:= SpecialtyStatsDs;
    EXPORT AllSpecialtyDataset			  			:= AllSpecialtyDs;
    EXPORT AllSpecialtyCCPADataset					:= AllSpecialtyCCPADs;
    EXPORT ProviderFlagDataset			  			:= ProviderFlagDs;
    EXPORT AddressFlagDataset				  			:= AddressFlagDs;		
		EXPORT SummaryDataset										:= SummaryDs;

END;