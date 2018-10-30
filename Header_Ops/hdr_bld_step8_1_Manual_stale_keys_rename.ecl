IMPORT tools,header;
#workunit('name','Manual stale keys rename');
filedate:='20180926';//header.version_build;
all_packagekeys := DATASET([                                                                                                                                                                                                                              
{'~thor_data400::key::header.rid_qa', '~thor_data400::key::header::'+filedate+'::rid'}  // put in the NEW version name                                                                                                                                                
], tools.Layout_SuperFilenames.inputlayout);                                                                                                                                                                                                                  

// nothor(tools.fun_RenameFiles(all_packagekeys, true));        // true = testing                                                                                                                                                                                           
nothor(tools.fun_RenameFiles(all_packagekeys, false));        // true = testing                                                                                                                                                                                           
/*
Previous Runs
---------------
20180821 W20180923-121024
0626 W20180717-105854
0522 W20180620-134200
0320 http://prod_esp.br.seisint.com:8010/?Wuid=W20180419-140631&Widget=WUDetailsWidget#/stub/Summary
// */
// 0221 W20180320-125426
// 0130 W20180306-093829
// 1227 W20180205-134113
// W20171205-124115
// W20171129-115920
// W20171101-123350
// W20171003-221318
// W20170905-234401 (0725)
// W20170807-100711 (0628)
// W20170717-105000 (0522)
// W20170612-091937 (0430)  
// W20170501-111836 (0321)
// W20170321-125022 (0223)
// W20170222-102448 (0123)
// W20170117-113644 (1220)
// W20161216-123455
// W20161122-081151
// W20161025-130807
// W20160926-083914
// W20160314-092503 (feb 16)
// W20160216-092720 (jan 16)
// W20160119-105314 (dec 15)
// W20150914-090234 (older)
// W20151009-125458 (check)
// W20151009-125628 (changed 20150921)