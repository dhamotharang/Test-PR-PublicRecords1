import PRTE2_BIPV2_BusHeader, mdr;

EXPORT CommonBase := MODULE

	// Clean only SBFE Records
	EXPORT sbfe_clean(ds) := FUNCTIONMACRO
		IMPORT Suppress;
		ds_exclude  :=	ds(source IN MDR.sourceTools.set_Business_Credit);
		ds_exorcise	:=	ds_exclude(ingest_status<>'Old'); // Exorcise all ghosts, which _can_ remove cluster base records!
		// ds_reg      :=	Suppress.applyRegulatory.applyBIPV2(ds_exorcise); //Not needed for demo records
		RETURN ds_exorcise;
	ENDMACRO;

	
	EXPORT	DS_SBFE_CLEAN								:= sbfe_clean(PRTE2_BIPV2_BusHeader.CommonBase.DS_BUILT);
	// EXPORT	DS_SBFE_FATHER_CLEAN				:= sbfe_clean(PRTE2_BIPV2_BusHeader.CommonBase.DS_FATHER);
	// EXPORT	DS_SBFE_FATHER_STATIC_CLEAN	:= sbfe_clean(PRTE2_BIPV2_BusHeader.CommonBase.DS_FATHER_STATIC);
	// EXPORT	DS_SBFE_PROD_CLEAN					:= sbfe_clean(PRTE2_BIPV2_BusHeader.CommonBase.DS_PROD);
	// EXPORT	DS_SBFE_LOCAL_CLEAN					:= sbfe_clean(PRTE2_BIPV2_BusHeader.CommonBase.DS_LOCAL);
	// EXPORT	DS_SBFE_LOCAL_STATIC_CLEAN	:= sbfe_clean(PRTE2_BIPV2_BusHeader.CommonBase.DS_LOCAL_STATIC);
	

END;