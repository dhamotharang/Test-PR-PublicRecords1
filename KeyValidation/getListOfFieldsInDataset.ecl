EXPORT getListOfFieldsInDataset(inData) := functionmacro
   import ashirey, std;
   ashirey.Flatten(inData, flattenedInData);
	 
	 loadxml('<xml/>');
	 #exportxml(flatInDataLayoutXML, recordof(flattenedInData));
	 
	 #declare(stringOfFields)
	 #set(stringOfFields,'');
	 #for(flatInDataLayoutXML)
	   #for(Field)
		   #if(%'{@isEnd}'% = '')
		     #append(stringOfFields, %'{@label}'% + ',');
			 #end
			#end
	 #end
	 
	 // loadxml('<xml/>');
	 // #exportxml(keyLayoutXML, recordof(keyFile));
	 
	 // #declare(commonFields)
	 // #set(commonFields,'');
	 // #for(keyLayoutXML)
	   // #for(Field)
		   // #if(%'{@isEnd}'% = '')
			   // #if(%'{@label}'% in std.str.splitwords(%'stringOfFields'%, ','))
		      // #append(commonFields, %'{@label}'% + ',');
				 // #end
			 // #end
			// #end
	 // #end
	 
	 
	 return dataset(std.str.splitwords(%'stringOfFields'%, ','), {string fieldName});
	 // return %'commonFields'%;
	 
endmacro;