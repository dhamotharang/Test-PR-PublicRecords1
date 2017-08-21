#workunit('name','TPM SAMPLE');

File_Telcordia_tpm_father := DATASET('~thor_data400::base::tpmdata_father',Risk_Indicators.Layout_Telcordia_tpm,flat);

srt1 := sort(Risk_Indicators.File_Telcordia_tpm,ocn,company_type,nxx_type, st);

srt2 := sort(File_Telcordia_tpm_father,ocn,company_type,nxx_type, st);

j1 := join(srt1,srt2,LEFT.ocn=RIGHT.ocn and LEFT.company_type=RIGHT.company_type and LEFT.nxx_type=RIGHT.nxx_type and LEFT.st=RIGHT.st,transform
(Risk_Indicators.Layout_Telcordia_tpm,self := left), LEFT ONLY);

export TPM_Sample := output(dedup(sort(j1,ocn,nxx_type,company_type,st),ocn,nxx_type,company_type, st));