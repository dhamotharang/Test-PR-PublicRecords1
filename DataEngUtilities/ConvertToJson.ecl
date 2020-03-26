EXPORT ConvertToJson(Packagename = '', FileName = '', FileToJSON) := functionmacro	
	Package:=PackageName;
	File:=FileName;
	inrec:=recordof(FileToJSON);
	#declare(JSONString);
	#declare(LayoutString);
	#declare(FinalString);
	#declare(precomma);
	#declare(firstfield);
	#set(firstfield,'1');
	#set(JSONString,Packagename+':'+FileName+'\r\n{');
	// #set(LayoutString,'inrec:=recordof\r\n');
	#set(precomma,'');
	#exportXML(FIELDLIST,recordof(FileToJSON));
	#FOR(FieldList)
		#DECLARE(thisChild)
		#SET(thisChild,'')
		#DECLARE(thisRec)
		#SET(thisRec,'')
			#FOR(field)
				#IF(%'@isDataset'%='1')
					#SET(thisChild,%'@name'%)
					#APPEND(JSONString,'\r\n\"'+%'@name'%+'\":[');
					#set(firstfield,'');
					#set(precomma,'');
				#ELSEIF(%'@isRecord'%='1')
					#SET(thisRec,%'@name'%+'.')
					#APPEND(JSONString,'\r\n\"'+%'@name'%+'\":{');
					#set(firstfield,'');
					#set(precomma,'');
				#ELSEIF(%'@isEnd'%='1')
					#IF(%'thisRec'%<>'')
						#APPEND(JSONString,'\r\n}');
					#END
					#IF(%'thisChild'%<>'')
						#APPEND(JSONString,'\r\n]');
					#END
					#SET(thisChild,'')
					#SET(thisRec,'')
				#ELSE
					#if(%'@type'% in ['string','qstring'])
						#APPEND(JSONString,%'precomma'%+'\r\n\"'+%'@name'%+'\":\"1\"');
					#elseif(%'@type'% in ['unsigned','decimal','integer'])
						#APPEND(JSONString,%'precomma'%+'\r\n"'+%'@name'%+'\":1');
					#else
						#APPEND(JSONString,%'precomma'%+'\r\n'+%'@name'%+':true');
					#end
					#set(firstfield,'1');
				#end
				#if(%'firstfield'%='1')
					#set(precomma,',');
				#end
			#end
	#END
	// #APPEND(LayoutString,'end;\r\n\r\n');
	#APPEND(JSONString,'\r\n}\r\n');
	// #set(FinalString,%'LayoutString'% + %'JSONString'%);
	// %JSONString%;
	// return returnstring;
	return %'JSONString'%;
endmacro;