import ut;
export proc_bkrollup_stats(  dataset(dateconv.dates) infile,string iter = '1') := module

export string itn := if ( iter = '1','first_iteration','second_iteration');


newrec := record
infile.Pacer_EnteredDate;
infile.EnteredDate;
integer counts := count(group);
end;

grpdates := dedup(sort(table(infile,newrec,Pacer_EnteredDate,EnteredDate,few),-Pacer_EnteredDate,-counts),Pacer_EnteredDate);


rolluprec := record
grpdates.Pacer_EnteredDate;
grpdates.EnteredDate;
grpdates.counts;
string alertflag := '' ;
end;

datescnt := project(grpdates,transform(rolluprec,self := left)) ;

rolluprec dorollup( datescnt  L  ) := transform
self.Pacer_EnteredDate := L.Pacer_EnteredDate;
self.alertflag := if ( L.counts > 15000,'N','Y');
self := L;
END;


export drolled := project(datescnt ,dorollup(LEFT))  ;

toalert := drolled(alertflag = 'Y');

alertset := Set(toalert,Pacer_EnteredDate);

newfilter := banko.dateconv.cnvdatefmt ( Pacer_EnteredDate in alertset ) ;

pdatrec := record
newfilter.Pacer_EnteredDate;
end;

pdatetab := sort(table(newfilter,pdatrec,Pacer_EnteredDate,few),-Pacer_EnteredDate);

mydatestring := record
string pdatestr;
end;

mydatestring concatpnew(pdatetab l) := transform
self.pdatestr := l.Pacer_EnteredDate;
end;

app_pdate := project(pdatetab,concatpnew(LEFT));

mydatestring concatproll(app_pdate l, app_pdate r) := transform
self.pdatestr := l.pdatestr + ',' + r.pdatestr ;
self := l;

end;

conv2pdatestr := rollup(app_pdate,true,concatproll(LEFT,RIGHT));

nfrec := record
newfilter.Pacer_EnteredDate;
newfilter.EnteredDate;
integer counts := count(group);
end;


nftab := dedup(sort(table(newfilter,nfrec,Pacer_EnteredDate,EnteredDate,few),-Pacer_EnteredDate,-Counts),Pacer_EnteredDate);

mystr := record
string mystring;
end;

mystr concat(nftab l) := transform
self.mystring := l.Pacer_EnteredDate + '                       ' + l.EnteredDate + '           ' + l.counts ;
end;

appn2string := project(nftab,concat(LEFT));

mystr toconcat(appn2string l, appn2string r) := transform
self.mystring := l.mystring + '\n' + r.mystring ;
self := l;

end;

conv2str := rollup(appn2string,true,toconcat(LEFT,RIGHT));

string mailsubject := 'ALERT: BKEVENTS PACER DATES :'+ut.GetDate; 
string mailbody := 'ALERT:  Pacer Date  does not have any recent Entered Date containing 15000 or more records!  '+ '\n\n' +
                                       'WORKUNIT  :'+workunit + '\n' +
																			 'Pacer Dates : '+conv2pdatestr[1].pdatestr + '\n' +
                                       '--------------------------------------' + '\n' +
																		   'Pacer_EnteredDate  EnteredDate  Counts' + '\n' + 
																			 '--------------------------------------' + '\n' +
																			  conv2str[1].mystring;

//Output(drolled,named('Max_Pacer_EnteredDate_Counts'+itn));

export outmacro := if(count(drolled(alertflag = 'Y')) > 0,Sequential(/*Output(drolled(alertflag = 'Y'),named('Pacer_EnteredDate_Alert_'+itn)),*/
                                               fileservices.SendEmail(Banko.Email_Notification_list.BuildSuccess, mailsubject,mailbody
																							 )),
																		Output('All_PacerDate_Counts_are_valid'));
																		
end;

