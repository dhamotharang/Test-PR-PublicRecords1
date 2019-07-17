import dx_FirstData;
loadfile := DATASET('~thor_data400::base::FirstData::qa::firstdata'
																					,firstdata.layout.base,THOR,__compressed__,OPT);
																					
convertFile:=project(loadfile(trim(lex_id,left,right)<>''),transform(dx_FirstData.layouts.i_did,self.LEX_ID:=(UNSIGNED6)Left.LEX_ID;self:=left;));

EXPORT data_key_did_fcra := convertFile;