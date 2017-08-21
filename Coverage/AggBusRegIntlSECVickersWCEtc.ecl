/* W20080207-163305
Martindale-Hubble
Business Registrations
America's Corporate Finance Directory (ACF)
DCA
Insider Trading (Vickers)
Workers Comp (MS and OR)
*/

shared martin 	:= martindale_hubbell.files().Base.Organizations.qa;
shared abusreg	:= BusReg.File_BusReg_Base;
shared acfbase	:= acf.File_ACF_Base;
shared dcabase	:= dca.File_DCA_Base;
shared vickbase	:= vickers.File_13d13g_Base;
shared mswork		:= govdata.File_MS_Workers_Comp_BDID;
shared orwork		:= govdata.File_OR_Workers_Comp_BDID;

ut.macGetCoverageDates(martin		,'MartinDale Hubbell'			,dt_first_seen		,dt_last_seen		,Hubbell_coverage	,false	);
ut.macGetCoverageDates(abusreg	,'Business Registrations'	,dt_first_seen		,dt_last_seen		,Busreg_coverage	,true		);
ut.macGetCoverageDates(acfbase	,'ACF'										,dt_first_seen		,dt_last_seen		,acf_coverage			,false	);
ut.macGetCoverageDates(dcabase	,'DCA'										,Update_Date			,Update_Date		,dca_coverage			,true		);
ut.macGetCoverageDates(vickbase	,'Vickers'								,filing_date			,upd_date				,vick_coverage		,true		);
ut.macGetCoverageDates(mswork		,'MS Workers Comp'				,date_first_seen	,date_last_seen	,mswork_coverage	,true		);
ut.macGetCoverageDates(orwork		,'OR Workers Comp'				,date_first_seen	,date_last_seen	,orwork_coverage	,true		);
                     
all_coverage := 
		Hubbell_coverage	
	+ Busreg_coverage	
	+ acf_coverage
	+ dca_coverage
	+ vick_coverage
	+ mswork_coverage
	+ orwork_coverage
	;

output(all_coverage, all);