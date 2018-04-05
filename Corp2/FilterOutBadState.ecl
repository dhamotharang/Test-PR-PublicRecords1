#workunit('name', 'Filter out Bad State Corporations');
#workunit('protect',true);
#workunit('priority','high');
#workunit('priority',11);
#option ('activitiesPerCpp', 50);
#OPTION('multiplePersistInstances',FALSE);

import tools,Orbit_report;

string	pversion		:=	'20171208a';
psourceSet					:= 	['IN'];
	
dsCurrentCorp		:=	corp2.Files().Base_xtnd.corp.QA;
dsPrevCorp			:=	corp2.Files().Base_xtnd.corp.Father;
count(dsCurrentCorp(corp_state_origin not in psourceSet));
count(dsPrevCorp(corp_state_origin in psourceSet));

dsCurrentCont		:=	corp2.Files().Base_xtnd.cont.QA;
dsPrevCont			:=	corp2.Files().Base_xtnd.cont.father;
count(dsCurrentCont(corp_state_origin not in psourceSet));
count(dsPrevCont(corp_state_origin in psourceSet));

dsCurrentStock	:=	corp2.Files().Base_xtnd.stock.QA;
dsPrevStock			:=	corp2.Files().Base_xtnd.stock.father;
count(dsCurrentStock(corp_state_origin not in psourceSet));
count(dsPrevStock(corp_state_origin in psourceSet));

dsCurrentEvent	:=	corp2.Files().Base_xtnd.events.QA;
dsPrevEvent			:=	corp2.Files().Base_xtnd.events.father;
count(dsCurrentEvent(corp_state_origin not in psourceSet));
count(dsPrevEvent(corp_state_origin in psourceSet));

dsCurrentAR			:=	corp2.Files().Base_xtnd.ar.QA;
dsPrevAR				:=	corp2.Files().Base_xtnd.ar.father;
count(dsCurrentAR(corp_state_origin not in psourceSet));
count(dsPrevAR(corp_state_origin in psourceSet));

MergeCorp				:= 	dsCurrentCorp	(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) not in psourceSet) +
										dsPrevCorp		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) in psourceSet);
count(MergeCorp);									
										
MergeCont				:=	dsCurrentCont	(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) not in psourceSet) +
										dsPrevCont		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) in psourceSet);
count(MergeCont);										
										
MergeStock			:=	dsCurrentStock(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) not in psourceSet) +
										dsPrevStock		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) in psourceSet);										
count(MergeStock);										
										
MergeEvent			:=	dsCurrentEvent(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) not in psourceSet) +
										dsPrevEvent		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) in psourceSet);	
count(MergeEvent);										
										
MergeAR					:=	dsCurrentAR		(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) not in psourceSet) +
										dsPrevAR			( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) in psourceSet);											
count(MergeAR);	
								
sequential(
		parallel(
					output (MergeCorp,,	'~thor_data400::base::corp2::' + pversion +'::corp_xtnd',	overwrite,__compressed__),
					output (MergeCont,,	'~thor_data400::base::corp2::' + pversion +'::cont_xtnd',	overwrite,__compressed__),
					output (MergeStock,,'~thor_data400::base::corp2::' + pversion +'::stock_xtnd',overwrite,__compressed__),
					output (MergeEvent,,'~thor_data400::base::corp2::' + pversion +'::event_xtnd',overwrite,__compressed__),
					output (MergeAR,,		'~thor_data400::base::corp2::' + pversion +'::ar_xtnd',		overwrite,__compressed__)
						),
		parallel(
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::cont_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::stock_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::event_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::ar_xtnd'),		
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::cont_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::stock_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::event_xtnd'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::ar_xtnd')	
						),
		parallel(
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::corp_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::cont_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::cont_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::stock_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::stock_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::event_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::event_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::ar_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::ar_xtnd'
													 ),														 
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::corp_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::cont_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::cont_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::stock_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::stock_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::event_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::event_xtnd'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::ar_xtnd',
														'~thor_data400::base::corp2::' + pversion +'::ar_xtnd'
													 )										 
						)
				);			