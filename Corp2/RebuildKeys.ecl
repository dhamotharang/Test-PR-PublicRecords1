#workunit('name', 'Yogurt:Rebuild Keys Corporations');
#workunit('protect',true);
#workunit('priority','high');
#workunit('priority',11);
#option ('activitiesPerCpp', 50);
#OPTION('multiplePersistInstances',FALSE);

import tools,Orbit_report;

string	pversion	:=	'20171208a';
										
Orbit_report.Corp_Stats(getretval);
											
sequential(
					corp2.Proc_Build_Roxie_Keys(pversion).Build_All
					,corp2.Promote_Built_To_QA
					,corp2.strata_population_stats(pversion).all_stats
					,corp2.Proc_Build_Boolean_Keys(pversion)
					,corp2.QA_records(corp2.files().base.corp.qa)
					,Corp2.Stats_Coverage(pversion)
					,getretval
				);			
				