EXPORT Unmangle(s) := FUNCTIONMACRO
    LoadXml('<xml/>');
    #DECLARE(out) #SET(out, '')
    #DECLARE(mangled)
    #DECLARE(flag) #SET(flag, FALSE)

    //remove flag prefix/suffix
    #IF(REGEXFIND('(__)(.*)(_flags)$',s))
      #SET(flag, TRUE)
      #SET(mangled, REGEXFIND('(__)(.*)(_flags)$',s,2))
    #ELSE
      #SET(mangled, s)
    #END

    //mangled fields end in '_' (not __recordcount)
    #IF(REGEXFIND('_$', %'mangled'%))
      #DECLARE(step) #SET(step, %'mangled'%)
      //handle leading '_'
      #IF(REGEXFIND('^_[a-z]', %'step'%))
        #APPEND(out, %'step'%[2])
        #SET(step, %'step'%[3..])
      #ELSEIF(REGEXFIND('^[a-z]', %'step'%))
        #APPEND(out, (QSTRING) %'step'%[1])
        #SET(step, %'step'%[2..])
      #END

      #LOOP
        #IF(REGEXFIND('^__', %'step'%))
          #APPEND(out, '_')
          #SET(step, %'step'%[3..])
        #ELSEIF(REGEXFIND('^_[a-z]',%'step'%))
          #APPEND(out, (QSTRING) %'step'%[2])
          #SET(step, %'step'%[3..])
        #ELSEIF(REGEXFIND('([a-z0-9]+)(_+.*)', %'step'%))
          #APPEND(out, REGEXFIND('([a-z0-9]+)(_+.*)', %'step'%,1))
          #SET(step, REGEXFIND('([a-z0-9]+)(_+.*)', %'step'%,2))
        #ELSE
          #BREAK
        #END
      #END
    #ELSE
      #APPEND(out, %'mangled'%)
    #END

    //reapply flag prefix/suffix
    #IF(%flag%)
      RETURN '__'+%'out'% + '_flags';
    #ELSE
      RETURN %'out'%;
    #END
ENDMACRO;
