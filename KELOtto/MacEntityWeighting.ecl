import KELOtto;

#option('multiplePersistInstances', false);


setentities := ['_011010860301',
'_01148780838129',
'_01167704694016',
'_01169473864634',
'_01189966519808',
'_01190240626940',
'_01191006874560',
'_01192778685013',
'_01193954116871',
'_01194129205573',
'_01194214495764',
'_01194277817139',
'_01194399873691',
'_01194492308913',
'_01194492597463',
'_01194536967214',
'_01194661090725',
'_01195002095491',
'_01195233310647',
'_011956742669',
'_01198281214',
'_012408887237',
'_01361095100',
'_0142530064143',
'_01449444212',
'_015323391079',
'_01605972853',
'_016628291246',
'_0178828513669',
'_01810203556',
'_01962347522',
'_091141456528',
'_091145872212',
'_091205958879',
'_091288860871',
'_091309632825',
'_091405037521',
'_09158777835',
'_091602364971',
'_09172570328',
'_091747927892',
'_091812742937',
'_091835781937',
'_091920669559',
'_092038033691',
'_092062300198',
'_092063509902',
'_09211380954',
'_092252444631',
'_092318741181',
'_092371887884',
'_092623208329',
'_092699521780',
'_092699521780',
'_092766313875',
'_092771529110',
'_092866445907',
'_092890833716',
'_093047695517',
'_09314226984',
'_093267141553',
'_093387558123',
'_093443661019',
'_093582536567',
'_09363302454',
'_093651535979',
'_093888773168',
'_093925607472',
'_093950980112',
'_09480444290'];

//d1 := KELOtto.KelFiles.EntityStats;

d1 := DATASET('~temp::deleteme::entitystats', RECORDOF(KELOtto.KelFiles.EntityStats), THOR);

WeightingChart := DATASET([
{9, 'deceased_person_count_', '', 0, 2, 1, 1, 'Low Risk Deceased Identity Count' },
{9, 'deceased_person_count_', '', 3, 5, 2, 3, 'Medium Risk Deceased Identity Count'},
{9, 'deceased_person_count_', '', 6, 0, 2, 3, 'High Risk Deceased Identity Count'},

{9, 'cl_identity_count_', '', 0, 2, 1, 1, 'Low Risk Deceased Identity Count' },
{9, 'cl_identity_count_', '', 3, 5, 2, 6, 'Medium Risk Deceased Identity Count'},
{9, 'cl_identity_count_', '', 6, 0, 3, 10, 'High Risk Deceased Identity Count'},

{9, 'cl_impact_weight_', '', 0, 30, 1, 1, 'Cluster has a low impact weight' }, 
{9, 'cl_impact_weight_', '', 31, 70, 2, 3, 'Cluster has a medium impact weight'}, 
{9, 'cl_impact_weight_', '', 71, 100, 3, 5, 'Cluster has a high impact weight'}

], {INTEGER EntityType, STRING Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, INTEGER Weighting, STRING UiDescription});

// Weighting this is what needs to be in the index for the entity stats...
WeightedResult := JOIN(d1, WeightingChart, 
                         LEFT.Field=RIGHT.Field AND (INTEGER)LEFT.entity_context_uid_[2..3] = RIGHT.EntityType AND
                         (
                           (
                             RIGHT.Value != '' AND LEFT.Value = RIGHT.Value
                           )
                           OR
                           (
                             (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
                             (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
                           )
                         ), TRANSFORM({RECORDOF(LEFT), RIGHT.Weighting}, 
                            SELF.Weighting := RIGHT.Weighting, 
                            SELF.RiskLevel := RIGHT.RiskLevel, 
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => RIGHT.UiDescription, LEFT.Label);
                            SELF.field := LEFT.field +
                                          MAP(TRIM(RIGHT.Value) != '' =>  '_' + RIGHT.Value, MAP(RIGHT.Low > 0 => '_' + (STRING)RIGHT.Low, '') + MAP(RIGHT.High > 0 => '_' + (STRING)RIGHT.High, ''));
                            SELF := LEFT), LOOKUP, LEFT OUTER);
                         
output(WeightedResult);

// Score Breakdown                         
ScoreBreakdownAggregate := TABLE(WeightedResult(customer_id_>0), 
                        {customer_id_, industry_type_, entity_context_uid_, indicatortype, indicatordescription, 
                         INTEGER RiskLevel := 0 /* percentile */, populationtype := 'Element', 
                         INTEGER Value := SUM(GROUP, Weighting)}, customer_id_, industry_type_, entity_context_uid_, indicatortype, indicatordescription, MERGE);
                         
output(ScoreBreakdownAggregate);

ScoreBreakdownAggregateWithPercentile := 
          PROJECT(
            KELOtto.Functions.CalculatePercentile(ScoreBreakdownAggregate, 'customer_id_, industry_type_, indicatortype, indicatordescription', Value, 'CustomerPercentile', 'CustomerQuartileRank'), 
            TRANSFORM(RECORDOF(LEFT) AND NOT [hashid], self.RiskLevel := LEFT.CustomerPercentile, SELF := LEFT)) : PERSIST('~temp::deleteme43', EXPIRE(7));

// join risk level back to the original 

output(ScoreBreakdownAggregateWithPercentile);

// customer averages by customer_id, industry_type, indicatortype, indicatordescription  populationtype = 'Average'

CustomerScoreBreakdownAverages := TABLE(ScoreBreakdownAggregate, 
                        {customer_id_, industry_type_, indicatortype, indicatordescription, 
                         INTEGER RiskLevel := 0 /* percentile */, STRING populationtype := 'Average', 
                         INTEGER Value := AVE(GROUP, Value)}, customer_id_, industry_type_, indicatortype, indicatordescription, MERGE);

output(CustomerScoreBreakdownAverages);                         


ScoresPrep := TABLE(ScoreBreakdownAggregateWithPercentile,
             {customer_id_, industry_type_, entity_context_uid_, Score := SUM(GROUP, CustomerPercentile)}, customer_id_, industry_type_, entity_context_uid_, MERGE);
             
output(ScoresPrep);

Scores := KELOtto.Functions.CalculatePercentile(ScoresPrep, 'customer_id_, industry_type_', Score, 'ScorePercentile', 'ScoreQuartileRank');

// NB !! Scores have to be joined back to ENTITY STATS to fill in the score value..

output(Scores);




                         
//EXPORT MacEntityWeighting := 'todo';