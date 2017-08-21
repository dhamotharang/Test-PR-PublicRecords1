export MAC_compare_files(inputFile,inputHash, file_no, primary_list) := macro
LOADXML('<xml/>');

#EXPORTXML(doCleanFieldMetaInfo1, recordof(inputFile))




// inputHash := PROJECT(inputFile, transform({recordof(inputfile), string60 hash_combine,  integer1 flag_data }, 
inputHash := PROJECT(inputFile, transform( { string80 key1 , string80 key2 , string80 key3, string60 hash_combine,  integer1 flag_data }, 
    self.flag_data := file_no ;

	 


#IF (%'dohashText1'%='')
 #DECLARE(dohashText1)
#END


#IF (%'dokeyText1'%='')
 #DECLARE(dokeyText1)
#END

#IF (%'dokeyText2'%='')
 #DECLARE(dokeyText2)
#END

#IF (%'dokeyText3'%='')
 #DECLARE(dokeyText3)
#END

#DECLARE (Ndx)

#SET (dohashText1, false)

#SET (dokeyText1, false)
#SET (dokeyText2, false)
#SET (dokeyText3, false)

#DECLARE(dofirst1)
#SET (dofirst1, '')

#DECLARE(dofirst11)
#SET (dofirst11, '')

#SET (dokeyText1,'self.key1 := ') 
#SET (dokeyText2,'self.key2 := ') 
#SET (dokeyText3,'self.key3 := ') 

#SET (dohashText1,'self.hash_combine :=  (string80)hash64(')
#SET (Ndx, 1)

#FOR (doCleanFieldMetaInfo1)
 #FOR (Field)

 
 #if ( StringLib.StringToUpperCase(%'@name'%) not in  primary_list )
 
  #if (%'dofirst1'% ='') 
			#IF (%'@type'% = 'string') 
					#APPEND (dohashText1, 'trim(left.' +  %'@name'% + ', all)  ')
			#ELSE
					#APPEND (dohashText1, 'left.' +  %'@name'%  )
			#END
			#SET (dofirst1, 'not')
  #ELSE
			#IF (%'@type'% = 'string') 
					#APPEND (dohashText1, ', trim(left.' +  %'@name'% + ', all)  ')
			#ELSE
					#APPEND (dohashText1, ', left.' +  %'@name'%  )
			#END
			#SET (Ndx, %Ndx% + 1)
	#END
	

#ELSE

    #IF (%'dofirst11'% ='')  
		  #IF (%'@type'% = 'string')     
				#APPEND (dokeyText1 , ' left.' + %'@name'%   )
		  #ELSE
				#APPEND (dokeyText1 , ' (string) left.' + %'@name'%   )
			#END
			#SET (dofirst11, '1st')
	  #elseif  (%'dofirst11'% ='1st' )
		  #IF (%'@type'% = 'string')
		     #APPEND (dokeyText2 , '  left.' + %'@name'%   )
			#ELSE
			   #APPEND (dokeyText2 , ' (string)  left.' + %'@name'%  )
			#END
			#SET (dofirst11, '2nd')
		#else
			#IF (%'@type'% = 'string')
		     #APPEND (dokeyText3 , '  left.' + %'@name'%   )
			#ELSE
			   #APPEND (dokeyText3 , ' (string)  left.' + %'@name'%  )
			#END
      #SET (dofirst11, '3rd')	
		#END
				
 #END

 
 #END
 
 
		
#END



#APPEND (dohashText1, '), ' )


  #IF (%'dofirst11'% ='1st') 
	    #APPEND (dokeyText2 , '\'\'' ) 
			#APPEND (dokeyText3 , '\'\'' )
  #END
	
  #IF (%'dofirst11'% ='2nd') 
	   	#APPEND (dokeyText3 , '\'\'' )
  #END

	
 
 %dohashText1%;

 %dokeyText1%;
 %dokeyText2%;
 %dokeyText3%;



#IF (%'doCleanFieldText1'%='')
 #DECLARE(doCleanFieldText1)
#END
#SET (doCleanFieldText1, false)
#SET ( doCleanFieldText1, ' SELF := left'  )
#APPEND (doCleanFieldText1 ,    '))' );

		
%doCleanFieldText1%;



endmacro;