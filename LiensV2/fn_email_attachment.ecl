import _control;
EXPORT fn_email_attachment(DATASET(Layout_TMSIDRMSID_Mappingfile) MappingFile ) := function

  mail_data := record, maxlength(10000000)
	 string mail_text;
  end;

header_ := dataset([{'TMSID_old,RMSID_old,TMSID,RMSID\n'}], mail_data); 
  mail_data convertToString(Layout_TMSIDRMSID_Mappingfile L) := TRANSFORM
	  SELF.mail_text := L.TMSID_old + ','+ 
											L.RMSID_old + ','+ 
											L.TMSID + ','+ 
											L.RMSID + '\n';	                
  END;
  
	stringRecs := header_ + project(MappingFile, convertToString(LEFT));

  mail_data convertToText(mail_data L, mail_data R) := TRANSFORM
	  SELF.mail_text := trim(L.mail_text) + trim(R.mail_text);
  END;

  textDs := ROLLUP(stringRecs, 1=1, convertToText(LEFT, RIGHT));

  return(textDs[1].mail_text);
	
																											 
end;


 