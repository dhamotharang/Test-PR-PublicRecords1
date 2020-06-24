IMPORT FraudgovKEL.KEL_PivotIndexPrep;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);

// output(FraudgovKEL.KEL_PivotIndexPrep.ds_KEL_PivotIndexPrep,, '~gov::otto::pivotentityprofileindex', overwrite, compressed);
output(FraudgovKEL.KEL_PivotIndexPrep.ds_KEL_PivotIndexPrep,NAMED('res1'));