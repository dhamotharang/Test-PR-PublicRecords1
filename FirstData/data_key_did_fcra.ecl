import dx_FirstData;
EXPORT data_key_did_fcra(string pVersion = '') := function 
    loadfile := DATASET(Filenames(pVersion).base.firstdata.new ,firstdata.layout.base,THOR,__compressed__,OPT);
                                                                                        
    convertFile:=project(loadfile(trim(lex_id,left,right)<>''),transform(dx_FirstData.layouts.i_did,self.LEX_ID:=(UNSIGNED6)Left.LEX_ID;
                                                                                            self.DATE_FIRST_SEEN:=left.FIRST_SEEN_DATE_TRUE;
                                                                                            self.DATE_LAST_SEEN:=left.LAST_SEEN_DATE;
                                                                                            self:=left;));
    return convertFile;
end;

