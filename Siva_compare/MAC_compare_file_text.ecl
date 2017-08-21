export MAC_compare_file_text(inputFile,inputHash, primary_list ) := macro
LOADXML('<xml/>');

#EXPORTXML(doCleanFieldMetaInfo1, recordof(inputFile))




inputHash := PROJECT(inputFile, transform({recordof(inputfile), string6000 text_string}, 
    


#IF (%'dohashText1'%='')
 #DECLARE(dohashText1)
#END

#DECLARE (Ndx)

#SET (dohashText1, false)
#DECLARE(dofirst1)
#SET (dofirst1, '')
#SET (dohashText1,'self.text_string :=  ')
#SET (Ndx, 1)

#FOR (doCleanFieldMetaInfo1)
 #FOR (Field)
 #if (( StringLib.StringToUpperCase(%'@name'%)   not in primary_list ) and  (%'@name'%  not in ['flag_data','hash_combine']) )
  #if (%'dofirst1'% ='') 
			#IF (%'@type'% = 'string') 
					#APPEND ( dohashText1, ' if ( left.' +  %'@name'% + ' =  \'1\' ' + ',\' ' +  %'@name'% +  '\',' + '\'' + '\'' + ')' )
			#ELSEif  (%'@type'% = 'boolean')
			    #APPEND ( dohashText1, ' if ( left.' +  %'@name'% + ' =  true ' + ',\' ' +  %'@name'% +  '\',' + '\'' + '\'' + ')' )
			#else
					#APPEND (dohashText1, '  if ( left.' +  %'@name'% + ' =  1 ' + ',\' ' +  %'@name'% +  '\',' + '\'' + '\'' + ')' )
			#END
			#SET (dofirst1, 'not')
  #ELSE
			#IF (%'@type'% = 'string') 
					#APPEND ( dohashText1, '+' + ' if ( left.' +  %'@name'% + ' =  \'1\' ' + ',\' ' + ',' +  %'@name'% +  '\',' + '\'' + '\'' + ')' )
		  #ELSEif  (%'@type'% = 'boolean')
			    #APPEND ( dohashText1, '+' +  'if ( left.' +  %'@name'% + ' =  true ' + ',\' ' +  ',' + %'@name'% +  '\',' + '\'' + '\'' + ')' )
			#else			
					#APPEND (dohashText1, '+' + '  if ( left.' +  %'@name'% + ' =  1 ' + ',\' ' + ',' +  %'@name'% +  '\',' + '\'' + '\'' + ')' )
			#END
			#SET (Ndx, %Ndx% + 1)
	#END
 #END	
 #END
#END

#APPEND (dohashText1, ' ,' )

 %dohashText1%;




#IF (%'doCleanFieldText1'%='')
 #DECLARE(doCleanFieldText1)
#END
#SET (doCleanFieldText1, false)
#SET (doCleanFieldText1, 'SELF := LEFT ))');

		
%doCleanFieldText1%;


endmacro;