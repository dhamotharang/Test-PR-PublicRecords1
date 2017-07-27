import _control;
InfoUSA.fSprayInputFiles(
													_control.IPAddress.edata10
												,'/prod_data_build_13/eval_data/infousa/abius/out'
												,'abius_*.d00'
												,'abius'				// could be 'abius', 'idexec', 'fbn', 'deadco'
												,'thor_data400'
												);
InfoUSA.fSprayInputFiles(
													_control.IPAddress.edata10
												,'/prod_data_build_13/eval_data/infousa/idexec/out'
												,'idexec_*.d00'
												,'idexec'				// could be 'abius', 'idexec', 'fbn', 'deadco'
												,'thor_data400'
												);
InfoUSA.fSprayInputFiles(
													_control.IPAddress.edata10
												,'/prod_data_build_13/eval_data/infousa/dead_companies/out'
												,'deadco_*.d00'
												,'deadco'				// could be 'abius', 'idexec', 'fbn', 'deadco'
												,'thor_data400'
												);
InfoUSA.fSprayInputFiles(
													_control.IPAddress.edata10
												,'/prod_data_build_13/eval_data/infousa/fbn/out'
												,'fbn_*.d00'
												,'fbn'				// could be 'abius', 'idexec', 'fbn', 'deadco'
												,'thor_data400'
												);												