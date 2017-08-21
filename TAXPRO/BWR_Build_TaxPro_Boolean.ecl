









import TAXPRO,ut;
import text_search;




export BWR_Build_TaxPro_Boolean(string filename) :=

function



// append the key to each of the files
mac_append_key(infile,in_layout,keyfile,layout_keyfile,outfile,layout_outfile) := macro
#uniquename(append_key)
#uniquename(infile_sorted)
%infile_sorted% := sort(distribute(infile,hash32(tmsid)),tmsid,local);

layout_outfile %append_key%(in_layout L, layout_keyfile K) := transform
	self := l;
	self.doc := k.doc;
	end;
	
outfile := join(%infile_sorted%,keyfile,
				left.tmsid = right.tmsid, //and
				//left.rmsid = right.rmsid,
				%append_key%(left, right),left outer,local);

endmacro;

info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'TAXPRO', filename);

						

inData := TAXPRO.File_Base;




// record for mapping tmsid rmsid to doc
layout_tmsid := record
typeof(Taxpro.File_Base.tmsid)  tmsid;
typeof(text_search.Types.DocID) doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;

// take a slice of the file .... just tmsid
layout_tmsid slice_file(Layout.Taxpro_Standard_Base l ) := transform

	self := l;
	self.doc := 0;
	end;


//Mac_isolate_tmsid_rmsid(indata_bus,Layout_Common.Business,layout_tmsid_rmsid,bus_keys);
//Mac_isolate_tmsid_rmsid(indata_cont,Layout_Common.contact,layout_tmsid_rmsid,cont_keys);

allkeys := project(inData,slice_file(left));

uniquekeys := dedup(sort(distribute(allkeys,hash32(tmsid)),tmsid,local),tmsid,local);

ut.MAC_Sequence_Records(uniquekeys,doc,taxpro_key_translation);

// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( taxpro_key_translation l, unsigned2 segno ) := TRANSFORM
        self.docref.doc := l.doc;
        self.docref.src := 0;
		self.segment := segno;
        self.content := trim(l.tmsid);
        self.sect := 1;
    END;

    segkeys := PROJECT(taxpro_key_translation,MakeKeySegs(LEFT,250));

//layout_layout_tmsid_rmsid number_records(layout_tmsid_rmsid L) := transform
// self.doc := (unsigned)(header.Sourcedata_month[3..7] +(string)thorlib.node()+1*thorlib.nodes());
// self := l;
//end;


//fbn_key_translation := project(uniquekeys,number_records(left));

// append doc to both files
Layout_TaxPro_keyed := record
Layout.Taxpro_Standard_Base;
unsigned6 doc;
end;

mac_append_key(inData,Layout.Taxpro_Standard_Base,
			taxpro_key_translation,layout_tmsid,
			taxpro_keyed,Layout_TaxPro_keyed);

docs := TAXPRO.Convert_TaxPro_Func(taxpro_keyed) + segkeys : persist('~thor_data400::persist::taxpro::boolean');


 
all_docs := docs;

inlkeyname := '~thor_data400::key::taxpro::'+filename+'::docref.docref';
inskeyname := '~thor_data400::key::taxpro::qa::docref.docref';

build_key := buildindex(taxpro_key_translation,{doc,tmsid,__filepos},
								inlkeyname, OVERWRITE);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(all_docs(content <> ''),info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::taxpro::boolean')
									
									);
return retval;
 
end;