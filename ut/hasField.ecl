/*
This macro returns true or false in the hasIt field if the dataset contains the field_name in its layout.
*/

EXPORT hasField(myDataset, field_name, hasIt) := MACRO
//loadxml('<xml/>');
	#exportxml(records, recordof(myDataset))	
	#uniquename( field_found )
	#set( field_found, false )
	  #for (records)		
			#for (Field)
				#if(stringlib.stringtouppercase(%'@name'%)=stringlib.stringtouppercase(#TEXT(field_name)))							
					#set(field_found, true)					
					#break;				
				#end			
		  #end
	  #end
		hasIt := %field_found%;
ENDMACRO;
/*
Sample Code

myLayout := record
  unsigned4 seq;
	STRING20 fname;	
	STRING20 lname;
	STRING25 city;
	STRING2  st;
end;
loadxml('<xml/>');
ds := dataset([
				{1, 'John', 'Doe', 'Wonderland', 'NA'}, 
				{2, 'jonh', 'Smith', 'Nowhere', 'NA'}, 
				{3, 'Mary', 'Low', 'Somewhere', 'NA'}],
				myLayout);

	
	ut.hasField(ds, seq, aaa);	
	output(aaa);

*/
