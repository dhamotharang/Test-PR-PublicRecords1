import prte2_header, data_services;

EXPORT file_personrecs := // 10.121.145.93 /data/prct/infiles/dev_16/PRCT_PersonRecs__20170314
dataset(data_services.Data_location.prefix('PRTE')+PRTE2_Header.constants.filename_prct_personrecs
        ,prte2_header.layout_prte_manual_raw.main
        ,CSV(HEADING(1), SEPARATOR([',','\t']), TERMINATOR(['\n','\r\n','\n\r'])   ))(link_dob<>'link_dob');