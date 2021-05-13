import _control;
EXPORT Mailing_List(string st = '', string ut = '', string Customer_list = '') := module

	shared Dev_list :=	'Oscar.Barrientos@lexisnexisrisk.com'
										// +	';Sesha.Nookala@lexisnexisrisk.com'
										// +	';John.Santos@lexisnexisrisk.com'
										// +	';Greg.Whitaker@lexisnexisrisk.com'
										;

	shared Data_QA_list := 'John.Santos@lexisnexisrisk.com';
							
	shared TN_UNEMPLOYMENT := 'Jeremy.Riley@lexisnexisrisk.com'
										+	';'+Data_QA_list
										+	';'+Dev_list
										;

	shared Batch_list	:=	Dev_list
										+	';roberto.perez@lexisnexisrisk.com'
										;

	shared Roxie_list :=	'Vishesh.Ved@lexisnexisrisk.com'
										+	';'+Data_QA_list
										+	';'+Dev_list
										;
	shared RinNetwork_list := 'riskintelligencenetwork.support@lexisnexisrisk.com'
										;										
	shared Boca_Ops	:= 	'SupercomputerOps@lexisnexisrisk.com'
										+	';'+Dev_list										
										;
										
	shared Analytics_list	:= 	'Julie.Carmigniani@lexisnexisrisk.com'
											+';Michael.Sterling@lexisnexisrisk.com'
											+	';'+Dev_list										
											;


	shared fn_mail_recipiant(string recipiant) := function
		return		map(
									 recipiant='Validation' => if(_control.ThisEnvironment.Name = 'Prod_Thor',
										map(st = 'TN' => TN_UNEMPLOYMENT, Dev_list),
										map(st = 'TN' => TN_UNEMPLOYMENT, Dev_list))
									,recipiant='Alert'			=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Dev_list,Dev_list)
									,recipiant='Roxie' 			=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Roxie_list,Dev_list)
									,recipiant='RinNetwork'	=> if(_control.ThisEnvironment.Name = 'Prod_Thor',RinNetwork_list,Dev_list)
									,recipiant='BocaOps'		=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Boca_Ops,Dev_list)
									,recipiant='Analytics'	=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Analytics_list,Dev_list)
									,Dev_list
								);
	end;

	export Validation		:= fn_mail_recipiant('Validation');
	export Roxie				:= fn_mail_recipiant('Roxie');
	export Alert				:= fn_mail_recipiant('Alert');
	export BocaOps			:= fn_mail_recipiant('BocaOps');
	export Analytics		:= fn_mail_recipiant('Analytics');
	export RinNetwork		:= fn_mail_recipiant('RinNetwork');

end;