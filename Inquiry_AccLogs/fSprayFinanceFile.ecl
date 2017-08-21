#WORKUNIT('name','Spray Finance Master to New Logs Thor')

version := ut.GetDate;

filename := SORT(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/inquiry_data_01/finance',,FALSE)(REGEXFIND('txt$', name, nocase)), -modified)[1].name;

fexists := COUNT((fileservices.superfilecontents('~thor100_21::in::mbs::finance_master') + fileservices.superfilecontents('~thor100_21::in::mbs::finance_master_father'))
								(name = 'thor100_21::in::mbs::'+version+'::finance_master')) > 0;

spray := fileservices.SprayVariable(_control.IPAddress.bctlpedata10, '/data/inquiry_data_01/finance/'+filename, , , , , 'thor100_21', '~thor100_21::in::mbs::'+version+'::finance_master', , , , FALSE, TRUE, TRUE); 
																		
addsuper := fileservices.promotesuperfilelist(['~thor100_21::in::mbs::finance_master', '~thor100_21::in::mbs::finance_master_father'], '~thor100_21::in::mbs::'+version+'::finance_master');

removefile := fileservices.DeleteExternalFile(_control.IPAddress.bctlpedata10, '/data/inquiry_data_01/finance/'+filename); 

IF(~fexists and filename <> '', SEQUENTIAL(spray, addsuper, removefile));
