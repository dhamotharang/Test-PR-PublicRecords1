IMPORT PRTE;
EXPORT file_header_base := dedup(sort(dataset('~prte::base::header',{PRTE.File_PRTE_Header},thor),record),record)(did<>0);