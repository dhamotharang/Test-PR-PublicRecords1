import ut,STD,Scrubs_BK_Events;
EXPORT proc_BKevents_stats(string filedate) := module
//For the Entered Date-Pacer Date combination

datefilter := dedup(sort(Banko.dateconv.cnvdatefmt(	EnteredDate = filedate[1..8] and STD.Date.IsValidDate((integer) Pacer_EnteredDate[1..8]) and Pacer_EnteredDate[1..8] <= filedate ),-Pacer_EnteredDate),Pacer_EnteredDate);


listpdates := topn(datefilter ,10,-Pacer_EnteredDate) : independent;

listpdatesnew := listpdates(Pacer_EnteredDate = (string)((unsigned)ut.getDateOffset(-10,filedate[1..8])));



pdatecnt := Banko.dateconv.cnvdatefmt( Pacer_EnteredDate in Set(listpdatesnew,Pacer_EnteredDate));

first_iter := Sequential(Output('Checking pacer date counts processed today...'),Banko.proc_bkrollup_stats(pdatecnt,'1').outmacro);

//Get Valid Pacer Dates
missingrec := record
string8 valid_Pacer_Dates;
end;

//emptyds := dataset([],missingrec);

missingrec titerate(  listpdates L,integer c) := transform
self.valid_Pacer_Dates := (string)((unsigned)ut.getDateOffset(-c,filedate[1..8]));
end;

pdatesvalid := project(listpdates,titerate(LEFT,counter));
// Pacer Dates not in valid dates
pnewdates := pdatesvalid( valid_Pacer_Dates not in Set(listpdatesnew,Pacer_EnteredDate));


pacerfilterbase := dateconv.cnvdatefmt(Pacer_EnteredDate in Set(pnewdates,valid_Pacer_Dates));


											
//send last 10 pacer date counts 

d1 := Banko.proc_bkrollup_stats(pdatecnt,'1').drolled;
d2 := Banko.proc_bkrollup_stats(pacerfilterbase,'2').drolled;

d3 := sort((d1 + d2),-Pacer_EnteredDate);

pdatecounts := output(d3,named('Last_10_Pacer_Date_Counts'));

mynewstr := record
string mystring;
end;


mynewstr concatnew(d3 l) := transform
self.mystring := l.Pacer_EnteredDate + '                      ' + l.EnteredDate + '          ' + l.counts ;
end;

appn3string := project(d3,concatnew(LEFT));

mynewstr toconcatnew(appn3string l, appn3string r) := transform
self.mystring := l.mystring + '\n' + r.mystring ;
end;

conv2newstr := rollup(appn3string,true,toconcatnew(LEFT,RIGHT));

string mailsubject := 'BKEVENTS PACER DATES :'+ut.GetDate; 
string mailbody := 'Last 10 Pacer Date Counts : ' + '\n\n' +
                    'Pacer_EnteredDate  EnteredDate  Counts' + '\n' + conv2newstr[1].mystring;
										
//Send missing Pacer Dates										
pmissingdates := pdatesvalid( valid_Pacer_Dates not in Set(d3,Pacer_EnteredDate));

mydates := record
string mystring;
end;

pick_file := if ( count(pacerfilterbase) > 0,pmissingdates,pnewdates);

mydates validdates(pick_file l) := transform
self.mystring := l.valid_Pacer_Dates  ;
end;

appndate := project(pick_file,validdates(LEFT));

mydates validdatesnew(appndate l, appndate r) := transform
self.mystring := l.mystring + '\n' + r.mystring ;
end;

conv2datestr := rollup(appndate,true,validdatesnew(LEFT,RIGHT));


string mailsubjectnew := 'BKEVENTS PACER DATES :'+ut.GetDate; 
string mailbodynew := 'Missing Pacer Dates not in Banko Production base file : ' + '\n\n' + conv2datestr[1].mystring;


second_iter := if ( count ( pacerfilterbase ) > 0  , Sequential(Output('Checking pacer date counts not processed today...'),
                                                                  fileservices.SendEmail(Banko.Email_Notification_list.BuildFailure, mailsubject,mailbody),
                                                                  Banko.proc_bkrollup_stats(pacerfilterbase,'2').outmacro
																												          ),Output('...'));
                      
											
											
missing_dates   :=	if ( count ( pick_file ) > 0 and ut.Weekday((integer) ut.GetDate) <> 'SUNDAY', Sequential(Output( pick_file,named('Missing_Pacer_Dates')),
											                                     fileservices.SendEmail(Banko.Email_Notification_list.BuildSuccess, mailsubjectnew,mailbodynew))
																													 ,Output('All_Pacer_Dates_exists'));
																													 


export out_all := Sequential(
	first_iter,
	second_iter,
	pdatecounts,
	missing_dates,
	Scrubs_BK_Events.Fn_RunScrubs(filedate)
): success(fileservices.sendemail(Banko.Email_Notification_list.BuildFailure,'BANKO PACER DATES ALERT SUCCESS WU - '+workunit,'SUCCESS !!!.Please view Last 10 Pacer Alet Stats for any anamolies')),
		                                                                failure(fileservices.sendemail(Banko.Email_Notification_list.BuildFailure,'BANKO PACER DATES ALERT FAILED WU - '+workunit,'Please rerun PACER DATE alert code -- Banko.proc_BKevents_stats(filedate).out_all seperately'));
end;





