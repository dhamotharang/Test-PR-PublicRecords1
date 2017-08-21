import relative_regression,ut;
#workunit('name', 'Relatives');

holder1 := header.relatives.relatives1 ;
holder2 := header.relatives.relatives2 ;

ut.MAC_SF_BuildProcess(holder1,'~thor_data400::BASE::Relatives',a,2,,true);

b := relative_regression.BWR_Regression_Relatives;

sequential(	a
			,output(holder2,,'~thor_data400::base::relatives_for_moxie',__compressed__,overwrite)
			,b);