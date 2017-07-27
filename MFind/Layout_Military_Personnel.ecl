import ut;

//Layout_In_Docinfo 			:= RECORD
//	string lni   				{xpath('@lni')};
//	string dminrev 				{xpath('@minrev')}; 
//	string src 		    		{xpath('@src')}; 
//	string f 					{xpath('@f')}; 
//END;

CurrentNameRec 					:= RECORD
	string CURR_NAME_LAST		{xpath('LN')};
	string CURR_NAME_FIRST		{xpath('GN')};
	string CURR_NAME_MIDDLE		{xpath('MN')};
	string CURR_NAME_M_INITIAL	{xpath('MI')};
	string CURR_NAME_SUFFIX		{xpath('TL')};
	string CURR_NAME_GENDER		{xpath('GD')};
END;

OccupationRec 					:= RECORD
	string PRIM_OCCUP			{xpath('OCP')};
	string DUTY_OCCUP			{xpath('OCD')};
	string SCND_OCCUP			{xpath('OCS')};
END;

OccupationMonths				:= RECORD
	string MIL_PRIM_MOS			{xpath('MOP')};
	string MIL_DUTY_MOS			{xpath('MOD')};
	string MIL_SCND_MOS			{xpath('MOS')};
END;

CurrentAddrRec 					:= RECORD
	string STR_ADDR_1			{xpath('S1')};
	string STR_ADDR_2			{xpath('S2')};
	string CITY					{xpath('CY')};
	string STATE				{xpath('ST')};
	string ZIP					{xpath('ZP')};
END;

export Layout_Military_Personnel := RECORD
			
	//Dataset(Layout_In_Docinfo)  doc{xpath('doc')};
	
	string		DOC			    {xpath('doc')};

	string10 	TRANS_DATE		{xpath('TD')};
	
	CurrentNameRec 				CN{xpath('CN')};
	
	string 		HOME_STATE		{xpath('HS')};
	string 		LEGAL_RES_STATE	{xpath('LS')};
	string 		DUTY_BASE		{xpath('DY')};

    OccupationRec				OC{xpath('OC')};
	
	string 		EDUCATION		{xpath('ED')};
	string 		SOURCE_OF_ENTRY	{xpath('SE')};
	string 		MIL_BRANCH		{xpath('MB')};
	string 		MIL_STATUS		{xpath('MS')};
	string 		MIL_PAY_GRADE	{xpath('MP')};
	string10 	MIL_ACTIVE_DATE	{xpath('MVD')};
	string10 	MIL_EST_SEP_DATE{xpath('MES')};
	string 		MIL_SEP_DATE	{xpath('DUMMY-SEG')};
	string 		MIL_SERVICE_YRS	{xpath('MY')};
	
	OccupationMonths			MPM{xpath('MPM')};
	
	string 		CITE_ID			{xpath('CI')};
	string 		FILE_ID			{xpath('FI')};
	string 		PUBLICATION		{xpath('PU')};
	
	CurrentAddrRec				CA{xpath('CA')};
	
	string VID					{xpath('VI')};
END;


//ds := dataset(ut.foreign_prod + 'thor_data400::in::mfind',MFind.Layout_Military_Personnel,XML('batch/doc'));
//output(ds);

