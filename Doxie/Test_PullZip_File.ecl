new := doxie.File_pullzip;

leMailTarget := 'avenkatachalam@seisint.com';

fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);


isAzip := LENGTH(TRIM(new.zip))=5 and length(trim(StringLib.StringFilter(new.zip,'0123456789'),ALL))=5;

one := output(new(isAzip),{string12 myzip := '\'' + TRIM(zip) + '\','}, all,named('Zip'));

send_mail := fSendMail('Pull Zip updates','New Zips:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

export Test_PullZip_File := sequential(one,send_mail);