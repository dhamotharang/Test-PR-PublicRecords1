import _control, mdr, doxie, std, ut, watchdog, infutor;
	
	hdrInfutor 		:= infutor.infutor_header;
	
	Header.File_Teaser_Macro(hdrInfutor, hdrInfutorTeaser,false);
	
	addGlobalSID 	:= mdr.macGetGlobalSID(hdrInfutorTeaser,'Infutor','','global_sid'); //DF-26401: Populate Global_SID Field

export File_Teaser_cnsmr := addGlobalSID;