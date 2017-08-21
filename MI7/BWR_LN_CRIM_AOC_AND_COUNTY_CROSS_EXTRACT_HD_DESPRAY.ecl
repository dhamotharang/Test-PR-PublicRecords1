





import crim_common;



//*****DeSray shadow load files*****
a := FileServices.DeSpray('~thor_data400::out::crim::cross_aoc_and_county::case_details'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/aoc/shadow_files/LN_CROSS_CASE_DETAILS'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									
b := FileServices.DeSpray('~thor_data400::out::crim::cross_aoc_and_county::case_master'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/aoc/shadow_files/LN_CROSS_CASE_MASTER'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									
c := FileServices.DeSpray('~thor_data400::out::crim::cross_aoc_and_county::criminal_supplimental'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/aoc/shadow_files/LN_CROSS_CRIMINAL_SUPPLIMENTAL'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									

									
e := FileServices.DeSpray('~thor_data400::out::crim::cross_aoc_and_county::criminal_charges'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/aoc/shadow_files/LN_CROSS_CRIMINAL_CHARGES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
								
f := FileServices.DeSpray('~thor_data400::out::crim::cross_aoc_and_county::criminal_sentences'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/aoc/shadow_files/LN_CROSS_CRIMINAL_SENTENCES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);	



//*****Envoke mapping attributes and despray attributes*****
 sequential(a,b,c,e,f);
 
 //sequential(f);
 