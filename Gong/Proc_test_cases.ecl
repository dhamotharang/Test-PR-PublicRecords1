import doxie,header,autokey;
a := pull(doxie.Key_Header_Phone)((integer)p3>100);

rm_score := dataset('fake',autokey.Layout_Phone,flat);

b := pull(INDEX(rm_score, {rm_score}, '~thor_data400::key::header.phone_prod'))((integer)p3>100);

rec := record
 string10 phone;
end;

rec getnew(a L, b R) := transform
 self.phone := l.p3+l.p7;
end;

rec getold(b L, a R) := transform
 self.phone := l.p3+l.p7;
end;

number_new := join(a,b,left.p3=right.p3 and left.p7=right.p7,getnew(left,right),hash,left only);
number_old := join(b,a,left.p3=right.p3 and left.p7=right.p7,getold(left,right),hash,left only);

one := output(choosen(number_new,100),named('newNumber'));
two := output(choosen(number_old,100),named('oldNumber'));

send_mail := fileservices.sendemail('RQuerido@seisint.com','Roxie test cases','Finished Weekly Roxie Build \r\n \r\n ' +
			  'Results and test cases:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

export Proc_test_cases := parallel(one,two,send_mail);