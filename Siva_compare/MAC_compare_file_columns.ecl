export MAC_compare_file_columns(inputFile,inputHash, no_of_keys, primary_list, key1, key2, key3 ) := macro




LOADXML('<xml/>');

#EXPORTXML(doCleanFieldMetaInfo1, recordof(inputFile))


#UNIQUENAME(df1)
%df1% := inputFile(flag_data =1 );


#UNIQUENAME(df2)
%df2% := inputFile(flag_data =2 );




#UNIQUENAME(chk_files)

%chk_files% :=  join(%df1% , %df2%,

	 #if ( (integer) no_of_keys = 1 )
											 (qstring) left.key1 = (qstring) right.key1 ,
											
											
	 #elseif ( (integer) no_of_keys = 3 )
	                     (qstring) left.key1 = (qstring) right.key1  and		 
											 (qstring) left.key2 = (qstring) right.key2  and
											 (qstring) left.key3 = (qstring) right.key3 ,
	 #elseif ( (integer) no_of_keys = 2 )
                       (qstring) left.key1 = (qstring) right.key1  and		                   
											 (qstring) left.key2 = (qstring) right.key2  ,
	 #end	

                    // (qstring) left.key1  = (qstring) right.key1 and
										// (qstring) left.key2  = (qstring) right.key2 and
										// (qstring) left.key3  = (qstring) right.key3 ,
										
                     transform({recordof(%df1%) }, 

#DECLARE (dohashText1)
#SET (dohashText1,'')



// array_list := ['flag_data','hash_combine', 'operatorid','sequencenum', 'textlineseq'];

#FOR (doCleanFieldMetaInfo1)
 #FOR (Field)
 #IF (( %'@name'%  not in primary_list ) and (%'@name'%  not in ['flag_data','hash_combine']) )
  #IF (%'@type'% <> 'string')
	  #APPEND (dohashText1, ' self. ' +  %'@name'% + ' := if(left.' + %'@name'% + ' = right.' + %'@name'% + ', 0, 1 );' )
	#ELSE
		#APPEND (dohashText1, ' self. ' +  %'@name'% + ' := if(left.' + %'@name'% + ' = right.' + %'@name'% + ',' + '\'0\',\'1\');' )
	#END	
 #END	
 #END 
#END

 
  %dohashText1%;




#IF (%'doCleanFieldText1'%='')
 #DECLARE(doCleanFieldText1)
#END
#SET (doCleanFieldText1, false)
#SET (doCleanFieldText1, ' SELF := LEFT ), local );')

		
%doCleanFieldText1%;


inputHash := %chk_files%;


endmacro;