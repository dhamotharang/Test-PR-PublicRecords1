import lib_workunitservices;
export Msg (string txt):= module

	shared email_addrs1:='9549156711@txt.att.net,jose.bello@lexisnexis.com';
	shared email_addrs2:='9549156711@txt.att.net,jose.bello@lexisnexis.com,aleida.lima@lexisnexis.com,manish.shah@lexisnexis.com';
	shared wid:=txt;

	export good := fileservices.sendemail(email_addrs2,txt+' succeeded',txt+' succeeded');
	export good_alt := fileservices.sendemail(email_addrs2,txt+' succeeded',txt+' succeeded');

	export bad  := fileservices.sendemail(email_addrs1,txt+' failed',txt+' '+FAILMESSAGE);

	d:=lib_workunitservices.WorkunitServices.WorkunitTimings(wid);
	export timing  := ((sum(d,duration)/1000)/60)/60;

	d:=lib_workunitservices.WorkunitServices.workunitmessages(wid);
	export err  := d(severity=2);
end;