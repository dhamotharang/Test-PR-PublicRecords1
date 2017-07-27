






import Corp2,ut;
import text_search;




export BWR_Build_Corp_Boolean(string filename) :=

function



Mac_isolate_key(infile,in_layout,out_layout,outfile) := macro
#uniquename(getkey)
out_layout %getkey%(in_layout L) := transform
 self.corp_key := l.corp_key; 
 self.doc := 0;
end;
outfile := project(infile,%getkey%(left));
endmacro;


// append the key to each of the 5 different files
mac_append_key(infile,in_layout,keyfile,layout_keyfile,outfile,layout_outfile) := macro
#uniquename(append_key)
#uniquename(infile_sorted)
%infile_sorted% := sort(distribute(infile,hash32(corp_key)),corp_key,local);

layout_outfile %append_key%(in_layout L, layout_keyfile K) := transform
	self := l;
	self.doc := k.doc;
	end;
	
outfile := join(%infile_sorted%,keyfile,
				left.corp_key = right.corp_key,%append_key%(left, right),left outer,local);

endmacro;





// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'CORP', filename);

						

//inData := InfoUSA.File_Deadco_base;

layout_corp_key := record
string30  corp_key;
unsigned6 doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;


layout_corp_key isolate_corp_key(Corp2.Layout_Corporate_Direct_Corp_Base l) := transform
self.corp_key := l.corp_key;
self.doc := 0;
end;


//header.Mac_Set_Header_Source(indata,DNB_FEINv2.layout_DNB_fein_base_main,fpos_fein,0,fein_withID);



corpdata := corp2.Files('').Base.Corp.built;
contdata := corp2.Files('').Base.Cont.built;
eventdata := corp2.Files('').Base.Events.built; 
stockdata := corp2.Files('').Base.Stock.built; 
ardata := corp2.Files('').Base.AR.built;




//mac_isolate_key(corpdata,Corp2.Layout_Corporate_Direct_Corp_Base,layout_corp_key,corpkeys);

mac_isolate_key(corpdata,Corp2.Layout_Corporate_Direct_Corp_Base,layout_corp_key,corpkeys);
mac_isolate_key(contdata,Corp2.Layout_Corporate_Direct_Cont_Base,layout_corp_key,contkeys);
mac_isolate_key(eventdata,Corp2.Layout_Corporate_Direct_Event_Base,layout_corp_key,eventkeys);
mac_isolate_key(stockdata,Corp2.Layout_Corporate_Direct_Stock_Base,layout_corp_key,stockkeys);
mac_isolate_key(ardata,Corp2.Layout_Corporate_Direct_AR_Base,layout_corp_key,arkeys);

allkeys := corpkeys + contkeys + eventkeys + stockkeys + arkeys;

uniquekeys := dedup(sort(distribute(allkeys,hash32(corp_key)),corp_key,local),corp_key,local);

//layout_corp_key number_records(layout_corp_key L) := transform
// self.doc := (unsigned)(header.Sourcedata_month[3..7] +(string)thorlib.node()+1*thorlib.nodes());
// self := l;
//end;
 
//corp_key_translation := project(uniquekeys,number_records(left));
// corp_key_translation now has the corp_key and a unique number

ut.MAC_Sequence_Records(uniquekeys,doc,corp_key_translation)



// use this as a mapping from string30 corp_key to unsigned6 srcdoc.doc
// append stcdoc.doc to all records in all 5 files

Layout_Corporate_Direct_Corp_Base_keyed := record
Corp2.Layout_Corporate_Direct_Corp_Base;
unsigned6 doc;
end;

mac_append_key(corpdata,Corp2.Layout_Corporate_Direct_Corp_Base,
				corp_key_translation,layout_corp_key,
				corpdata_keyed,Layout_Corporate_Direct_Corp_Base_keyed);


Layout_Corporate_Direct_Cont_Base_keyed := record
Corp2.Layout_Corporate_Direct_Cont_Base;
unsigned6 doc;
end;

mac_append_key(contdata,Corp2.Layout_Corporate_Direct_Cont_Base,
			corp_key_translation,layout_corp_key,
			contdata_keyed,Layout_Corporate_Direct_Cont_Base_keyed);


Layout_Corporate_Direct_Event_Base_keyed := record
Corp2.Layout_Corporate_Direct_Event_Base;
unsigned6 doc;
end;

mac_append_key(eventdata,Corp2.Layout_Corporate_Direct_Event_Base,
			corp_key_translation,layout_corp_key,
			eventdata_keyed,Layout_Corporate_Direct_Event_Base_keyed);


Layout_Corporate_Direct_Stock_Base_keyed := record
Corp2.Layout_Corporate_Direct_Stock_Base;
unsigned6 doc;
end;

mac_append_key(stockdata,Corp2.Layout_Corporate_Direct_Stock_Base,
			corp_key_translation,layout_corp_key,
			stockdata_keyed,Layout_Corporate_Direct_Stock_Base_keyed);

Layout_Corporate_Direct_ar_Base_keyed := record
Corp2.Layout_Corporate_Direct_AR_Base;
unsigned6 doc;
end;

mac_append_key(ardata,Corp2.Layout_Corporate_Direct_AR_Base,
			corp_key_translation,layout_corp_key,
			ardata_keyed,Layout_Corporate_Direct_AR_Base_keyed);



// call a convert function for each file
// concat all the results
// call the rest of the code

corpdocks := Corp2.Convert_Corp2_Func(corpdata_keyed);
contdocks := Corp2.convert_cont_func(contdata_keyed);
eventdocks := Corp2.convert_event_func(eventdata_keyed);
stockdocks := Corp2.convert_stock_func(stockdata_keyed);
ardocks := Corp2.convert_ar_func(ardata_keyed);

 



fileNameDoc := 'boolean_test::jmw::corp_test';
//OUTPUT(docs(content <> ''),,fileNameDoc,OVERWRITE);

// May need to change high level


docs := corpdocks+contdocks+eventdocks+stockdocks+ardocks : persist('~thor_data400::persist::corp2::boolean');

	
  inlkeyname := '~thor_data400::key::corp2::'+filename+'::docref.docref';
	inskeyname := '~thor_data400::key::corp2::qa::docref.docref';

	build_key := buildindex(corp_key_translation,{doc,corp_key,__filepos},inlkeyname, OVERWRITE);






stuff := sequential(

Text_Search.Build_From_DocSeg_Records(docs(content <> ''),info),
	build_key,
	Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
	fileservices.deletelogicalfile('~thor_data400::persist::corp2::boolean')
);

return stuff;
 
end;