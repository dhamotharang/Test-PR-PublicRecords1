import ut, phonesplus;

export Proc_Build_Stats(string filedate) := function

/* Distribute files and trim */

	tnow  := dedup(distribute(table(infutorcid.File_InfutorCID_Base(~historical), {phone}), hash(phone)), phone, local);
	then  := dataset('~thor_data400::base::infutorcid_father', infutorCID.Layout_InfutorCID_Base, thor)(~historical);
	tthen := dedup(distribute(table(then, {phone}), hash(phone)), phone, local);

/* Join for infutorcid new and old stats */

	pstatus := join(tnow, tthen, right.phone = left.phone, transform({string phone, string status}, 
																	self.status := if(left.phone = right.phone, 'S', 
																						if(left.phone <> '', 'N','L'));
																	self.phone := if(left.phone <> '', left.phone, right.phone)), full outer, local);
/* create stats for infutorcid new and old  */

BaseCt := ut.intWithCommas(count(tnow));

S := ut.intWithCommas(count(pstatus(status = 'S')));
pcS := (decimal10_2)(count(pstatus(status = 'S'))/count(tnow) * 100);

L := ut.intWithCommas(count(pstatus(status = 'L')));
pcL := (decimal10_2)(count(pstatus(status = 'L'))/count(tnow) * 100);

N := ut.intWithCommas(count(pstatus(status = 'N')));
pcN := (decimal10_2)(count(pstatus(status = 'N'))/count(tnow) * 100);

/* distribute pplus and trim, also find version number for pplus */
/* though pplus is distributed before, the stats generated without redistributing are incorrect */

	pplus := dedup(distribute(table(phonesplus.file_phonesplus_base(vendor <> 'IC'), {cellphone}), hash(cellphone)), cellphone, local);
	subname := FileServices.GetSuperFileSubName('~thor_data400::base::phonesplus', 1);
	getppver := if(subname[stringlib.stringfind(subname, '_20',1)+1..] = '', '\\(Check Base File for Version\\)', 
					subname[stringlib.stringfind(subname, '_20',1)+1..]);
	
/* join to pplus to find new and old */

	ppstatus := join(tnow(phone <> ''), pplus(cellphone <> ''), right.cellphone = left.phone, transform({string phone, string status}, 
																	self.status := if(left.phone = right.cellphone, 'S', 
																						if(left.phone <> '', 'N',''));
																	self.phone := if(left.phone <> '', left.phone, right.cellphone)), left outer, keep(1), local);

/* create stats for infutor cid and pplus */

ppS := ut.intWithCommas(count(ppstatus(status = 'S')));
pcppS := (decimal10_2)(count(ppstatus(status = 'S'))/count(tnow) * 100);

ppN := ut.intWithCommas(count(ppstatus(status = 'N')));
pcppN := (decimal10_2)(count(ppstatus(status = 'N'))/count(tnow) * 100);



wustats := parallel(
	output(BaseCt, named('infutorcid_total_base_phones'));
	output(S + ' - ' + pcs, named('infutorcid_same_phones'));
	output(L + ' - ' + pcl, named('infutorcid_lost_phones'));
	output(N + ' - ' + pcn, named('infutorcid_new_phones'));
	output(ppS + ' - ' + pcpps, named('same_phones_for_pplus'));
	output(ppN + ' - ' + pcppn, named('new_phones_for_pplus')));


email_body := 
	'View Workunit:                                        ' + thorlib.wuid() + '\n\n' +
	'Counts and Percentages (count/infutorcid base)' + '\n\n' +

	'Base File Count:                                      ' + BaseCt + '\t 100.00%\n' +
	'SAME - Current phones found in Father:                ' + S + '\t ' + pcs + '%\n' +
	'NEW  - Current phones not found in Father:            ' + N + '\t ' + pcn + '%\n' +
	'LOST - Phones in Father and no longer Current:	      '  + L + '\t ' + pcl + '%\n\n' +
	
	'Phones Plus Version '+ getppver +' - Phone Compare:\n' +
	'SAME     - Current phones in Other PPlus Sources and Infutor CID:       ' + ppS + '\t ' + pcpps + '%\n' +
	'CID Only - Current phones from Infutor CID not in Other PPlus Sources:  ' + ppN + '\t ' + pcppn + '%\n\n\n' +
	
	' * No regard to threshold or any type of flagging was taken into consideration when creating stats.\n'+
	' * For Phones Plus comparison, all IC vendor phones are filtered out.\n'+
	' * Current phones are all phones received on the most current full file refresh from Infutor CID.\n'+
	' * To find historical phones, search Infutor CID base file for historical flag "true".\n';
										
Phone_Compare := 
	sequential(	wustats, 
				FileServices.SendEmail(
			/* EMAIL RECIPIENTS */		'cecelie.guyton@lexisnexis.com,john.freibaum@lexisnexis.com, angela.herzberg@lexisnexis.com, jason.trost@lexisnexis.com, jill.luber@lexisnexis.com', 
			/* SUBJECT */				'InfutorCID Version ' + filedate + ' - Phone Compare',
			/* Email Body */			'InfutorCID must provide 2% new phones to stay in compliance with contract\n\n\n' + email_body));

return Phone_Compare;
end;

