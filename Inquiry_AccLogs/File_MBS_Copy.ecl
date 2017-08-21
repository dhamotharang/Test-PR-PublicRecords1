IMPORT ut;
EXPORT File_MBS_Copy (string param_version = ut.GetDate):= FUNCTION
applysubset:=dataset(ut.foreign_prod+'thor100_21::out::inquiry_acclogs::file_mbs::' + param_version,Inquiry_Acclogs.Layout_MBS, thor);
RETURN sequential(output(applysubset,,'~thor100_21::out::inquiry_acclogs::file_mbs::' + param_version, overwrite, __compressed__),
											 fileservices.startsuperfiletransaction(),
											 
												 fileservices.clearsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_grandfather'),
												 fileservices.addsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_grandfather', '~thor100_21::out::inquiry_acclogs::file_mbs_father',,true),

												 fileservices.clearsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_father'),
												 fileservices.addsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_father', '~thor100_21::out::inquiry_acclogs::file_mbs',,true),
												 
												 fileservices.clearsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs'),
												 fileservices.addsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs', '~thor100_21::out::inquiry_acclogs::file_mbs::' + param_version),
												 
											 fileservices.finishsuperfiletransaction();
											 output('MBS File Check', named('Quality_Check')),
											 output(table(applysubset, {vertical, cnt := count(group)}, vertical, few), all, named('Verticals')),
											 output(table(applysubset, {industry, cnt := count(group)}, industry, few), all, named('Industries')),
											 output(table(applysubset, {use, cnt := count(group)}, use, few), all, named('Uses')),
											 output(table(applysubset, {product_id, cnt := count(group)}, product_id, few), all, named('Product_IDs'))
											 );
END;															