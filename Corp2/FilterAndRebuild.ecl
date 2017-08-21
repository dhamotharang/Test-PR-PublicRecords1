import tools,Orbit_report;

export FilterAndRebuild(
	 string								pversion						=		''
	,string								pFolderDate					=		'' 
	,string								psource							= 	''
	,string								pGeneration					= 	'1'
	,string								ptype								= 	''
) :=
module
	
dsCurrentCorp		:=	corp2.files().aid.corp.qa;
dsPrevCorp			:=	if (pGeneration	='2',corp2.files().aid.corp.grandfather,corp2.files().aid.corp.father);

dsCurrentCont		:=	corp2.files().aid.cont.qa;
dsPrevCont			:=	if (pGeneration	='2',corp2.files().aid.cont.grandfather,corp2.files().aid.cont.father);

dsCurrentStock	:=	corp2.files().base.stock.qa;
dsPrevStock			:=	if (pGeneration	='2',corp2.files().base.stock.grandfather,corp2.files().base.stock.father);

dsCurrentEvent	:=	corp2.files().base.events.qa;
dsPrevEvent			:=	if (pGeneration	='2',corp2.files().base.events.grandfather,corp2.files().base.events.father);

dsCurrentAR			:=	corp2.files().base.ar.qa;
dsPrevAR				:=	if (pGeneration	='2',corp2.files().base.ar.grandfather,corp2.files().base.ar.father);

MergeCorp				:= 	dsCurrentCorp	(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) != pSource) +
										dsPrevCorp		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) = pSource);
										
MergeCont				:=	dsCurrentCont	(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) != pSource) +
										dsPrevCont		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) = pSource);
										
MergeStock			:=	dsCurrentStock(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) != pSource) +
										dsPrevStock		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) = pSource);										
										
MergeEvent			:=	dsCurrentEvent(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) != pSource) +
										dsPrevEvent		( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) = pSource);	
										
MergeAR					:=	dsCurrentAR		(	trim(stringlib.StringToUpperCase(corp_state_origin),left,right) != pSource) +
										dsPrevAR			( trim(stringlib.StringToUpperCase(corp_state_origin),left,right) = pSource);											
										
Orbit_report.Corp_Stats(getretval);
											
export fullbuild := sequential(
		parallel(
					// Change versions here
					output (MergeCorp,,	'~thor_data400::base::corp2::' + pversion +'::corp_aid',overwrite,__compressed__),
					output (MergeCont,,	'~thor_data400::base::corp2::' + pversion +'::cont_aid',overwrite,__compressed__),
					output (MergeStock,,'~thor_data400::base::corp2::' + pversion +'::stock',overwrite,__compressed__),
					output (MergeEvent,,'~thor_data400::base::corp2::' + pversion +'::event',overwrite,__compressed__),
					output (MergeAR,,		'~thor_data400::base::corp2::' + pversion +'::ar',overwrite,__compressed__)
						),
		parallel(
					FileServices.ClearSuperFile('~thor_data400::base::corp2::built::corp_aid'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::built::cont_aid'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::built::stock'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::built::event'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::built::ar'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::qa::corp_aid'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::qa::cont_aid'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::qa::stock'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::qa::event'),
					FileServices.ClearSuperFile('~thor_data400::base::corp2::qa::ar')					
						),
		parallel(
					// Change versions here
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
													 )														 
						),
					corp2.Proc_Build_Roxie_Keys(pversion).Build_All
					,strata_population_stats(pversion).all_stats
					,Proc_Build_Boolean_Keys(pversion)
					,QA_records(files().base.corp.qa)
					,Corp2.Stats_Coverage(pversion)
					,getretval
				);
				
end;				