EXPORT MacComputeDashboardOutputs(
  InDataset
  
 ,InLNPID = ''
 ,InLEXID = ''
 ,InProviderKey = ''
 ,InProviderFirstName = ''
 ,InProviderMiddleName = ''
 ,InProviderLastName = ''
 ,InProviderSuffixName = ''
 ,InProviderType = ''
 ,InFacilityName = ''
 ,InTotalChargeAmount = ''
 ,InTotalPaidAmount = ''
 ,InTotalClaimCount = ''
 ,InTotalProviderCount = ''
 
 ,InProviderSpecialtyCode = ''
 ,InProviderSpecialtyDescription = ''

 ,InProviderNpi = ''
 ,InClientNpi = ''

 ,InPrimaryRange = ''
 ,InPreDirectional = ''
 ,InPrimaryName = ''
 ,InAddressSuffix = ''
 ,InPostDirectional = ''
 ,InSecondaryRange = ''
 ,InCityName_Vanity = ''
 ,InState = ''
 ,InZip5 = ''
 ,InFipsState = ''
 ,InCounty = ''
 ,InLatitude = ''
 ,InLongitude = ''
 ,InProfessionalScore = ''
 ,InAddressScore = ''
 ,InAddressExclusionFlag = ''
 ,InAddressClaimCount = ''
 ,InAddressHighPaidAmount = ''
 ,InAddressProviderCount = ''
 ,InLNPIDClaimCount = ''
 ,InLNPIDHighChargeAmount = ''
 ,InLNPIDHighPaidAmount = ''
 ,InNumberOfAddress = ''
 ,InProviderClaimCount = ''
 ,InProviderHighPaidAmount = ''
 ,InAddressKey = ''
 ,InHighPaidDollarsPerClaim = ''
 ,InClaimStartDate = ''
 ,InClaimEndDate = ''
 ,InSuspectReason = ''
 ,InSuspectDescription = ''
 
 ,InClientSpecialtyCode = ''
 ,InClientSpecialtyDescription = ''

 ,InProviderImpactClaimCount = ''
 ,InProviderImpactAmount = ''
 ,InAddressImpactClaimCount = ''
 ,InAddressImpactAmount = ''
 ,InLNPIDImpactClaimCount = ''
 ,InLNPIDImpactAmount = ''
 ,InScoreReasons = ''
 ,InOptOutIndicator = '' 
 ,UseOptOutIndicator = FALSE
) := FUNCTIONMACRO

    IMPORT STD; 
    IMPORT HealthCareProvider; 
    IMPORT Relavator;
    IMPORT SuspectAddressVisualization;

    TrimFacilityDs := PROJECT(InDataset(InFacilityName <> '' AND InAddressExclusionFlag <> 'Y' AND InProviderType <> 'P'), 
        TRANSFORM(SuspectAddressVisualization.Layouts.FacilityRec,
            SELF.Provider_ID            := LEFT.InProviderKey;
            SELF.Facility_Name          := LEFT.InFacilityName;
            SELF.Legal_Business_Name    := '';
            SELF.Doing_Business_As      := '',
            SELF.Primary_Address        := STD.STR.CleanSpaces(
                                               TRIM(LEFT.InPrimaryRange) + ' ' + 
                                               TRIM(LEFT.InPreDirectional) + ' ' + 
                                               TRIM(LEFT.InPrimaryName) + ' ' + 
                                               TRIM(LEFT.InAddressSuffix) + ' ' + 
                                               TRIM(LEFT.InPostDirectional) + ' ' + 
                                               TRIM(LEFT.InSecondaryRange)
                                           ); 
            SELF.City                   := LEFT.InCityName_Vanity;
            SELF.State                  := LEFT.InState;
            SELF.Zip                    := LEFT.InZip5;
            SELF.FacilityType           := '';
            SELF.ChargedDollarAmount    := LEFT.InTotalChargeAmount;
            SELF.PaidDollarAmount       := LEFT.InTotalPaidAmount;
            SELF.ClaimsStartDate        := IF(HealthCareProvider.isValidDate(LEFT.InClaimStartDate), LEFT.InClaimStartDate, ''); 
            SELF.ClaimsEndDate          := IF(HealthCareProvider.isValidDate(LEFT.INClaimEndDate), LEFT.INClaimEndDate, '');
            SELF.NPI                    := LEFT.InProviderNpi;
            SELF.Client_NPI             := LEFT.InClientNpi;
						SELF.Speciality							:= IF (LEFT.InClientSpecialtyCode <> '' AND LEFT.InClientSpecialtyDescription <> '',LEFT.InClientSpecialtyDescription,LEFT.InProviderSpecialtyDescription);
            // SELF.Speciality             := IF(TRIM(LEFT.InClientSpecialtyDescription, LEFT, RIGHT) <> '',
                                              // TRIM(LEFT.InClientSpecialtyDescription, LEFT, RIGHT),
                                              // IF(TRIM(LEFT.InProviderSpecialtyDescription, LEFT, RIGHT) <> '', 
                                                 // TRIM(LEFT.InProviderSpecialtyDescription, LEFT, RIGHT) + ' (LN)',
                                                 // ''));
            SELF.Specialty_Code         := LEFT.InProviderSpecialtyCode;
            SELF.Client_Specialty_Code  :=  IF (LEFT.InClientSpecialtyCode <> '' AND LEFT.InClientSpecialtyDescription <> '', LEFT.InClientSpecialtyCode, 'LN:' + TRIM(LEFT.InProviderSpecialtyCode));
            SELF.TotalClaims            := LEFT.InProviderClaimCount;
        )
    );

    MaxAddressScore := MAX (InDataset, InAddressScore) : INDEPENDENT;
		
		LOCAL ScoredRec := #IF((BOOLEAN)UseOptOutIndicator) SuspectAddressVisualization.Layouts.ScoredCCPARec #ELSE SuspectAddressVisualization.Layouts.ScoredRec #END;
    TrimScoredOutDs := PROJECT(InDataset, 
        TRANSFORM(ScoredRec,
            SELF.ProviderKey        :=  LEFT.InProviderKey;
            SELF.ProviderNpi        :=  LEFT.InClientNpi;
            SELF.FacilityName       :=  LEFT.InFacilityName;
            SELF.LastName           :=  LEFT.InProviderLastName;
            SELF.FirstName          :=  LEFT.InProviderFirstName;
            SELF.MiddleName         :=  LEFT.InProviderMiddleName;
            SELF.SuffixName         :=  LEFT.InProviderSuffixName;
            SELF.PrimaryRange       :=  LEFT.InPrimaryRange;
            SELF.PreDirectional     :=  LEFT.InPreDirectional;
            SELF.PrimaryName        :=  LEFT.InPrimaryName;
            SELF.AddressSuffix      :=  LEFT.InAddressSuffix;
            SELF.PostDirectional    :=  LEFT.InPostDirectional;
            SELF.SecondaryRange     :=  LEFT.InSecondaryRange;
            SELF.City               :=  LEFT.InCityName_Vanity;
            SELF.State              :=  LEFT.InState;
            SELF.Zip5               :=  LEFT.InZip5;
            SELF.CountyCode         :=  LEFT.InFipsState + LEFT.InCounty;
            SELF.StateCountyCode    :=  LEFT.InState + LEFT.InFipsState + LEFT.InCounty;
            SELF.AddressLine1       :=  STD.STR.CleanSpaces(
                                            TRIM(LEFT.InPrimaryRange) + ' ' + 
                                            TRIM(LEFT.InPreDirectional) + ' ' + 
                                            TRIM(LEFT.InPrimaryName) + ' ' + 
                                            TRIM(LEFT.InAddressSuffix) + ' ' + 
                                            TRIM(LEFT.InPostDirectional) + ' ' + 
                                            TRIM(LEFT.InSecondaryRange)
                                        ); 
            SELF.AddressLine        :=  STD.STR.CleanSpaces(
                                            TRIM(LEFT.InPrimaryRange) + ' ' + 
                                            TRIM(LEFT.InPreDirectional) + ' ' + 
                                            TRIM(LEFT.InPrimaryName) + ' ' + 
                                            TRIM(LEFT.InAddressSuffix) + ' ' + 
                                            TRIM(LEFT.InPostDirectional) + ' ' + 
                                            TRIM(LEFT.InSecondaryRange) + ' ' + 
                                            TRIM(LEFT.InCityName_Vanity) + ' ' + 
                                            TRIM(LEFT.InState) + ' ' + 
                                            TRIM(LEFT.InZip5)
                                        );
            SELF.Latitude           :=  LEFT.InLatitude;
            SELF.Longitude          :=  LEFT.InLongitude;
            SELF.LNPID              :=  LEFT.InLNPID;
            SELF.LEXID              :=  LEFT.InLEXID;
						SELF.TaxonomyDescription				:= LEFT.InProviderSpecialtyDescription;
            // SELF.TaxonomyDescription        :=  IF(TRIM(LEFT.InClientSpecialtyDescription, LEFT, RIGHT) <> '',
                                                   // TRIM(LEFT.InClientSpecialtyDescription, LEFT, RIGHT),
                                                   // IF(TRIM(LEFT.InProviderSpecialtyDescription, LEFT, RIGHT) <> '', 
                                                      // TRIM(LEFT.InProviderSpecialtyDescription, LEFT, RIGHT) + ' (LN)',
                                                      // ''));
            SELF.ProviderClaimCount         :=  LEFT.InProviderClaimCount;
            SELF.LNPIDClaimCount            :=  LEFT.InLNPIDClaimCount;
            SELF.ProviderHighChargeAmount   :=  ROUND(LEFT.InTotalChargeAmount);
            SELF.ProviderHighPaidAmount     :=  ROUND(LEFT.InTotalPaidAmount);
            SELF.LNPIDHighChargeAmount      :=  ROUND(LEFT.InLNPIDHighChargeAmount);
            SELF.LNPIDHighPaidAmount        :=  ROUND(LEFT.InLNPIDHighPaidAmount);
            SELF.AddressExclusionFlag       :=  LEFT.InAddressExclusionFlag;
            SELF.AddressProviderCount       :=  LEFT.InAddressProviderCount;
            SELF.AddressClaimCount          :=  LEFT.InAddressClaimCount;
            SELF.AddressHighPaidAmount      :=  ROUND(LEFT.InAddressHighPaidAmount);
            SELF.NumberOfAddress            :=  LEFT.InNumberOfAddress;
            SELF.AddressKey                 :=  LEFT.InAddressKey;
            SELF.ProfessionalScore          :=  LEFT.InProfessionalScore;
            SELF.ScoreReasons               :=  LEFT.InScoreReasons;
            SELF.ProviderScored             :=  IF(LEFT.InProfessionalScore > 0, '1', '0'); 
            SELF.AddressScore               :=  ROUNDUP((LEFT.InAddressScore * 100)/MaxAddressScore);
            SELF.PaidPercent                :=  ROUND((LEFT.InTotalPaidAmount / LEFT.InTotalChargeAmount) * 100);
            SELF.AddressScoreRangeGroup     :=  MAP(
                                                    SELF.AddressScore BETWEEN 1 AND 20   => 5,
                                                    SELF.AddressScore BETWEEN 21 AND 40  => 4,
                                                    SELF.AddressScore BETWEEN 41 AND 60  => 3,
                                                    SELF.AddressScore BETWEEN 61 AND 80  => 2,
                                                    SELF.AddressScore BETWEEN 81 AND 100 => 1,
                                                                                            0
                                                );
            SELF.AddressScoreRange          :=  MAP(
                                                    SELF.AddressScoreRangeGroup = 5 => '1  - 20 ',
                                                    SELF.AddressScoreRangeGroup = 4 => '21 - 40 ',
                                                    SELF.AddressScoreRangeGroup = 3 => '41 - 60 ',
                                                    SELF.AddressScoreRangeGroup = 2 => '61 - 80 ',
                                                    SELF.AddressScoreRangeGroup = 1 => '81 - 100',
                                                                                       '0       '
                                                );
            SELF.AddressScoreRangeProviderCount :=  LEFT.InTotalProviderCount;
            SELF.AddressScoreRangeAddressCount  :=  0;
            SELF.PaidPercentByLNPID             :=  ROUND((LEFT.InLNPIDHighPaidAmount / LEFT.InLNPIDHighChargeAmount) * 100); 
            SELF.SLNPID                         :=  (STRING)LEFT.InLNPID;
            SELF.ProviderType                   :=  MAP(LEFT.InProviderLastName <> '' AND LEFT.InProviderFirstName <> '' => 'P',
                                                        LEFT.InFacilityName <> '' => 'F','');
            SELF.ContextUID                     :=  IF(SELF.SLNPID <> '', Relavator.MacGraphContextUID(8, SELF.SLNPID), '');
            SELF.ClientSpecialtyCode            :=  IF (LEFT.InClientSpecialtyCode <> '' AND LEFT.InClientSpecialtyDescription <> '', LEFT.InClientSpecialtyCode, 'LN:' + TRIM(LEFT.InProviderSpecialtyCode));
            SELF.ClientSpecialtyDesc            :=  IF (LEFT.InClientSpecialtyCode <> '' AND LEFT.InClientSpecialtyDescription <> '', LEFT.InClientSpecialtyDescription, LEFT.InProviderSpecialtyDescription);
            SELF.ProviderImpactClaimCount       :=  LEFT.InProviderImpactClaimCount;
            SELF.ProviderImpactAmount           :=  LEFT.InProviderImpactAmount;
            SELF.AddressImpactClaimCount        :=  LEFT.InAddressImpactClaimCount;
            SELF.AddressImpactAmount            :=  LEFT.InAddressImpactAmount;
            SELF.LNPIDImpactClaimCount          :=  LEFT.InLNPIDImpactClaimCount;
            SELF.LNPIDImpactAmount              :=  LEFT.InLNPIDImpactAmount;
						SELF.HeaderNPI											:=	MAP(LEFT.InClientNpi <> '' AND LEFT.InProviderNpi <> '' AND LEFT.InClientNpi = LEFT.InProviderNpi => '',
																												LEFT.InProviderNpi);
						#IF((BOOLEAN)UseOptOutIndicator) SELF.OptOutInd											:=	LEFT.InOptOutIndicator; #END
            SELF := LEFT;
            SELF := [];
        )
    ); 

    AddressScoreRangeCount := TABLE(
        DEDUP(
            DISTRIBUTE(TrimScoredOutDs(AddressExclusionFlag <> 'Y' AND AddressScoreRange <> '' AND AddressKey <> '' and State <> ''), HASH32(State, AddressKey, AddressScoreRange)),
            State, AddressKey, AddressScoreRange, ALL, LOCAL
        ), 
        {State, AddressScoreRange, AddressRangeCount := COUNT(GROUP)}, 
        State, AddressScoreRange, MERGE
    );
    
    ScoredOutDs := JOIN(TrimScoredOutDs, AddressScoreRangeCount, LEFT.State = RIGHT.State AND LEFT.AddressScoreRange = RIGHT.AddressScoreRange, 
        TRANSFORM(ScoredRec, 
            SELF.AddressScoreRangeAddressCount := RIGHT.AddressRangeCount;
            SELF := LEFT;
        ), LEFT OUTER, HASH
    );

    TopAddrDs := DEDUP(
        SORT(DISTRIBUTE(ScoredOutDs(PrimaryName <> '' AND Zip5 <> ''), HASH32(AddressLine)), AddressLine, -AddressScore,LOCAL), 
        AddressLine,LOCAL
    );
    TopAddrTable := TABLE(TopAddrDs(State <> ''), {State, StateCounts := COUNT(GROUP)}, State, MERGE);
    ScoredDsWithStateCount := JOIN(ScoredOutDs, TopAddrTable, LEFT.State = RIGHT.State, 
        TRANSFORM(ScoredRec,
            SELF.StateCount := RIGHT.StateCounts;
            SELF := LEFT;
        ), LEFT OUTER, HASH
    );

    SortLNPIDDs := SORT(DISTRIBUTE(ScoredOutDs(LNPID > 0), HASH32(LNPID)), LNPID, LOCAL);
    GroupLNPIDDs := GROUP(SortLNPIDDs, LNPID, LOCAL);   
    
    ScoredRec LnpidRollUp(ScoredRec L, DATASET (ScoredRec) R) := TRANSFORM
        SELF.ProviderScoreByLnpid := MAX(r,ProfessionalScore);
        SELF := L;
    END;
    RollupLnpidTrimDs := ROLLUP(GroupLNPIDDs, GROUP, LnpidRollUp(LEFT, ROWS(LEFT)));
   
    JoinLNPIDDs := JOIN(ScoredDsWithStateCount, RollupLnpidTrimDs, LEFT.LNPID = RIGHT.LNPID, 
        TRANSFORM(ScoredRec,
            SELF.ProviderScoreByLnpid := RIGHT.ProviderScoreByLnpid;
            SELF := LEFT;
        ), LEFT OUTER,HASH
    );
		
		LOCAL ScoredOutRec := #IF((BOOLEAN)UseOptOutIndicator) SuspectAddressVisualization.Layouts.ScoredCCPAOutRec #ELSE SuspectAddressVisualization.Layouts.ScoredOutRec #END;
    TrimScoredDs:= PROJECT(JoinLNPIDDs, TRANSFORM(ScoredOutRec, SELF := LEFT;));

    TopScoredProvider := DEDUP(
        SORT(
            DISTRIBUTE(
                PROJECT(JoinLNPIDDs(PrimaryName <> '' AND Zip5 <> ''), SuspectAddressVisualization.Layouts.TopProviderRec), 
                HASH32(PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5)
            ), 
            PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, -ProfessionalScore, LOCAL
        ), 
        PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, LOCAL
    );
    FilterExcludedAddress := JoinLNPIDDs(AddressExclusionFlag <> 'Y' AND PrimaryName <> '' AND Zip5 <> '');
   
    SuspectAddress := JOIN(FilterExcludedAddress, TopScoredProvider, 
        LEFT.PrimaryRange       = RIGHT.PrimaryRange AND 
        LEFT.PreDirectional     = RIGHT.PreDirectional AND 
        LEFT.PrimaryName        = RIGHT.PrimaryName AND 
        LEFT.AddressSuffix      = RIGHT.AddressSuffix AND 
        LEFT.PostDirectional    = RIGHT.PostDirectional AND 
        LEFT.SecondaryRange     = RIGHT.SecondaryRange AND 
        LEFT.City               = RIGHT.City AND 
        LEFT.State              = RIGHT.State AND 
        LEFT.Zip5               = RIGHT.Zip5,  
        TRANSFORM(RECORDOF(LEFT),
            SELF.ScoreReasons := LEFT.ScoreReasons; 
            SELF := LEFT;
        ), HASH
    );
    
    AddressDs := PROJECT(SuspectAddress, TRANSFORM(SuspectAddressVisualization.Layouts.TopSuspectAddressRecord, SELF.Zip := LEFT.Zip5; SELF := LEFT;));
   
    TopAddress := DEDUP(
        SORT(DISTRIBUTE(AddressDs, HASH32(AddressLine1, City, State, Zip)), AddressLine1, City, State, Zip, -AddressScore, LOCAL), 
        AddressLine1, City, State, Zip, LOCAL
    );  
    TopStateDs := TABLE(TopAddress ,{State, StateCount := COUNT(GROUP)}, State, MERGE);
    TopAddressDs:= SORT(TopAddress, -AddressScore);

    AddressDataDs := PROJECT(SuspectAddress, 
        TRANSFORM(SuspectAddressVisualization.Layouts.TopSuspectAddressDataRecord, 
            SELF.NoOfProviders  := LEFT.AddressProviderCount;
            SELF.TotalPaid      := LEFT.AddressHighPaidAmount;
            SELF.TotalClaim     := LEFT.AddressClaimCount; 
            SELF.Zip            := LEFT.Zip5; 
            SELF := LEFT;
        )
    );

    TopAddressDataDs := JOIN(AddressDataDs, TopAddressDs, 
        LEFT.AddressLine1   = RIGHT.AddressLine1 AND 
        LEFT.City           = RIGHT.City AND 
        LEFT.State          = RIGHT.State AND 
        LEFT.Zip            = RIGHT.Zip,
        TRANSFORM(SuspectAddressVisualization.Layouts.TopSuspectAddressDataRecord, SELF := LEFT;), RIGHT OUTER, HASH
    );

    SortedAddressDs := SORT(DISTRIBUTE(TopAddressDataDs, HASH32(AddressLine, City, State, Zip)), AddressLine, City, State, Zip, -AddressScore, LOCAL);
    GroupAddressDs  := GROUP(SortedAddressDs, AddressLine, City, State, Zip, LOCAL);

    SuspectAddressVisualization.Layouts.TopSuspectAddressDataRecord NormAddrData(SuspectAddressVisualization.Layouts.TopSuspectAddressDataRecord l, DATASET (SuspectAddressVisualization.Layouts.TopSuspectAddressDataRecord) R) := TRANSFORM
        Norm_Ds := NORMALIZE(R, COUNT(LEFT.ScoreReasons), 
            TRANSFORM(SuspectAddressVisualization.Layouts.ReasonLayout, 
                SELF.Reason := LEFT.ScoreReasons[COUNTER].Reason; 
                SELF.Description := LEFT.ScoreReasons[COUNTER].Description;
                SELF.Value := LEFT.ScoreReasons[COUNTER].Value
            )
        );
        SDS := SORT(Norm_Ds,Reason);
        DSDS := DEDUP(SDS(Reason <> ''), Reason);
        SELF.ScoreReasons := PROJECT(DSDS, TRANSFORM(SuspectAddressVisualization.Layouts.ReasonLayout, SELF := LEFT;));
        SELF := L;
    END;
    RolledAddressDs := ROLLUP(GroupAddressDs, GROUP, NormAddrData(LEFT, ROWS(LEFT)));

    AddressReasonAttrDs := NORMALIZE(RolledAddressDs, COUNT(LEFT.ScoreReasons), 
        TRANSFORM(SuspectAddressVisualization.Layouts.TopSuspectAddressReasonRecord, 
            SELF.ReasonCode             :=  LEFT.ScoreReasons[counter].Reason [1..1]; 
            SELF.Reason                 :=  LEFT.ScoreReasons[counter].Reason; 
            SELF.IsProfSuspectIndicator :=  IF(SELF.Reason IN [
                                                  'B001',
                                                  'B002',
                                                  'B003',
                                                  'B004',
                                                  'B005',
                                                  'B006',
                                                  'C001',
                                                  'C002',
                                                  'C003',
                                                  'C004',
                                                  'C005',
                                                  'D001',
                                                  'D002',
                                                  'G002',
                                                  'G003',
                                                  'J001',
                                                  'J002'
                                               ], 
                                               1, 
                                               0);
            SELF.IsProfOutlierIndicator :=  IF(SELF.Reason IN [
                                                  'F001',
                                                  'F002',
                                                  'F003',
                                                  'F004',
                                                  'G001',
                                                  'H001'
                                               ], 
                                               1, 
                                               0);
            SELF.ReasonCodeDescription  :=  MAP(
                                                SELF.ReasonCode = 'A' => 'Flagged Addresses', 
                                                SELF.ReasonCode = 'B' => 'Federal & State Exclusion Providers', 
                                                SELF.ReasonCode = 'C' => 'Flagged License Providers', 
                                                SELF.ReasonCode = 'D' => 'Deceased/Deactivated NPI Providers', 
                                                SELF.ReasonCode = 'E' => 'Flagged Facilities', 
                                                SELF.ReasonCode = 'F' => 'High Paid Providers', 
                                                SELF.ReasonCode = 'G' => 'Flagged Patient Profile Providers', 
                                                SELF.ReasonCode = 'H' => 'Flagged Distances Providers', 
                                                SELF.ReasonCode = 'I' => 'Flagged Relationship Providers', 
                                                SELF.ReasonCode = 'J' => 'Bankruptcy/Felony Providers', 
                                                                         ''
                                            );
            SELF.Description            :=  LEFT.ScoreReasons[counter].Description;
            SELF.ReasonValue            :=  LEFT.ScoreReasons[counter].Value;
            SELF.ReasonType             :=  IF(SELF.ReasonCode IN ['A', 'E'], 'A', 'P');
            SELF.ReasonValueForAddress  :=  IF(SELF.ReasonType = 'A', SELF.ReasonValue, '');
            SELF.ReasonValueForProvider :=  IF(SELF.ReasonType = 'P', SELF.ReasonValue, '');
            SELF.SLNPID                 :=  (STRING)LEFT.LNPID;
            SELF.LNPID                  :=  LEFT.LNPID; 
            SELF := LEFT;
        )
    );
           
    AddressAttrsDs := DEDUP(
        SORT(DISTRIBUTE(AddressReasonAttrDs(Reason <> ''), HASH32(Reason,AddressLine)), Reason, AddressLine, LOCAL),
        Reason, AddressLine, LOCAL
    );
		
		LOCAL TopSuspectAddressProviderRecord := #IF((BOOLEAN)UseOptOutIndicator) SuspectAddressVisualization.Layouts.TopSuspectAddressProviderCCPARecord #ELSE SuspectAddressVisualization.Layouts.TopSuspectAddressProviderRecord #END;
    ProviderDataDs := PROJECT(ScoredOutDs(PrimaryName <> '' AND Zip5 <> ''), 
        TRANSFORM(TopSuspectAddressProviderRecord, 
            SELF.TotalCharge    := LEFT.LNPIDHighChargeAmount;
            SELF.TotalPaid      := LEFT.LNPIDHighPaidAmount;
            SELF.PaidPercent    := ROUND((LEFT.ProviderHighPaidAmount / LEFT.ProviderHighChargeAmount) * 100);
            SELF.NoOfClaims     := LEFT.LNPIDClaimCount;
            SELF.SpecialityDesc := LEFT.TaxonomyDescription;
            SELF.Npi            := LEFT.ProviderNPI;
            SELF.ProviderScore  := LEFT.ProfessionalScore;
            SELF.ScoreReasons   := LEFT.ScoreReasons;
            SELF.Zip            := LEFT.Zip5;
            SELF := LEFT;
        )
    );

		LOCAL TopSuspectProviderReasonRecord := #IF((BOOLEAN)UseOptOutIndicator) SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord #ELSE SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord #END;
    ReasonAttrDs := NORMALIZE (ProviderDataDs, COUNT(LEFT.ScoreReasons), 
        TRANSFORM(TopSuspectProviderReasonRecord, 
            SELF.ReasonCode             :=  LEFT.ScoreReasons[counter].Reason [1..1]; 
            SELF.Reason                 :=  LEFT.ScoreReasons[counter].Reason; 
            SELF.ReasonCodeDescription  :=  MAP(
                                                SELF.ReasonCode = 'A' => 'Flagged Addresses', 
                                                SELF.ReasonCode = 'B' => 'Federal & State Exclusion Providers', 
                                                SELF.ReasonCode = 'C' => 'Flagged License Providers', 
                                                SELF.ReasonCode = 'D' => 'Deceased/Deactivated NPI Providers', 
                                                SELF.ReasonCode = 'E' => 'Flagged Facilities', 
                                                SELF.ReasonCode = 'F' => 'High Paid Providers', 
                                                SELF.ReasonCode = 'G' => 'Flagged Patient Profile Providers', 
                                                SELF.ReasonCode = 'H' => 'Flagged Distances Providers', 
                                                SELF.ReasonCode = 'I' => 'Flagged Relationship Providers', 
                                                SELF.ReasonCode = 'J' => 'Bankruptcy/Felony Providers', 
                                                                         ''
                                            );
            SELF.Description            :=  LEFT.ScoreReasons[counter].Description;
            SELF.ReasonValue            :=  LEFT.ScoreReasons[counter].Value;
            SELF.ReasonType             :=  IF (SELF.ReasonCode IN ['A','E'],'A','P');
            SELF.ReasonValueForAddress  :=  IF (SELF.ReasonType = 'A', SELF.ReasonValue, '');
            SELF.ReasonValueForProvider :=  IF (SELF.ReasonType = 'P', SELF.ReasonValue, '');
            SELF.LNPID                  :=  LEFT.LNPID;
            SELF.SLNPID                 :=  (STRING)LEFT.LNPID;
            SELF.ContextUID             :=  IF(SELF.SLNPID <> '', Relavator.MacGraphContextUID (8,SELF.SLNPID),'');
            SELF.ClientSpecialtyCode    :=  LEFT.ClientSpecialtyCode;
            SELF.ClientSpecialtyDesc    :=  LEFT.ClientSpecialtyDesc;
            SELF.ProviderImpactClaimCount :=  LEFT.ProviderImpactClaimCount;
            SELF.ProviderImpactAmount     :=  LEFT.ProviderImpactAmount;
            SELF.AddressImpactClaimCount  :=  LEFT.AddressImpactClaimCount;
            SELF.AddressImpactAmount      :=  LEFT.AddressImpactAmount;
            SELF.LNPIDImpactClaimCount    :=  LEFT.LNPIDImpactClaimCount;
            SELF.LNPIDImpactAmount        :=  LEFT.LNPIDImpactAmount;
            SELF := LEFT;
        )
    );
            
    ProviderAttrsDs := DEDUP(SORT(DISTRIBUTE(ReasonAttrDs(Reason <> ''), HASH32(Reason, ProviderKey)), Reason, ProviderKey, LOCAL), Reason, ProviderKey, LOCAL);
		ProviderSpecialtyDs	:= DEDUP(SORT(DISTRIBUTE(ReasonAttrDs(ClientSpecialtyCode <> ''), HASH32(ProviderKey)), ProviderKey, LOCAL), ProviderKey, LOCAL);

		AllSpecialtyDs	:= PROJECT (ProviderSpecialtyDs (FirstName <> '' AND LastName <> ''), TRANSFORM(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord, SELF.ClientSpecialtyCode := 'All Codes'; SELF := LEFT;)) + PROJECT(ProviderSpecialtyDs  (FirstName <> '' AND LastName <> ''),SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord);
		AllSpecialtyCCPADs := PROJECT (ProviderSpecialtyDs (FirstName <> '' AND LastName <> ''), TRANSFORM(SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord, SELF.ClientSpecialtyCode := 'All Codes'; SELF := LEFT;)) + PROJECT(ProviderSpecialtyDs  (FirstName <> '' AND LastName <> ''),SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord);
		
    AttrTable := TABLE(ProviderAttrsDs, {ReasonCode, Reason, ReasonCodeDescription, ReasonCount := COUNT(GROUP)}, ReasonCode, MERGE);

		ProviderFlagDs := PROJECT(ProviderAttrsDs, TRANSFORM(SuspectAddressVisualization.Layouts.ProviderFlagLayout, 
				SELF.Description := MAP (LEFT.Reason IN ['G002','G003','H001','B001','B004','C001','C002','C003','C004','C005','A007','A008'] => '<u>'+ TRIM(LEFT.Description) + '</u>',LEFT.Description);
				AddrLine1				 := STD.Str.CleanSpaces(LEFT.PrimaryRange + LEFT.PreDirectional + LEFT.PrimaryName + LEFT.AddressSuffix+ LEFT.PostDirectional+ LEFT.SecondaryRange + LEFT.City + LEFT.State + LEFT.Zip);
				TAddrLine1			 := TRIM(AddrLine1);
				SELF.HistKey		 := MAP (LEFT.Reason IN ['G002','G003','H001','B001','B004','C001','C002','C003','C004','C005','A008'] => LEFT.Reason + '_' + TRIM(LEFT.ProviderKey), 
																 // LEFT.Reason = 'A007' => LEFT.Reason + '_' + TRIM((STRING)HASH64(HASHMD5 (TAddrLine1))),
																 LEFT.Reason = 'A007' => LEFT.Reason + '_' + TAddrLine1,
																 ''
																 );
				// SELF.ReasonValueForProvider := MAP (LEFT.Reason = 'A007' => TAddrLine1, LEFT.ReasonValueForProvider);
				SELF := LEFT;
				));

    PieChartDs := PROJECT(AttrTable, 
        TRANSFORM(RECORDOF(AttrTable), 
            SELF.ReasonCodeDescription := LEFT.ReasonCodeDescription;
            SELF := LEFT;
        )
    );

    TopAddressesQualifiedLayout := RECORD
        STRING25 AddressKey := AddressAttrsDs.AddressKey;
        INTEGER4 CountProfSuspectIndicator := SUM(GROUP, AddressAttrsDs.IsProfSuspectIndicator);
        INTEGER4 CountProfOutlierIndicator := SUM(GROUP, AddressAttrsDs.IsProfOutlierIndicator);
    END;
    TopAddressesQualifiedTable := TABLE(AddressAttrsDs, TopAddressesQualifiedLayout, AddressKey);

    SuspectAddressVisualization.Layouts.FinalAddressLayout FinalAddressXform(RECORDOF(AddressAttrsDs) L, TopAddressesQualifiedLayout R) := TRANSFORM
        SELF.TopAddressesQualified  := IF(R.CountProfSuspectIndicator > 0 AND R.CountProfOutlierIndicator > 0, '1', '0');
        SELF.AddressScored          := IF(L.AddressScoreRangeGroup > 0, '1', '0'); 
        SELF := L;
    END; 
    FinalAddressDataset := JOIN(AddressAttrsDs, TopAddressesQualifiedTable, LEFT.AddressKey = RIGHT.AddressKey,
        FinalAddressXform(LEFT, RIGHT)
    );

		AddressFlagDs := PROJECT (FinalAddressDataset, TRANSFORM(SuspectAddressVisualization.Layouts.AddressFlagLayout, 
				SELF.Description := MAP (LEFT.Reason IN ['G002','G003','H001','B001','B004','C001','C002','C003','C004','C005','A007','A008'] => '<u>'+ TRIM(LEFT.Description) + '</u>',LEFT.Description);
				AddrLine1				 := STD.Str.CleanSpaces(LEFT.AddressLine1);	
				TAddrLine1			 := TRIM(AddrLine1);
				SELF.HistKey		 := MAP (LEFT.Reason IN ['G002','G003','H001','B001','B004','C001','C002','C003','C004','C005','A008'] => LEFT.Reason + '_' + TRIM(LEFT.ProviderKey), 
																 // LEFT.Reason = 'A007' => LEFT.Reason + '_' + TRIM((STRING)HASH64(HASHMD5 (Addrline1))),
																 LEFT.Reason = 'A007' => LEFT.Reason + '_' + TAddrLine1,
																 ''
																 );
				SELF := LEFT;
		));
		
    ScoredDs := PROJECT(TrimScoredDs, SuspectAddressVisualization.Layouts.ScoredOutRec);
    ScoredDsCCPA := PROJECT(TrimScoredDs, SuspectAddressVisualization.Layouts.ScoredCCPAOutRec);
    ProviderDs := PROJECT(ProviderAttrsDs, SuspectAddressVisualization.Layouts.TopSuspectProviderReasonRecord);
    ProviderDsCCPA := PROJECT(ProviderAttrsDs, SuspectAddressVisualization.Layouts.TopSuspectProviderReasonCCPARecord);

		LOCAL ScoredWithFlagFilterLayout := #IF((BOOLEAN)UseOptOutIndicator) SuspectAddressVisualization.Layouts.ScoredWithFlagFilterCCPALayout #ELSE SuspectAddressVisualization.Layouts.ScoredWithFlagFilterLayout #END;  
  ScoredWithEmptyFlagFilter := PROJECT(TrimScoredDs, TRANSFORM(ScoredWithFlagFilterLayout, SELF.FlagFilter := ''; SELF := LEFT));
    ScoredWithFlagFilterLayout FlagFilterXform(RECORDOF(TrimScoredDs) L, RECORDOF(ProviderAttrsDs) R) := TRANSFORM
        SELF.FlagFilter := R.Description;
        SELF := L;
				SELF := [];
    END; 
    ScoredWithFlagFilter := JOIN(TrimScoredDs, ProviderAttrsDs, LEFT.ProviderKey = RIGHT.ProviderKey AND RIGHT.Description <> '', 
        FlagFilterXform(LEFT, RIGHT)
    );
    ScoredWithAllFlagFilterDs_ := ScoredWithFlagFilter + ScoredWithEmptyFlagFilter;
		ScoredWithAllFlagFilterDs := PROJECT(ScoredWithAllFlagFilterDs_, SuspectAddressVisualization.Layouts.ScoredWithFlagFilterLayout);
		ScoredWithAllFlagFilterDsCCPA := PROJECT(ScoredWithAllFlagFilterDs_, SuspectAddressVisualization.Layouts.ScoredWithFlagFilterCCPALayout);
		
		TrimSpecialtyDs := PROJECT (InDataset, TRANSFORM(SuspectAddressVisualization.Layouts.TrimSpecialtyLayout, 
			SELF.LNPID					:=	LEFT.InLNPID;
			SELF.ProviderSocre	:=	(INTEGER)LEFT.InProfessionalScore;
			SELF.SpecialtyDesc	:= MAP(LEFT.InClientSpecialtyCode <> '' AND LEFT.InClientSpecialtyDescription <> '' => trim(LEFT.InClientSpecialtyDescription), TRIM(LEFT.InProviderSpecialtyDescription)); 				
			SELF.SpecialtyCode	:= MAP(LEFT.InClientSpecialtyCode <> '' AND LEFT.InClientSpecialtyDescription <> '' => LEFT.InClientSpecialtyCode, 'LN:' + LEFT.InProviderSpecialtyCode); 
			// SELF.SpecialtyDesc	:= MAP(LEFT.InClientSpecialtyDescription <> '' => trim(LEFT.InClientSpecialtyDescription) + ':' + trim(LEFT.InClientSpecialtyCode), TRIM(LEFT.InProviderSpecialtyDescription) + ':' + 'LN' + ':' + trim(LEFT.InProviderSpecialtyCode)); 				
			// SELF.SpecialtyCode	:= MAP(LEFT.InClientSpecialtyDescription <> '' => LEFT.InClientSpecialtyCode, LEFT.InProviderSpecialtyCode); 
			SELF.ProviderImpactAmount := LEFT.InProviderImpactAmount;
			)) (SpecialtyCode <> '' and SpecialtyDesc <> '');

		Total_Specialty_Providers := COUNT (TrimSpecialtyDs(LNPID > 0 and SpecialtyDesc <> '' and ProviderSocre > 0))  : INDEPENDENT;
		
		Total_impact_amount 			:= SUM (TrimSpecialtyDs, ProviderImpactAmount) : INDEPENDENT;

		SpecialtyDs := TABLE (TrimSpecialtyDs (LNPID > 0 and SpecialtyDesc <> '' and ProviderSocre > 0), {
				SpecialtyCode, 							
				SpecialtyDesc,
				SpecialtyCount 						:= COUNT(GROUP), 
				SpecialtyProvidersPercent := (COUNT(GROUP, ProviderSocre > 0) / Total_Specialty_Providers) * 100, 
				SpecialtyImpactAmt 				:= (SUM(GROUP, ProviderImpactAmount));
				SpecialtyImpactPercent 		:= (sum(group, ProviderImpactAmount) / Total_impact_amount) * 100}, 
				SpecialtyCode, 							
				SpecialtyDesc,							
				MERGE);

		Max_Specialty_Count := MAX (SpecialtyDs,SpecialtyCount) : INDEPENDENT;

		All_Specialty_Count := SUM (SpecialtyDs,SpecialtyCount) 		: INDEPENDENT;
		All_Specialty_Amt 	:= SUM (SpecialtyDs,SpecialtyImpactAmt) : INDEPENDENT;

		AppendSpecialtyPercent := PROJECT (SpecialtyDs,TRANSFORM (SuspectAddressVisualization.Layouts.SpecialtyLayout, 
				SELF.SpecialtyImpactAmt 				:= LEFT.SpecialtyImpactAmt; 
				SELF.SpecialtyProvidersPercent 	:= LEFT.specialtyproviderspercent; 
				SELF.SpecialtyImpactPercent 		:= LEFT.specialtyimpactpercent; 
				SELF.SpecialtyCode 							:= LEFT.SpecialtyCode;
				SELF.SpecialtyDesc 							:= LEFT.SpecialtyDesc;
				SELF.SpecialtyCount 						:= LEFT.specialtycount; 
				SELF.SpecialtyPercent 					:= ROUND((LEFT.specialtycount * 100) / max_specialty_count)));

		SpecialtyStatsDs := SORT(Dataset ([{'All Specialty',100,All_Specialty_Count,'All Codes',100,All_Specialty_Amt,100}],SuspectAddressVisualization.Layouts.SpecialtyLayout) + AppendSpecialtyPercent, -SpecialtyPercent);

		SuspectAddressVisualization.Layouts.SummaryLayout := RECORD
			UNSIGNED4 TotalClaims 			:= SUM (GROUP, InDataset.InProviderClaimCount);
			UNSIGNED4 TotalImpactClaims := SUM (GROUP, InDataset.InLNPIDImpactClaimCount);
			UNSIGNED4 TotalImpactAmount := SUM (GROUP, InDataset.InProviderImpactAmount);
			UNSIGNED4 TotalPaidAmount 	:= SUM (GROUP, InDataset.InProviderHighPaidAmount);
		END;

		SummaryDS := TABLE (InDataset (InLNPID > 0),SummaryLayout);
		
		
    Resultset := SuspectAddressVisualization.Results(ScoredDs, ProviderDs, FinalAddressDataset, TrimFacilityDs, ScoredWithAllFlagFilterDs, SpecialtyStatsDs, AllSpecialtyDs, ProviderFlagDs, AddressFlagDs, SummaryDS, ScoredDsCCPA, ProviderDsCCPA, ScoredWithAllFlagFilterDsCCPA, AllSpecialtyCCPADs);
    RETURN Resultset;
ENDMACRO;