

//export BWR_Build_FEIN_Boolean := 'todo';

// change this


import MFIND;
import text_search;
import lib_stringlib;
import header;

export BWR_Build_MFind_Boolean(string filedate) := function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'MFIND', filedate);

						
//inData := choosen(DNB_FEINV2.File_DNB_Fein_base_main,10000000);
inData := MFind.File_MFind_Clean;

fpos_mfind := record
MFind.Layout_Clean_MFind;
unsigned6 uid;
unsigned2 src;
end;
// append fpos to the origional file for the lookup key
//header.Mac_Set_Header_Source(indata,MFind.Layout_Clean_MFind,fpos_mfind,hash32(l.FILE_ID),mfind_withID)
header.Mac_Set_Header_Source(indata,MFind.Layout_Clean_MFind,fpos_mfind,0,mfind_withID);



docs := MFIND.Convert_MFIND_Func(mfind_withID);

string_rec := record
		unsigned2 src;
		unsigned6 doc;
		unsigned2 src2;
		string84 doc2;		
		unsigned8 __filepos {virtual (fileposition)} := 0;
end;

proj_map := project(mfind_withID,transform(string_rec,
								 self.src :=  left.src;
								 self.doc := left.uid;
								 self.src2 := left.src;
								 self.doc2 := left.TRIM_VID;
							
								 self := left));

dist_map := distribute(proj_map,doc);
sort_map := sort(dist_map,src,doc,local);
tmsid_map := dedup(sort_map,src,doc,local);


//fileNameDoc := 'boolean_test::jmw::MFIND_test';
//OUTPUT(docs(content <> ''),,fileNameDoc,OVERWRITE);

// May need to change high level

inlkeyname := '~thor_data400::key::mfind::'+filedate+'::docref.tmsid';
inskeyname := '~thor_data400::key::mfind::qa::docref.tmsid';


retval := sequential
					(
					buildindex(tmsid_map,{src,doc,src2,doc2,__filepos},inlkeyname, OVERWRITE),
					Text_Search.Build_From_DocSeg_Records(docs(
								lib_stringlib.StringLib.StringFilterOut(content,';') <> ''),info),
					Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname)
					);


return retval;

end;

