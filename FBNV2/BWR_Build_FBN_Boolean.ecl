import FBNV2,ut;
import text_search;
export BWR_Build_FBN_Boolean(string filename) :=

function


Mac_isolate_tmsid_rmsid(infile,in_layout,out_layout,outfile) := macro
#uniquename(getkey)
out_layout %getkey%(in_layout L) := transform
 self.tmsid := l.tmsid;
 self.rmsid := l.rmsid;
 self.doc := 0;
end;
outfile := project(infile,%getkey%(left));
endmacro;


// append the key to each of the files
mac_append_key(infile,in_layout,keyfile,layout_keyfile,outfile,layout_outfile) := macro
#uniquename(append_key)
#uniquename(infile_sorted)
%infile_sorted% := sort(distribute(infile,hash32(tmsid,rmsid)),tmsid,rmsid,local);

layout_outfile %append_key%(in_layout L, layout_keyfile K) := transform
	self := l;
	self.doc := k.doc;
	end;
	
outfile := join(%infile_sorted%,keyfile,
				left.tmsid = right.tmsid, //and
				//left.rmsid = right.rmsid,
				%append_key%(left, right),left outer,local);

endmacro;





info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'FBN', filename);

						

inData_bus := FBNV2.File_FBN_Business_Base;
inData_cont := FBNV2.File_FBN_Contact_Base;

// record for mapping tmsid rmsid to doc
layout_tmsid_rmsid := record
typeof(indata_bus.tmsid)  tmsid;
typeof(indata_bus.rmsid)  rmsid;
typeof(text_search.Types.docid) doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;

Mac_isolate_tmsid_rmsid(indata_bus,Layout_Common.Business,layout_tmsid_rmsid,bus_keys);
Mac_isolate_tmsid_rmsid(indata_cont,Layout_Common.contact,layout_tmsid_rmsid,cont_keys);

allkeys := bus_keys + cont_keys;

uniquekeys := dedup(sort(distribute(allkeys,hash32(tmsid,rmsid)),tmsid,rmsid,local),tmsid,rmsid,local);

ut.MAC_Sequence_Records(uniquekeys,doc,fbn_key_translation);


//layout_layout_tmsid_rmsid number_records(layout_tmsid_rmsid L) := transform
// self.doc := (unsigned)(header.Sourcedata_month[3..7] +(string)thorlib.node()+1*thorlib.nodes());
// self := l;
//end;


//fbn_key_translation := project(uniquekeys,number_records(left));

// append doc to both files
Layout_bus_keyed := record
Layout_Common.Business;
unsigned6 doc;
end;

mac_append_key(inData_bus,Layout_Common.Business,
			fbn_key_translation,layout_tmsid_rmsid,
			busdata_keyed,Layout_bus_keyed);

docs_bus := FBNV2.Convert_FBN_Bus_Func(busdata_keyed);


Layout_cont_keyed := record
Layout_Common.contact;
unsigned6 doc;
end;

mac_append_key(inData_cont,Layout_Common.contact,
			fbn_key_translation,layout_tmsid_rmsid,
			contdata_keyed,Layout_cont_keyed);


docs_cont := FBNV2.Convert_FBN_Cont_Func(contdata_keyed);

// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( fbn_key_translation l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.doc;
        self.docref.src := 0;
		self.segment := segno;
        self.content := l.tmsid + l.rmsid;
        self.sect := 1;
    END;

    segkeys := PROJECT(fbn_key_translation,MakeKeySegs(LEFT,250));

 
all_docs := docs_bus + docs_cont + segkeys  : persist('~thor_data400::persist::fbn::boolean');


//fileNameDoc := 'boolean_test::jmw::fbn_test';
//OUTPUT(docs(content <> ''),,fileNameDoc,OVERWRITE);
/* DF-28344
inlkeyname := '~thor_data400::key::fbn::'+filename+'::docref.docref';
inskeyname := '~thor_data400::key::fbn::qa::docref.docref';

build_key := buildindex(fbn_key_translation,{doc,tmsid,rmsid,__filepos},
	inlkeyname, OVERWRITE);
*/

stuff := sequential(
									Text_Search.Build_From_DocSeg_Records(all_docs(content <> ''),info),
									//build_key, //DF-28344
									//Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::fbn::boolean')
									
									);

return stuff;
 
end;