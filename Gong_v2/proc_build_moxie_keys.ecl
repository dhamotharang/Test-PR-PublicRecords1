import lib_fileservices;

leMailTarget                            := 'cguyton@seisint.com;jtrost@seisint.com';
fSendMail(string pSubject,string pBody) := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

export proc_build_moxie_keys := 

sequential( 
//Build Moxie Keys
output(choosen(Gong_v2.proc_build_moxie_keybuildprep2,1)),
Gong_v2.proc_build_moxie_fpos_data_key,
fSendMail('Gongv2 1 of 3','Gongv2 Daily KeyBuild:  FPOS Key Complete... Kicking DKC'),
parallel(
 Gong_v2.proc_build_moxie_cnKeys,
 Gong_v2.proc_build_moxie_lfmnameKeys,
 Gong_v2.proc_build_moxie_lnKeys
),
fSendMail('Gongv2 2 of 3','Gongv2 Daily KeyBuild:  CN,LFM,LN Keys Complete... Kicking DKC'),
parallel(
 Gong_v2.proc_build_moxie_pcnKeys,
 Gong_v2.proc_build_moxie_phoneKeys,
 Gong_v2.proc_build_moxie_phoneticKeys
),
fSendMail('Gongv2 3 of 3','Gongv2 Daily KeyBuild:  PCN,PHONE,PHONETIC Keys Complete... Kicking DKC')
);