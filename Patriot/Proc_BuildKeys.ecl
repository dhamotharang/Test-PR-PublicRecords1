import ut, _Control;

#workunit('name','Patriot Spray And Build');

ver := '2005xxxx'; // set to correct version
insize := 4125;    // must match record length of input file

ut.mac_file_spray_and_build(_Control.IPAddress.edata12,'/sanc_15/sanctions_all.d00',insize,ver,'patriot_file',pre);

do1 := output(count(Patriot.ScoreNames));
do2 := patriot.Proc_BuildDidKeys;
do3 := patriot.Proc_BuildWordKeys;
ut.MAC_SK_BuildProcess(key_prep_patriot_file,'~thor_Data400::key::patriot_File_Full_','~thor_Data400::key::patriot_File_Full',do4,2,true)
ut.MAC_SK_BuildProcess_v2(patriot.key_did_patriot_file,'~thor_data400::key::patriot_did_file',do5)

do6 := patriot.proc_accept_sk_to_qa;

BOOLEAN doSpray := true;
BOOLEAN doscore := false; 

export Proc_BuildKeys := 
#if(doscore)
	#if(doSpray)
		sequential(pre, do1, do2, do3, do4, do5, do6);
	#else
		sequential(do1, do2, do3, do4, do5, do6);
	#end
#else
	#if(doSpray)
		sequential(pre, do2, do3, do4, do5, do6);
	#else
		sequential(do2, do3, do4, do5, do6);
	#end
#end