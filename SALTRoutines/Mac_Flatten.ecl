/* scroll down to see what this macro does
                      _
                     | |
                     | |
                     | |
                     | |
                     | |
                 __  | |  __
                 \ \ | | / /
                  \ \| |/ /
                   \ \ / /
                    \   /
                     \*/
		  
EXPORT Mac_Flatten( indata, outnames, fullyQualify=true, stringify=false, returnECL=false, Pairs=false ) := MACRO
	loadxml('<xml/>');
	#exportxml(records, recordof(indata) )

  #declare(retString)
  #uniquename(r)
  #if(not Pairs)
    #if(returnECL)
      #set(retString,'r := RECORD\n')
    #else
      #set(retString, %'r'% + ' := RECORD\n')
    #end
	#end
	
	#declare( maxName )
	#declare( maxValue )
	#declare( valueNoExplicitMax )
	#set(maxName,0)
	#set(maxValue,0)
	#set(valueNoExplicitMax,false)
	
	#declare(path)
	#set(path,'')
	

  #if(not Pairs)
    #for(records)
      #for(Field)
        #if(%@isDataset%=1)
          // dataset
          #error('Found nested dataset within structure (' + %'name'% + ')')

        #elseif(%{@isRecord}%=0 and %{@isEnd}%=0 )
          #declare(fieldname)
          #set(fieldname, %'path'% + %'{@name}'%)
        
          #declare(thisType)
          // #if(%@size% != -15)
          #if(stringify)
            #declare(sz)
            #if(%'@type'% = 'boolean')
              #set(sz,1)
            #elseif(%'@type'% = 'real')
              #set(sz, 0)
            #elseif(%'@type'% = 'unsigned')
              #set(sz, roundup(log(power(2,(8*%@size%)))))
            #elseif(%'@type'% = 'integer')
              #set(sz, 1+roundup(log(power(2,(8*%@size%)))))
            #elseif(%'@type'% in ['string','qstring','data'])
              #if(%@size% > 0)
                #set(sz, %@size%)
              #else
                #set(sz, 0)
              #end
            #elseif(%'@type'%[1..7] = 'decimal' or %'@type'%[1..8] = 'udecimal' )
              // decimal32 has a @size=17; decimal31 has @size16, etc. it looks like ceil(n/2)+1
              // this is a lazy calculation:
              #set(sz, (%@size%+1)*2+1)
            #else
              #set(sz,0) // ?
            #end
            
            #if(%sz%=0)
              #set(thisType, 'string')
            #else
              #set(thisType, 'string'+%'sz'%)
            #end
          #else
            #if(%@size% > 0 and %'@type'% != 'boolean')
              #set(thisType, %'@type'% + %'@size'%)
            #else
              #set(thisType,%'@type'%)
            #end
          #end
          #append(retString, '\t' + %'thisType'% + ' ' + %'fieldname'% + ';\n')
          
        #elseif(%{@isEnd}%=1 and fullyQualify )
          #set(path, %'path'%[1..LENGTH(%'path'%)-LENGTH(%'{@name}'%)-2])
        #elseif( %{@isRecord}%=1 and fullyQualify)
          #append(path, %'{@name}'% + '__')
        #else
          // pass
        #end
      #end
    #end
  #end
  


  /* Now build the transform */
  #declare(origPath)
  #set(origPath,'')

  #declare( name )
  #declare( val )
  
  #uniquename(convert)
  #if(Pairs)
    #set( name, '' )
    #set( val,  '' )
    #if(returnECL)
      #append(retString, 'r convert( indata le, integer c ) := TRANSFORM\n')
    #else
      #append(retString, %'r'% + ' ' + %'convert'% + '(' + #text(indata) + ' le, integer c ) := TRANSFORM\n' )
    #end
  #else
    #append(retString, 'END;\n')
    #if(returnECL)
      #append(retString, 'r convert( indata le ) := TRANSFORM\n')
    #else
      #append(retString, %'r'% + ' ' + %'convert'% + '( ' + #text(indata) + ' le ) := TRANSFORM\n')
    #end
  #end
  
  #declare(isFirstField)
  #set(isFirstField, true)
  
  #declare(fieldCount)
  #set(fieldCount, 0)
  #for(records)
    #for(Field)
      #if(%{@isRecord}%=0 and %{@isEnd}%=0 )
        #set( fieldCount, 1+%fieldCount% )
        #declare(fieldname)
        #set(fieldname, %'path'% + %'{@name}'%)
        #declare(origfieldname)
        #set(origfieldname, %'origpath'% + %'{@name}'%)
        
        
        
        // determine the size
          #declare(sz)
          #if(%'@type'% = 'real')
            #set(sz, 0)
          #elseif(%'@type'% = 'unsigned')
            #set(sz, roundup(log(power(2,(8*%@size%)))))
          #elseif(%'@type'% = 'integer')
            #set(sz, 1+roundup(log(power(2,(8*%@size%)))))
          #elseif(%'@type'% in ['string','qstring','data'])
            #if(%@size% > 0)
              #set(sz, %@size%)
            #else
              #set(sz, 0)
            #end
          #elseif(%'@type'%[1..7] = 'decimal' or %'@type'%[1..8] = 'udecimal' )
            // decimal32 has a @size=17; decimal31 has @size16, etc. it looks like ceil(n/2)+1
            // this is a lazy calculation:
            #set(sz, (%@size%+1)*2+1)
          #elseif( %'@type'% = 'boolean' )
            #set(sz, 1 )
          #else
            #set(sz,0) // ?
              #append(retString, %'origfieldname'% + ' isa ' + %'@type'% + ' of size ' + %'@size'% + '\n')
          #end

          #declare(thisType)
          #if(%sz%=0)
            #set(thisType, 'string')
            #set(valueNoExplicitMax,true)
          #else
            #set(thisType, 'string'+%'sz'%)
            #set(maxValue, max(%maxValue%, %sz%))
          #end
        // done determining size
        #set(maxName, max(%maxName%, length(%'fieldName'%)))
        
        
        
        #declare(thisLine)
        #if(Pairs)
          #if( %isFirstField% )
            #set(thisLine, '\t\t ')
            #set(isFirstField, false)
          #else
            #set(thisLine, '\t\t, ' )
          #end
          
          #declare( strCast )
          #if( %'@type'% in ['string','qstring'] )
            // don't bother to explicitly cast fields that are already strings
            #set(strCast, '')
          #elseif( %'@type'% = 'boolean' )
            // make sure booleans are '1' and '0'
            #set(strCast, '(string)(integer)')
          #else
            #set(strCast, '(string)')
          #end
          
          // NOTE: returning strings is a requirement for a name-value pair return.
          #append( name, '\t\t' + %'fieldCount'% + ' => \''                     + %'origfieldname'% + '\',\n' )
          #append( val,  '\t\t' + %'fieldCount'% + ' => ' + %'strcast'% + 'le.' + %'origfieldname'% + ',\n' )

        #else
          #if(stringify)
            #if(%'@type'% = 'boolean')
              #set(thisLine, '\tself.' + %'fieldname'% + ' := if(le.' + %'origfieldname'% + ', \'1\', \'0\');\n')
            #elseif(%'@type'% in ['string','qstring'])
              #set(thisLine, '\tself.' + %'fieldname'% + ' := le.' + %'origfieldname'% + ';\n')
            #else

              #set(thisLine, '\tself.' + %'fieldname'% + ' := (' + %'thisType'% + ')le.' + %'origfieldname'% + ';\n')
            #end
          #else
            #set(thisLine, '\tself.' + %'fieldname'% + ' := le.' + %'origfieldname'% + ';\n')
          #end
          #append(retString, %'thisLine'%)
        #end

      #elseif(%{@isEnd}%=1 and fullyQualify )
        #set(path, %'path'%[1..LENGTH(%'path'%)-LENGTH(%'{@name}'%)-2])
        #set(origpath, %'origpath'%[1..LENGTH(%'origpath'%)-LENGTH(%'{@name}'%)-1])
      #elseif( %{@isRecord}%=1 and fullyQualify)
        #append(path, %'{@name}'% + '__')
        #append(origpath, %'{@name}'% + '.')
      #else
        // pass
      #end
    #end
  #end
  
  #if(Pairs)
    #append(retString, '\tself.name := case( c,\n')
    #append(retString, %'name'% )
    #append(retString, '\t\t\'\' );\n' )
    #append(retString, '\tself.value := case( c,\n')
    #append(retString, %'val'% )
    #append(retString, '\t\t\'\' );\n' )
    #append(retString, '\tEND;\n')
  #end
 
  
  #if( Pairs )
    #declare(decl)
    #if(returnECL)
      #set(decl, 'r := RECORD\n')
    #else
      #set(decl, %'r'% + ' := RECORD\n')
    #end
    
    #append(decl,'\tstring' + %'maxName'% + ' name;\n')
    #if(%valueNoExplicitMax%)
      #append(decl,'\tstring value; // needs to be at least ' + %'maxValue'% + ' bytes\n')
    #else
      #append(decl,'\tstring' + %'maxValue'% + ' value;\n')
    #end
    #append(decl,'END;\n')

    #set(retString, %'decl'% + %'retString'%)
    #if(returnECL)
      #append(retString, 'converted := normalize( indata, ' + %'fieldCount'% + ', convert(LEFT,COUNTER) );\n')
      outnames := %'retString'%;
    #else
      // returning pairs (not ECL)
      %retString%
      outnames := normalize( indata, %fieldCount%, %convert%(LEFT,COUNTER) );
    
    #end
  #else
    #append(retString, 'END;\n\n')
    #if(returnECL)
      #append(retString, 'converted := project( indata, convert(LEFT) );\n')
      outnames := %'retString'%;
    #else
      %retString%
      outnames := project( indata, %convert%(LEFT) );
    #end
  #end
ENDMACRO;

/*
This macro takes a nested structure, such as Risk_Indicators.Layout_Boca_Shell, and flattens it into a one-level structure.

For example:

	r := record
		string spam;
		string eggs;
	end;
	
	r1 := record
		r breakfast;
		r lunch;
		r dinner;
		string python;
		string sketches;
	end;
	
	d := dataset( [], r1 );
	flatten(d, dFlat);
	
dFlat is in the following structure:
	r2 := record
		string breakfast__spam;
		string breakfast__eggs;
		string lunch__spam;
		string lunch__eggs;
		string dinner__spam;
		string dinner__eggs;
		string python;
		string sketches;
	end;

The FULLYQUALIFY argument prefixes field names (eg, 'spam') with the path to that field ('breakfast'), if applicable.
Setting fullyQualify:=false would, in this example, cause a syntax error (defining 'spam' and 'eggs' three times each).

RETURNECL doesn't actually flatten indata into outnames, but rather outputs the ECL string necessary to do so. This makes
it trivial to create your own ECL code to flatten. For example, setting RETURNECL:=true for the above code would return this
code (AS A STRING):


	r := RECORD
		string breakfast__spam;
		string breakfast__eggs;
		string lunch__spam;
		string lunch__eggs;
		string dinner__spam;
		string dinner__eggs;
		string python;
		string sketches;
	END;
	r convert( indata le ) := TRANSFORM
		self.breakfast__spam := le.breakfast.spam;
		self.breakfast__eggs := le.breakfast.eggs;
		self.lunch__spam := le.lunch.spam;
		self.lunch__eggs := le.lunch.eggs;
		self.dinner__spam := le.dinner.spam;
		self.dinner__eggs := le.dinner.eggs;
		self.python := le.python;
		self.sketches := le.sketches;
	END;

	converted := project( indata, convert(LEFT) );


STRINGIFY converts all non-string data types to strings and provides conversion logic as necessary (eg, booleans are 
converted to '0' and '1'). This makes it easier to create a fixed-width (space-padded) output layout. The caveat is
that this logic cannot know the proper lengths for variable-length types (string, qstring, data). These would need to
be specified by the user (eg, string10, qstring24, data16). Numeric types are declared as the maximum length string
needed to guarantee no truncation. An unsigned4, for example, has a valid range of [0,4294967295] and therefore
requires a string10 to guarantee it can hold that maximum value.

PAIRS flattens vertically, not horizontally, meaning it returns a dataset with name/value pairs. For example:

	r := record
		string spam;
		string eggs;
	end;
	
	r1 := record
		r breakfast;
		r lunch;
		r dinner;
		string python;
		string sketches;
	end;
	x := dataset( [{
		'spam for breakfast', 'eggs for breakfast',
		'spam for lunch', 'eggs for lunch',
		'spam for dinner', 'eggs for dinner',
		'monty',
		'flying circus' }], r1 );
	output(x, named('x'));

flatten( x, y, Pairs:=true );

y here will be:

  +-----------------+--------------------+
  | name            | value              |
  +-----------------+--------------------+
  | breakfast.spam  | spam for breakfast |
  | breakfast.eggs  | eggs for breakfast |
  | lunch.spam      | spam for lunch     |
  | lunch.eggs      | eggs for lunch     |
  | dinner.spam     | spam for dinner    |
  | dinner.eggs     | eggs for dinner    |
  | python          | monty              |
  | sketches        | flying circus      |
  +-----------------+--------------------+

PAIRS also plays nicely with RETURNECL.

Note: returning a vertically-flattened dataset necessarily returns both fields (name and value) as strings.
STRING and QSTRING fields are implicitly converted; all others are simply (string) cast. The maximum possible
length of the 'name' field can be determined at compile-time and therefore optimized. The same can be done with
'value' only if all field lengths are explicitly defined; if a variable-length 'string' or 'qstring' field is
present within the input dataset, Flatten cannot predict the optimal size for 'value'. However, when returning
strings (returnECL=true), the minimum required length (to not truncate explicitly defined fields) is thrown
in as a hint.




This macro won't work on any structures with child datasets, such as:
	r := record
		string spam;
		string eggs;
	end;
	r3 := record
		dataset(r1) meals;
	end;



USES:
Flatten is handy for creating a flat layout that can be easily viewed in QueryBuilder's outputs without having
to look at ECL Watch, or for taking an existing dataset and 'batchifying' it; that is to say, making it available
for queries for the batch team. (See Risk_Indicators.CDIP_Batch_Service, for example.)

Vertical flattening (PAIRS=true) can be used for making realtime 'attribute'-style return datasets that
can be sent through ESDL structures.
*/


// import risk_indicators;
// d := choosen( riskwise.shortcuts.validation_fcra_shell95, 1 );
// Flatten( d, df, pairs := true, returnECL := true );
// output(df);
// indata := d;