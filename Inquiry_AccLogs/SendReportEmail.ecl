import ut;
EXPORT SendReportEmail := module



newrec := { string20 pftype, string8 pver, string1 spray_ready , string20 receive_datetime };


dInqfile := dataset('~thor::in::inquiry_acclogs_filestatus',newrec,flat) (pver = ut.GetDate) ;

newrec1 := record
newrec;
string IsExists := '';
end;

dInqfilesort := sort(project(dInqfile,transform(newrec1,self.IsExists := if ( left.Spray_Ready = 'Y','true','false'),self := left)),pFType,pVer,-Spray_Ready);


newrec1 addexists(dInqfilesort l ,dInqfilesort r) := transform
self.IsExists := if ( l.Spray_Ready = 'Y' or r.Spray_Ready = 'Y', 'true' ,'false');
self := l;
end;

fileStatus := rollup(dInqfilesort,addexists(left,right),pFType,pVer) ( IsExists = 'false') ;

mail_data := record, maxlength(10000000)
	 string mail_text;
  end;


header_ := dataset([{'pftype,  pver,  spray_ready,   receive_datetime, IsExists\n'}],mail_data );

mail_data convertToString(newrec1 L) := TRANSFORM
	  SELF.mail_text := L.pftype + ','+ 
											L.pver + ','+ 
											L.spray_ready + ','+ 
											L.receive_datetime + ','+
											L.IsExists + ','+
											'\n';	                
  END;
  
	stringRecs := header_ + project(fileStatus, convertToString(LEFT));

  mail_data convertToText(mail_data L, mail_data R) := TRANSFORM
	  SELF.mail_text := trim(L.mail_text) + trim(R.mail_text);
  END;

  textDs := ROLLUP(stringRecs, 1=1, convertToText(LEFT, RIGHT));

   attachment := textDs[1].mail_text;
Emailnotification := 'John.Freibaum@lexisnexis.com; Sudhir.Kasavajjala@lexisnexis.com;  Wenhong.Ma@lexisnexis.com; valerie.minnis@lexisnexis.com;jose.bello@lexisnexis.com';  

dblogsemail := map ( count(fileStatus (pftype in [ 'accurint' ,'banko', 'custom' ,'riskwise'  ])) > 0 =>    'Curtis.MacDonald@risk.lexisnexis.com; ' + Emailnotification,
                     count(fileStatus ( pftype in [  'bridger' , 'idm_bls', 'deconfliction' ] )) > 0  => 	'brian.fenlason@lexisnexis.com; ' + Emailnotification,
										 count(fileStatus (pftype =  'batch')) > 0 => 	'roberto.perez@lexisnexis.com; ' + Emailnotification, Emailnotification );


mailsubject := map ( count(fileStatus (pftype in [ 'accurint' ,'banko', 'custom' ,'riskwise'  ])) > 0 =>    'Inquiry Account Logs File Status -- Missing Accounting Log Files'+ut.GetDate,
                     count(fileStatus ( pftype in [  'bridger' , 'idm_bls', 'deconfliction' ] )) > 0  => 	'Inquiry Account Logs File Status -- Missing Bridger/IDM Log Files'+ut.GetDate,
										 count(fileStatus (pftype =  'batch')) > 0 => 	'Inquiry Account Logs File Status -- Missing Batch Files'+ut.GetDate, '' );


mailbody := map ( count(fileStatus (pftype in [ 'accurint' ,'banko', 'custom' ,'riskwise'  ])) > 0 =>    'Please view List of Missing Acc logs Input files --'+ut.GetDate ,
                     count(fileStatus ( pftype in [  'bridger' , 'idm_bls', 'deconfliction' ] )) > 0  => 	'Please view List of Missing Bridger/IDM Log Files'+ut.GetDate,
										 count(fileStatus (pftype =  'batch')) > 0 => 	'Please view List of Missing Batch Files'+ut.GetDate, '' );


mailfile := FileServices.SendEmailAttachData(dblogsemail
																						,mailsubject //subject
																						,mailbody //body
																						,(data)attachment
																						,'text/csv'
																						,'Missingfilereport.csv'
																						,
																						,
																						,'sudhir.kasavajjala@lexisnexis.com'
																						+',jose.bello@lexisnexis.com'
																						+',fernando.incarnacao@lexisnexis.com'
																						);	
																						
mailtoall := FileServices.SendEmail(Emailnotification
                                    ,'Inquiry Account Logs File Status -- 0 Missing Files'+ut.GetDate
																		,'All Inquiry Account Log files sprayed to Logs thor'
																		);
																		
export dall := map ( count(fileStatus (pftype in [ 'accurint' ,'banko', 'custom' ,'riskwise'  ] and spray_ready = 'N' )) > 0  => Sequential ( Output('Sent Email to Curtis and to trigger build is on hold'),mailfile ),
                                count(fileStatus ( pftype in [  'bridger' , 'idm_bls', 'deconfliction' ] and spray_ready = 'N' )) > 0  => Sequential ( Output('Sent Email to Brian and to trigger build is on hold'),mailfile ),
																count(fileStatus (pftype =  'batch' and spray_ready = 'N' )) > 0 => Sequential ( Output('Sent Email to Roberto Perez'),mailfile ),Sequential( notify('Spray Complete','*'),mailtoall) );
																
																
																						


end;
																			

