import lib_workunitservices;
export Msg (string txt,string email_addrs):= module
	shared wid:=workunit;

	export good := fileservices.sendemail(email_addrs,regexfind('([^\n]*)',txt,1),txt+'\n\rSee '+wid);

	export bad  := fileservices.sendemail(email_addrs,regexfind('([^\n]*)',txt,1),txt+'\n\rSee '+wid+'\n\r'+FAILMESSAGE);

	d:=lib_workunitservices.WorkunitServices.WorkunitTimings(wid);
	export timing  := ((sum(d,duration)/1000)/60)/60;

	d:=lib_workunitservices.WorkunitServices.workunitmessages(wid);
	export err  := d(severity=2);
end;