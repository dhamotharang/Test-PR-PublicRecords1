import bankruptcyv2, ut;

export Mac_Spray_BK_Input_Files_CourtLookup(Courtfile,filedate,group_name = '') := macro

#uniquename(spray_Court)
#uniquename(super_Court)
#uniquename(sourceIP)
#uniquename(dbefore)
#uniquename(dafter)
#uniquename(trecs)
#uniquename(dafter)
#uniquename(diff)
#uniquename(buildkeys)
#uniquename(updatedops)
#uniquename(strata)


%sourceIP% := _control.IPAddress.bctlpedata10;

%spray_Court% := FileServices.SprayVariable(%sourceIP%,Courtfile,,,,,group_name,
						'~thor_data400::base::bankruptcyv3::'+filedate+'::courts',-1,,,true,true);

%super_Court% := sequential(if(fileservices.GetSuperFileSubCount('~thor_data400::base::bankruptcyv3::courts_delete')>4,
							   fileservices.clearsuperfile('~thor_data400::base::bankruptcyv3::courts_delete',true),output(''));
							
							FileServices.StartSuperFileTransaction(),
                            fileservices.swapsuperfile('~thor_data400::base::bankruptcyv3::courts_delete','~thor_data400::base::bankruptcyv3::courts'),
							fileservices.clearsuperfile('~thor_data400::base::bankruptcyv3::courts'),
							fileservices.addsuperfile('~thor_data400::base::bankruptcyv3::courts','~thor_data400::base::bankruptcyv3::'+filedate+'::courts'),
							FileServices.FinishSuperFileTransaction());
							
%buildkeys% := BankruptcyV3.proc_build_court_key(filedate);

%updatedops% := if(ut.weekday((integer)filedate) <> 'SATURDAY' and 
				 ut.weekday((integer)filedate) <> 'SUNDAY',
				 RoxieKeyBuild.updateversion('BKCourtKeys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',,'N|F'),output('No_dops_update_on_weekends'));

/////////////////////////////////////////////////////////////////////////////////
//Diff Files:
/*(BK Court Lookup file is received daily but does not always have new information - 
We want to build keys only when the input file has changes.) */
/////////////////////////////////////////////////////////////////////////////////					
%dbefore% := dataset('~thor_data400::base::bankruptcyv3::courts',
							{bankruptcyv3.layout_courts, unsigned8 RecPos{virtual(fileposition)}},
										                 CSV(SEPARATOR(['\t']), quote('"'),TERMINATOR(['\n','\r\n'])));

%dafter% := dataset('~thor_data400::base::bankruptcyv3::'+filedate+'::courts',
							{bankruptcyv3.layout_courts, unsigned8 RecPos{virtual(fileposition)}},
														CSV(SEPARATOR(['\t']), quote('"'),TERMINATOR(['\n','\r\n'])));

%dafter% %trecs%(%dafter% L, %dbefore% R) := transform
self := L;
end;


%diff% := join(distribute(%dafter%,hash(C3courtID,
cfiled,
state,
address1,
address2,
zip,
phone,
fax,
district,
courtID,
div,
city,
hoganID,
court,
moxie_court,
boca_court,
active))
, distribute(%dbefore%,hash(C3courtID,
cfiled,
state,
address1,
address2,
zip,
phone,
fax,
district,
courtID,
div,
city,
hoganID,
court,
moxie_court,
boca_court,
active)),

left.C3courtID=right.C3courtID and
left.cfiled=right.cfiled and
left.state=right.state and
left.address1=right.address1 and
left.address2=right.address2 and
left.zip=right.zip and
left.phone=right.phone and
left.fax=right.fax and
left.district=right.district and
left.courtID=right.courtID and
left.div=right.div and
left.city=right.city and
left.hoganID=right.hoganID and
left.court=right.court and
left.moxie_court=right.moxie_court and
left.boca_court=right.boca_court and
left.active=right.active, %trecs%(left,right),left only,local);

 
sequential(
	if(fileservices.superfileexists('~thor_data400::base::bankruptcyv3::courts'),
		%spray_Court%,
		sequential(fileservices.createsuperfile('~thor_data400::base::bankruptcyv3::courts'),%spray_Court%)),
				
	output(%diff%,named('QASampleData')),
	
	if(count(%diff%)>0,
		sequential(%super_Court%,%buildkeys%,%updatedops%),
			
		parallel(output('No changes found when comparing thor_data400::base::bankruptcyv3::'+filedate+'::courts with '+
				fileservices.GetSuperFileSubName('~thor_data400::base::bankruptcyv3::courts',1)),
				FileServices.sendemail('cbrodeur@seisint.com'
										,'Bankruptcyv3 Court Lookup'
										,'No changes found when comparing Bankruptcy Court Lookup Files '
										+ thorlib.WUID()))
		  )
		  );


endmacro;	

	