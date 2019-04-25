// EXPORT Compare_dsets_macro_email ( indata1, indata2, unique_fields,filter ) := MACRO
EXPORT Compare_dsets_macro_email ( indata1, indata2, unique_fields,filter ) := functionMACRO

 // projecting all current dataset fields and previous dataset fields with unlimited join coditions
 
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
          #append( unsigned_layout, 'unsigned3 count_' + %'@name'% + ';\n' )
        // #end
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
    
    // #if(meta != '')
      %unsigned_layout% // counts of differences
    // #end
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
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( trim(le.' + %'@name'% + ') = trim(ri.' + %'@name'% + '), 0, 1 );\n' )
          // #end

        #elseif(%'@type'% = 'data')
          self.L.%@name% := if( le.%@name% = ri.%@name%, x'', le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, x'', ri.%@name% );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
          // #end

        #elseif(%'@type'% = 'boolean' )
          self.L.%@name% := map( le.%@name% = ri.%@name% => '', le.%@name% => '1', '0' );
          self.R.%@name% := map( le.%@name% = ri.%@name% => '', ri.%@name% => '1', '0' );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
          // #end

        #elseif(%'@type'%[1..7] not in ['real','decimal'])
          // ^^^ a decimal11_10 shows up with %'@name'% = 'decimal11_', so take the first 7 bytes ^^^
          self.L.%@name% := if( le.%@name% = ri.%@name%, '', (string)le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, '', (string)ri.%@name% );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( le.' + %'@name'% + ' = ri.' + %'@name'% + ', 0, 1 );\n' )
          // #end

        #else
          // comparing reals within a small threshold
          self.L.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( le.%@name%, 25, 6 )) );
          self.R.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( ri.%@name%, 25, 6 )) );
          // #if(meta != '')
            #set( count_field, 'self.count_' + %'@name'% + ' := if( abs(le.' + %'@name'% + ' - ri.' + %'@name'% + ') < 0.0001, 0, 1 );\n' )
          // #end
          
        #end
        // #warning(%'count_field'%)
      #end
      // #if(meta != '')
        %count_field%
      // #end
    #end
  #end
  END;

// finding all unmatched current dataset fields and previous dataset field

  #uniquename(joined1)
  #uniquename(joined)
  %joined1% := join( indata1, indata2, %join_condition% /*and left!=right*/, %xform%(left,right), keep(1) );
  %joined% := %joined1%( L != R );


// output(%joined1%);
// output(%joined%);


inner_join := join( indata1, indata2, %join_condition%);

	  #uniquename(string_layout1)
	%string_layout1% := record, maxlength(1000000)
    %string_layout% L;
    %string_layout% R;
    
    // #if(meta != '')
      %unsigned_layout% // counts of differences
    // #end
  END;
  
  #declare( count_field1 )
  #uniquename(xform1)
  %string_layout1% %xform1%( indata1 le, indata2 ri ) := TRANSFORM
  #for(diffs)
    #for(Field)
      #if(%'@name'% in unique_fields)
        self.L.%@name% := (typeof(self.L.%@name%))le.%@name%;
        self.R.%@name% := (typeof(self.R.%@name%))ri.%@name%;
        #set( count_field1, 'self.count_' + %'@name'% + ' := 1;\n' )
      #else
        #if(%'@type'% = 'string')
          // self.L.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', le.%@name% );
          // self.R.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', ri.%@name% );
					
					// self.L.%@name% :=  map( (real)le.%@name% = (real)ri.%@name% => 'equal', (real)le.%@name%<(real)ri.%@name% => 'up', 'down' );
          // self.R.%@name% := map( (real)le.%@name% = (real)ri.%@name% => 'equal', (real)le.%@name%<(real)ri.%@name% => 'up', 'down' );
					
					
					      self.L.%@name% := map(  RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			  TRIM(le.%@name%,LEFT,RIGHT) = TRIM(ri.%@name%,LEFT,RIGHT) => '',
																				
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) = (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'equal',
																			
																				not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) < (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'up',
																			 
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) > (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'down',   
																			 
																			                                                                          le.%@name%);
								
								self.R.%@name% := map(  RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			  TRIM(le.%@name%,LEFT,RIGHT) = TRIM(ri.%@name%,LEFT,RIGHT) => '',
																				
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) = (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'equal',
																			
																				not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) < (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'up',
																			 
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) > (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'down',   
																			 
																			                                                                         ri.%@name%);
																																																								
			
					
				#set( count_field1, 'self.count_' + %'@name'% + ' := if( not RegexFind(\'[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]\',TRIM(le.' + %'@name'% +',LEFT,RIGHT)) and '+''+  
								                       ' not RegexFind(\'[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]\',TRIM(ri.' + %'@name'% + ',LEFT,RIGHT)) and' +
																			 '(real)TRIM(le.' + %'@name'% + ',LEFT,RIGHT) > (real)TRIM(ri.' +%'@name'% + ',LEFT,RIGHT), 1, 0 );\n' )
					
			
          // #if(meta != '')
            // #set( count_field1, 'self.count_' + %'@name'% + ' := 0;\n' )
										 // #set( count_field1, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' > ri.' + %'@name'% + ', 1, 0 );\n' )
          // #end

        #elseif(%'@type'% = 'data')
          self.L.%@name% := if( le.%@name% = ri.%@name%, x'', le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, x'', ri.%@name% );
          // #if(meta != '')
					 #set( count_field1, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' > ri.' + %'@name'% + ', 1, 0 );\n' )
            // #set( count_field1, 'self.count_' + %'@name'% + ' :=  MAP( le.' + %'@name'% + ' > ri.' + %'@name'% + ' => 1, le.' + %'@name'% + ' < ri.' + %'@name'% + ' => 2,3 );\n' )
          // #end

        #elseif(%'@type'% = 'boolean' )
          self.L.%@name% := map( le.%@name% = ri.%@name% => '', le.%@name% => '1', '0' );
          self.R.%@name% := map( le.%@name% = ri.%@name% => '', ri.%@name% => '1', '0' );
          // #if(meta != '')
            #set( count_field1, 'self.count_' + %'@name'% + ' := 0;\n' )
          // #end

        #elseif(%'@type'%[1..7] not in ['real','decimal'])
          // ^^^ a decimal11_10 shows up with %'@name'% = 'decimal11_', so take the first 7 bytes ^^^
          self.L.%@name% :=  map( le.%@name% = ri.%@name% => 'equal', le.%@name%<ri.%@name% => 'up', 'down' );

          self.R.%@name% := map( le.%@name% = ri.%@name% => 'equal', le.%@name%<ri.%@name% => 'up', 'down' );
          // #if(meta != '')
            #set( count_field1, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' > ri.' + %'@name'% + ', 1, 0 );\n' )
						// #set( count_field1, 'self.count_' + %'@name'% + ':= MAP( le.' + %'@name'% + ' > ri.' + %'@name'% + ' => 1, le.' + %'@name'% + ' < ri.' + %'@name'% + ' => 2,3 );\n' )
          // #end
					
					// map( le.' + % '@name'%+' = ' +'equal'+' =>0, le.%@name% =' + 'up' + '=> 1,2 )\n' )

        #else
          // comparing reals within a small threshold
          self.L.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( le.%@name%, 25, 6 )) );
          self.R.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( ri.%@name%, 25, 6 )) );
          // #if(meta != '')
					
					 #set( count_field1, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' > ri.' + %'@name'% + ', 1, 0 );\n' )
            // #set( count_field1, 'self.count_' + %'@name'% + ' :=  MAP( le.' + %'@name'% + ' > ri.' + %'@name'% + ' => 1, le.' + %'@name'% + ' < ri.' + %'@name'% + ' => 2,3 );\n' )
          // #end
          
        #end
        // #warning(%'count_field'%)
      #end
      // #if(meta != '')
        %count_field1%
      // #end
    #end
  #end
  END;

	
	  #uniquename(joined2)
    %joined2% :=join( indata1, indata2, %join_condition% /*and left!=right*/, %xform1%(left,right), keep(1) );
		
		// output( %joined2%);

		  #declare( count_field2 )
  #uniquename(xform2)
  %string_layout2% %xform2%( indata1 le, indata2 ri ) := TRANSFORM
  #for(diffs)
    #for(Field)
      #if(%'@name'% in unique_fields)
        self.L.%@name% := (typeof(self.L.%@name%))le.%@name%;
        self.R.%@name% := (typeof(self.R.%@name%))ri.%@name%;
        #set( count_field2, 'self.count_' + %'@name'% + ' := 1;\n' )
      #else
        #if(%'@type'% = 'string')
          // self.L.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', le.%@name% );
          // self.R.%@name% := if( trim(le.%@name%) = trim(ri.%@name%), '', ri.%@name% );
					
					
					      self.L.%@name% := map(  RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			  TRIM(le.%@name%,LEFT,RIGHT) = TRIM(ri.%@name%,LEFT,RIGHT) => '',
																				
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) = (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'equal',
																			
																				not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) < (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'up',
																			 
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) > (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'down',   
																			 
																			                                                                          le.%@name%);
								
								self.R.%@name% := map(  RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			  TRIM(le.%@name%,LEFT,RIGHT) = TRIM(ri.%@name%,LEFT,RIGHT) => '',
																				
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) = (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'equal',
																			
																				not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) < (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'up',
																			 
																			  not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(le.%@name%,LEFT,RIGHT)) and  
								                        not RegexFind('[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]',TRIM(ri.%@name%,LEFT,RIGHT)) and
																			 (real)TRIM(le.%@name%,LEFT,RIGHT) > (real)TRIM(ri.%@name%,LEFT,RIGHT) => 'down',   
																			 
																			                                                                         ri.%@name%);
																																																								
			
					
				#set( count_field2, 'self.count_' + %'@name'% + ' := if( not RegexFind(\'[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]\',TRIM(le.' + %'@name'% +',LEFT,RIGHT)) and '+''+  
								                       ' not RegexFind(\'[A-Z~!a-z@&%#$^*()_=+?<>,/"{}|]\',TRIM(ri.' + %'@name'% + ',LEFT,RIGHT)) and' +
																			 '(real)TRIM(le.' + %'@name'% + ',LEFT,RIGHT) < (real)TRIM(ri.' +%'@name'% + ',LEFT,RIGHT), 1, 0 );\n' )
					
			
          // #if(meta != '')
            // #set( count_field2, 'self.count_' + %'@name'% + ' := 0;\n' )
          // #end

        #elseif(%'@type'% = 'data')
          self.L.%@name% := if( le.%@name% = ri.%@name%, x'', le.%@name% );
          self.R.%@name% := if( le.%@name% = ri.%@name%, x'', ri.%@name% );
          // #if(meta != '')
					 #set( count_field2, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' < ri.' + %'@name'% + ', 1, 0 );\n' )
            // #set( count_field1, 'self.count_' + %'@name'% + ' :=  MAP( le.' + %'@name'% + ' > ri.' + %'@name'% + ' => 1, le.' + %'@name'% + ' < ri.' + %'@name'% + ' => 2,3 );\n' )
          // #end

        #elseif(%'@type'% = 'boolean' )
          self.L.%@name% := map( le.%@name% = ri.%@name% => '', le.%@name% => '1', '0' );
          self.R.%@name% := map( le.%@name% = ri.%@name% => '', ri.%@name% => '1', '0' );
          // #if(meta != '')
            #set( count_field2, 'self.count_' + %'@name'% + ' := 0;\n' )
          // #end

        #elseif(%'@type'%[1..7] not in ['real','decimal'])
          // ^^^ a decimal11_10 shows up with %'@name'% = 'decimal11_', so take the first 7 bytes ^^^
          self.L.%@name% :=  map( le.%@name% = ri.%@name% => 'equal', le.%@name%<ri.%@name% => 'up', 'down' );

          self.R.%@name% := map( le.%@name% = ri.%@name% => 'equal', le.%@name%<ri.%@name% => 'up', 'down' );
          // #if(meta != '')
            #set( count_field2, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' < ri.' + %'@name'% + ', 1, 0 );\n' )
						// #set( count_field1, 'self.count_' + %'@name'% + ':= MAP( le.' + %'@name'% + ' > ri.' + %'@name'% + ' => 1, le.' + %'@name'% + ' < ri.' + %'@name'% + ' => 2,3 );\n' )
          // #end
					
					// map( le.' + % '@name'%+' = ' +'equal'+' =>0, le.%@name% =' + 'up' + '=> 1,2 )\n' )

        #else
          // comparing reals within a small threshold
          self.L.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( le.%@name%, 25, 6 )) );
          self.R.%@name% := if( abs(le.%@name% - ri.%@name%) < 0.0001, '', trim(realformat( ri.%@name%, 25, 6 )) );
          // #if(meta != '')
					
					 #set( count_field2, 'self.count_' + %'@name'% + ':= if( le.' + %'@name'% + ' < ri.' + %'@name'% + ', 1, 0 );\n' )
            // #set( count_field1, 'self.count_' + %'@name'% + ' :=  MAP( le.' + %'@name'% + ' > ri.' + %'@name'% + ' => 1, le.' + %'@name'% + ' < ri.' + %'@name'% + ' => 2,3 );\n' )
          // #end
          
        #end
        // #warning(%'count_field'%)
      #end
      // #if(meta != '')
        %count_field2%
      // #end
    #end
  #end
  END;

	
	  #uniquename(joined3)
    %joined3% :=join( indata1, indata2, %join_condition% /*and left!=right*/, %xform2%(left,right), keep(1) );
		
// output(%joined3%);


  #uniquename(norm_xform)
  %string_layout% %norm_xform%( %joined% le, integer c ) := TRANSFORM
    self := if( c=1, le.L, le.R );
  END;
  
  #uniquename(normed)
  %normed% := normalize( %joined%, 2, %norm_xform%(left,counter) );

  
  // #if(meta!='')
    #declare(trans)
    #set(trans,'')
    
    #declare(roll)
    #set(roll,'')
    
    #declare(hier)
    #set(hier,'dataset([{\'\',0}')
		
		#declare(hier1)
    #set(hier1,'dataset([{\'\',0}')
		
				#declare(hier2)
    #set(hier2,'dataset([{\'\',0}')
    
    #uniquename(metaRolled)
	  #uniquename(metaRolled1)
	  #uniquename(metaRolled2)
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
					  #append(hier1, ',{\'' + %'@name'% + '\',' + %'metaRolled1'% + '[1].' + %'@name'% + '}')
						#append(hier2, ',{\'' + %'@name'% + '\',' + %'metaRolled2'% + '[1].' + %'@name'% + '}')
          #end
        #end
      // #end
    END;
		

    #uniquename(metaXform)
    %metaLayout% %metaXform%( %joined% le ) := TRANSFORM
      %trans%
    END;
    #uniquename(metaJoined)
    %metaJoined% := project( %joined%, %metaXform%(left) );
		
		  #uniquename(metaJoined1)
    %metaJoined1% := project( %joined2%, %metaXform%(left) );
		
			  #uniquename(metaJoined2)
    %metaJoined2% := project( %joined3%, %metaXform%(left) );
		
		
		
		
    
    #uniquename(metaRollup)
    %metaLayout% %metaRollup%( %metaLayout% le, %metaLayout% ri ) := TRANSFORM
      %roll%
    END;
    %metaRolled% := rollup( %metaJoined%, true, %metaRollup%(left,right) );
		

		  %metaRolled1% := rollup( %metaJoined1%, true, %metaRollup%(left,right) );
			
		
			%metaRolled2% := rollup( %metaJoined2%, true, %metaRollup%(left,right) );
			
    // output(%metaRolled%, named('meta_' + meta) );
    
    #append(hier, '], {string field, unsigned4 num_diffs} )')
		#append(hier1, '], {string field, unsigned4 num_diffs} )')
		#append(hier2, '], {string field, unsigned4 num_diffs} )')

    // keep only a summary of those fields that have some differences
    #uniquename(foo)
    %foo% := %hier%( num_diffs > 0 );
		
		  #uniquename(foo1)
    %foo1% := %hier1%( num_diffs > 0 );
		
		  #uniquename(foo2)
    %foo2% := %hier2%( num_diffs > 0 );
    
    // then provide a little extra info -- how frequently is this field or that field different? it'll let us focus on the really bad variables first.
    #uniquename(bar)
    %bar% := table( %foo%, {%foo%, pct := num_diffs/count(%joined%), pct_all := num_diffs/count(%joined1%)} );

 // #uniquename(meta)
 // %meta%:='\'\'';
 //**********************************************


// calculating up cnt percentages and down cnt percentages for numeric fields only
 
 #uniquename(lay)
  %lay%:=record
	string field;
	integer total_cnt;
	integer diff_cnt;
	decimal10_2 diff_pct;
	
	end;
 
 %lay% func(%bar% l):=transform
 self.field:=l.field;
 self.total_cnt:=count(%joined1%);
 self.diff_cnt:=l.num_diffs;
 self.diff_pct:=(l.num_diffs/count(%joined1%))*100;
 end;

 #uniquename(pjt)
%pjt%:=project(%bar%,func(left));

 #uniquename(append_up_lay)
%append_up_lay%:=record
recordof(%lay%);
integer up_cnt;
end;



 #uniquename(up_stats_ds)
%up_stats_ds%:= join( %foo2%, %pjt%,left.field=right.field,transform(recordof(%append_up_lay%),self.up_cnt:=left.num_diffs;self:=right;),right outer);

 #uniquename(append_down_lay)
%append_down_lay%:=record
recordof(%lay%);
integer down_cnt;
end;


 #uniquename(down_stats_ds)
%down_stats_ds%:= join( %foo1%, %pjt%,left.field=right.field,transform(recordof(%append_down_lay%),self.down_cnt:=left.num_diffs;self:=right;),right outer);


 #uniquename(final_lay)
%final_lay%:=record
recordof(%lay%);
integer up_cnt;
decimal10_2 up_pct;
integer down_cnt;
decimal10_2 down_pct;
end;

 #uniquename(final_join)
 
 %final_join%:= join( %up_stats_ds%, %down_stats_ds%,left.field=right.field,transform(recordof(%final_lay%),self.down_cnt:=right.down_cnt;
                                                                                                            self.down_pct:= (right.down_cnt/right.total_cnt)*100;
                                                                                                            self.up_cnt:=left.up_cnt;
																																																						self.up_pct:= (left.up_cnt/right.total_cnt)*100;
																																																						self:=right;));
 
// filtering final result
		
		 #uniquename(result)
 %result%:=sort(%final_join%(diff_pct>=filter),-diff_cnt);
 
results_out :=   %result%;
 
// all outputs
 
// output(choosen(indata1,20),named('ds_baseline'));
// output(choosen(indata2,20),named('ds_new'));
// output(count(indata1),named('ds_baseline_cnt'));
// output(count(indata2),named('ds_new_cnt'));
// output(count(inner_join),named('joined_cnt'));
// output( %result%,all,named('stats_total')); 
// output(if(count(%result%)>=1,'0','no differences exceed threshold'));
return results_out;	

  #end
	
 endmacro;