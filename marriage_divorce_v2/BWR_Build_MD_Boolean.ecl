import marriage_divorce_v2;
import text_search;

echo (unsigned6 stuff) := function
return stuff;
end;


// add stuff
export BWR_Build_MD_Boolean(string filename) :=

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'MD', filename);

						

inData := marriage_divorce_v2.file_mar_div_base;


// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( indata l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.record_id;
        self.docref.src := 0;
		self.segment := segno;
        self.content := intformat(l.record_id,15,1);
        self.sect := 1;
    END;

    segkeys := PROJECT(indata,MakeKeySegs(LEFT,250));

 

docs := marriage_divorce_v2.Convert_MD_Func(indata) + segkeys : persist('~thor_data400::persist::mdv2::boolean');

//fileNameDoc := 'boolean_test::jmw::md_test';
//OUTPUT(docs(content <> ''),,fileNameDoc,OVERWRITE);

// May need to change high level

	inlkeyname := '~thor_data400::key::md::'+filename+'::docref.docref';
	inskeyname := '~thor_data400::key::md::qa::docref.docref';

	build_key := buildindex(indata,{record_id,echo(record_id),0},inlkeyname, OVERWRITE);


	stuff := sequential(build_key,
											Text_Search.Build_From_DocSeg_Records(docs(content <> ''),info),
											Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
											fileservices.deletelogicalfile('~thor_data400::persist::mdv2::boolean')
											);	

	return stuff;
 
end;