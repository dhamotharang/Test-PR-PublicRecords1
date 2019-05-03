﻿import _control;
EXPORT Mailing_List(string st = '', string ut = '', string Customer_list = '') := module

	shared Dev_list :=	'Oscar.Barrientos@lexisnexisrisk.com'
										+	';Sesha.Nookala@lexisnexisrisk.com'
										;
	shared Batch_list	:=	Dev_list
										+	';roberto.perez@lexisnexisrisk.com'
										;
	shared Roxie_list := 	Dev_list
										+	';riskintelligencenetwork.support@lexisnexisrisk.com'	
										;
										
	shared Boca_Ops	:= 	'SupercomputerOps@lexisnexisrisk.com'
										+	';'+Dev_list										
										;


	shared fn_mail_recipiant(string recipiant) := function
		return		map(
									 recipiant='Validation' 	=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Dev_list,Dev_list)
									,recipiant='Alert'		=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Dev_list,Dev_list)
									,recipiant='Roxie' 		=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Dev_list,Dev_list)
									,recipiant='BocaOps'	=> if(_control.ThisEnvironment.Name = 'Prod_Thor',Dev_list,Dev_list)
									,Dev_list
								);
	end;

	export Validation		:= fn_mail_recipiant('Validation');
	export Roxie				:= fn_mail_recipiant('Roxie');
	export Alert				:= fn_mail_recipiant('Alert');
	export BocaOps			:= fn_mail_recipiant('BocaOps');

end;