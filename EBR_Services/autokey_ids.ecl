
import autokeyb,doxie,doxie_raw,business_header,EBR;

export autokey_ids(boolean workhard = false, boolean nofail =false) := 
FUNCTION


t :=EBR.constants.Str_autokeyName;

ds := dataset([],EBR_services.layout_autokeyready);
ids := autokeyb.get_IDs(t,'BC',(['C','F']),workHard,noFail);

autokeyb.mac_get_payload(ids,t,ds,outpl,ds.zero,ds.bdid, 'BC')

//***** File Numbers
byak := project(outpl, transform(ebr_services.Layout_file_number,self.file_number:=left.file_number));

//***** BDIDs
bdids := project(ids(isbdid), transform(doxie.Layout_ref_bdid, self.bdid := left.id));

ebr.Layout_0010_Header_Base get_filenumbers(ebr.Key_0010_Header_File_number ri) :=
TRANSFORM
	SELF := ri;
END;

byfile_number :=join(byak,ebr.Key_0010_Header_FILE_NUMBER,left.File_Number=Right.File_Number,get_filenumbers(right),keep(500));

ebr.Layout_0010_Header_Base get_bybdids(ebr.Key_0010_Header_BDID ri) := Transform
	SELF :=ri;
END;


bybdid := join(bdids,ebr.Key_0010_Header_BDID,left.bdid=right.bdid,get_bybdids(right), keep(500));


return dedup(bybdid+byfile_number,all);

END;