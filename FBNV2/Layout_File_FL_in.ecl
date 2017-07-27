export Layout_File_FL_in :=
module
   export event:=Record
		 
					string8  	process_date                      ;
					string12 	EVENT_DOC_NUMBER                  ;
					string12 	EVENT_ORIG_DOC_NUMBER             ;
					string192 	EVENT_FIC_NAME                    ;
					string5 	EVENT_ACTION_CTR                  ; 
					string3 	EVENT_SEQ_NUMBER                  ;
					string3 	EVENT_PAGES                       ;
					string8 	EVENT_DATE                        ;
					string3 	ACTION_SEQ_NUMBER                 ;
					string3 	ACTION_CODE                       ;
					string25 	ACTION_VERBAGE                    ;
					string9 	ACTION_OLD_FEI                    ;
					string12	ACTION_OLD_COUNTY                 ;
					string40 	ACTION_OLD_ADDR1                  ;
					string40 	ACTION_OLD_ADDR2                  ;
					string28 	ACTION_OLD_CITY                   ;
					string2 	ACTION_OLD_STATE                  ;
					string5 	ACTION_OLD_ZIP5                   ;
					string4 	ACTION_OLD_ZIP4                   ;
					string40 	ACTION_OLD_COUNTRY                ;
					string9 	ACTION_NEW_FEI                    ;
					string12 	ACTION_NEW_COUNTY                 ;
					string40 	ACTION_NEW_ADDR1                  ;
					string40 	ACTION_NEW_ADDR2                  ;
					string28 	ACTION_NEW_CITY                   ;
					string2 	ACTION_NEW_STATE                  ;
					string5 	ACTION_NEW_ZIP5                   ;
					string4 	ACTION_NEW_ZIP4                   ;
					string40 	ACTION_NEW_COUNTRY                ;
					string55 	ACTION_OWN_NAME                   ;
					string40 	ACTION_OWN_ADDRESS                ;
					string28 	ACTION_OWN_CITY                   ;
					string2 	ACTION_OWN_STATE                  ;
					string5 	ACTION_OWN_ZIP5                   ;
					string9 	ACTION_OWN_FEI                    ;
					string12 	ACTION_OWN_CHARTER_NUMBER         ;
					string5 	ACTION_OLD_NAME_SEQ               ;
					string5 	ACTION_NEW_NAME_SEQ               ;
					string73  	pname;
					string70  	cname;
					string182 	clean_action_old_address          ;
					string182 	clean_address          ;
					string182 	clean_owner_address        ;
	END;
	
    export filing:=Record
	
					string8   	process_date 			  	;
					string12	FIC_FIL_DOC_NUM 		  	;
					string192	FIC_FIL_NAME  			  	;
					string12	FIC_FIL_COUNTY			  	;
					string40	FIC_FIL_ADDR1 				;
					string40	FIC_FIL_ADDR2 				;
					string28	FIC_FIL_CITY  				;
					string2		FIC_FIL_STATE 				;
					string5	    FIC_FIL_ZIP5  				;
					string4     FIC_FIL_ZIP4  				;
					string40	FIC_FIL_COUNTRY   			;
					string8		FIC_FIL_DATE  				;
					string3		FIC_FIL_PAGES 				;
					string1		FIC_FIL_STATUS				;
					string9		FIC_FIL_STATUS_DEC			;
					string8		FIC_FIL_CANCELLATION_DATE 	;
					string8		FIC_FIL_EXPIRATION_DATE   	;
					string3		FIC_FIL_TOTAL_OWN_CUR_CTR 	;
					string14	FIC_FIL_FEI_NUM  			;
					string1		FIC_GREATER_THAN__OWNERS  	;
					string12	FIC_OWNER_DOC_NUM 	  		;
					string55	FIC_OWNER_NAME 	  			;
					string1		FIC_OWNER_NAME_FORMAT  	  	;
					string40	FIC_OWNER_ADDR 	  			;
					string28	FIC_OWNER_CITY 	  			;
					string2		FIC_OWNER_STATE   			;
					string5		FIC_OWNER_ZIP5				;
					string4     FIC_OWNER_ZIP4				;
					string40	FIC_OWNER_COUNTRY 			;
					string9		FIC_OWNER_FEI_NUM 			;
					string12	FIC_OWNER_CHARTER_NUM 		;
					string182  	clean_owner_address   		;
					string73   	p_owner_name   	  			;
					string70   	clean_name					;
					string182   clean_address 		  		;
					string2     seq							;
      end;
end;

 