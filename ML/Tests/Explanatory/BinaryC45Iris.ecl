IMPORT ML;
IMPORT ML.Types AS Types;

dsRecord := RECORD
  Types.t_FieldReal a1 ;
  Types.t_FieldReal a2 ;
  Types.t_FieldReal a3 ;
  Types.t_FieldReal a4 ;
  Types.t_FieldReal class;
END;
c45_irisDS := DATASET([
{5.1,3.5,1.4,0.2,0},
{4.9,3.0,1.4,0.2,0},
{4.7,3.2,1.3,0.2,0},
{4.6,3.1,1.5,0.2,0},
{5.0,3.6,1.4,0.2,0},
{5.4,3.9,1.7,0.4,0},
{4.6,3.4,1.4,0.3,0},
{5.0,3.4,1.5,0.2,0},
{4.4,2.9,1.4,0.2,0},
{4.9,3.1,1.5,0.1,0},
{5.4,3.7,1.5,0.2,0},
{4.8,3.4,1.6,0.2,0},
{4.8,3.0,1.4,0.1,0},
{4.3,3.0,1.1,0.1,0},
{5.8,4.0,1.2,0.2,0},
{5.7,4.4,1.5,0.4,0},
{5.4,3.9,1.3,0.4,0},
{5.1,3.5,1.4,0.3,0},
{5.7,3.8,1.7,0.3,0},
{5.1,3.8,1.5,0.3,0},
{5.4,3.4,1.7,0.2,0},
{5.1,3.7,1.5,0.4,0},
{4.6,3.6,1.0,0.2,0},
{5.1,3.3,1.7,0.5,0},
{4.8,3.4,1.9,0.2,0},
{5.0,3.0,1.6,0.2,0},
{5.0,3.4,1.6,0.4,0},
{5.2,3.5,1.5,0.2,0},
{5.2,3.4,1.4,0.2,0},
{4.7,3.2,1.6,0.2,0},
{4.8,3.1,1.6,0.2,0},
{5.4,3.4,1.5,0.4,0},
{5.2,4.1,1.5,0.1,0},
{5.5,4.2,1.4,0.2,0},
{4.9,3.1,1.5,0.1,0},
{5.0,3.2,1.2,0.2,0},
{5.5,3.5,1.3,0.2,0},
{4.9,3.1,1.5,0.1,0},
{4.4,3.0,1.3,0.2,0},
{5.1,3.4,1.5,0.2,0},
{5.0,3.5,1.3,0.3,0},
{4.5,2.3,1.3,0.3,0},
{4.4,3.2,1.3,0.2,0},
{5.0,3.5,1.6,0.6,0},
{5.1,3.8,1.9,0.4,0},
{4.8,3.0,1.4,0.3,0},
{5.1,3.8,1.6,0.2,0},
{4.6,3.2,1.4,0.2,0},
{5.3,3.7,1.5,0.2,0},
{5.0,3.3,1.4,0.2,0},
{7.0,3.2,4.7,1.4,1},
{6.4,3.2,4.5,1.5,1},
{6.9,3.1,4.9,1.5,1},
{5.5,2.3,4.0,1.3,1},
{6.5,2.8,4.6,1.5,1},
{5.7,2.8,4.5,1.3,1},
{6.3,3.3,4.7,1.6,1},
{4.9,2.4,3.3,1.0,1},
{6.6,2.9,4.6,1.3,1},
{5.2,2.7,3.9,1.4,1},
{5.0,2.0,3.5,1.0,1},
{5.9,3.0,4.2,1.5,1},
{6.0,2.2,4.0,1.0,1},
{6.1,2.9,4.7,1.4,1},
{5.6,2.9,3.6,1.3,1},
{6.7,3.1,4.4,1.4,1},
{5.6,3.0,4.5,1.5,1},
{5.8,2.7,4.1,1.0,1},
{6.2,2.2,4.5,1.5,1},
{5.6,2.5,3.9,1.1,1},
{5.9,3.2,4.8,1.8,1},
{6.1,2.8,4.0,1.3,1},
{6.3,2.5,4.9,1.5,1},
{6.1,2.8,4.7,1.2,1},
{6.4,2.9,4.3,1.3,1},
{6.6,3.0,4.4,1.4,1},
{6.8,2.8,4.8,1.4,1},
{6.7,3.0,5.0,1.7,1},
{6.0,2.9,4.5,1.5,1},
{5.7,2.6,3.5,1.0,1},
{5.5,2.4,3.8,1.1,1},
{5.5,2.4,3.7,1.0,1},
{5.8,2.7,3.9,1.2,1},
{6.0,2.7,5.1,1.6,1},
{5.4,3.0,4.5,1.5,1},
{6.0,3.4,4.5,1.6,1},
{6.7,3.1,4.7,1.5,1},
{6.3,2.3,4.4,1.3,1},
{5.6,3.0,4.1,1.3,1},
{5.5,2.5,4.0,1.3,1},
{5.5,2.6,4.4,1.2,1},
{6.1,3.0,4.6,1.4,1},
{5.8,2.6,4.0,1.2,1},
{5.0,2.3,3.3,1.0,1},
{5.6,2.7,4.2,1.3,1},
{5.7,3.0,4.2,1.2,1},
{5.7,2.9,4.2,1.3,1},
{6.2,2.9,4.3,1.3,1},
{5.1,2.5,3.0,1.1,1},
{5.7,2.8,4.1,1.3,1},
{6.3,3.3,6.0,2.5,2},
{5.8,2.7,5.1,1.9,2},
{7.1,3.0,5.9,2.1,2},
{6.3,2.9,5.6,1.8,2},
{6.5,3.0,5.8,2.2,2},
{7.6,3.0,6.6,2.1,2},
{4.9,2.5,4.5,1.7,2},
{7.3,2.9,6.3,1.8,2},
{6.7,2.5,5.8,1.8,2},
{7.2,3.6,6.1,2.5,2},
{6.5,3.2,5.1,2.0,2},
{6.4,2.7,5.3,1.9,2},
{6.8,3.0,5.5,2.1,2},
{5.7,2.5,5.0,2.0,2},
{5.8,2.8,5.1,2.4,2},
{6.4,3.2,5.3,2.3,2},
{6.5,3.0,5.5,1.8,2},
{7.7,3.8,6.7,2.2,2},
{7.7,2.6,6.9,2.3,2},
{6.0,2.2,5.0,1.5,2},
{6.9,3.2,5.7,2.3,2},
{5.6,2.8,4.9,2.0,2},
{7.7,2.8,6.7,2.0,2},
{6.3,2.7,4.9,1.8,2},
{6.7,3.3,5.7,2.1,2},
{7.2,3.2,6.0,1.8,2},
{6.2,2.8,4.8,1.8,2},
{6.1,3.0,4.9,1.8,2},
{6.4,2.8,5.6,2.1,2},
{7.2,3.0,5.8,1.6,2},
{7.4,2.8,6.1,1.9,2},
{7.9,3.8,6.4,2.0,2},
{6.4,2.8,5.6,2.2,2},
{6.3,2.8,5.1,1.5,2},
{6.1,2.6,5.6,1.4,2},
{7.7,3.0,6.1,2.3,2},
{6.3,3.4,5.6,2.4,2},
{6.4,3.1,5.5,1.8,2},
{6.0,3.0,4.8,1.8,2},
{6.9,3.1,5.4,2.1,2},
{6.7,3.1,5.6,2.4,2},
{6.9,3.1,5.1,2.3,2},
{5.8,2.7,5.1,1.9,2},
{6.8,3.2,5.9,2.3,2},
{6.7,3.3,5.7,2.5,2},
{6.7,3.0,5.2,2.3,2},
{6.3,2.5,5.0,1.9,2},
{6.5,3.0,5.2,2.0,2},
{6.2,3.4,5.4,2.3,2},
{5.9,3.0,5.1,1.8,2}], dsRecord);

OUTPUT(c45_irisDS, NAMED('c45_irisDS'), ALL);
ML.AppendID(c45_irisDS, id, iris_data);
ML.ToField(iris_Data, full_ds);
OUTPUT(full_ds, NAMED('full_ds'), ALL);
indepData:= full_ds(number<5);
depData:= ML.Discretize.ByRounding(full_ds(number=5));
minNumObj:= 2;    maxLevel := 100;
// Learning Phase
trainer1:= ML.Classify.DecisionTree.C45Binary(minNumObj, maxLevel); 
tmod:= trainer1.LearnC(indepData, depData);
tmodel:= trainer1.Model(tmod);
OUTPUT(SORT(tmodel, -node_id, -new_node_id), ALL, NAMED('TreeModel'));

// Classification Phase
results1:= trainer1.ClassifyC(indepData, tmod);
OUTPUT(results1, NAMED('ClassificationResults'), ALL);
results11:= ML.Classify.Compare(PROJECT(depData, TRANSFORM(ML.Types.DiscreteField,SELF.number:=1, SELF:=LEFT)), results1);
OUTPUT(SORT(results11.CrossAssignments, c_actual, c_modeled), NAMED('CrossAssig1'), ALL);
OUTPUT(results11.RecallByClass, NAMED('RecallByClass1'));
OUTPUT(results11.PrecisionByClass, NAMED('PrecisionByClass1'));
OUTPUT(results11.Accuracy, NAMED('Accur1'));
