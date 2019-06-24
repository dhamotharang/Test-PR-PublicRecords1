IMPORT SuspectAddressVisualization;

EXPORT Results(
    DATASET(SuspectAddressVisualization.Layouts.ScoredOutRec)                    Score,
    DATASET(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord)  Provider,
    DATASET(SuspectAddressVisualization.Layouts.FinalAddressLayout)              Address,
    DATASET(SuspectAddressVisualization.Layouts.FacilityRec)                     Facility,
    DATASET(SuspectAddressVisualization.Layouts.ScoredWithFlagFilterLayout)      ScoreWithFlagFilter,
    DATASET(SuspectAddressVisualization.Layouts.SpecialtyLayout)      					 SpecialtyStatsDs,		
		DATASET(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord)  AllSpecialtyDs,
		DATASET(SuspectAddressVisualization.Layouts.ProviderFlagLayout)							 ProviderFlagDs,
		DATASET(SuspectAddressVisualization.Layouts.AddressFlagLayout)							 AddressFlagDs,
		DATASET(SuspectAddressVisualization.Layouts.SummaryLayout)									 SummaryDs
) := MODULE

    EXPORT ScoreDataset                 := Score;
    EXPORT ProviderDataset              := Provider;
    EXPORT AddressDataset               := Address;
    EXPORT FacilityDataset              := Facility;
    EXPORT ScoreWithFlagFilterDataset   := ScoreWithFlagFilter;
    EXPORT SpecialtyStatsDataset			  := SpecialtyStatsDs;
    EXPORT AllSpecialtyDataset			  	:= AllSpecialtyDs;
    EXPORT ProviderFlagDataset			  	:= ProviderFlagDs;
    EXPORT AddressFlagDataset				  	:= AddressFlagDs;		
		EXPORT SummaryDataset								:= SummaryDs;

END;