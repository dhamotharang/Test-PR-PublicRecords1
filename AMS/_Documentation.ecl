EXPORT _Documentation := 'todo';

/*

AMS -- Advantage Medical Services


Data from Ingenix is ranked via their tierTypeId. Most of the data has this field.  AMS does not have this field,
                       so there is a constant NO_TIER_AVAILABLE (set to 0) available for use in the AMS._Constants attribute
                       to use for all AMS data when combining with existing Ingenix data layouts.
Ingenix TierTypeID -
Tier codes:
? Tier 1  – Data values submitted to Ingenix from originating government agencies (e.g., state licensure boards,
            Centers for Medicare and Medicaid Services), or data that has been verified correct.
? Tier 2  – The same data value was received from 5 or more sources
? Tier 3  – The same data value was received from 2-4 sources
? Tier 99 – The data value was received from a single source
? Tier 0  – No tier available

*/