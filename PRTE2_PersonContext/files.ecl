
EXPORT files := module
EXPORT LaborActions_IN := DATASET(constants.In_LaborActions, Layouts.In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT Base_Context := DATASET (constants.Base_PersonContext, Layouts.In_Layout, THOR);

 Export DS_out_LexID	:=	Project(base_context,
  Transform(Layouts.Layout_deltakey_personcontext,
   self.lexid:=left.lexid;
	 self.cd_id:=left.cd_id;
   self.datagroup := left.datagroup;
   self.RecordType := left.recordtype;
   self.datatypeversion := (integer)left.data_type_version;
   self.dateadded := left.dataadded;
   SELF.eventtype :=left.eventtype;
   self.sourcesystem :=left.source_system;
	 self.StatementSequence :=(integer)left.Statement_Sequence;
	 self.StatementID :=(integer)left.StatementID;
   self.content := left.Content;
   self:=LEFT; 
   self:=[];
 ));
 Export DS_out_RecID :=    DATASET([ ],Layouts.Layout_deltakey_personcontext);

End;