export MAC_compare_file_filter (inputFile, outfile ) := macro
LOADXML('<xml/>');

#EXPORTXML(doCleanFieldMetaInfo1, recordof(inputFile))

 // output(inputfile);


#UNIQUENAME(filter_files)
%filter_files% := inputFile (  

#DECLARE (dohashText2)
#SET (dohashText2,'')

#DECLARE(dofirst1)
#SET (dofirst1, '')


#FOR (doCleanFieldMetaInfo1)
 #FOR (Field)
 #IF (%'@name'% not in ['flag_data','hash_combine', 'operatorid','sequencenum','textlineseq']) 
  #if (%'dofirst1'% ='') 
		#IF (%'@type'% <> 'string')
			#APPEND (dohashText2, %'@name'% + ' > 0 ' )
		#ELSE
			#APPEND (dohashText2, %'@name'% + ' > \'0\' ' )
		#END	
		#SET (dofirst1, 'not')
 #ELSE
  #IF (%'@type'% <> 'string')
	  #APPEND (dohashText2, ' or '  +  %'@name'% + ' > 0 ' )
	#ELSE
		#APPEND (dohashText2, ' or '  +  %'@name'% + ' > \'0\' ' )
  #END	
 
 #END
#END	
#END 
#END

 
  %dohashText2%


#IF (%'doCleanFieldText2'%='')
 #DECLARE(doCleanFieldText2)
#END
#SET (doCleanFieldText2, false)
#SET (doCleanFieldText2, ' );')

%doCleanFieldText2%;

outfile := %filter_files% ;

endmacro;