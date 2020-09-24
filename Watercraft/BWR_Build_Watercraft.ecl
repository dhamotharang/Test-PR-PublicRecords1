import Text_Search,Liensv2,header,Roxiekeybuild;

export bwr_build_watercraft(string filedate) := function

// File name template
info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'WATERCRAFT', filedate);

// Join all 3 watercraft files (main, search and coastgaurd)
wc_uid := watercraft.Create_Watercraft_file(filedate) : persist('~thor_data400::persist::watercraft::boolean');

// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( wc_uid l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.uid;
        self.docref.src := TRANSFER(l.src, INTEGER2);;
		self.segment := segno;
        self.content := l.watercraft_key + l.sequence_key + l.state_origin;
        self.sect := 1;
    END;

    segkeys := PROJECT(wc_uid,MakeKeySegs(LEFT,250));

 
// Convert to Text search document format
ret := Watercraft.Convert_watercraft_Func(wc_uid) + segkeys;

// Distribute the document records
dist_ret := distribute(ret,hash32(docref.doc));

// Logical and super key names for UID key
luidkey := '~thor_data400::key::watercraft::'+filedate+'::uid_map';
suidkey := '~thor_data400::key::watercraft::qa::uid_map';

// UID key build

uid_rec := record
	wc_uid.uid;
	wc_uid.watercraft_key;
	wc_uid.sequence_key;
	wc_uid.state_origin;
end;

uid_table := table(wc_uid,uid_rec);

uidkey := index(uid_table,{uid},{watercraft_key,sequence_key,state_origin},'~thor_data400::key::watercraft::qa::uid_map');

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(uidkey,
																					suidkey,
																					luidkey,
																					uid_key);
// Return value
retval := sequential 
							(
							Text_Search.Build_From_DocSeg_Records(dist_ret,info),
							//uid_key,
							//Text_Search.Boolean_Move_To_QA(suidkey,luidkey),
							fileservices.deletelogicalfile('~thor_data400::persist::watercraft::boolean')
							);
							
return retval;

end;
