EXPORT CROSSTAB_MACRO( indata1, indata2, unique_fields,filter_field) := MACRO
 
 // projecting all current dataset numeric fields and previous dataset numeric fields with unlimited join coditions
 
  LOADXML('<xml/>');
  #exportxml(diffs, recordof(indata1) )

  #declare(sort_fields)
  #declare(join_condition)

  #declare(i)
  #set(i,1)
  #loop
    #if(%i% > count(unique_fields))
      #break
    #elseif(%i%=1)
      #set(join_condition, 'left.' + unique_fields[%i%] + '=right.' + unique_fields[%i%] )
      #set(sort_fields, unique_fields[%i%] )
      #set(i,%i%+1)
    #else
      #append(join_condition, ' AND left.' + unique_fields[%i%] + '=right.' + unique_fields[%i%] )
      #append(sort_fields, ', ' + unique_fields[%i%] )
      #set(i,%i%+1)
    #end
  #end

  // create a string-only layout in order that we can blank out any fields that match, making it easier to see only those fields that differ
  #declare(unsigned_layout)
  #set(unsigned_layout, '')
  #uniquename(string_layout)
  %string_layout% := record, maxlength(1000000)
  #for(diffs)
    #for(Field)

      #if(%@isDataset%=1)
        #error( 'Your input contains a child dataset. This won\'t work.' )
      #elseif( %@isRecord%=1)
        #error( 'Your input is hierarchical. Flatten it first with ashirey.Flatten' )
      #else
        // everything is fine and dandy
        // #if( meta != '' )
          #append( unsigned_layout, 'integer count_' + %'@name'% + ';\n' )
					#append( unsigned_layout, 'integer count1_' + %'@name'% + ';\n' )
					#append( unsigned_layout, 'integer count2_' + %'@name'% + ';\n' )
        // #end
      #end
    
    
      #declare(decl)
      #declare(bytes)
      #set(bytes, roundup(log(power(2,8*%@size%))) )

      #if( %'@type'% in ['string','qstring','data'] )
        // #if( %@size%=-15)
          #set(decl, 'string ' + %'@name'% + ';')
        // #else
          // #set(decl, 'string'+ %'@size'% + ' ' + %'@name'% + ';')
        // #end
        
     
        
      #elseif( %'@type'% = 'integer' )
        // a signed integer may need one extra byte for the sign
         #set(decl, 'string ' + %'@name'% + ';')

      #elseif( %'@type'% = 'unsigned integer' )
        #set(decl, 'string ' + %'@name'% + ';')

      #elseif( %'@type'% = 'real' )
        #set(decl, 'string ' + %'@name'% + ';')

      #else
        #set(decl, 'string ' + %'@name'% + ';')
      #end
      %decl%
    #end
  #end
  END;
  
  #uniquename(string_layout2)
  #uniquename(seq)
  %string_layout2% := record, maxlength(1000000)
    %string_layout% L;
    %string_layout% R;
    
    // #if(meta != '')
      %unsigned_layout% // counts of differences
    // #end
  END;
  
  #declare( count_field )
	#declare( count_field1 )
	#declare( count_field2 )
		
  #uniquename(xform)
  %string_layout2% %xform%( indata1 le, indata2 ri ) := TRANSFORM
  #for(diffs)
    #for(Field)
      #if(%'@name'% in unique_fields)
        self.L.%@name% := (typeof(self.L.%@name%))le.%@name%;
        self.R.%@name% := (typeof(self.R.%@name%))ri.%@name%;
        #set( count_field, 'self.count_' + %'@name'% + ' := 0;\n' )
				 #set( count_field1, 'self.count1_' + %'@name'% + ' := 0;\n' )
				 	 #set( count_field2, 'self.count2_' + %'@name'% + ' := 0;\n' )
      #else
        #if(%'@type'% in[ 'string','qstring'])
          self.L.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', le.%@name% );
          self.R.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', ri.%@name% );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( trim(le.' + %'@name'% + ') = trim(ri.' + %'@name'% + '), 0, 0 );\n' )
						 #set( count_field1, 'self.count1_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
						 	 #set( count_field2, 'self.count2_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
          // #end

        #elseif(%'@type'% = 'data')
          self.L.%@name% := if( le.%@name% = ri.%@name%, x'', le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, x'', ri.%@name% );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
						 #set( count_field1, 'self.count1_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
						 	 #set( count_field2, 'self.count2_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
          // #end
					
					 

        #elseif(%'@type'% = 'boolean' )
          self.L.%@name% := map( le.%@name% = ri.%@name% => '', le.%@name% => '1', '0' );
          self.R.%@name% := map( le.%@name% = ri.%@name% => '', ri.%@name% => '1', '0' );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
						#set( count_field1, 'self.count1_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
						#set( count_field2, 'self.count2_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 0 );\n' )
          // #end

        #elseif(%'@type'%[1..7] not in ['real','decimal'])
          // ^^^ a decimal11_10 shows up with %'@name'% = 'decimal11_', so take the first 7 bytes ^^^
          self.L.%@name% := if( le.%@name% = ri.%@name%, '', (string)le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, '', (string)ri.%@name% );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := ri.' + %'@name'% +';\n' )
						#set( count_field1, 'self.count1_' + %'@name'% + ' := le.' + %'@name'% + ';\n' )
						#set( count_field2, 'self.count2_' + %'@name'% + ' := ri.' + %'@name'% +' - le.' + %'@name'% + ';\n' )
          // #end

        #else
          // comparing reals within a small threshold
          self.L.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( le.%@name%, 25, 6 )) );
          self.R.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( ri.%@name%, 25, 6 )) );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := ri.' + %'@name'% +';\n' )
						#set( count_field1, 'self.count1_' + %'@name'% + ' := le.' + %'@name'% + ';\n' )
						#set( count_field2, 'self.count2_' + %'@name'% + ' := ri.' + %'@name'% +' - le.' + %'@name'% + ';\n' )
          // #end
          
        #end
        // #warning(%'count_field'%)
      #end
      // #if(meta != '')
        %count_field%
			  %count_field1%
				%count_field2%
      // #end
    #end
  #end
  END;



  #uniquename(joined1)
  #uniquename(joined)
  %joined1% := join( indata1, indata2, %join_condition% /*and left!=right*/, %xform%(left,right), keep(1) );
  // %joined% := %joined1%( L != R );
	

	
	
#uniquename(j_left_lay)
%j_left_lay%:=record
recordof(indata1);   

end;
    #uniquename(j_left)
%j_left% := join(indata1, indata2,  %join_condition% and 					
					left.#expand(filter_field) <> right.#expand(filter_field),
					transform( %j_left_lay%, self := left)
);
 #uniquename(j_right)
%j_right% := join(indata1, indata2,  %join_condition%
					and left.#expand(filter_field) <> right.#expand(filter_field),
					transform(%j_left_lay%, self := right));


			
j_1 := choosen(join(%j_left%, %j_right%,  %join_condition%,
					transform( {dataset (%j_left_lay%) res}, self.res := left + right) ),20);

	
	
	
  inner_join := join( indata1, indata2, %join_condition%);
	
	
	
	// subtracting all current dataset numeric fields with previous dataset numeric fields

	
	
  // #if(meta!='')
    #declare(trans)
    #set(trans,'')
    
    #declare(roll)
    #set(roll,'')
    
    #declare(hier)
    #set(hier,'dataset([{\'\',0}')
    
    #uniquename(metaRolled)
    #uniquename(metaLayout)
    %metaLayout% := RECORD
      #for(diffs)
        #for(Field)
          #if(%'@name'% in unique_fields)

          #else
            #append(trans, 'self.' + %'@name'% + ' := le.count2_' + %'@name'% + ';\n' )
            #append(roll,  'self.' + %'@name'% + ' := le.' + %'@name'% + ' + ri.' + %'@name'% + ';\n' )
            integer %@name%;
            
            // #append(trans, 'self.' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
            // #append(trans, 'self.' + %'@name'% + ' := le.count_' + %'@name'% + ';\n' )

            // #append(roll,  'self.' + %'@name'% + ' := le.' + %'@name'% + ' + ri.' + %'@name'% + ';\n' )
            #append(hier, ',{\'' + %'@name'% + '\',' + %'metaRolled'% + '[1].' + %'@name'% + '}')
          #end
        #end
      #end
    END;
    
    
    #uniquename(metaXform)
    %metaLayout% %metaXform%( %joined1% le ) := TRANSFORM
      %trans%
    END;
    #uniquename(metaJoined)
    %metaJoined% := project( %joined1%, %metaXform%(left) );
		

 // Produce the output, with one row for every field/column.

 Scoring_qa.Runway_Macro_Simplified(%metaJoined%,re);
   
// creating tabler report  
 
 scoring_qa.table_macro(re,'field_name','field_value',op);
   
// filtering result with field name
	 
   #uniquename(op_filter)
   %op_filter%:=op(field_name=filter_field);
   
// calculating pct  
   	
   #uniquename(MyFormat)	
   %MyFormat% := RECORD
   %op_filter%.field_name;
   %op_filter%.total;
   %op_filter%.total_change;
   decimal10_2 pct := (%op_filter%.total_change/count(inner_join))*100;
   END;
   #uniquename(result_Table)	
   %result_Table% := sort(TABLE(%op_filter%,%MyFormat%),total);

// all outputs

output(choosen(indata1,20),named('ds_baseline'));
output(choosen(indata2,20),named('ds_new'));
output(count(indata1),named('ds_baseline_cnt'));
output(count(indata2),named('ds_new_cnt'));
output(count(inner_join),named('joined_cnt'));
output(%result_Table%,named('stats_total'));
output(if(count(j_1)>0,choosen(j_1,20)),named('diff_detail'));
output(if(count(j_1)>0,'0','dsets are identical'));
 	
ENDMACRO;

//******************************example**********************************************************

// input_lay := { integer AccountNumber, string fname, string1 lname , integer score};
// ds_baseline := dataset( [ {1,'john','s',800}, {2,'jane','n',700}, {3,'bob','s',690}, {4,'betty','p',750} ], input_lay );
// ds_new := dataset( [ {1,'john','s',1000}, {2,'jane','s',900}, {3,'bob','s',0}, {4,'betty','s',750} ], input_lay );

// scoring_qa.CROSSTAB_MACRO( ds_baseline, ds_new, ['AccountNumber'],'score');

