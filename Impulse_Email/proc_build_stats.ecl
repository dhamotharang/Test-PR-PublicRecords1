export proc_build_stats(filedate, zDoStatsReference)
	:=
		MACRO
		
			#uniquename(File_ImpulseEmail);
			#uniquename(zDoPopulationStats);
		
			%File_ImpulseEmail%	:=	Impulse_Email.files.file_Impulse_Email_Base;
		
			Impulse_Email.out_STRATA_population_stats(%File_ImpulseEmail%, filedate, zDoPopulationStats);
		
			zDoStatsReference	:=	sequential(zDoPopulationStats);
		
		ENDMACRO;