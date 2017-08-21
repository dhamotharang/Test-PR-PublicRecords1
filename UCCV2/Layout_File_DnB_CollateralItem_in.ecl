export Layout_File_DnB_CollateralItem_in := 

record		
	 string8         PROCESS_DATE;
	 string6         ENTITY_ID;	
	 string1         ACTION_CODE;	
	 string1         DEF_GLOBAL_AGN ;	
	 string3         DEF_DATA_LENGTH;	
	 string11        F_FING_ENTY_ID;
	 //string11        UCC;	
	 string3         F_FING_COLL_SEQ;	
	 string3         FING_ITEM_SEQ_NBR;	
	 string3         MACH_CD_PRIM;	
	 string145       MACH_PRIM;
	 string3         MACH_CD_SECDY;
	 string145       MACH_SECDY;	
	 string5         MFR_CD;	
	 string120       MFR_NAME;	
	 string15        MODEL;	
	 string4         MODEL_YR;	
	 string50        MODEL_DESC;	
	 string2         COLL_ITEM_QTY_NULL ;	
	 string5         COLL_ITEM_QTY;	
	 string4         YR_MFD;	
	 string1         NEW_USED_INDC;	
	 string30        SER_NBR;	
	 string1         SZ_CLASS_CD;
	 		
end;