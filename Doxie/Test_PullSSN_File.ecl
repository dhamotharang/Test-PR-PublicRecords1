new := doxie.File_pullSSN;

leMailTarget := 'jwindle@seisint.com;jtolbert@seisint.com;kgummadi@seisint.com';

fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);


isAssn := LENGTH(TRIM(new.ssn))=9 AND LENGTH(TRIM(StringLib.StringFilter(new.ssn,'0123456789'),ALL)) = 9;
isAdid := LENGTH(TRIM(new.ssn))=12 AND LENGTH(TRIM(StringLib.StringFilter(new.ssn,'0123456789'),ALL)) = 12;

one := output(new(isAssn),{string12 myssn := '\'' + TRIM(ssn) + '\','}, all,named('SSNs'));
two := output(new(isAdid),{string13 mydid := (integer)ssn + ','}, all,named('DIDs'));

send_mail := fSendMail('Pull SSN updates','New SSNs and DIDs:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

export Test_PullSSN_File := sequential(one,two,send_mail);