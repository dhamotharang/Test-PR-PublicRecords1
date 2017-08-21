export Layout_File_DnB_FinancingStatement_in:= 

record
 string8           PROCESS_DATE;
 string6           ENTITY_ID;	
 string1           ACTION_CODE;	
 string1           DEF_GLOBAL_AGN;
 string3           DEF_DATA_LENGTH;	
 string11          F_FING_ENTY_ID;
 string9           FILG_OFC_DUNS_NBR;	
 string14          FILG_STMT_FILG_NBR;
 string2      	   Filing_Jurisdiction;
 string14          FILG_NBR_FULL;	
 string1           FILG_STMT_TYPE_CD;
 string15          FILG_STMT_TYPE_DEC;	
 string8           FILG_DT;	
 string8           XREF_DT;	
 string14          XREF_NBR;	
 string120         FILG_OFC_NME;	
 string64          FILG_OFC_STR_ADR;	
 string30          FILG_OFC_CITY_NME;	
 string30          FILG_OFC_CNTY_NME;	
 string2           FILG_OFC_ST_NME;	
 string9           FILG_OFC_POST_CD;	
 string8           DT_LAST_UPD;	
 string6           TIME_LAST_UPD;	
 string8           DT_ENTD;	
 string6           TIME_ENTD;	
 string1           CONT_TYPE;
 string9           CONT_desc;	
 string1           DISTBN_CTRL_CD;	
 string8           FILG_EXPN_DT;	
 string3           FILG_NBR_PG;	
 string4           FILG_TIME;	
 string8           RECVDDT;	
 string8           VERNDT;	
 string1           MIN_REQM_MET_INDC;	
 string3           PRTY_CD;
 string100				 prep_addr_line1;
 string50					 prep_addr_last_line;
end;
	
