#option('skipFileFormatCrcCheck', 1);

import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export VA := MODULE;

	export Layouts_Raw_Input := MODULE;
	
	export recIn := RECORD
		EBCDIC STRING   str;
	    END;
        
    export recOut := RECORD,MAXLENGTH(2048)
        STRING str;
        END;		 

	export TABLES := record
			string2   REC_TYPE;
			string2   TABLE_ID;
			string10  TABLE_CODE;                  
			string50  TABLE_DESC;                			        
		    end;
		
    export CORPS := record
			string2   REC_TYPE;  
			string7   CORP_ID;
			string100 CORP_NAME;
			string2   CORP_STATUS;
			string8   CORP_STATUS_DATE;
			string8   CORP_PER_DUR; 
			string8   CORP_INC_DATE;
			string2   CORP_STATE_INC;
			string2   CORP_IND_CODE;
			string45  CORP_STREET1;
			string45  CORP_STREET2;
			string23  CORP_CITY;
			string2   CORP_STATE;
			string9   CORP_ZIP;
			string8   CORP_PO_EFF_DATE;
			string100 CORP_RA_NAME;
			string45  CORP_RA_STREET1; 
			string45  CORP_RA_STREET2;
			string23  CORP_RA_CITY;
			string2   CORP_RA_STATE;
			string9   CORP_RA_ZIP;
			string8   CORP_RA_EFF_DATE;
			string1   CORP_RA_STATUS;
			string3   CORP_RA_LOC;
			string1   CORP_STOCK_IND;
			string11  CORP_TOTAL_SHARES;
			string1   CORP_MERGER_IND;
			string1   CORP_ASMT_IND;
			string8   CORP_STOCK_CLASS1;
			string8   CORP_STOCK_CLASS2;
			string8   CORP_STOCK_CLASS3;
			string8   CORP_STOCK_CLASS4;
			string8   CORP_STOCK_CLASS5;
			string8   CORP_STOCK_CLASS6;
			string8   CORP_STOCK_CLASS7;
			string8   CORP_STOCK_CLASS8;
			string11  CORP_STOCK_SHARE_AUTH1;
			string11  CORP_STOCK_SHARE_AUTH2;
			string11  CORP_STOCK_SHARE_AUTH3;
			string11  CORP_STOCK_SHARE_AUTH4;
			string11  CORP_STOCK_SHARE_AUTH5;
			string11  CORP_STOCK_SHARE_AUTH6;
			string11  CORP_STOCK_SHARE_AUTH7;
			string11  CORP_STOCK_SHARE_AUTH8;
		    end;
		
	export NORM_CORPS_LAYOUT := record
			string7   CORP_ID;			
			string11  CORP_TOTAL_SHARES;			
			string8   CORP_STOCK_CLASS;			
			string11  CORP_STOCK_SHARE_AUTH;			
		end;	
	
	export NORM_CORPS_STOCK := record
		    norm_corps_layout;
			string50 lkup_stock_type;
			string15 edit_total_shares;
			string50 edit_stock_share_auth;
		end;
		
	export CORPSandLOOKUP01 := record
			CORPS;
			string50  STATUS_DESC;
		    END;
		
	export CORPSandLOOKUP02 := record
			CORPSandLOOKUP01;
			string50  FORGN_STATE_DESC;
		    END;
		
	export CORPSandLOOKUP03 := record
			CORPSandLOOKUP02;
			string50  ORIG_BUS_TYPE_DESC;
		    END;
		
	export CORPSandLOOKUP04 := record
			CORPSandLOOKUP03;
			string50  RA_TITLE_DESC;
		    END;
		
	export CORPSandLOOKUP05 := record
			CORPSandLOOKUP04;
			string50  RA_ADDL_INFO;
		    END;				
		
	export LP := record
			string2   REC_TYPE;  
			string7   CORP_ID;
			string100 CORP_NAME;
			string2   CORP_STATUS;
			string8   CORP_STATUS_DATE;
			string8   CORP_PER_DUR; 
			string8   CORP_INC_DATE;
			string2   CORP_STATE_INC;
			string2   CORP_IND_CODE;
			string45  CORP_STREET1;
			string45  CORP_STREET2;
			string23  CORP_CITY;
			string2   CORP_STATE;
			string9   CORP_ZIP;
			string8   CORP_PO_EFF_DATE;
			string100 CORP_RA_NAME;
			string45  CORP_RA_STREET1; 
			string45  CORP_RA_STREET2;
			string23  CORP_RA_CITY;
			string2   CORP_RA_STATE;
			string9   CORP_RA_ZIP;
			string8   CORP_RA_EFF_DATE;
			string1   CORP_RA_STATUS;
			string3   CORP_RA_LOC;			
		    end;
		
	export LPandLOOKUP01 := record
			LP;
			string1   FILLER_STOCK_IND;
			string11  FILLER_TOTAL_SHARES;
			string1   FILLER_MERGER_IND;
			string1   FILLER_ASMT_IND;
			string8   FILLER_STOCK_CLASS1;
			string8   FILLER_STOCK_CLASS2;
			string8   FILLER_STOCK_CLASS3;
			string8   FILLER_STOCK_CLASS4;
			string8   FILLER_STOCK_CLASS5;
			string8   FILLER_STOCK_CLASS6;
			string8   FILLER_STOCK_CLASS7;
			string8   FILLER_STOCK_CLASS8;
			string11  FILLER_STOCK_SHARE_AUTH1;
			string11  FILLER_STOCK_SHARE_AUTH2;
			string11  FILLER_STOCK_SHARE_AUTH3;
			string11  FILLER_STOCK_SHARE_AUTH4;
			string11  FILLER_STOCK_SHARE_AUTH5;
			string11  FILLER_STOCK_SHARE_AUTH6;
			string11  FILLER_STOCK_SHARE_AUTH7;
			string11  FILLER_STOCK_SHARE_AUTH8;
			string50  STATUS_DESC;
		END;
		
	export LPandLOOKUP02 := record
			LPandLOOKUP01;
			string50  FORGN_STATE_DESC;
		    END;
		
		
	export LPandLOOKUP03 := record
			LPandLOOKUP02;
			string50  ORIG_BUS_TYPE_DESC;
		    END;
		
	export LPandLOOKUP04 := record
			LPandLOOKUP03;
			string50  RA_TITLE_DESC;
		    END;
		
	export LPandLOOKUP05 := record
			LPandLOOKUP04;
			string50  RA_ADDL_INFO;
		    END;
		
	export HISTORY := record
			string2   REC_TYPE;  
			string7   HIST_CORP_ID;
			string1   HIST_AMEND_IND;
			string1   HIST_AMEND_TYPE1;
			string1   HIST_AMEND_TYPE2;
			string1   HIST_AMEND_TYPE3;
			string1   HIST_AMEND_TYPE4;
			string1   HIST_AMEND_TYPE5;
			string1   HIST_AMEND_TYPE6;
			string1   HIST_AMEND_TYPE7;
			string1   HIST_AMEND_TYPE8;
			string8   HIST_AMEND_DATE;
			string3   HIST_STOCK_INFO; 
			string11  HIST_OLD_SHARES_AUTH1;
			string11  HIST_OLD_SHARES_AUTH2;
			string11  HIST_OLD_SHARES_AUTH3;
			string11  HIST_OLD_SHARES_AUTH4;
			string11  HIST_OLD_SHARES_AUTH5;
			string11  HIST_OLD_SHARES_AUTH6;
			string11  HIST_OLD_SHARES_AUTH7;
			string11  HIST_OLD_SHARES_AUTH8;
			string8   HIST_OLD_STOCK_CLASS1;
			string8   HIST_OLD_STOCK_CLASS2;
			string8   HIST_OLD_STOCK_CLASS3;
			string8   HIST_OLD_STOCK_CLASS4;
			string8   HIST_OLD_STOCK_CLASS5;
			string8   HIST_OLD_STOCK_CLASS6;
			string8   HIST_OLD_STOCK_CLASS7;
			string8   HIST_OLD_STOCK_CLASS8;
		   end;
		
    export NORM_HISTORY_LAYOUT := record 
			string7   HIST_CORP_ID;
			string1   HIST_AMEND_IND;
			string1   HIST_AMEND_TYPE;			
			string8   HIST_AMEND_DATE;
			string3   HIST_STOCK_INFO; 
			string11  HIST_OLD_SHARES_AUTH;			
			string8   HIST_OLD_STOCK_CLASS;			
		end;
		
	export NORM_HISTORY_AMENDS := record
		    norm_history_layout;
			string50 lkup_amend_desc;
		end;
		
	export NORM_HISTORY_STOCK := record
		    norm_history_layout;
			string50 lkup_stock_type;
			string50 edit_stock_auth_nbr;
		end;
		
	export OFFICERS := record
			string2   REC_TYPE;  
			string7   DIRC_CORP_ID;
			string30  DIRC_LAST_NAME;
			string20  DIRC_FIRST_NAME;
			string20  DIRC_MIDDLE_NAME;
			string15  DIRC_TITLE; 			
		   end;
		
	export OFFICERS_CORPS := record
			officers;  
			string350 CORP_LEGAL_NAME;
		   end;	
		
	export NAMES := record
			string2   REC_TYPE;  
			string7   NAME_CORP_ID;
			string2   NAME_STATUS;
			string100 NAME_CORP_NAME;
			string8   NAME_EFF_DATE; 			
		    end;
		
	export MERGERS := record
			string2   REC_TYPE;  
			string7   MERG_CORP_ID;
			string1   MERG_TYPE;
			string8   MERG_EFF_DATE;
			string7   MERG_SURV_ID;
			string100 MERG_FOR_CORP_NAME; 			
		    end;
		
	export RESERVED := record
			string2   REC_TYPE;  
			string7   RES_NUMBER;
			string1   RES_TYPE;
			string2   RES_STATUS;
			string100 RES_NAME;
			string8   RES_EXP_DATE; 
			string100 RES_REQUESTOR;
			string45  RES_STREET1;
			string45  RES_STREET2;
			string23  RES_CITY;
			string2   RES_STATE;
			string9   RES_ZIP;			
		    end;
		
	export LLC := record
			string2   REC_TYPE;  
			string7   CORP_ID;
			string100 CORP_NAME;
			string2   CORP_STATUS;
			string8   CORP_STATUS_DATE;
			string8   CORP_PER_DUR; 
			string8   CORP_INC_DATE;
			string2   CORP_STATE_INC;
			string2   CORP_IND_CODE;
			string45  CORP_STREET1;
			string45  CORP_STREET2;
			string23  CORP_CITY;
			string2   CORP_STATE;
			string9   CORP_ZIP;
			string8   CORP_PO_EFF_DATE;
			string100 CORP_RA_NAME;
			string45  CORP_RA_STREET1; 
			string45  CORP_RA_STREET2;
			string23  CORP_RA_CITY;
			string2   CORP_RA_STATE;
			string9   CORP_RA_ZIP;
			string8   CORP_RA_EFF_DATE;
			string1   CORP_RA_STATUS;
			string3   CORP_RA_LOC;
		    end;				
		
	export LLCandLOOKUP01 := record
		    LLC;			
			string50  STATUS_DESC;
		end;
				
	export LLCandLOOKUP02 := record
		    LLCandLOOKUP01;
			string50  FORGN_STATE_DESC;
		   end;
				
	export LLCandLOOKUP03 := record
			LLCandLOOKUP02;
			string50  ORIG_BUS_TYPE_DESC;
		    END;
		
	export LLCandLOOKUP04 := record
			LLCandLOOKUP03;
			string50  RA_TITLE_DESC;
		    END;
		
	export LLCandLOOKUP05 := record
			LLCandLOOKUP04;
			string50  RA_ADDL_INFO;
		    END;								
		
	end;    //End of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;	
		export corps(string fileDate)  := DATASET('~thor_data400::in::corp2::'+fileDate+'::corps::va',Layouts_Raw_Input.recIn,FLAT);		
		end;

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function				
		
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;			
         
        Layouts_Raw_Input.recOut  trans(Layouts_Raw_Input.recIn L) := TRANSFORM
           SELF.str := L.str[1..length((>varstring1023<)L.str)];
           // self.strLen := (string) length((>varstring1023<)L.str);
           END; 
  
		Layouts_Raw_Input.TABLES  transTABLE(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.rec_type   := l.str[1..2];
		   self.TABLE_ID   := l.str[3..4];
		   self.TABLE_CODE := l.str[5..14];
		   self.TABLE_DESC := l.str[15..64];
		   END;
 
		Layouts_Raw_Input.CORPS  transCORPS(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.CORP_ID                  := l.str[3..9];
		   self.CORP_NAME                := l.str[10..109];
		   self.CORP_STATUS              := l.str[110..111];
		   self.CORP_STATUS_DATE         := l.str[112..119];
		   self.CORP_PER_DUR             := l.str[120..127]; 
		   self.CORP_INC_DATE            := l.str[128..135];
		   self.CORP_STATE_INC           := l.str[136..137];
		   self.CORP_IND_CODE            := l.str[138..139];
		   self.CORP_STREET1             := l.str[140..184];
		   self.CORP_STREET2             := l.str[185..229];
		   self.CORP_CITY                := l.str[230..252];
		   self.CORP_STATE               := l.str[253..254];
		   self.CORP_ZIP                 := l.str[255..263];
		   self.CORP_PO_EFF_DATE         := l.str[264..271];
		   self.CORP_RA_NAME             := l.str[272..371];
		   self.CORP_RA_STREET1          := l.str[372..416];
		   self.CORP_RA_STREET2          := l.str[417..461];
		   self.CORP_RA_CITY             := l.str[462..484];
		   self.CORP_RA_STATE            := l.str[485..486];
		   self.CORP_RA_ZIP              := l.str[487..495];
		   self.CORP_RA_EFF_DATE         := l.str[496..503];
		   self.CORP_RA_STATUS           := l.str[504..504];
		   self.CORP_RA_LOC              := l.str[505..507];
		   self.CORP_STOCK_IND           := l.str[508..508];
		   self.CORP_TOTAL_SHARES        := l.str[509..519];
		   self.CORP_MERGER_IND          := l.str[520..520];
		   self.CORP_ASMT_IND            := l.str[521..521];
		   self.CORP_STOCK_CLASS1        := l.str[522..529];
		   self.CORP_STOCK_CLASS2        := l.str[530..537];
		   self.CORP_STOCK_CLASS3        := l.str[538..545];
		   self.CORP_STOCK_CLASS4        := l.str[546..553];
		   self.CORP_STOCK_CLASS5        := l.str[554..561];
		   self.CORP_STOCK_CLASS6        := l.str[562..569];
		   self.CORP_STOCK_CLASS7        := l.str[570..577];
		   self.CORP_STOCK_CLASS8        := l.str[578..585];
		   self.CORP_STOCK_SHARE_AUTH1   := l.str[586..596];
		   self.CORP_STOCK_SHARE_AUTH2   := l.str[597..607];
		   self.CORP_STOCK_SHARE_AUTH3   := l.str[608..618];
		   self.CORP_STOCK_SHARE_AUTH4   := l.str[619..629];
		   self.CORP_STOCK_SHARE_AUTH5   := l.str[630..640];
		   self.CORP_STOCK_SHARE_AUTH6   := l.str[641..651];
		   self.CORP_STOCK_SHARE_AUTH7   := l.str[652..662];
		   self.CORP_STOCK_SHARE_AUTH8   := l.str[663..673];
		   END;
 
		Layouts_Raw_Input.LP  transLP(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.CORP_ID                  := l.str[3..9];
		   self.CORP_NAME                := l.str[10..109];
		   self.CORP_STATUS              := l.str[110..111];
		   self.CORP_STATUS_DATE         := l.str[112..119];
		   self.CORP_PER_DUR             := l.str[120..127]; 
		   self.CORP_INC_DATE            := l.str[128..135];
		   self.CORP_STATE_INC           := l.str[136..137];
		   self.CORP_IND_CODE            := l.str[138..139];
		   self.CORP_STREET1             := l.str[140..184];
		   self.CORP_STREET2             := l.str[185..229];
		   self.CORP_CITY                := l.str[230..252];
		   self.CORP_STATE               := l.str[253..254];
		   self.CORP_ZIP                 := l.str[255..263];
		   self.CORP_PO_EFF_DATE         := l.str[264..271];
		   self.CORP_RA_NAME             := l.str[272..371];
		   self.CORP_RA_STREET1          := l.str[372..416];
		   self.CORP_RA_STREET2          := l.str[417..461];
		   self.CORP_RA_CITY             := l.str[462..484];
		   self.CORP_RA_STATE            := l.str[485..486];
		   self.CORP_RA_ZIP              := l.str[487..495];
		   self.CORP_RA_EFF_DATE         := l.str[496..503];
		   self.CORP_RA_STATUS           := l.str[504..504];
		   self.CORP_RA_LOC              := l.str[505..507];   
		   END;
 
		Layouts_Raw_Input.HISTORY  transHISTORY(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.HIST_CORP_ID             := l.str[3..9];
		   self.HIST_AMEND_IND           := l.str[10..10];
		   self.HIST_AMEND_TYPE1         := l.str[11..11];
		   self.HIST_AMEND_TYPE2         := l.str[12..12];
		   self.HIST_AMEND_TYPE3         := l.str[13..13];
		   self.HIST_AMEND_TYPE4         := l.str[14..14];
		   self.HIST_AMEND_TYPE5         := l.str[15..15];
		   self.HIST_AMEND_TYPE6         := l.str[16..16];
		   self.HIST_AMEND_TYPE7         := l.str[17..17];
		   self.HIST_AMEND_TYPE8         := l.str[18..18];
		   self.HIST_AMEND_DATE          := l.str[19..26];
		   self.HIST_STOCK_INFO          := l.str[27..29]; 
		   self.HIST_OLD_SHARES_AUTH1    := l.str[30..40];
		   self.HIST_OLD_SHARES_AUTH2    := l.str[41..51];
		   self.HIST_OLD_SHARES_AUTH3    := l.str[52..62];
		   self.HIST_OLD_SHARES_AUTH4    := l.str[63..73];
		   self.HIST_OLD_SHARES_AUTH5    := l.str[74..84];
		   self.HIST_OLD_SHARES_AUTH6    := l.str[85..95];
		   self.HIST_OLD_SHARES_AUTH7    := l.str[96..106];
		   self.HIST_OLD_SHARES_AUTH8    := l.str[107..117];
		   self.HIST_OLD_STOCK_CLASS1    := l.str[118..125];
		   self.HIST_OLD_STOCK_CLASS2    := l.str[126..133];
		   self.HIST_OLD_STOCK_CLASS3    := l.str[134..141];
		   self.HIST_OLD_STOCK_CLASS4    := l.str[142..149];
		   self.HIST_OLD_STOCK_CLASS5    := l.str[150..157];
		   self.HIST_OLD_STOCK_CLASS6    := l.str[158..165];
		   self.HIST_OLD_STOCK_CLASS7    := l.str[166..173];
		   self.HIST_OLD_STOCK_CLASS8    := l.str[174..181];
		   END;
 
        NORM_HISTORY_LAYOUT := record 
			string7   HIST_CORP_ID;
			string1   HIST_AMEND_IND;
			string1   HIST_AMEND_TYPE;			
			string8   HIST_AMEND_DATE;
			string3   HIST_STOCK_INFO; 
			string11  HIST_OLD_SHARES_AUTH;			
			string8   HIST_OLD_STOCK_CLASS;			
		end; 
 
		Layouts_Raw_Input.OFFICERS  transOFFICERS(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.DIRC_CORP_ID             := l.str[3..9];
		   self.DIRC_LAST_NAME           := l.str[10..39];
		   self.DIRC_FIRST_NAME          := l.str[40..59];
		   self.DIRC_MIDDLE_NAME         := l.str[60..79];
		   self.DIRC_TITLE               := l.str[80..94];  
		   END;
		 
		Layouts_Raw_Input.NAMES  transNAMES(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.NAME_CORP_ID             := l.str[3..9];
		   self.NAME_STATUS              := l.str[10..11];
		   self.NAME_CORP_NAME           := l.str[12..111];
		   self.NAME_EFF_DATE            := l.str[112..119];  
		   END;
		 
		Layouts_Raw_Input.MERGERS  transMERGERS(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.MERG_CORP_ID             := l.str[3..9];
		   self.MERG_TYPE                := l.str[10..10];
		   self.MERG_EFF_DATE            := l.str[11..18];
		   self.MERG_SURV_ID             := l.str[19..25];
		   self.MERG_FOR_CORP_NAME       := l.str[26..125];  
		   END;
 
		Layouts_Raw_Input.RESERVED  transRESERVED(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.RES_NUMBER               := l.str[3..9];
		   self.RES_TYPE                 := l.str[10..10];
		   self.RES_STATUS               := l.str[11..12];
		   self.RES_NAME                 := l.str[13..112];
		   self.RES_EXP_DATE             := l.str[113..120]; 
		   self.RES_REQUESTOR            := l.str[121..220];
		   self.RES_STREET1              := l.str[221..265];
		   self.RES_STREET2              := l.str[266..310];
		   self.RES_CITY                 := l.str[311..333];
		   self.RES_STATE                := l.str[334..335];
		   self.RES_ZIP                  := l.str[336..344];    
		   END;
		 
		Layouts_Raw_Input.LLC  transLLC(Layouts_Raw_Input.recout l) := TRANSFORM
		   self.REC_TYPE                 := l.str[1..2]; 
		   self.CORP_ID                  := l.str[3..9];
		   self.CORP_NAME                := l.str[10..109];
		   self.CORP_STATUS              := l.str[110..111];
		   self.CORP_STATUS_DATE         := l.str[112..119];
		   self.CORP_PER_DUR             := l.str[120..127]; 
		   self.CORP_INC_DATE            := l.str[128..135];
		   self.CORP_STATE_INC           := l.str[136..137];
		   self.CORP_IND_CODE            := l.str[138..139];
		   self.CORP_STREET1             := l.str[140..184];
		   self.CORP_STREET2             := l.str[185..229];
		   self.CORP_CITY                := l.str[230..252];
		   self.CORP_STATE               := l.str[253..254];
		   self.CORP_ZIP                 := l.str[255..263];
		   self.CORP_PO_EFF_DATE         := l.str[264..271];
		   self.CORP_RA_NAME             := l.str[272..371];
		   self.CORP_RA_STREET1          := l.str[372..416];
		   self.CORP_RA_STREET2          := l.str[417..461];
		   self.CORP_RA_CITY             := l.str[462..484];
		   self.CORP_RA_STATE            := l.str[485..486];
		   self.CORP_RA_ZIP              := l.str[487..495];
		   self.CORP_RA_EFF_DATE         := l.str[496..503];
		   self.CORP_RA_STATUS           := l.str[504..504];
		   self.CORP_RA_LOC              := l.str[505..507];   
		   END;
		
		
	
//---------------------  Corporation File Mapping for Corp Type Records  --------------------//	

		corp2_mapping.Layout_CorpPreClean CorpTransform01(Layouts_Raw_Input.CORPSandLOOKUP05 input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '51-' + trimUpper(input.corp_id);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_id);													  						
			self.corp_legal_name				:= trimUpper(input.corp_name);				
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL'; 		
			self.corp_address1_line1			:= trimUpper(input.CORP_street1); 
			self.corp_address1_line2			:= trimUpper(input.CORP_street2); 
			self.corp_address1_line3			:= trimUpper(input.CORP_city); 
			self.corp_address1_line4			:= trimUpper(input.CORP_state); 															
			self.corp_address1_line5			:= if (length(trim(input.CORP_zip)) = 9 and 
			                                          trim(input.CORP_zip)[6..9] = '0000',
													  trim(input.CORP_zip)[1..5],
													  trim(input.CORP_zip)
													   ); 
			self.corp_address1_effective_date   := if(_validate.date.fIsValid(input.corp_po_eff_date) and 
													_validate.date.fIsValid(input.corp_po_eff_date,_validate.date.rules.DateInPast),
														input.corp_po_eff_date,
														''
													  ); 		
			self.corp_status_cd				    := trimUpper(input.corp_status);			
			self.corp_status_desc				:= trimUpper(input.status_desc);
			self.corp_status_date				:= if(_validate.date.fIsValid(input.corp_status_date) and 
													_validate.date.fIsValid(input.corp_status_date,_validate.date.rules.DateInPast),
														input.corp_status_date,
														''
													  );			
			self.corp_inc_state					:= if (trimUpper(input.corp_state_inc) = 'VA',
															'VA',
															'');		
			self.corp_inc_date					:= if (trimUpper(input.corp_state_inc) = 'VA' and
														_validate.date.fIsValid(input.corp_inc_date) and 
														_validate.date.fIsValid(input.corp_inc_date,_validate.date.rules.DateInPast),
															input.corp_inc_date,
															''
													   );													   																							
			self.corp_term_exist_cd				:= if(trimUpper(input.corp_state_inc) = 'VA',
														  if((integer)input.corp_per_dur = 0,
											  			     'P',
											  				 if(_validate.date.fIsValid(input.corp_per_dur),
															   'D',
															   '')
															),
													''
													 );
			self.corp_term_exist_exp			:= if(trimUpper(input.corp_state_inc)  = 'VA',
													 if((integer)input.corp_per_dur = 0,
														'',															 
														input.corp_per_dur
														),
													''
													 );															 						
			self.corp_term_exist_desc			:= if(trimUpper(input.corp_state_inc) = 'VA',
													  if((integer)input.corp_per_dur = 0,
													    'PERPETUAL',
														if(_validate.date.fIsValid(input.corp_per_dur),
														   'EXPIRATION DATE',
															'')
														),
													''
													  );
			self.corp_foreign_domestic_ind		:= if(trimUpper(input.corp_state_inc) <> 'VA',
													 'F',
													 'D');
			self.corp_forgn_state_cd			:= if (trimUpper(input.corp_state_inc) <> 'VA',
														 trimUpper(input.corp_state_inc),
														 '');														 
			self.corp_forgn_state_desc          := if (trimUpper(input.corp_state_inc) <> 'VA',
														 trimUpper(input.forgn_state_desc),
														 '');
			self.corp_forgn_date				:= if (trimUpper(input.corp_state_inc) <> 'VA' and
														_validate.date.fIsValid(input.corp_inc_date) and 
														_validate.date.fIsValid(input.corp_inc_date,_validate.date.rules.DateInPast),
															input.corp_inc_date,
															''
													   );
			self.corp_forgn_term_exist_cd		:= if(trimUpper(input.corp_state_inc) <> 'VA',
														  if((integer)input.corp_per_dur = 0,
														     'P',
															 if(_validate.date.fIsValid(input.corp_per_dur),
															   'D',
															   '')
															),
													''
													 );
			self.corp_forgn_term_exist_exp		:= if(trimUpper(input.corp_state_inc) <> 'VA',
													 if((integer)input.corp_per_dur = 0,
														'',															 
														input.corp_per_dur
														),
													''
													 );
			self.corp_forgn_term_exist_desc		:= if(trimUpper(input.corp_state_inc) <> 'VA',
														  if((integer)input.corp_per_dur = 0,
														     'PERPETUAL',
															 if(_validate.date.fIsValid(input.corp_per_dur),
															   'EXPIRATION DATE',
															   '')
															),
														''
														 );
			self.corp_orig_bus_type_cd			:= trimUpper(input.corp_ind_code);			
			self.corp_orig_bus_type_desc        := trimUpper(input.orig_bus_type_desc);															
			self.corp_ra_name					:= trimUpper(input.corp_ra_name);
			self.corp_ra_title_cd               := trimUpper(input.corp_ra_status);
			self.corp_ra_title_desc             := trimUpper(input.ra_title_desc);
			self.corp_ra_effective_date         := if(_validate.date.fIsValid(input.corp_ra_eff_date),
													input.corp_ra_eff_date,
													''),
			self.corp_ra_address_type_desc		:= if(trim(input.corp_ra_street1) <> '',
													  'REGISTERED OFFICE',
													  '');												 
			self.corp_ra_address_line1			:= trimUpper(input.corp_ra_street1);		
			self.corp_ra_address_line2			:= trimUpper(input.corp_ra_street2);
			self.corp_ra_address_line3			:= trimUpper(input.corp_ra_city);
			self.corp_ra_address_line4			:= trimUpper(input.corp_ra_state);
			self.corp_ra_address_line5			:= trimUpper(input.corp_ra_zip);
			self.corp_ra_addl_info              := if(trim(input.ra_addl_info) <> '',
													 'COURT LOCALITY: ' + input.ra_addl_info,
													 '');
			self.corp_orig_org_structure_cd     := case(input.rec_type,'02'=>'02',
																	   '03'=>'03',
																       '09'=>'09',
																       '');
			self.corp_orig_org_structure_desc   := case(input.rec_type,'02'=>'CORPORATION',
																       '03'=>'LIMITED PARTNERSHIP',
																       '09'=>'LIMITED LIABILITY COMPANY',
																       '');
			self 								:= [];
		end; // end transform		
		
//---------------------  Corporation File Mapping for Name Type Records  --------------------//	

		corp2.layout_corporate_direct_corp_in CorpTransform02(Layouts_Raw_Input.Names input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;			
			self.corp_key						:= '51-' + trimUpper(input.name_corp_id);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';			
			self.corp_process_date				:= fileDate;
			self.corp_src_type				    := 'SOS';			

			self.corp_orig_sos_charter_nbr		:= trimUpper(input.name_corp_id);															
			self.corp_legal_name				:= trimUpper(input.name_corp_name);				
			self.corp_ln_name_type_cd			:= trim(input.name_status,left,right);				
			self.corp_ln_name_type_desc			:= map(  
                                                    trim(input.name_status,left,right) = '50' => 'FICTITIOUS',
                                                    trim(input.name_status,left,right) = '70' => 'OLD NAME',                                                    
													''
                                                   );		
			self.corp_name_comment			    := 'NAME EFFECTIVE DATE: ' + trim(input.name_eff_date);			
			self 								:= [];						
		end; // end transform
		
//---------------------  Corporation File Mapping for Reserved Type Records  --------------------//	

		corp2.layout_corporate_direct_corp_in CorpTransform03(Layouts_Raw_Input.Reserved input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;	
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '51-' + trimUpper(input.res_number);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';						
			self.corp_src_type				    := 'SOS';			
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.res_number) 												  			;
			self.corp_legal_name				:= trimUpper(input.res_name);				
			self.corp_ln_name_type_cd			:= map(  
                                                    trim(input.res_status,left,right) = '60' => '09',
                                                    trim(input.res_status,left,right) = '61' => '07',                                                    
													''
                                                   );				
			self.corp_ln_name_type_desc			:= map(  
                                                    trim(input.res_status,left,right) = '60' => 'REGISTRATION',
                                                    trim(input.res_status,left,right) = '61' => 'RESERVED',                                                    
													''
                                                   );	
			self.corp_term_exist_cd				:= if(_validate.date.fIsValid(input.res_exp_date),
													 'D',
													 '');															 													  															 

			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(input.res_exp_date),
													 input.res_exp_date,
													 '');															 						

			self.corp_term_exist_desc			:= if(_validate.date.fIsValid(input.res_exp_date),
													 'EXPIRATION DATE',
													 '');
													 
			self 								:= [];						
		end; // end transform
		
//---------------------  Contact File Mapping for Reserved Type Records  --------------------//	

		corp2_mapping.Layout_ContPreClean ContTransform01(Layouts_Raw_Input.Reserved input) := transform
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;			
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '51-' + trimUpper(input.res_number);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';									
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.res_number);
			self.corp_legal_name                := trimUpper(input.res_name);
			self.cont_name			            := trimUpper(input.res_requestor);				
			self.cont_type_cd					:= map(  
                                                    trim(input.res_status,left,right) = '60' => '02',
                                                    trim(input.res_status,left,right) = '61' => '01',                                                    
													''
                                                   );				
			self.cont_type_desc					:= map(  
                                                    trim(input.res_status,left,right) = '60' => 'REGISTRANT',
                                                    trim(input.res_status,left,right) = '61' => 'RESERVER',                                                    
													''
                                                   );	
			self.cont_address_line1				:= trimUpper(input.res_street1);													 
            self.cont_address_line2				:= trimUpper(input.res_street2);	
			self.cont_address_line3				:= trimUpper(input.res_city);	
			self.cont_address_line4				:= trimUpper(input.res_state);	
			self.cont_address_line5				:= trim(input.res_zip,left,right);
			self.cont_address_type_cd			:= map(  
                                                    trim(input.res_status,left,right) = '60' => '02',
                                                    trim(input.res_status,left,right) = '61' => '01',                                                    
													''
                                                   );				
			self.cont_address_type_desc			:= map(  
                                                    trim(input.res_status,left,right) = '60' => 'REGISTRANT',
                                                    trim(input.res_status,left,right) = '61' => 'RESERVER',                                                    
													''
                                                   );	
												   
			self 								:= [];						
		end; // end transform

//---------------------  Contact File Mapping for Officers Type Records  --------------------//	

		corp2_mapping.Layout_ContPreClean ContTransform02(Layouts_Raw_Input.Officers_Corps input) := transform
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;			
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '51-' + trimUpper(input.dirc_corp_id);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';											
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.dirc_corp_id);
			self.corp_legal_name                := trimUpper(input.corp_legal_name);
			self.cont_name			            := trimUpper(input.dirc_first_name) + ' ' +
			                                       trimUpper(input.dirc_middle_name) + ' ' +
												   trimUpper(input.dirc_last_name);										
			self.cont_title1_desc				:= trimUpper(input.dirc_title);                                                    				
			self.cont_address_type_cd			:= if((trimUpper(input.dirc_first_name) + 
													  trimUpper(input.dirc_last_name)) <> '',
													  'F',															
													  ''															
													  );
			self.cont_address_type_desc			:= if((trimUpper(input.dirc_first_name) + 
													  trimUpper(input.dirc_last_name)) <> '',
													  'OFFICER',															
													  ''															
													  );	
												   
			self 								:= [];						
		end; // end transform
		
		
//---------------------  Event File Mapping for History Type Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransform01(Layouts_Raw_Input.NORM_HISTORY_AMENDS input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '51-' + trimUpper(input.hist_corp_id);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';								
			self.corp_sos_charter_nbr			:= trimUpper(input.hist_corp_id);
			self.event_filing_date              := if(_validate.date.fIsValid(input.hist_amend_date) and 
													  _validate.date.fIsValid(input.hist_amend_date,_validate.date.rules.DateInPast),
														input.hist_amend_date,
														'');
			self.event_date_type_cd             := 'FIL';
			self.event_date_type_desc           := 'FILING';
			self.event_filing_cd                := trimUpper(input.hist_amend_type);
			self.event_filing_desc              := trimUpper(input.lkup_amend_desc);			
												   
			self 								:= [];						
		end; // end transform
		
//---------------------  Event File Mapping for Merger Type Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransform02(Layouts_Raw_Input.Mergers input) := transform			
			self.corp_key						:= '51-' + trimUpper(input.merg_corp_id);
			self.corp_vendor					:= '51';
			self.corp_state_origin				:= 'VA';									
			self.corp_sos_charter_nbr			:= trimUpper(input.merg_corp_id);
			self.event_filing_date              := if(_validate.date.fIsValid(input.merg_eff_date) and 
													  _validate.date.fIsValid(input.merg_eff_date,_validate.date.rules.DateInPast),
														input.merg_eff_date,
														'');
			self.event_date_type_cd             := 'MER';
			self.event_date_type_desc           := 'MERGER';
			string sep                          := if(trim(input.merg_type,left,right) <> '',
			                                         '; ',
													 '');
			string100 corp_name                 := if(trim(input.merg_for_corp_name,left,right) <> '',			                                         													    
													 sep + 'FOREIGN CORP NAME: ' + 
													 trimUpper(input.merg_for_corp_name),
													 '');
			self.event_desc                     := if(trimUpper(input.merg_type) = 'N',
													 'MERGED TO: ' + trimUpper(input.merg_surv_id) + corp_name,
													 if(trimUpper(input.merg_type) = 'S',
													   'SURVIVING CORP: ' + trimUpper(input.merg_surv_id) + corp_name,
													   corp_name));
												   
			self 								:= [];						
		end; // end transform		


//---------------------  Stock File Mapping for History Type Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Stock_In StockTransform01(Layouts_Raw_Input.NORM_HISTORY_STOCK input) := transform
			
			self.corp_key					:= '51-' + trimUpper(input.hist_corp_id);
			self.corp_vendor				:= '51';
			self.corp_state_origin			:= 'VA';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.hist_corp_id);
			self.stock_type         		:= input.lkup_stock_type;
			self.stock_authorized_nbr		:= input.edit_stock_auth_nbr;
			self.stock_change_date          := if((integer)input.hist_stock_info <> 0 and
												  _validate.date.fIsValid(input.hist_amend_date) and 
												  _validate.date.fIsValid(input.hist_amend_date,_validate.date.rules.DateInPast),
													  input.hist_amend_date,
													  '');
													  
			self							:=[];
			
		end; // end transform

//---------------------  Stock File Mapping for Corps Type Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Stock_In StockTransform02(Layouts_Raw_Input.NORM_CORPS_STOCK input) := transform
			
			self.corp_key					:= '51-' + trimUpper(input.corp_id);
			self.corp_vendor				:= '51';
			self.corp_state_origin			:= 'VA';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.corp_id);
			self.stock_type         		:= input.lkup_stock_type;
			self.stock_shares_issued	    := input.edit_total_shares;
			self.stock_authorized_nbr		:= input.edit_stock_share_auth;			
													  
			self							:=[];
			
		end; // end transform		
		

//---------------------------- Clean Corps Name and Addresses ---------------------//

		
		corp2.layout_corporate_direct_corp_in CleanCorps(corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 					:= if (input.corp_ra_name = '', '',Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
	

			
			string182 clean_address1 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' + 														                        
												trim(input.corp_address1_line2,left,right),left,right),														                   
												trim(trim(input.corp_address1_line3,left,right) + ', ' +
												trim(input.corp_address1_line4,left,right) + ' ' +
												trim(input.corp_address1_line5,left,right),left,right));											

			self.corp_addr1_prim_range    		:= clean_address1[1..10];
			self.corp_addr1_predir 	      		:= clean_address1[11..12];
			self.corp_addr1_prim_name 	  		:= clean_address1[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address1[41..44];
			self.corp_addr1_postdir 	    	:= clean_address1[45..46];
			self.corp_addr1_unit_desig 	  		:= clean_address1[47..56];
			self.corp_addr1_sec_range 	  		:= clean_address1[57..64];
			self.corp_addr1_p_city_name	  		:= clean_address1[65..89];
			self.corp_addr1_v_city_name	  		:= clean_address1[90..114];
			self.corp_addr1_state 				:= clean_address1[115..116];
			self.corp_addr1_zip5 		    	:= clean_address1[117..121];
			self.corp_addr1_zip4 		    	:= clean_address1[122..125];
			self.corp_addr1_cart 		    	:= clean_address1[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address1[130];
			self.corp_addr1_lot 		      	:= clean_address1[131..134];
			self.corp_addr1_lot_order 	  		:= clean_address1[135];
			self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
			self.corp_addr1_chk_digit 	  		:= clean_address1[138];
			self.corp_addr1_rec_type		  	:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
			self.corp_addr1_county 	  			:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
			self.corp_addr1_msa 		      	:= clean_address1[167..170];
			self.corp_addr1_geo_blk				:= clean_address1[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address1[178];
			self.corp_addr1_err_stat 	    	:= clean_address1[179..182];			
	
						
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right),left,right));											

			self.corp_ra_prim_range    			:= clean_address[1..10];
			self.corp_ra_predir 	      		:= clean_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_address[41..44];
			self.corp_ra_postdir 	    		:= clean_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_address[90..114];
			self.corp_ra_state 			      	:= clean_address[115..116];
			self.corp_ra_zip5 		      		:= clean_address[117..121];
			self.corp_ra_zip4 		      		:= clean_address[122..125];
			self.corp_ra_cart 		      		:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
			self.corp_ra_lot 		      		:= clean_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_address[135];
			self.corp_ra_dpbc 		      		:= clean_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_address[138];
			self.corp_ra_rec_type		  		:= clean_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_address[141..142];
			self.corp_ra_county 	  			:= clean_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_address[156..166];
			self.corp_ra_msa 		      		:= clean_address[167..170];
			self.corp_ra_geo_blk				:= clean_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_address[178];
			self.corp_ra_err_stat 	    		:= clean_address[179..182];
			
			self								:= input;
			self								:= [];
		end;
				
//---------------------------- Clean Corps Name and Addresses ---------------------//

		Corp2.Layout_Corporate_Direct_Cont_In CleanConts(corp2_mapping.Layout_ContPreClean input) := transform
			string73 tempname 				:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
			
			string182 clean_address 		:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
											trim(input.cont_address_line2,left,right),left,right),														                   
											trim(trim(input.cont_address_line3,left,right) + ', ' +
											trim(input.cont_address_line4,left,right) + ' ' +
											trim(input.cont_address_line5,left,right),left,right));
	

			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 			    := clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;
			
			self							:= [];
		end;
/// New VA Code follows

 // in  := DATASET('~data_build_4::corporate_filings::va::20070710pvs::20070710.corps',Layouts_Raw_Input.recIn,FLAT);
 out := PROJECT(Files_Raw_Input.corps(filedate),trans(LEFT)); 

 tablesFile   := PROJECT(out(str[1..2]='01'),transTABLE(LEFT)); 
 corpsFile    := PROJECT(out(str[1..2]='02'),transCORPS(LEFT)); 
 lpFile       := PROJECT(out(str[1..2]='03'),transLP(LEFT));
 historyFile  := PROJECT(out(str[1..2]='04'),transHISTORY(LEFT));
 officersFile := PROJECT(out(str[1..2]='05'),transOFFICERS(LEFT));
 namesFile    := PROJECT(out(str[1..2]='06'),transNAMES(LEFT));
 mergersFile  := PROJECT(out(str[1..2]='07'),transMERGERS(LEFT));
 reservedFile := PROJECT(out(str[1..2]='08'),transRESERVED(LEFT));
 llcFile      := PROJECT(out(str[1..2]='09'),transLLC(LEFT));
 
 // allCorps := corpsFile + lpFile + llcFile;
 
  //Get Status for Corps, LP, and LLC 
 Layouts_Raw_Input.CORPSandLOOKUP01   MergeCorps01(Layouts_Raw_Input.Corps l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.Status_desc 	    := trim(r.table_desc);
		end;
 
 joinCorps01 := join(corpsFile, tablesFile,
                            right.table_id ='01' and							
							left.corp_status = right.table_code,
							MergeCorps01(left,right),
							left outer);
							
 Layouts_Raw_Input.LPandLookup01   MergeLP01(Layouts_Raw_Input.Lp l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.Status_desc 	    := trim(r.table_desc);
			self                    := [];
		end;
 
 joinLP01 := join(lpFile, tablesFile,
                            right.table_id ='01' and							
							left.corp_status = right.table_code,
							MergeLP01(left,right),
							left outer);
							
 Layouts_Raw_Input.LLCandLookup01   MergeLLC01(Layouts_Raw_Input.LLC l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.Status_desc 	    := trim(r.table_desc);
			self                    := [];
		end;
 
 joinLLC01 := join(llcFile, tablesFile,
                            right.table_id ='01' and							
							left.corp_status = right.table_code,
							MergeLLC01(left,right),
							left outer);
							
 //Get Foreign State Description for Corps, LP, and LLC 
 Layouts_Raw_Input.CORPSandLOOKUP02   MergeCorps02(Layouts_Raw_Input.CORPSandLOOKUP01 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.Forgn_state_desc 	:= trim(r.table_desc);
		end;
 
 joinCorps02 := join(joinCorps01, tablesFile,
                            right.table_id ='02' and							
							left.corp_state_inc = right.table_code,
							MergeCorps02(left,right),
							left outer);
							
 Layouts_Raw_Input.LPandLookup02 MergeLP02(Layouts_Raw_Input.LPandLookup01 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.Forgn_state_desc 	:= trim(r.table_desc);
		end;
 
 joinLP02 := join(joinLP01, tablesFile,
                            right.table_id ='02' and							
							left.corp_state_inc = right.table_code,
							MergeLP02(left,right),
							left outer);
							
 Layouts_Raw_Input.LLCandLookup02 MergeLLC02(Layouts_Raw_Input.LLCandLookup01 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.Forgn_state_desc 	:= trim(r.table_desc);
		end;
 
 joinLLC02 := join(joinLLC01, tablesFile,
                            right.table_id ='02' and							
							left.corp_state_inc = right.table_code,
							MergeLLC02(left,right),
							left outer);
 
 //Get Original Business Description for Corps, LP, and LLC 
 Layouts_Raw_Input.CORPSandLOOKUP03   MergeCorps03(Layouts_Raw_Input.CORPSandLOOKUP02 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.ORIG_BUS_TYPE_DESC 	:= trim(r.table_desc);
		end;
 
 joinCorps03 := join(joinCorps02, tablesFile,
                            right.table_id ='03' and							
							left.corp_ind_code = right.table_code,
							MergeCorps03(left,right),
							left outer);
							
 Layouts_Raw_Input.LPandLookup03 MergeLP03(Layouts_Raw_Input.LPandLookup02 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.ORIG_BUS_TYPE_DESC 	:= trim(r.table_desc);
		end;
 
 joinLP03 := join(joinLP02, tablesFile,
                            right.table_id ='03' and							
							left.corp_ind_code = right.table_code,
							MergeLP03(left,right),
							left outer);
							
 Layouts_Raw_Input.LLCandLookup03 MergeLLC03(Layouts_Raw_Input.LLCandLookup02 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.ORIG_BUS_TYPE_DESC 	:= trim(r.table_desc);
		end;
 
 joinLLC03 := join(joinLLC02, tablesFile,
                            right.table_id ='03' and							
							left.corp_ind_code = right.table_code,
							MergeLLC03(left,right),
							left outer);

//Get RA Title Description for Corps, LP, and LLC 
 Layouts_Raw_Input.CORPSandLOOKUP04   MergeCorps04(Layouts_Raw_Input.CORPSandLOOKUP03 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.RA_TITLE_DESC 	:= trim(r.table_desc);
		end;
 
 joinCorps04 := join(joinCorps03, tablesFile,
                            right.table_id ='04' and							
							left.corp_ra_status = right.table_code,
							MergeCorps04(left,right),
							left outer);
							
 Layouts_Raw_Input.LPandLookup04    MergeLP04(Layouts_Raw_Input.LPandLookup03 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.RA_TITLE_DESC 	:= trim(r.table_desc);
		end;
 
 joinLP04 := join(joinLP03, tablesFile,
                            right.table_id ='28' and							
							left.corp_ra_status = right.table_code,
							MergeLP04(left,right),
							left outer);
							
 Layouts_Raw_Input.LLCandLookup04    MergeLLC04(Layouts_Raw_Input.LLCandLookup03 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.RA_TITLE_DESC 	:= trim(r.table_desc);
		end;
 
 joinLLC04 := join(joinLLC03, tablesFile,
                            right.table_id ='40' and							
							left.corp_ra_status = right.table_code,
							MergeLLC04(left,right),
							left outer);
							
 //Get RA Court Locality for Corps, LP, and LLC 
 Layouts_Raw_Input.CORPSandLOOKUP05   MergeCorps05(Layouts_Raw_Input.CORPSandLOOKUP04 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.RA_ADDL_INFO 	:= trim(r.table_desc);
		end;
 
 joinCorps05 := join(joinCorps04, tablesFile,
                            right.table_id ='05' and							
							left.corp_ra_loc = right.table_code,
							MergeCorps05(left,right),
							left outer);
							
 Layouts_Raw_Input.CORPSandLOOKUP05    MergeLP05(Layouts_Raw_Input.LPandLookup04 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.RA_ADDL_INFO 	:= trim(r.table_desc);
			self                := [];  
		end;
 
 joinLP05 := join(joinLP04, tablesFile,
                            right.table_id ='05' and							
							left.corp_ra_loc = right.table_code,
							MergeLP05(left,right),
							left outer);
							
 Layouts_Raw_Input.CORPSandLOOKUP05    MergeLLC05(Layouts_Raw_Input.LLCandLookup04 l, Layouts_Raw_Input.Tables r ) := transform
			self 					:= l;
			self.RA_ADDL_INFO 	:= trim(r.table_desc);
			self                := [];
		end;
 
 joinLLC05 		:= join(joinLLC04, tablesFile,
                            right.table_id ='05' and							
							left.corp_ra_loc = right.table_code,
							MergeLLC05(left,right),
							left outer);	
// Normalize the History records for use in creating Event and Stock records.						
 norm_History_Layout normalizeHistory(historyFile l, unsigned1 cnt) := transform
	self.hist_amend_type    	:= choose(cnt,l.hist_amend_type1,l.hist_amend_type2,l.hist_amend_type3,l.hist_amend_type4,l.hist_amend_type5,l.hist_amend_type6,l.hist_amend_type7,l.hist_amend_type8);
	self.hist_old_shares_auth	:= choose(cnt,l.hist_old_shares_auth1,l.hist_old_shares_auth2,l.hist_old_shares_auth3,l.hist_old_shares_auth4,l.hist_old_shares_auth5,l.hist_old_shares_auth6,l.hist_old_shares_auth7,l.hist_old_shares_auth8);
	self.hist_old_stock_class   := choose(cnt,l.hist_old_stock_class1,l.hist_old_stock_class2,l.hist_old_stock_class3,l.hist_old_stock_class4,l.hist_old_stock_class5,l.hist_old_stock_class6,l.hist_old_stock_class7,l.hist_old_stock_class8);
	self 				        := l;
 end;
 
 historyNormal := normalize(historyFile, 8, normalizeHistory(left, counter));
 
 historyEvents := historyNormal(trim(hist_amend_type,left,right) <> '');
 
 historyStocks := historyNormal(trim(hist_old_stock_class,left,right) <> '');							
		
// Take the historyEvents file and create the joinHistAmend to include lookup information.			
 Layouts_Raw_Input.NORM_HISTORY_AMENDS    MergeHistAmend(Layouts_Raw_Input.NORM_HISTORY_LAYOUT l, Layouts_Raw_Input.Tables r ) := transform			
			self.lkup_amend_desc 	:= trim(r.table_desc);
			self 					:= l;
		end;
 
 joinHistAmend := join(historyEvents, tablesFile,
                            if(left.hist_corp_id[1..1] in ['L','M'], 
                               right.table_id = '23',
							   right.table_id = '19') and							
							left.hist_amend_type = right.table_code,
							MergeHistAmend(left,right),
							left outer);
							
// Take the historyStocks file and create the joinHistStock to include lookup information.								
 Layouts_Raw_Input.NORM_HISTORY_STOCK    MergeHistStock(Layouts_Raw_Input.NORM_HISTORY_LAYOUT l, Layouts_Raw_Input.Tables r) := transform			
			self.lkup_stock_type 	 := trim(r.table_desc);
			self.edit_stock_auth_nbr := (string)ut.IntWithCommas((integer)l.HIST_OLD_SHARES_AUTH);
			self 					 := l;
		end; 
 
 joinHistStock := join(historyStocks, tablesFile,                            
                        right.table_id = '12' and							   							
						left.hist_old_stock_class = right.table_code,
							MergeHistStock(left,right),
							left outer);
							
// Normalize the Corps records for use in creating Stock records.							
 Layouts_Raw_Input.norm_Corps_Layout normalizeCorps(corpsFile l, unsigned1 cnt) := transform		
	self.corp_stock_class       := choose(cnt,l.corp_stock_class1,l.corp_stock_class2,l.corp_stock_class3,l.corp_stock_class4,l.corp_stock_class5,l.corp_stock_class6,l.corp_stock_class7,l.corp_stock_class8);
	self.corp_stock_share_auth	:= choose(cnt,l.corp_stock_share_auth1,l.corp_stock_share_auth2,l.corp_stock_share_auth3,l.corp_stock_share_auth4,l.corp_stock_share_auth5,l.corp_stock_share_auth6,l.corp_stock_share_auth7,l.corp_stock_share_auth8);
	self 				        := l;
    end;
 
 corpsNormal := normalize(corpsFile, 8, normalizeCorps(left, counter));
 
 corpsStocks := corpsNormal(trim(corp_stock_class,left,right) <> '');	
 
// Take the corpsStocks file and create the joinCorpsStock to include lookup information. 
 Layouts_Raw_Input.NORM_CORPS_STOCK    MergeCorpsStock(Layouts_Raw_Input.NORM_CORPS_LAYOUT l, Layouts_Raw_Input.Tables r) := transform			
			self.lkup_stock_type           := trim(r.table_desc);
			self.edit_total_shares         := (string)ut.IntWithCommas((integer)l.CORP_TOTAL_SHARES);
			self.edit_stock_share_auth     := (string)ut.IntWithCommas((integer)l.CORP_STOCK_SHARE_AUTH);
			self 					       := l;
		    end; 
 
 joinCorpsStock := join(corpsStocks, tablesFile,                            
                        right.table_id = '12' and							   							
						left.corp_stock_class = right.table_code,
							MergeCorpsStock(left,right),
							left outer);
  						

// Merge the Officers file and and Corps file and create the joinOfficersCorps file. 
 Layouts_Raw_Input.OFFICERS_CORPS    MergeOfficersCorps(Layouts_Raw_Input.OFFICERS l, Layouts_Raw_Input.Corps r) := transform			
			self 					       := l;
			self.corp_legal_name           := trimUpper(r.corp_name);
		    end; 
 
 joinOfficersCorps := join(officersFile, corpsFile,                            							   							
							left.dirc_corp_id = right.corp_id,
							MergeOfficersCorps(left,right),
							left outer);
		
		Stocks01        := joinHistStock;
		mappedStocks01  := project(Stocks01,StockTransform01(left));
		
		Stocks02        := joinCorpsStock;
		mappedStocks02  := project(Stocks02,StockTransform02(left));
		
		allStocks       := sort(mappedStocks01 + mappedStocks02,corp_key);
		
		Events01        := joinHistAmend;
		mappedEvents01  := project(Events01,EventTransform01(left));
		
		Events02        := mergersFile;
		mappedEvents02  := project(Events02,EventTransform02(left));
		
		allEvents       := sort(mappedEvents01 + mappedEvents02,corp_key);
		
		Conts01         := reservedFile;
		mappedConts01   := project(Conts01,ContTransform01(left));
		
		Conts02         := joinOfficersCorps;
		mappedConts02   := project(Conts02,ContTransform02(left));
		
		cleanedConts 	:= project(mappedConts01 + mappedConts02,CleanConts(left));
		
		sortContDedup   := sort(cleanedConts,corp_orig_sos_charter_nbr,cont_lname1,cont_fname1,-cont_mname1,cont_title1);
		
		allConts	    := dedup(sortContDedup,corp_orig_sos_charter_nbr,cont_lname1,cont_fname1,cont_title1);				
		
		Corps03      	:= reservedFile;
		mappedCorps03   := project(Corps03,CorpTransform03(left));
		
		Corps02      	:= namesFile;
		mappedCorps02   := project(Corps02,CorpTransform02(left));
		
		Corps01      	:= joinCorps05 + joinLLC05 + joinLP05;
		mappedCorps01   := project(Corps01,CorpTransform01(left));
		
		cleanedCorps 	:= project(mappedCorps01,CleanCorps(left));	
		
		allCorps        := sort(cleanedCorps + mappedCorps02 + mappedCorps03,corp_key);						              

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_va'	,allCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_va'	,allEvents,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_va'	,allConts	,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_va'	,allStocks,stock_out	,,,pOverwrite);
						                                                                                                                                               
		mapVA := parallel(
			 corp_out	
			,event_out
			,cont_out	
			,stock_out
		);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('va',filedate,pOverwrite := pOverwrite))
			,mapVA
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_va')			  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_va')						  											
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_va')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_va')																	  
			)
		);      
							
		return result;
		
	end;					 					
			
end; // end of module