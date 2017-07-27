import relative_regression;
#workunit('name', 'Relatives');

holder := header.relatives ;

ut.MAC_SF_BuildProcess(holder,'~thor_data400::BASE::Relatives',a,2);
b := relative_regression.BWR_Regression_Relatives;

sequential(a,b);