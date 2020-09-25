/*
One of the common points of failure of the NAC build is during collision processing
This script can be used the restart the job provided
1) the Base file has been built
2) the collision file has not been built

Be sure to set the version to the correct date
*/
//version := '20200913';
ip := NAC.Constants.LandingZoneServer;
rootDir := NAC.Constants.LandingZonePathBaseEx;

col:=NAC.Mod_Collisions(version[1..6]).NewCollisions;

out_all_col:=	sequential(
							output(col,,'~nac::out::collisions_'+Version,compressed)
							,FileServices.StartSuperFileTransaction()
							,FileServices.AddSuperFile('~nac::out::collisions','~nac::out::collisions_'+Version)

							,FileServices.AddSuperFile('~nac::in::consortium_history','~nac::in::consortium',,true)
							,FileServices.ClearSuperFile('~nac::in::consortium')
							,FileServices.FinishSuperFileTransaction()
							);
							
SampleRecs       :=output(choosen(sample(NAC.Files().Base,1000,1),1000),Named('Base_File_Samples'));
PopulationRpt    :=output(NAC.Mod_stats.Population(),named('Field_Population_Report'),all);
CollisionSummary :=output(NAC.Mod_stats.colPerState(),named('All_Collisions_Count_Summary'),all);
StateBenefitMonth:=output(NAC.Mod_stats.BenefitMonthCnt(),named('State_Benefit_Month_Record_Count'),all);
zDoPopulationStats := nac.fn_Strata(version);

restart := SEQUENTIAL(
								Out_all_col
								,NAC.Mod_despray(version,ip,rootDir).Odespray
								,SampleRecs
								,PopulationRpt
								,CollisionSummary
								,StateBenefitMonth
);						
							

doit := sequential(
		restart,
		NAC_V2.fn_Base2_from_Base1(version)
	);
doit;