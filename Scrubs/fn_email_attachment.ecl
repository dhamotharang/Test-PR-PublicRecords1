EXPORT fn_email_attachment(DATASET(layouts.StatsOutLayout) ScrubsStas) := function

  mail_data := record, maxlength(10000000)
	 string mail_text;
  end;

header_ := dataset([{'processDate,RecordsTotal,SourceCode,FieldName,RuleName,RuleDesc,Rulecnt,RulePcnt,RuleThreshold,RejectWarning,InvalidValue,InvalidValueCnt,Code,Severity\n'}], mail_data); 
  mail_data convertToString(layouts.StatsOutLayout L) := TRANSFORM
	  SELF.mail_text := L.processDate + ','+ 
											L.RecordsTotal + ','+ 
											L.SourceCode + ','+ 
											L.FieldName + ','+ 
											L.RuleName  + ','+ 
											L.RuleDesc + ','+ 
											L.Rulecnt  + ','+ 
											L.RulePcnt + ','+ 
											L.RuleThreshold + ','+ 
											L.RejectWarning + ',"'+ 
											L.InvalidValue + '",'+ 
											L.InvalidValueCnt + ','+ 
											L.Code+ ','+ 
											L.Severity +'\n';	                
  END;
  
	stringRecs := header_ + project(ScrubsStas, convertToString(LEFT));

  mail_data convertToText(mail_data L, mail_data R) := TRANSFORM
	  SELF.mail_text := trim(L.mail_text) + trim(R.mail_text);
  END;

  textDs := ROLLUP(stringRecs, 1=1, convertToText(LEFT, RIGHT));

  return textDs[1].mail_text;
end;


 