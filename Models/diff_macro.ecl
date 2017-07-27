EXPORT diff_macro( indata1, indata2, unique_fields, outdata, meta='\'\'' ) := MACRO
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
        #if( meta != '' )
          #append( unsigned_layout, 'unsigned3 count_' + %'@name'% + ';\n' )
        #end
      #end
    
    
      #declare(decl)
      #declare(bytes)
      #set(bytes, roundup(log(power(2,8*%@size%))) )

      #if( %'@type'% in ['string','data'] )
        #if( %@size%=-15)
          #set(decl, 'string ' + %'@name'% + ';')
        #else
          #set(decl, 'string'+ %'@size'% + ' ' + %'@name'% + ';')
        #end
        
      #elseif( %'@type'% = 'boolean' )
        #set(decl, 'string1 ' + %'@name'% + ';')
        
      #elseif( %'@type'% = 'integer' )
        // a signed integer may need one extra byte for the sign
        #set(decl, 'string'+ (string)(1+%bytes%) + ' ' + %'@name'% + ';')

      #elseif( %'@type'% = 'unsigned integer' )
        #set(decl, 'string'+ (string)(%bytes%) + ' ' + %'@name'% + ';')

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
    
    #if(meta != '')
      %unsigned_layout% // counts of differences
    #end
  END;
  
  #declare( count_field )
  #uniquename(xform)
  %string_layout2% %xform%( indata1 le, indata2 ri ) := TRANSFORM
  #for(diffs)
    #for(Field)
      #if(%'@name'% in unique_fields)
        self.L.%@name% := (typeof(self.L.%@name%))le.%@name%;
        self.R.%@name% := (typeof(self.R.%@name%))ri.%@name%;
        #set( count_field, 'self.count_' + %'@name'% + ' := 1;\n' )
      #else
        #if(%'@type'% = 'string')
          self.L.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', le.%@name% );
          self.R.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', ri.%@name% );
          #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( trim(le.' + %'@name'% + ') = trim(ri.' + %'@name'% + '), 0, 1 );\n' )
          #end

        #elseif(%'@type'% = 'data')
          self.L.%@name% := if( le.%@name% = ri.%@name%, x'', le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, x'', ri.%@name% );
          #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
          #end

        #elseif(%'@type'% = 'boolean' )
          self.L.%@name% := map( le.%@name% = ri.%@name% => '', le.%@name% => '1', '0' );
          self.R.%@name% := map( le.%@name% = ri.%@name% => '', ri.%@name% => '1', '0' );
          #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
          #end

        #elseif(%'@type'%[1..7] not in ['real','decimal'])
          // ^^^ a decimal11_10 shows up with %'@name'% = 'decimal11_', so take the first 7 bytes ^^^
          self.L.%@name% := if( le.%@name% = ri.%@name%, '', (string)le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, '', (string)ri.%@name% );
          #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
          #end

        #else
          // comparing reals within a small threshold
          self.L.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( le.%@name%, 25, 6 )) );
          self.R.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( ri.%@name%, 25, 6 )) );
          #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( abs(le.' + %'@name'% + ' - ri.' + %'@name'% + ') < 0.0001, 0, 1 );\n' )
          #end
          
        #end
        // #warning(%'count_field'%)
      #end
      #if(meta != '')
        %count_field%
      #end
    #end
  #end
  END;



  #uniquename(joined1)
  #uniquename(joined)
  %joined1% := join( indata1, indata2, %join_condition% /*and left!=right*/, %xform%(left,right), keep(1) );
  %joined% := %joined1%( L != R );
  
  // #uniquename(projected)
  // %projected% := 
      // project( %joined%, transform( %string_layout%, self := left.L ) )
    // + project( %joined%, transform( %string_layout%, self := left.R ) );

  // #uniquename(sorted)
  // %sorted% := sort( %projected%, %sort_fields% );
  // outdata := %sorted%;
  
  #uniquename(norm_xform)
  %string_layout% %norm_xform%( %joined% le, integer c ) := TRANSFORM
    self := if( c=1, le.L, le.R );
  END;
  
  #uniquename(normed)
  %normed% := normalize( %joined%, 2, %norm_xform%(left,counter) );

  outdata := %normed%;
  
  #if(meta!='')
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
            #append(trans, 'self.' + %'@name'% + ' := le.count_' + %'@name'% + ';\n' )
            #append(roll,  'self.' + %'@name'% + ' := le.' + %'@name'% + ' + ri.' + %'@name'% + ';\n' )
            unsigned3 %@name%;
            
            // #append(trans, 'self.' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
            // #append(trans, 'self.' + %'@name'% + ' := le.count_' + %'@name'% + ';\n' )

            // #append(roll,  'self.' + %'@name'% + ' := le.' + %'@name'% + ' + ri.' + %'@name'% + ';\n' )
            #append(hier, ',{\'' + %'@name'% + '\',' + %'metaRolled'% + '[1].' + %'@name'% + '}')
          #end
        #end
      #end
    END;
    
    
    #uniquename(metaXform)
    %metaLayout% %metaXform%( %joined% le ) := TRANSFORM
      %trans%
    END;
    #uniquename(metaJoined)
    %metaJoined% := project( %joined%, %metaXform%(left) );
    
    #uniquename(metaRollup)
    %metaLayout% %metaRollup%( %metaLayout% le, %metaLayout% ri ) := TRANSFORM
      %roll%
    END;
    %metaRolled% := rollup( %metaJoined%, true, %metaRollup%(left,right) );
    // output(%metaRolled%, named('meta_' + meta) );
    
    #append(hier, '], {string field, unsigned4 num_diffs} )')

    // keep only a summary of those fields that have some differences
    #uniquename(foo)
    %foo% := %hier%( num_diffs > 0 );
    
    // then provide a little extra info -- how frequently is this field or that field different? it'll let us focus on the really bad variables first.
    #uniquename(bar)
    %bar% := table( %foo%, {%foo%, pct := num_diffs/count(%joined%), pct_all := num_diffs/count(%joined1%)} );
    output(%bar%,named('meta_' + meta),all);

  #end
ENDMACRO;


// names := { integer seq, string fname, string1 lname };
// ds1 := dataset( [ {1,'john','s'}, {2,'jane','n'}, {3,'bob','s'}, {4,'betty','p'} ], names );
// ds2 := dataset( [ {1,'john','s'}, {2,'jane','s'}, {3,'bob','s'}, {4,'betty','s'} ], names );
// diff( ds1, ds2, ['seq'], outnames, meta:='names' );

// output( sort(ds1+ds2,fname), named('fields'));
// output(outnames, named('diffs'));