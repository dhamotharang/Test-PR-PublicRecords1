import SANCTN,ut;
import text_search;




export BWR_Build_Sanc_Boolean(string filename) := function


Mac_isolate_key(infile,in_layout,out_layout,outfile) := macro
#uniquename(getkey)
out_layout %getkey%(in_layout L) := transform
 self.BATCH_NUMBER := l.BATCH_NUMBER; 
 self.INCIDENT_NUMBER := l.INCIDENT_NUMBER;
 self.doc := 0;
end;
outfile := project(infile,%getkey%(left));
endmacro;




// append the key to each of the 5 different files
mac_append_key(infile,in_layout,keyfile,layout_keyfile,outfile,layout_outfile) := macro
#uniquename(append_key)
#uniquename(infile_sorted)
%infile_sorted% := sort(distribute(infile,hash32(INCIDENT_NUMBER)),INCIDENT_NUMBER,local);

layout_outfile %append_key%(in_layout L, layout_keyfile K) := transform
	self := l;
	self.doc := k.doc;
	end;
	
outfile := join(
				%infile_sorted%,
				keyfile,
				left.INCIDENT_NUMBER = right.INCIDENT_NUMBER and 
				left.BATCH_NUMBER = right.BATCH_NUMBER,
				%append_key%(left, right),left outer,local);

endmacro;





// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'SANCTN', filename);

						

//inData := InfoUSA.File_Deadco_base;

layout_sanc_key := record
STRING8   BATCH_NUMBER;
STRING8   INCIDENT_NUMBER;
unsigned6 doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;



//layout_sanc_key isolate_sanc_key(Corp2.Layout_Corporate_Direct_Corp_Base l) := transform
//self.corp_key := l.corp_key;
//self.doc := 0;
//end;



incident_data := SANCTN.file_out_incident_cleaned;
party_data := SANCTN.file_out_party_cleaned;

mac_isolate_key(incident_data,SANCTN.layout_SANCTN_incident_clean,layout_sanc_key,incident_keys);
mac_isolate_key(party_data,SANCTN.layout_SANCTN_party_clean,layout_sanc_key,party_keys);

allkeys := incident_keys + party_keys;

uniquekeys := dedup(sort(distribute(allkeys,hash32(INCIDENT_NUMBER)),INCIDENT_NUMBER,local),INCIDENT_NUMBER,local);

ut.MAC_Sequence_Records(uniquekeys,doc,sanc_key_translation)



// use this as a mapping from string30 corp_key to unsigned6 srcdoc.doc
// append stcdoc.doc to all records in all 5 files

layout_SANCTN_incident_clean_keyed := record
SANCTN.layout_SANCTN_incident_clean;
unsigned6 doc;
end;

mac_append_key(incident_data,
				SANCTN.layout_SANCTN_incident_clean,
				sanc_key_translation,
				layout_sanc_key,
				incident_data_keyed,
				layout_SANCTN_incident_clean_keyed);


layout_SANCTN_party_clean_keyed := record
SANCTN.layout_SANCTN_party_clean;
unsigned6 doc;
end;

mac_append_key(party_data,SANCTN.layout_SANCTN_party_clean,
			sanc_key_translation,layout_sanc_key,
			party_data_keyed,layout_SANCTN_party_clean_keyed);


inc_docs := SANCTN.Convert_Incident_Func(incident_data_keyed);
party_docs := SANCTN.Convert_Party_Func(party_data_keyed);

// External key incident
	
	Text_Search.layout_DocSeg MakeKeySegs( incident_data_keyed l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.doc;
        self.docref.src := 0;
		self.segment := segno;
        self.content := l.BATCH_NUMBER+l.INCIDENT_NUMBER;
        self.sect := 1;
    END;

    inc_segkeys := PROJECT(incident_data_keyed,MakeKeySegs(LEFT,250));

// External key party
	
	Text_Search.layout_DocSeg party_MakeKeySegs( party_data_keyed l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.doc;
        self.docref.src := 0;
		self.segment := segno;
        self.content := l.BATCH_NUMBER+l.INCIDENT_NUMBER;
        self.sect := 1;
    END;

    party_segkeys := PROJECT(party_data_keyed,party_MakeKeySegs(LEFT,250));

fileNameDoc := 'boolean_test::jmw::corp_test';
//OUTPUT(docs(content <> ''),,fileNameDoc,OVERWRITE);

// May need to change high level


docs := inc_docs + party_docs + inc_segkeys + party_segkeys : persist('~thor_data400::persist::sanctn::boolean');

	
  inlkeyname := '~thor_data400::key::sanctn::'+filename+'::docref.docref';
	inskeyname := '~thor_data400::key::sanctn::qa::docref.docref';

	build_key := buildindex(sanc_key_translation,{doc,INCIDENT_NUMBER,BATCH_NUMBER,__filepos},inlkeyname, OVERWRITE);

stuff := sequential(

Text_Search.Build_From_DocSeg_Records(docs(content <> ''),info),
	//build_key,
	//Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
	fileservices.deletelogicalfile('~thor_data400::persist::sanctn::boolean')
);

return stuff;
 
end;