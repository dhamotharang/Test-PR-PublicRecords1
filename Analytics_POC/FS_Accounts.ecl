export FS_Accounts := module

shared file_FSRaw := Finance.file_FSRaw;

export ds_accts := table(file_FSRaw, 
												 {sys_cd,cust_cd,vc_id,mig_gen03_cd,cust_id := regexreplace('[\\w]*-+', file_FSRaw.MIG_GEN03_CD,''), hh_id}, 
									 			 sys_cd,cust_cd,vc_id,mig_gen03_cd,hh_id);
 
build_slim := output(ds_accts, ,
										 'poc::fs_accts_slim', 
											csv(heading(single), quote(''), separator('\t'), terminator('\n')),
											overwrite
											);

export fn_despraySlim := 
	sequential(build_slim,
				 		 FileServices.DeSpray('poc::fs_accts_slim', 
																  Analytics_POC.Constants.landing_ip, 
																  'w:\\poc\\fs_slim.tsv', ,,,true)
	);


end;