import prte2_header,STD;
EXPORT files := module
EXPORT LaborActions_IN := DATASET(constants.In_LaborActions, Layouts.In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

Export TU_Header := prte2_header.file_header_base(src = 'TU');

EXPORT base_Context := DATASET (constants.Base_PersonContext, Layouts.In_Layout_Work3, THOR);

Export DS_out_LexID	:=	Project(base_context(LexId!=''),
Transform(Layouts.Layout_deltakey_personcontext,
self.lexid:=left.lexid;
self.datagroup := 'PERSON';
self.RecordType := left.Cs_Statement_Type;
self.datatypeversion := 1;
self.dateadded := (string)Std.Date.Today();
SELF.eventtype :='ADD';
self.sourcesystem :='MBS';
self.content := left.CS_Content;
self.statementid:=left.rec_seq;
self:=LEFT; 
self:=[];
));

Export DS_out_LexID_Sort:=sort(DS_out_LexID,statementid);
Export DS_out_RecID :=    DATASET([ ],Layouts.Layout_deltakey_personcontext);

End;