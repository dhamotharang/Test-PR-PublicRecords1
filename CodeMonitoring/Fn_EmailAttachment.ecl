EXPORT Fn_EmailAttachment(DATASET(Layouts.out) infile) := FUNCTION

  MailData := record, maxlength(10000000)
	 string mail_text;
  end;

Header_ := DATASET([{'attribute,attribute_type,version,latest_version,flags,is_locked,is_checked_out,is_sandbox,is_orphan,modified_by,modified_date,description,\n'}], MailData); 

MailData convertToString(Layouts.out L) := TRANSFORM
           
	  SELF.mail_text := //L.module_name + ','+ 
											//L.name + ','+ 
											L.attribute + ','+ 
											L.attribute_type + ','+ 
											L.version + ','+ 
											L.latest_version  + ','+ 
											L.flags + ','+ 
											//L.access  + ','+ 
											L.is_locked + ','+ 
											L.is_checked_out + ','+ 
											L.is_sandbox + ',"'+ 
											L.is_orphan + '",'+ 
											//L.result_type + ','+ 
											L.modified_by+ ','+ 
											L.modified_date + ','+ 
											L.description +'\n';
										//	L.checksum + ','+
										//	L.attribute +'\n';	                
  END;
  
	StringRecs := Header_ + PROJECT(Infile, convertToString(LEFT));

  MailData convertToText(MailData L, MailData R) := TRANSFORM
  
	  SELF.mail_text := TRIM(L.mail_text) + TRIM(R.mail_text);
    
  END;

  textDs := ROLLUP(stringRecs, 1=1, convertToText(LEFT, RIGHT));

  return textDs[1].mail_text;
end;


 