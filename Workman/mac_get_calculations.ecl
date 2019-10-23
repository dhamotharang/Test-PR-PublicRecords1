EXPORT mac_get_calculations(

  pCondition

) :=
functionmacro

  // thecondition := '(100 - (MatchesPerformed / PreClusterCount * 100.0)) > 99.9 and (MatchesPerformed) < 100000 and istoolong = true and istooshort = false and true = metoo';
  // -- parse out the calculations into a set
  // -- then i can loop through and create exports for them.
  // -- calulations that we want are contained in parentheses
  // -- others we ignore
  
  #UNIQUENAME(CNTR                      )
  #UNIQUENAME(CONDITION                 )
  #UNIQUENAME(CONDITION_LEN             )
  #UNIQUENAME(CURRENT_CHARACTER         )
  #UNIQUENAME(SET_CALCULATIONS          )
  #UNIQUENAME(CURRENT_CALCULATION       )
  #UNIQUENAME(CURRENT_OPEN_PARENS       )
  #UNIQUENAME(CURRENT_CLOSE_PARENS      )
  #UNIQUENAME(CURRENT_OPEN_PARENS_LEN   )
  #UNIQUENAME(CURRENT_CLOSE_PARENS_LEN  )
  
  #SET(CNTR                   ,1                                  )
  #SET(CONDITION              ,pCondition                         )
  #SET(CONDITION_LEN          ,length(trim(pCondition,left,right)))
  #SET(CURRENT_CHARACTER      ,''                                 )
  #SET(SET_CALCULATIONS       ,''                                 )
  #SET(CURRENT_CALCULATION    ,''                                 )
  #SET(CURRENT_OPEN_PARENS    ,''                                 )
  #SET(CURRENT_CLOSE_PARENS   ,''                                 )
  #SET(CURRENT_OPEN_PARENS_LEN   ,0)
  #SET(CURRENT_CLOSE_PARENS_LEN  ,0)
  
  #LOOP

    #IF(%CNTR% > %CONDITION_LEN%)
      #BREAK
    #END

    #SET(CURRENT_CHARACTER  ,%'CONDITION'%[%CNTR%])

    // -- current character is (
    #IF(%'CURRENT_CHARACTER'% = '(')
      #APPEND (CURRENT_OPEN_PARENS      ,%'CURRENT_CHARACTER'%                )
      #SET    (CURRENT_OPEN_PARENS_LEN  ,length(trim(%'CURRENT_OPEN_PARENS'%)))
      #IF(%CURRENT_OPEN_PARENS_LEN% = 1)
        #SET   (CURRENT_CALCULATION  ,%'CURRENT_CHARACTER'%)
      #ELSE
        #APPEND(CURRENT_CALCULATION  ,%'CURRENT_CHARACTER'%)
      #END
      
    #ElSEIF(%'CURRENT_CHARACTER'% = ')')
      #IF(%CURRENT_OPEN_PARENS_LEN% = 1)
        #SET    (CURRENT_OPEN_PARENS      ,''                )
      #ELSE
        #SET    (CURRENT_OPEN_PARENS      ,%'CURRENT_OPEN_PARENS'%[1..%CURRENT_OPEN_PARENS_LEN% - 1]                )      
      #END
      
      #SET    (CURRENT_OPEN_PARENS_LEN  ,length(trim(%'CURRENT_OPEN_PARENS'%)))
   
      #APPEND(CURRENT_CALCULATION  ,%'CURRENT_CHARACTER'%)

      // -- done with this calculation, add to set of calculations
      #IF(%CURRENT_OPEN_PARENS_LEN% = 0)
        #APPEND (SET_CALCULATIONS  ,',\'' + %'CURRENT_CALCULATION'% + '\'')
      #END
    
    #ELSE
      // -- if within a calculation, add character to calculation
      #IF(%CURRENT_OPEN_PARENS_LEN% > 0)
        #APPEND(CURRENT_CALCULATION  ,%'CURRENT_CHARACTER'%)
      #END
      
    #END
   
    #SET(CNTR ,%CNTR% + 1) 

  #END

  #SET(SET_CALCULATIONS ,'[' + %'SET_CALCULATIONS'%[2..] + ']')

  return %'SET_CALCULATIONS'%;
  
endmacro;