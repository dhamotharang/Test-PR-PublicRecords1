import Roxiekeybuild,ut;
export BWR_Build_NAC (string version,string ip,string rootDir) := function

NewInput:=
   nothor(
						 FileServices.GetSuperFileSubCount('~nac::in::al::temp') > 0
					or FileServices.GetSuperFileSubCount('~nac::in::fl::temp') > 0
					or FileServices.GetSuperFileSubCount('~nac::in::ga::temp') > 0
					or FileServices.GetSuperFileSubCount('~nac::in::la::temp') > 0
					or FileServices.GetSuperFileSubCount('~nac::in::ms::temp') > 0
					)
					;

DoBuild := NAC.Build_All(version,ip,rootDir);

SampleRecs       :=output(choosen(sample(NAC.Files().Base,1000,1),1000),Named('Base_File_Samples'));
PopulationRpt    :=output(NAC.Mod_stats.Population(),named('Field_Population_Report'),all);
CollisionSummary :=output(NAC.Mod_stats.colPerState(),named('All_Collisions_Count_Summary'),all);
StateBenefitMonth:=output(NAC.Mod_stats.BenefitMonthCnt(),named('State_Benefit_Month_Record_Count'),all);
zDoPopulationStats := fn_Strata(version);

alertList:=NAC.Mailing_List('').Dev2;

return if(NewInput
			,sequential(DoBuild
								,SampleRecs
								,PopulationRpt
								,CollisionSummary
								,StateBenefitMonth
/*								,if (ut.Weekday((integer)version[1..8]) = 'SATURDAY'
										,Roxiekeybuild.updateversion( datasetname:='NacKeys',uversion:=version[1..8],email_t:=alertList,inenvment:= 'N',auto_pkg:= 'Y',isprodready:='Y')
										,Roxiekeybuild.updateversion( datasetname:='NacKeys',uversion:=version[1..8],email_t:=alertList,inenvment:= 'N')
										)*/
								//,zDoPopulationStats
								)
			,sequential(NAC.Send_Email().Drupal
								,output('No NAC Contributory Files Received.  No Collisions report will be produced.'
												,named('No_NAC_Contributory_Files_Received'))
								)
			)
			;

 END
 ;