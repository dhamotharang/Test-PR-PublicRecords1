import InfoUSA;
import text_search;

export bwr_build_abius_boolean(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'ABIUS', filedate);

inData := PROJECT(InfoUSA.File_ABIUS_Company_Base_AID,TRANSFORM(InfoUSA.Layout_ABIUS_Company_Base,SELF := LEFT;));

// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( indata l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := (unsigned6)hash32(l.abi_number);
        self.docref.src := 0;
		self.segment := segno;
        self.content := l.abi_number;
        self.sect := 1;
    END;

    segkeys := PROJECT(indata,MakeKeySegs(LEFT,250));

docs := InfoUSA.Convert_ABIUS_Func(indata) + segkeys : persist('~thor_data400::persist::abius::boolean');

string_rec := record
		unsigned2 src;
		unsigned6 doc;
		string9 abi_number;		
		unsigned8 __filepos {virtual (fileposition)} := 0;

end;

proj_map := project(indata,transform(string_rec,
								 self.src :=  0;
								 self.doc := (unsigned6)hash32(left.abi_number);
								 self.abi_number := left.abi_number;
								 self := left));


dist_map := distribute(proj_map,hash(doc));
sort_map := sort(dist_map,src,doc,local);
tmsid_map := dedup(sort_map,src,doc,local);

inlkeyname := '~thor_data400::key::abius::'+filedate+'::doc.abinumber';
inskeyname := '~thor_data400::key::abius::qa::doc.abinumber';

build_key := buildindex(tmsid_map,{src,doc,abi_number,__filepos},inlkeyname, OVERWRITE);


retval := sequential(
									build_key,
									Text_Search.Build_From_DocSeg_Records(docs(content <> ''),info),
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::abius::boolean')
									);

return retval;

end;
