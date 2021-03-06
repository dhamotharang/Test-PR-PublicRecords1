IMPORT Enclarity_Facility_Sanctions;
EXPORT Filecode_Control(string filedate, boolean pUseProd = false) := MODULE

	EXPORT cumulative_filecodes	:= ['SNC_AKF1','SNC_ALF1','SNC_AZF2','SNC_CAF2','SNC_CAF3','SNC_CAF4',
																	'SNC_CAF7','SNC_CAF8','SNC_CTF2','SNC_CTF3','SNC_DCF1','SNC_DEF2',
																	'SNC_HIF1','SNC_IAF2','SNC_ILF1','SNC_ILF2','SNC_ILF4','SNC_KSF3',
																	'SNC_MAF2','SNC_MDF3','SNC_MEF1','SNC_MIF1','SNC_NCF1','SNC_NMF3',
																	'SNC_NYF3','SNC_RIF1','SNC_TNF2','SNC_TXF2','SNC_TXF4','SNC_VAF1',
																	'SNC_WIF1','SNC_WYF1'];
																					 
	EXPORT fullrefresh_filecodes:= ['SNC_ALF2','SNC_CAF1','SNC_CTF5','SNC_FLF1','SNC_FLF2','SNC_FLF3',
																	'SNC_FLF4','SNC_FLF5','SNC_GAF1','SNC_IDF2','SNC_KSF1','SNC_KYF1',
																	'SNC_MDF4','SNC_MIF2','SNC_MNF1','SNC_MOF1','SNC_MSF1','SNC_MTF2',
																	'SNC_NCF2','SNC_NCF3','SNC_NDF1','SNC_NEF1','SNC_NVF1','SNC_NYF2',
																	'SNC_OHF1','SNC_PAF1','SNC_SCF1','SNC_TNF1','SNC_TXF1','SNC_WVF1',
																	'SNC_WVF2','SNC_WVF3'];
																					 
	EXPORT fullwithrein_filecodes:= ['SNC_HIF2','SNC_LAF3'];

	EXPORT Get_Level	:= FUNCTION
		prePrepFile	:= Enclarity_Facility_Sanctions.Files(filedate,pUseProd).facility_sanctions_input;

		enclarity_facility_sanctions.layouts.base.facility_sanctions tMap(Enclarity_Facility_Sanctions.layouts.input.facility_sanctions L) := TRANSFORM
			SELF.level                    := MAP(L.filecode in cumulative_filecodes   => 1,
																					 L.filecode in fullrefresh_filecodes  => 2,
																					 L.filecode in fullwithrein_filecodes => 3,
																					 0);			
			SELF  :=  L;
			SELF  :=  [];
		END;
	
		withlevel	:= PROJECT(prePrepFile, tMap(LEFT));
	
		RETURN withlevel;
	END;
END;



