IMPORT ML;
//NaiveBayes classifier
trainer:= ML.Classify.NaiveBayes();

// Monk Dataset - Discrete dataset 124 instances x 6 attributes + class
MonkData:= ML.Tests.Explanatory.MonkDS.Train_Data;
ML.ToField(MonkData, fullmds, id);
full_mds:=PROJECT(fullmds, TRANSFORM(ML.Types.DiscreteField, SELF:= LEFT));
indepDataD:= full_mds(number>1);
depDataD := full_mds(number=1);
// Learning Phase
D_Model:= trainer.LearnD(indepDataD, depDataD);
dmodel:= trainer.Model(D_model);
// Classification Phase
D_classDist:= trainer.ClassProbDistribD(indepDataD, D_Model); // Class Probalility Distribution
D_results:= trainer.ClassifyD(indepDataD, D_Model);
// Performance Metrics
D_compare:= ML.Classify.Compare(depDataD, D_results);   // Comparing results with original class
AUC_D0:= ML.Classify.AUC_ROC(D_classDist, 0, depDataD); // Area under ROC Curve for class "0"
AUC_D1:= ML.Classify.AUC_ROC(D_classDist, 1, depDataD); // Area under ROC Curve for class "1"
// OUPUTS
OUTPUT(MonkData, NAMED('MonkData'), ALL);
OUTPUT(SORT(dmodel, id), ALL, NAMED('DiscModel'));
OUTPUT(D_classDist, ALL, NAMED('DisClassDist'));
OUTPUT(D_results, NAMED('DiscClassifResults'), ALL);
OUTPUT(SORT(D_compare.CrossAssignments, c_actual, c_modeled), NAMED('DiscCrossAssig'), ALL); // Confusion Matrix
OUTPUT(AUC_D0, ALL, NAMED('AUC_D0'));
OUTPUT(AUC_D1, ALL, NAMED('AUC_D1'));
OUTPUT(D_compare.RecallByClass, NAMED('RecallByClassD'));
OUTPUT(D_compare.PrecisionByClass, NAMED('PrecByClassD'));
OUTPUT(SORT(D_compare.FP_Rate_ByClass, classifier, c_modeled), NAMED('FPR_ByClassD'));
OUTPUT(D_compare.Accuracy, NAMED('AccurD'));

// Iris Dataset -- Continuous dataset 150 instances x 4 attributes + class
irisData := ML.Tests.Explanatory.irisds;
ML.AppendID(irisData, id, t_irisData);
ML.ToField(t_irisData, full_lds);
//OUTPUT(full_lds_Map,ALL, NAMED('DatasetFieldMap'));
indepDataC:= full_lds(number<5);
depDataC:= ML.Discretize.ByRounding(full_lds(number=5));
// Learning Phase
C_Model:= trainer.LearnC(indepDataC, depDataC);
cmodel:= trainer.ModelC(C_model);
//Classification Phase
C_classDist:= trainer.ClassProbDistribC(indepDataC, C_Model); // Class Probalility Distribution
C_results:= trainer.ClassifyC(indepDataC, C_Model);
//Performance Metrics
C_compare:= ML.Classify.Compare(depDataC, C_results);   // Comparing results with original class
AUC_C0:= ML.Classify.AUC_ROC(C_classDist, 0, depDataC); // Area under ROC Curve for class "0"
AUC_C1:= ML.Classify.AUC_ROC(C_classDist, 1, depDataC); // Area under ROC Curve for class "1"
AUC_C2:= ML.Classify.AUC_ROC(C_classDist, 2, depDataC); // Area under ROC Curve for class "2"
// OUPUTS
OUTPUT(t_irisData, NAMED('irisData'), ALL);
OUTPUT(SORT(cmodel, id), ALL, NAMED('ContModel'));
OUTPUT(C_classDist, ALL, NAMED('ContClassDist'));
OUTPUT(C_results, NAMED('ContClassifResults'), ALL);
OUTPUT(SORT(C_compare.CrossAssignments, c_actual, c_modeled), NAMED('ContCrossAssig'), ALL); // Confusion Matrix
OUTPUT(AUC_C0, ALL, NAMED('AUC_C0'));
OUTPUT(AUC_C1, ALL, NAMED('AUC_C1'));
OUTPUT(AUC_C2, ALL, NAMED('AUC_C2'));
OUTPUT(C_compare.RecallByClass, NAMED('RecallByClassC'));
OUTPUT(C_compare.PrecisionByClass, NAMED('PrecByClassC'));
OUTPUT(SORT(C_compare.FP_Rate_ByClass, classifier, c_modeled), NAMED('FPR_ByClassC'));
OUTPUT(C_compare.Accuracy, NAMED('AccurC'));
 