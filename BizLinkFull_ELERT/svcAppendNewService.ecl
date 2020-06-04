EXPORT svcAppendNewService() := MACRO
  //Healthcare only services, not applicable outside HPC. -ZRS 4/8/2019    
  IMPORT HealthCare_Provider_Header AS pkgHeader;
  IMPORT HealthCare_Provider_Header_ELERT AS pkgQAMonitoring;
  #CONSTANT('Superfile_Name','qa');
  SHARED UNSIGNED Input_UniqueID            := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  SHARED UNSIGNED Input_LNPID               := 0 : STORED('LNPID', FORMAT(SEQUENCE(2)));
  SHARED UNSIGNED Input_RID                 := 0 : STORED('RID', FORMAT(SEQUENCE(3)));
  SHARED STRING   Input_SRC_CATEGORY        := '' : STORED('SRC_CATEGORY', FORMAT(SEQUENCE(4)));
  SHARED UNSIGNED Input_TIMESTAMP           := 0 : STORED('TIMESTAMP', FORMAT(SEQUENCE(5)));
  SHARED UNSIGNED Input_MODE                := 0 : STORED('MODE', FORMAT(SEQUENCE(6)));
  SHARED UNSIGNED Input_COMPAREMODE         := 0 : STORED('COMPAREMODE', FORMAT(SEQUENCE(7)));
  SHARED STRING   Input_DESCRIPTION         := '' : STORED('DESCRIPTION', FORMAT(SEQUENCE(8)));
  SHARED STRING   Input_FNAME               := '' : STORED('FNAME', FORMAT(SEQUENCE(9)));
  SHARED STRING   Input_MNAME               := '' : STORED('MNAME', FORMAT(SEQUENCE(10)));
  SHARED STRING   Input_LNAME               := '' : STORED('LNAME', FORMAT(SEQUENCE(11)));
  SHARED STRING   Input_SNAME               := '' : STORED('SNAME', FORMAT(SEQUENCE(12)));
  SHARED STRING   Input_GENDER              := '' : STORED('GENDER', FORMAT(SEQUENCE(13)));
  SHARED STRING   Input_SSN                 := '' : STORED('SSN', FORMAT(SEQUENCE(14)));
  SHARED UNSIGNED Input_DOB                 := 0 : STORED('DOB', FORMAT(SEQUENCE(15)));
  SHARED STRING   Input_TAXONOMY            := '' : STORED('TAXONOMY', FORMAT(SEQUENCE(16)));
  SHARED STRING   Input_PRACTITIONER_TYPE   := '' : STORED('PRACTITIONER_TYPE', FORMAT(SEQUENCE(17)));
  SHARED STRING   Input_CLASSIFICATION      := '' : STORED('CLASSIFICATION', FORMAT(SEQUENCE(18)));
  SHARED STRING   Input_PRIM_RANGE          := '' : STORED('PRIM_RANGE', FORMAT(SEQUENCE(19)));
  SHARED STRING   Input_PRIM_NAME           := '' : STORED('PRIM_NAME', FORMAT(SEQUENCE(20)));
  SHARED STRING   Input_SEC_RANGE           := '' : STORED('SEC_RANGE', FORMAT(SEQUENCE(21)));
  SHARED STRING   Input_CITY                := '' : STORED('CITY', FORMAT(SEQUENCE(22)));
  SHARED STRING   Input_ST                  := '' : STORED('ST', FORMAT(SEQUENCE(23)));
  SHARED STRING   Input_ZIP                 := '' : STORED('ZIP', FORMAT(SEQUENCE(24)));
  SHARED STRING   Input_PRAC_PHONE          := '' : STORED('PRAC_PHONE', FORMAT(SEQUENCE(25)));
  SHARED STRING   Input_NPI_NUMBER          := '' : STORED('NPI_NUMBER', FORMAT(SEQUENCE(26)));
  SHARED STRING   Input_UPIN                := '' : STORED('UPIN', FORMAT(SEQUENCE(27)));
  SHARED STRING   Input_DEA_NUMBER          := '' : STORED('DEA_NUMBER', FORMAT(SEQUENCE(28)));
  SHARED STRING   Input_LIC_STATE           := '' : STORED('LIC_STATE', FORMAT(SEQUENCE(29)));
  SHARED STRING   Input_LIC_NBR_NUM         := '' : STORED('LIC_NBR_NUM', FORMAT(SEQUENCE(30)));
  SHARED STRING   Input_CSR_STATE           := '' : STORED('CSR_STATE', FORMAT(SEQUENCE(31)));
  SHARED STRING   Input_CSR_NBR_NUM         := '' : STORED('CSR_NBR_NUM', FORMAT(SEQUENCE(32)));
  SHARED STRING   Input_MEDSCHOOL           := '' : STORED('MEDSCHOOL', FORMAT(SEQUENCE(33)));
  SHARED UNSIGNED Input_MEDSCHOOL_YEAR      := 0 : STORED('MEDSCHOOL_YEAR', FORMAT(SEQUENCE(34)));
  SHARED UNSIGNED Input_LEXID               := 0 : STORED('LEXID', FORMAT(SEQUENCE(35)));
  SHARED STRING   Input_HMS_PIID            := '' : STORED('HMS_PIID', FORMAT(SEQUENCE(36)));
  SHARED STRING   Input_VENDOR_ENTITY_ID    := '' : STORED('VENDOR_ENTITY_ID', FORMAT(SEQUENCE(37)));
  SHARED STRING   Input_Tax_ID              := '' : STORED('Tax_ID', FORMAT(SEQUENCE(38)));
  SHARED STRING   Input_BILLING_NPI         := '' : STORED('BILLING_NPI', FORMAT(SEQUENCE(39)));
  SHARED BOOLEAN  Input_Enumeration         := TRUE : STORED('ENUMERATION', FORMAT(SEQUENCE(40))); 
  SHARED BOOLEAN  Input_Segmentation        := FALSE : STORED('SEGMENTATION', FORMAT(SEQUENCE(41))); 
  SHARED UNSIGNED Input_Weight              := 0 : STORED('WEIGHT', FORMAT(SEQUENCE(42))); 
  SHARED UNSIGNED Input_Score               := 0 : STORED('SCORE', FORMAT(SEQUENCE(43))); 
  SHARED UNSIGNED Input_WeightMin           := 0 : STORED('WEIGHTMIN', FORMAT(SEQUENCE(44)));  
  SHARED BOOLEAN  Input_DisableForce        := TRUE : STORED('DISABLEFORCE', FORMAT(SEQUENCE(45))); 
  SHARED mac_score := Input_Score;
  SHARED mac_weight := Input_Weight;
  SHARED mac_weightMin := Input_WeightMin;
  SHARED mac_segmentation := Input_Segmentation;
  SHARED mac_disableForce := Input_DisableForce;
  SHARED mac_enumeration := Input_Enumeration;
  
	pkgQAMonitoring.ModLayouts.lSampleLayout tGenData() := TRANSFORM
    SELF.UniqueID           := INPUT_UniqueID;
    SELF.LNPID              := INPUT_lnpid;
    SELF.RID                := INPUT_RID;
    SELF.SRC_CATEGORY       := INPUT_SRC_CATEGORY;
    SELF.TIMESTAMP          := INPUT_TIMESTAMP;
    SELF.MODE               := INPUT_MODE;
    SELF.COMPAREMODE        := INPUT_COMPAREMODE;
    SELF.DESCRIPTION        := INPUT_DESCRIPTION;
    SELF.FNAME              := INPUT_FNAME;
    SELF.MNAME              := INPUT_MNAME;
    SELF.LNAME              := INPUT_LNAME; 
    SELF.SNAME              := INPUT_SNAME;
    SELF.GENDER             := INPUT_GENDER;
    SELF.SSN                := INPUT_SSN;
    SELF.DOB                := INPUT_DOB;    
    SELF.TAXONOMY           := INPUT_TAXONOMY;
    SELF.PRACTITIONER_TYPE  := INPUT_PRACTITIONER_TYPE;
    SELF.CLASSIFICATION     := INPUT_CLASSIFICATION;
    SELF.PRIM_RANGE         := INPUT_PRIM_RANGE;
    SELF.PRIM_NAME          := INPUT_PRIM_NAME;
    SELF.SEC_RANGE          := INPUT_SEC_RANGE;
    SELF.CITY               := INPUT_CITY;
    SELF.ST                 := INPUT_ST;
    SELF.ZIP                := INPUT_ZIP;
    SELF.PRAC_PHONE         := INPUT_PRAC_PHONE;
    SELF.NPI_NUMBER         := INPUT_NPI_NUMBER;
    SELF.UPIN               := INPUT_UPIN;
    SELF.DEA_NUMBER         := INPUT_DEA_NUMBER;
    SELF.LIC_STATE          := INPUT_LIC_STATE;
    SELF.LIC_NBR_NUM        := INPUT_LIC_NBR_NUM;
    SELF.CSR_STATE          := INPUT_CSR_STATE;
    SELF.CSR_NBR_NUM        := INPUT_CSR_NBR_NUM;
    SELF.MEDSCHOOL          := INPUT_MEDSCHOOL;
    SELF.MEDSCHOOL_YEAR     := INPUT_MEDSCHOOL_YEAR;
    SELF.LEXID              := INPUT_LEXID;
    SELF.HMS_PIID           := INPUT_HMS_PIID;	
    SELF.VENDOR_ENTITY_ID   := INPUT_VENDOR_ENTITY_ID;
    SELF.TAX_ID             := INPUT_TAX_ID;
    SELF.BILLING_NPI        := INPUT_BILLING_NPI;
		SELF := [];
	END;
	shared dIndata := DATASET([tGenData()]);
  /*Roxie*/
	pkgHeader.mac_xlinking_on_roxie(dIndata
    ,pkgQAMonitoring.modConstants.modInFields
    ,dOutfile
    ,pkgQAMonitoring.modConstants.dBasicRestrictions
		,pkgHeader.Constants.XLinkMode.BESTAPPEND
		,LNPID_Out
		,mac_score,mac_weight,mac_segmentation
		,FALSE, ,mac_weightMin,mac_disableForce,5,mac_enumeration)
    
  OUTPUT(dOutfile,,NAMED('Results'));	
ENDMACRO;
 
