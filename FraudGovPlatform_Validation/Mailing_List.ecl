EXPORT Mailing_List(string st = '', string ut = '', string Customer_list = '') := module

	shared Dev_list :=			'Oscar.Barrientos@lexisnexisrisk.com'
									//	+	';Sesha.Nookala@lexisnexisrisk.com'
										;

	shared Roxie_list := 	Dev_list
										+	';Jose.Bello@lexisnexisrisk.com'	
										+	';Vishesh.Ved@lexisnexisrisk.com'
										+	';greg.whitaker@lexisnexisrisk.com'
										+	';Swathi.Ankala@lexisnexisrisk.com'
										;
										
	shared DOPS_list := Dev_list;

	shared Boca_Ops	:= Dev_list;

	/* ******************************************************************************************************* */
	/* ADD CUSTOMER'S LISTS BEYOND THIS LINE																															  */
	/* ******************************************************************************************************* */
	shared list_248283671 := Dev_list;
										
	shared fn_mail_recipiant(string recipiant) := function
		return		map(
									 recipiant='Validation' => Customer_list
									,recipiant='Alert'		=> Dev_list
									,recipiant='Roxie' 		=> Roxie_list
									,recipiant='BocaOps'	=> Boca_Ops
									,Dev_list
								);
	end;

	export Validation		:= fn_mail_recipiant('Validation');
	export Roxie				:= fn_mail_recipiant('Roxie');
	export Alert				:= fn_mail_recipiant('Alert');
	export BocaOps			:= fn_mail_recipiant('BocaOps');

end;