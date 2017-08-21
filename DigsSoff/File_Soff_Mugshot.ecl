export File_Soff_Mugshot := DATASET(SOFF_SuperFileList.DIGSSOFFMugshot,
                                    //'~thor_data50::in::digssoff::raw_data_mugshot', 
                                    Layout_soff_mugshot, 
																		csv(separator('|'),terminator(['\r\n','\r','\n']),quote('')))
																		(id[1..2]<>'NC' or (id[1..2]='NC' and regexfind('L.jpg|R.jpg',image_name,0)=''));