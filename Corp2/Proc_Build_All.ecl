import VersionControl,orbit_report, RoxieKeyBuild, _control, Orbit3;

export Proc_Build_All(
	 
	 string 				pversion 
	,boolean				pBuildBaseFiles								= true

) :=
module

	export build_bases			:= Proc_Build_BaseFiles(pversion).Build_All;
	export build_roxie_keys	:= Proc_Build_Roxie_Keys(pversion).Build_All;
	export promote2QA				:= Promote_Built_To_QA;
	export stratapop				:= strata_population_stats(pversion).all_stats;
	export build_boolean		:= Proc_Build_Boolean_Keys(pversion);
	export NewRecs4QA				:= QA_records(files().base.corp.qa);
	export Coverage					:= Corp2.Stats_Coverage(pversion);
	export Cleanup					:= Promote(pDelete := true).buildfiles.cleanup;
	export dops							:= RoxieKeyBuild.updateversion('Corp2Keys', pversion, _control.MyInfo.EmailAddressNotify,,'N|B');
  export DOPSGrowthCheck  := fDOPSGrowthCheck(pversion).GrowthCheck;
	
	orbit_report.Corp_Stats(getretval);
	export corp_orbit_report := getretval;
	export corp2keys := 	
	sequential( 
							if(pBuildBaseFiles				,build_bases	)	
							,build_roxie_keys
							,promote2QA
							,stratapop
							,build_boolean
							,corp_orbit_report
							,DOPSGrowthCheck	
						) : success(Send_Email(pversion).Roxie), failure(Send_Email(pversion).BuildFailure);
						
	orbit_update := Orbit3.proc_Orbit3_CreateBuild('Corporations (SOS)',pversion, 'N|B');	
						
	export All :=
	sequential( corp2keys
							,Coverage
							,NewRecs4QA
							,Cleanup
							,dops
							,orbit_update
							// ,fileservices.ClearSuperFile('~thor_data400::spraylogs::corp2')						
						) : success(Send_Email(pversion).buildsuccess), failure(Send_Email(pversion).BuildFailure);

end;