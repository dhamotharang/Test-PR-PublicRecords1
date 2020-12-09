IMPORT BankruptcyV2;
//DF-28491
//List of approved Dispositions and Chapter set to be used to identify discharged BK 

Lkp_Rec := RECORD
BankruptcyV2.layout_bankruptcy_search_v3_supp.Disposition;
BankruptcyV2.layout_bankruptcy_search_v3_supp.chapter;
END;


lkp_ds := DATASET([
{'CLOSED'           ,'11' }, 
{'DISCHARGE GRANTED','11' }, 
{'DISCHARGE GRANTED','13' }, 
{'DISCHARGE GRANTED','7'  }, 
{'DISCHARGE GRANTED','12' }, 
{'DISCHARGE N/A'    ,'11' }, 
{'DISCHARGE NA'     ,'11' }, 
{'DISCHARGED'       ,'0'  }, 
{'DISCHARGED'       ,'7'  }, 
{'DISCHARGED'       ,'9'  }, 
{'DISCHARGED'       ,'11' }, 
{'DISCHARGED'       ,'12' }, 
{'DISCHARGED'       ,'13' }, 
{'DISCHARGED'       ,'304'}  
],Lkp_Rec);
EXPORT File_lookup_Discharged_BK_disposition := lkp_ds;
















