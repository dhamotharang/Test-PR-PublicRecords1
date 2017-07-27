import doxie;
j := Telcordia_tpm_base;
export Key_Telcordia_tpm := INDEX(j,{npa,nxx,tb},{j},'~thor_data400::key::telcordia_tpm_'+doxie.Version_SuperKey,OPT);