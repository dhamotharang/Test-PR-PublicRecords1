import BankruptcyV2,ut ; 

bk_search := project(BankruptcyV2.file_bankruptcy_search_v3_supp_bip,scrubs_bk_search.Layout_bk_search) ;
maxprocessdate    := max(bk_search, process_date) ; // some junk dates in there
EXPORT In_bk_search  := bk_search (process_date ='20140114');//= ut.getdate); //( process_date = MaxprocessDate) ;