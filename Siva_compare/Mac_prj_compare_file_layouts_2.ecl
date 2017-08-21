EXPORT Mac_prj_compare_file_layouts_2(inputfile, outputfile, outfile2 ) := macro


LOADXML('<xml/>');

#EXPORTXML(doCleanFieldMetaInfo1, recordof(inputFile))
#EXPORTXML(doCleanFieldMetaInfo2, recordof(outputfile))

#uniquename(project_list)
%project_list% := project(outputfile,

#DECLARE (dohashText2)
#SET (dohashText2,'transform({')

#DECLARE (dohashText3)
#SET (dohashText3,'')
	
#FOR (doCleanFieldMetaInfo2)
 #FOR (Field)
     #Append(dohashText2, 'string80 '+%'@name'%+';' )
		 #Append(dohashText3, 'self.' + %'@name'% + ':= (string80)left.'+%'@name'% +';')
 #end
#END 
#Append(dohashText2, '},')
#Append(dohashText3, '));')

%dohashText2%
%dohashText3%





// build the string of fields of first layout;

#uniquename(second_lay)
%second_lay% := []

#FOR (doCleanFieldMetaInfo2)
 #FOR (Field)
 
//check for each field in all the other fields of next file

  //open the other file fields 


  + [StringLib.StringToUpperCase(%'@name'%)]
   
 #END 
#END 
;




//now for the first file

#uniquename(table_list2)
%table_list2% := table( %project_list%,


#DECLARE (dohashText1)
#SET (dohashText1,'{ ')
	
#FOR (doCleanFieldMetaInfo1)
 #FOR (Field)

 

    #if (  //( %'@name'% in ['address_id']) and
		     (StringLib.StringToUpperCase(%'@name'%) in %second_lay%) )
		
     #Append(dohashText1, %'@name'% + ','  )

    #end



		
 #END 
#END 


#Append(dohashText1, file_2_special )
#Append(dohashText1, ',' ) 

#Append(dohashText1, '\'1\'' + '} );' )



%dohashText1%



outfile2 := %table_list2%

endmacro;