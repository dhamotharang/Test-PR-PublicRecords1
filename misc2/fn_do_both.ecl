export fn_do_both(string vdate,boolean ignore_compare=true)  := FUNCTION

input_file1 						:= 'ssn_sup.txt';
dest_file_qualifier1 		:= '::transfer';
do1 := fn_do_one('1',input_file1,dest_file_qualifier1,vdate,ignore_compare);

input_file2 						:= 'ssnunsigned_sup.txt';
dest_file_qualifier2 		:= '';
do2 := fn_do_one('2',input_file2,dest_file_qualifier2,vdate,ignore_compare);

email_results 	:= fileservices.sendemail(
												'skasavajjala@seisint.com',
												'misc2:ssn_sup:'+vdate+
												', ignore_compare:'+ignore_compare+
												', wu: '+workunit,
												'');	
												
do_it := sequential(do1,do2,email_results);

return do_it;

end;