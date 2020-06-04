EXPORT modCSV := MODULE 
  //Code to convert to a CSV and send in an email
  EXPORT macConvertToCSV(dInput,bNoHeader) := FUNCTIONMACRO
    IMPORT tools AS pkgTools;
		  pkgTools.mac_ConvertToCsv(dInput, dOutCSV);
    RETURN IF(bNoHeader,dOutCSV[2..],dOutCSV);
  ENDMACRO;
  EXPORT macAttachData(dInput) := FUNCTIONMACRO
    RETURN ROLLUP(dInput, TRUE, TRANSFORM(RECORDOF(LEFT), SELF.payload := TRIM(LEFT.payload) + '\n' + TRIM(RIGHT.payload)))[1].payload;
  ENDMACRO;
	EXPORT EmailAsCSV(msg, sCSVName, sTo, sSubject, sBody) := FUNCTIONMACRO
    IMPORT STD AS pkgSTD;
		attachment := (DATA)BizLinkFull_ELERT.modCSV.macAttachData(msg);
    RETURN pkgSTD.System.Email.SendEmailAttachData(sTo, sSubject, sBody, attachment, 'text/csv', sCSVName+'.csv');
  ENDMACRO;
END;
