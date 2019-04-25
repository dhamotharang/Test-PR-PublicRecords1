f := dataset('~dvstemp::out::flgo_test', riskprocessing.Layout_FLGOFLG1, csv(quote('"')));

dup_layout := record
	riskprocessing.Layout_FLGOFLG1;
	unsigned duplicateSSNs := 0;
	unsigned duplicatePhones := 0;
	unsigned duplicateAccounts := 0;
end;

dup_layout t_f(f le) := transform
	self := le;
	self := [];
end;

test := project(f, t_f(left));

lfs := riskprocessing.Layout_Field_Summary;

dup_layout count_accounts(dup_layout le, dup_layout rt) := transform
	self.duplicateAccounts := if(le.input.account=rt.input.account, le.duplicateAccounts + 1, le.duplicateAccounts);
	self := rt;
end;

da := rollup(sort(test,input.account), true,count_accounts(left,right));

dup_layout count_phones(dup_layout le, dup_layout rt) := transform
	self.duplicatePhones := if(le.input.hphone=rt.input.hphone, le.duplicatePhones + 1, le.duplicatePhones);
	self := rt;
end;
dp := rollup(sort(test,input.hphone), true,count_phones(left,right));

dup_layout count_ssns(dup_layout le, dup_layout rt) := transform
	self.duplicateSSNs := if(le.input.socs=rt.input.socs, le.duplicateSSNs + 1, le.duplicateSSNs);
	self := rt;
end;
ds := rollup(sort(test,input.socs), true,count_ssns(left,right));

lfs tf2(dup_layout le) := transform
	self := le;
	self := [];
end;
dup_counts := project(da + dp + ds, tf2(left));
output(dup_counts, named('dup_counts'));

// the 0,0,0 line is the dup_counts that were calculated above
flag_counts := dataset([{
				count(test(input.account='')), count(test(input.first='')), count(test(input.last='')), count(test(input.addr='')), 
				count(test(input.city='')), count(test(input.state='')), count(test(input.zip='')), count(test(input.hphone='')), count(test(input.socs='')), 
				count(test(input.dob='')), count(test(input.wphone='')),count(test(input.drlc='')), count(test(input.drlcstate='')),
				0,0,0,
				count(test(flags.phonevalflag='0')), count(test(flags.phonevalflag='1')), count(test(flags.phonevalflag='2')), count(test(flags.phonevalflag='3')), count(test(flags.phonevalflag='4')),
				count(test(flags.hriskphoneflag='0')), count(test(flags.hriskphoneflag='1')), count(test(flags.hriskphoneflag='2')), count(test(flags.hriskphoneflag='3')),
				count(test(flags.hriskphoneflag='4')), count(test(flags.hriskphoneflag='5')), count(test(flags.hriskphoneflag='6')), count(test(flags.hriskphoneflag='7')),			
				count(test(flags.phonezipflag='0')), count(test(flags.phonezipflag='1')),count(test(flags.phonezipflag='2'))	
				// todo:  add the rest of the fields to tabulate here...
				}], riskprocessing.Layout_Field_Summary);
				
output(flag_counts, named('flag_counts'));

lfs roll_counts(lfs le, lfs rt) := transform
	self.emtpyaccount := if(le.emtpyaccount>rt.emtpyaccount,le.emtpyaccount,rt.emtpyaccount);
	self.emptyfirst := if(le.emptyfirst>rt.emptyfirst,le.emptyfirst,rt.emptyfirst);
	self.emptylast := if(le.emptylast>rt.emptylast,le.emptylast,rt.emptylast);
	self.emptyaddr := if(le.emptyaddr>rt.emptyaddr,le.emptyaddr,rt.emptyaddr);
	self.emptycity := if(le.emptycity>rt.emptycity,le.emptycity,rt.emptycity);
	self.emptystate := if(le.emptystate>rt.emptystate,le.emptystate,rt.emptystate);
	self.emptyzip := if(le.emptyzip>rt.emptyzip,le.emptyzip,rt.emptyzip);
	self.emptyhphone := if(le.emptyhphone>rt.emptyhphone,le.emptyhphone,rt.emptyhphone);
	self.emptysocs := if(le.emptysocs>rt.emptysocs,le.emptysocs,rt.emptysocs);
	self.emptydob := if(le.emptydob>rt.emptydob,le.emptydob,rt.emptydob);
	self.emptywphone := if(le.emptywphone>rt.emptywphone,le.emptywphone,rt.emptywphone);
	self.emptydrlc := if(le.emptydrlc>rt.emptydrlc,le.emptydrlc,rt.emptydrlc);
	self.emptydrlcstate := if(le.emptydrlcstate>rt.emptydrlcstate,le.emptydrlcstate,rt.emptydrlcstate);
	self.duplicateSSNs := if(le.duplicateSSNs>rt.duplicateSSNs,le.duplicateSSNs,rt.duplicateSSNs);
	self.duplicatePhones := if(le.duplicatePhones>rt.duplicatePhones,le.duplicatePhones,rt.duplicatePhones);
	self.duplicateAccounts := if(le.duplicateAccounts>rt.duplicateAccounts,le.duplicateAccounts,rt.duplicateAccounts);
	self.invalidphone := if(le.invalidphone>rt.invalidphone,le.invalidphone,rt.invalidphone);
	self.validbusinessphone := if(le.validbusinessphone>rt.validbusinessphone,le.validbusinessphone,rt.validbusinessphone);
	self.validresidentialphone := if(le.validresidentialphone>rt.validresidentialphone,le.validresidentialphone,rt.validresidentialphone);
	self.validphoneunknown := if(le.validphoneunknown>rt.validphoneunknown,le.validphoneunknown,rt.validphoneunknown);
	self.phoneval_invalidformat := if(le.phoneval_invalidformat>rt.phoneval_invalidformat,le.phoneval_invalidformat,rt.phoneval_invalidformat);
	self.notriskyphone := if(le.notriskyphone>rt.notriskyphone,le.notriskyphone,rt.notriskyphone);
	self.cellphone := if(le.cellphone>rt.cellphone,le.cellphone,rt.cellphone);
	self.pager := if(le.pager>rt.pager,le.pager,rt.pager);
	self.pcs := if(le.pcs>rt.pcs,le.pcs,rt.pcs);
	self.othernonpots := if(le.othernonpots>rt.othernonpots,le.othernonpots,rt.othernonpots);
	self.disconnnect := if(le.disconnnect>rt.disconnnect,le.disconnnect,rt.disconnnect);
	self.highriskphone := if(le.highriskphone>rt.highriskphone,le.highriskphone,rt.highriskphone);
	self.phonerisk_invalidformat := if(le.phonerisk_invalidformat>rt.phonerisk_invalidformat,le.phonerisk_invalidformat,rt.phonerisk_invalidformat);
	self.goodphonezip := if(le.goodphonezip>rt.goodphonezip,le.goodphonezip,rt.goodphonezip);
	self.phonezipmismatch := if(le.phonezipmismatch>rt.phonezipmismatch,le.phonezipmismatch,rt.phonezipmismatch);
	self.phonezip_invalidformat := if(le.phonezip_invalidformat>rt.phonezip_invalidformat,le.phonezip_invalidformat,rt.phonezip_invalidformat);
	
	// todo:  add the rest of the fields to tabulate
end;

final := rollup(dup_counts + flag_counts, true, roll_counts(left, right));
output(final, named('field_summary_report'));
output(final,, '~dvstemp::out::field_summary_report', csv(quote('"')));




/*
counts := count(test);
phnrisk_layout := record
	phonerisk_value := test.flags.hriskphoneflag;
	phonerisk_count := count(group);
end;

phnval_layout := record
	phoneval_value := test.flags.phonevalflag;
	phoneval_count := count(group);
end;

phoneriskflag := table(test, phnrisk_layout, flags.hriskphoneflag, counts);
phonevalidationflag := table(test, phnval_layout, flags.phonevalflag, counts);
output(phoneriskflag, named('phoneriskflag'));
output(phonevalidationflag, named('phonevalidationflag'));
*/