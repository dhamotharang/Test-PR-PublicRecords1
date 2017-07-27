//These functionMacro's return the expanded fields of a layout in different forms. see sample code in zz_dabittan.BatchShare_MAC_ExpandLayout
EXPORT MAC_ExpandLayout := MODULE
  //generates a dynamically expanded layout
	EXPORT Generate(in_layout, prefix='', iterations=3, defaultToEmptyString=true, preNumberText='') := FUNCTIONMACRO
		BatchShare.MAC_ExpandLayout.Mac_SetDefaults(#TEXT(in_layout),#TEXT(prefix),pref,emptystring,defaultToEmptyString);

		#EXPORTXML(fields,in_layout);
		#DECLARE(expanded_layout); #SET(expanded_layout,'');
		#DECLARE(c); #SET(c,1);
		#LOOP
			#IF(%c% > iterations)
				#BREAK;
			#ELSE
				#FOR(fields)
					#FOR(field)
						#APPEND(expanded_layout,%'{@ecltype}'% + ' ' + pref + %'{@label}'% + preNumberText + %c% + emptystring + ';' + '\n');
					#END
				#END
				#SET(c,%c% + 1);
			#END
		#END
		
		RETURN {%expanded_layout%};
	ENDMACRO;
	
  //generates a dynamically expanded layout to echo the input layout and append a prefix to the field names
	EXPORT EchoIn(in_layout, prefix='\'in_\'') := FUNCTIONMACRO
		#DECLARE(echoed_layout); #SET(echoed_layout,'');
		#EXPORTXML(fields,in_layout);
		#FOR(fields)
			#FOR(field)
				#APPEND(echoed_layout,%'{@ecltype}'% + ' ' + prefix + %'{@label}'% + ';' + '\n');
			#END
		#END
		RETURN {%echoed_layout%};
	ENDMACRO;	
	
	//generates an expanded denormalize
	EXPORT Denorm(leftSide, rightSide, in_layout, prefix='', iterations=3, preNumberText='') := FUNCTIONMACRO

		BatchShare.MAC_ExpandLayout.Mac_SetDefaults(#TEXT(in_layout),#TEXT(prefix),pref,es);
		
		#DECLARE(trans_expanded); #SET(trans_expanded,'');
		#DECLARE(i); #SET(i,1);
		#DECLARE(tempN); #SET(tempN,'');
		#EXPORTXML(fields,in_layout);
		#LOOP
			#IF(%i% > iterations)
				#BREAK;
			#ELSE
				#FOR(fields)
					#FOR(field)
						#SET(tempN, pref + %'{@label}'% + preNumberText + %i%); 
						#APPEND(trans_expanded,'SELF.' + %'tempN'% + ':=' + 'IF(C=' + %i% + ',R.' + %'{@label}'% + ',L.' + %'tempN'% + ');' + '\n');
					#END
				#END
				#SET(i,%i% + 1);
			#END
		#END

		recordof(leftSide) DeNorm(recordof(leftSide) L, recordof(rightSide) R, INTEGER C) := TRANSFORM		
		 %trans_expanded%
		 self := L;	
		END;

		final := DENORMALIZE(leftSide, rightSide, LEFT.acctno = RIGHT.acctno, DeNorm(LEFT, RIGHT, COUNTER));
		
		//output(%'trans_expanded'%,named('trans_expanded'));
		RETURN final;
	ENDMACRO;
	//displays the contents of a layout
	EXPORT Display(layout):= FUNCTIONMACRO	
		
		#DECLARE(text_layout); #SET(text_layout,'');
		#DECLARE(i); #SET(i,0);
		#EXPORTXML(fields,layout);
		#FOR(fields)
			#FOR(Field)
				#APPEND(text_layout,%'{@ecltype}'% + ' ' + %'{@label}'% + ';' + '\n');
				#SET(i,%i% + 1);
			#END
		#END
		
		//output(%i%,named('number_of_fields'));
		RETURN %'text_layout'%;
	ENDMACRO;
  //sets some default fields for the above functions
	EXPORT Mac_SetDefaults(layoutName,inputPrefix,prefix_out,emptystr,defaultToEmptyStr=false) := MACRO

		hasQuotes   := stringlib.StringFind(inputPrefix, '\'', 2);
		prefix_out  := MAP(inputPrefix = '' => layoutName[((stringlib.StringFind(layoutName, '.', 1))+1)..(stringlib.StringFind(layoutName, '_', 1))], //use layout name as prefix : ex for pl_main_layout it will use 'pl_'
											 hasQuotes   > 0  => inputPrefix[((stringlib.StringFind(inputPrefix, '\'', 1))+1)..(hasQuotes-1)],inputPrefix); //use entered prefix 
											
		//additional logic can be added in the loop to check data type and set default accordingly int-0 bool-false -str-''...
		emptystr := if(defaultToEmptyStr,' :=\'\' ','');
	ENDMACRO;
		
END;