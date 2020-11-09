import DNB_FEINV2;
import text_search;
import header;

export BWR_Build_FEIN_Boolean(string filedate) := function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'FEINV2', filedate);

						
//inData := choosen(DNB_FEINV2.File_DNB_Fein_base_main,10000000);
inData := DNB_FEINV2.File_DNB_Fein_base_main;


fpos_fein := record
DNB_FEINv2.layout_DNB_fein_base_main;
unsigned6 uid;
unsigned2 src;
end;
header.Mac_Set_Header_Source(indata,DNB_FEINv2.layout_DNB_fein_base_main,fpos_fein,0,fein_withID);

// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( fein_withID l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.uid;
        self.docref.src := 0;
		self.segment := segno;
        self.content := l.tmsid;
        self.sect := 1;
    END;

    segkeys := PROJECT(fein_withID,MakeKeySegs(LEFT,250));



docs := DNB_FEINV2.Convert_FEIN_Func(fein_withID) + segkeys : persist('~thor_data400::persist::feinv2::boolean');


string_rec := record
		unsigned2 src;
		unsigned6 doc;
		unsigned2 src2;
		string50 doc2;		
		unsigned8 __filepos {virtual (fileposition)} := 0;

end;

proj_map := project(fein_withID,transform(string_rec,
								 self.src :=  left.src;
								 self.doc := left.uid;
								 self.src2 := left.src;
								 self.doc2 := left.tmsid;
							
								 self := left));


dist_map := distribute(proj_map,hash(doc));
sort_map := sort(dist_map,src,doc,local);
tmsid_map := dedup(sort_map,src,doc,local);

/* DF-28347
inlkeyname := '~thor_data400::key::feinv2::'+filedate+'::map.key';
inskeyname := '~thor_data400::key::feinv2::qa::map.key';

build_key := buildindex(tmsid_map,{src,doc,src2,doc2,__filepos},inlkeyname, OVERWRITE);
*/
retval := sequential(
									//build_key, //DF-28347
									Text_Search.Build_From_DocSeg_Records(docs(content <> ''),info),
									//Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::feinv2::boolean')
									);



return retval;

end;
