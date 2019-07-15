EXPORT Layout_Stats := MODULE;

EXPORT Inrec := RECORD 
		STRING9 SRC ;
		UNSIGNED CNT ; 
END;

EXPORT XTAB := RECORD
    STRING9 src;
    unsigned cnt_Old;
    unsigned cnt_Unchanged;
    unsigned cnt_Updated;
    unsigned cnt_New;
    real8 pct_tot_Old;
    real8 pct_tot_Unchanged;
    real8 pct_tot_Updated;
    real8 pct_tot_New;
    real8 pct_ingest_Unchanged;
    real8 pct_ingest_Updated;
    real8 pct_ingest_New;
  END;
EXPORT Out := RECORD 
    STRING src;
		STRING wuid ;
  	STRING version ;
    unsigned cnt_Old;
    unsigned cnt_Unchanged;
    unsigned cnt_Updated;
    unsigned cnt_New;
		unsigned cnt_Modified; 
		unsigned cnt_Tot;
		unsigned cnt_input;
    real8 pct_tot_Old;
    real8 pct_tot_Unchanged;
    real8 pct_tot_Updated;
    real8 pct_tot_New;
    real8 pct_ingest_Unchanged;
    real8 pct_ingest_Updated;
    real8 pct_ingest_New; 
END; 

END; 
