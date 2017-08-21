#workunit('name', 'Filter out Bad State Corporations');
#workunit('protect',true);
#workunit('priority','high');
#workunit('priority',11);
#option ('activitiesPerCpp', 50);
#OPTION('AllowedClusters','thor400_44,thor400_20');
#OPTION('AllowAutoSwitchQueue','1');
#OPTION('multiplePersistInstances',FALSE);

import tools,Orbit_report;

string	pversion		:=	'20151120a';
psourceSet					:= 	['PA'];
	
dsCurrentCorp		:=	corp2.Files().AID.Corp.qa;
dsPrevCorp			:=	corp2.Files().AID.Corp.father;
count(dsCurrentCorp(corp_state_origin not in psourceSet));
count(dsPrevCorp(corp_state_origin in psourceSet));

dsCurrentCont		:=	corp2.Files().AID.Cont.qa;
dsPrevCont			:=	corp2.Files().AID.Cont.father;
count(dsCurrentCont(corp_state_origin not in psourceSet));
count(dsPrevCont(corp_state_origin in psourceSet));

dsCurrentStock	:=	corp2.Files().base.stock.qa;
dsPrevStock			:=	corp2.Files().base.stock.father;
count(dsCurrentStock(corp_state_origin not in psourceSet));
count(dsPrevStock(corp_state_origin in psourceSet));

dsCurrentEvent	:=	corp2.Files().base.events.qa;
dsPrevEvent			:=	corp2.Files().base.events.father;
count(dsCurrentEvent(corp_state_origin not in psourceSet));
count(dsPrevEvent(corp_state_origin in psourceSet));

dsCurrentAR			:=	corp2.Files().base.ar.qa;
dsPrevAR				:=	corp2.Files().base.ar.father;
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

dsCorp					:=	project(MergeCorp,TRANSFORM(corp2.Layout_Corporate_Direct_Corp_Base,SELF := LEFT;));
dsCont					:=	project(MergeCont,TRANSFORM(corp2.Layout_Corporate_Direct_Cont_Base,SELF := LEFT;));									
										
Orbit_report.Corp_Stats(getretval);
											
sequential(
		parallel(
					output (MergeCorp,,	'~thor_data400::base::corp2::' + pversion +'::corp_aid',overwrite,__compressed__),
					output (MergeCont,,	'~thor_data400::base::corp2::' + pversion +'::cont_aid',overwrite,__compressed__),
					output (MergeStock,,'~thor_data400::base::corp2::' + pversion +'::stock',overwrite,__compressed__),
					output (MergeEvent,,'~thor_data400::base::corp2::' + pversion +'::event',overwrite,__compressed__),
					output (MergeAR,,		'~thor_data400::base::corp2::' + pversion +'::ar',overwrite,__compressed__)
						),
		parallel(
					output (dsCorp,,		'~thor_data400::base::corp2::' + pversion +'::corp',overwrite,__compressed__),
					output (dsCont,,		'~thor_data400::base::corp2::' + pversion +'::cont',overwrite,__compressed__)				
						),						
		parallel(
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp_aid'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::cont_aid'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::stock'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::event'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::ar'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::built::cont'),					
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp_aid'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::cont_aid'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::stock'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::event'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::ar'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp'),
					FileServices.clearsuperfile('~thor_data400::base::corp2::qa::cont')				
						),
		parallel(
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp_aid',
														'~thor_data400::base::corp2::' + pversion +'::corp_aid'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::cont_aid',
														'~thor_data400::base::corp2::' + pversion +'::cont_aid'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::stock',
														'~thor_data400::base::corp2::' + pversion +'::stock'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::event',
														'~thor_data400::base::corp2::' + pversion +'::event'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::ar',
														'~thor_data400::base::corp2::' + pversion +'::ar'
													 ),	
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp',
														'~thor_data400::base::corp2::' + pversion +'::corp'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::cont',
														'~thor_data400::base::corp2::' + pversion +'::cont'
													 ),														 
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp_aid',
														'~thor_data400::base::corp2::' + pversion +'::corp_aid'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::cont_aid',
														'~thor_data400::base::corp2::' + pversion +'::cont_aid'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::stock',
														'~thor_data400::base::corp2::' + pversion +'::stock'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::event',
														'~thor_data400::base::corp2::' + pversion +'::event'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::ar',
														'~thor_data400::base::corp2::' + pversion +'::ar'
													 ),														 
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp',
														'~thor_data400::base::corp2::' + pversion +'::corp'
													 ),
					Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::cont',
														'~thor_data400::base::corp2::' + pversion +'::cont'
													 )											 
						)
				);			