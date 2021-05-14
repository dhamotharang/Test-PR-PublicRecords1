EXPORT Spray_CA_All_Available(string filedate) := module

import VersionControl,_Control,lib_thorlib;


	string		pServer			:= _Control.IPAddress.bctlpedata11  ;
	string		pDir				:= '/data/hds_4/prolic/ca/all_available/'+filedate;
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::CA::all_available::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::CA::all_available::' + pkeyword ;

	spry_all_raw:=DATASET([

	{pServer,pDir,'BarberingAndCosmetology*Data*.csv'			,0 ,lfile('breeze_1'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'BehavioralSciences*Data*.csv'			,0 ,lfile('breeze_2'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'BoardOfOptometry*Data*.csv'			,0 ,lfile('breeze_3'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'DBHygieneCommittee*Data*.csv'			,0 ,lfile('breeze_4'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'DentalBoard*Data*.csv'			,0 ,lfile('breeze_5'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'MedicalBoard*Data*.csv'			,0 ,lfile('breeze_6'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'NaturopathicMedicine*Data*.csv'			,0 ,lfile('breeze_7'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'OccupationalTherapy*Data*.csv'			,0 ,lfile('breeze_8'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'OsteopathicMedical*Data*.csv'			,0 ,lfile('breeze_9'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'PhysicalTherapy*Data*.csv'			,0 ,lfile('breeze_10'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'PhysicianAssistant*Data*.csv'			,0 ,lfile('breeze_11'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'PodiatricMedical*Data*.csv'			,0 ,lfile('breeze_12'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'PodiatricMedicine*Data*.csv'			,0 ,lfile('breeze_13'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Psychology*Data*.csv'			,0 ,lfile('breeze_14'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'RegisteredNursing*Data*.csv'			,0 ,lfile('breeze_15'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'RespiratoryCare*Data*.csv'			,0 ,lfile('breeze_16'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'VeterinaryMedicineAndRegTechExamCommittee*Data*.csv'			,0 ,lfile('breeze_17'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'VocationalNursingAndPsychiatricTechnicians*Data*.csv'			,0 ,lfile('breeze_18'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},		
		 {pServer,pDir,'Accountancy*Data*.csv'			,0 ,lfile('legacy_1'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Architects*Data*.csv'			,0 ,lfile('legacy_2'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'AutomotiveRepair*Data*.csv'			,0 ,lfile('legacy_3'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Cemetery*Data*.csv'			,0 ,lfile('legacy_4'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'ChiropracticExaminers*Data*.csv'			,0 ,lfile('legacy_5'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'CourtReporters*Data*.csv'			,0 ,lfile('legacy_6'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'ElectronicApplianceRepair*Data*.csv'			,0 ,lfile('legacy_7'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Fiduciaries*Data*.csv'			,0 ,lfile('legacy_8'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Funeral*Data*.csv'			,0 ,lfile('legacy_9'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'HearingAidDispensers*Data*.csv'			,0 ,lfile('legacy_10'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'LandscapeArchitects*Data*.csv'			,0 ,lfile('legacy_11'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Pharmacy*Data*.csv'			,0 ,lfile('legacy_12'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'ProfEngrsLandSurvyrsGeologist*Data*.csv'			,0 ,lfile('legacy_13'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'Structural*Data*.csv'			,0 ,lfile('legacy_14'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
	

		
		 	], VersionControl.Layout_Sprays.Info);
	
	export dospray :=  Sequential( FileServices.ClearSuperfile('~thor_data400::in::prolic::CA::all_available::breeze'),
	                         FileServices.ClearSuperfile('~thor_data400::in::prolic::CA::all_available::legacy'),
													 VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting)
													 );
	
	end;