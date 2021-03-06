IMPORT KEL06 AS KEL;
EXPORT Null := MODULE
  // The bit value of the NotNull/Null flag in the flags field.  If this value ever
  // changes it must be changed in Kel.Typ as well.
  EXPORT __NotNullFlag := 1;
  EXPORT __NullFlag := 0;
  // Return the null status of a nullable record as a boolean
  EXPORT __NullStatusAsBool(o) := FUNCTIONMACRO
    LOCAL __v := o;
    RETURN (__v.f & __NotNullFlag = 0);
  ENDMACRO;
  // Return the null status of a nullable record as a flag
  EXPORT __NullStatusAsFlag(o) := FUNCTIONMACRO
    LOCAL __v := o;
    RETURN (__v.f & __NotNullFlag);
  ENDMACRO;
  // Return the null status in sorted order (null last)
  EXPORT __NullStatusAsSort(o) := FUNCTIONMACRO
    LOCAL __v := o;
    RETURN ((__v.f & __NotNullFlag) ^ __NotNullFlag);
  ENDMACRO;
  // Not Null Test function
  EXPORT __NN(o) := FUNCTIONMACRO
    RETURN NOT __NullStatusAsBool(o);
  ENDMACRO;
  // Is Null Test function
  EXPORT __NL(o) := FUNCTIONMACRO
    RETURN __NullStatusAsBool(o);
  ENDMACRO;
  // Return the appropriate null flag value based on the null status
  EXPORT Kel.Typ.flags __NullStatusBoolToFlag(BOOLEAN NullStatus) := IF(NullStatus, __NullFlag, __NotNullFlag);
  // Return the default value for the type of the given object
  EXPORT __DefaultFromItem(o) := FUNCTIONMACRO
    RETURN ROW(TRANSFORM({TYPEOF(o) v},SELF:=[])).v;
  ENDMACRO;
  EXPORT __DefaultFromType(t) := FUNCTIONMACRO
    RETURN ROW(TRANSFORM({t v},SELF:=[])).v;
  ENDMACRO;
  EXPORT __NullableTypeOf(o) := FUNCTIONMACRO
    RETURN Kel.Typ.ntyp(TYPEOF(o));
  ENDMACRO;
  EXPORT __NullableType(t) := FUNCTIONMACRO
    RETURN Kel.Typ.ntyp(t);
  ENDMACRO;
  // Tri-state version of AND
  EXPORT Kel.typ.nbool __AND(Kel.typ.nbool b1, Kel.typ.nbool b2) := FUNCTION
    LOCAL __ResultTrue := b1.v AND b2.v;
    LOCAL __ResultFalse := (NOT __NullStatusAsBool(b1) AND NOT b1.v) OR (NOT __NullStatusAsBool(b2) AND NOT b2.v);
    LOCAL __NullStatus := NOT __ResultFalse and NOT __ResultTrue;
    RETURN ROW({ __ResultTrue, __NullStatusBoolToFlag(__NullStatus) }, Kel.Typ.nbool);
  END;
  // Tri-state version of OR
  EXPORT Kel.typ.nbool __OR(Kel.typ.nbool b1, Kel.typ.nbool b2) := FUNCTION
    LOCAL __ResultTrue := (NOT __NullStatusAsBool(b1) AND b1.v) OR (NOT __NullStatusAsBool(b2) AND b2.v);
    LOCAL __ResultFalse :=  NOT __NullStatusAsBool(b1) AND NOT __NullStatusAsBool(b2) AND NOT b1.v AND NOT b2.v;
    LOCAL __NullValue := NOT __ResultFalse AND NOT __ResultTrue;
    RETURN ROW({ __ResultTrue, __NullStatusBoolToFlag(__NullValue) }, Kel.Typ.nbool);
  END;
  // Tri-state version of NOT
  EXPORT Kel.typ.nbool __NOT(Kel.typ.nbool b) := FUNCTION
    LOCAL __r := NOT b.v;
    RETURN ROW({ IF(__NullStatusAsBool(b), FALSE, __r), __NullStatusAsFlag(b) }, Kel.typ.nbool);
  END;
  // Non-null aware equality operator - this is used with join conditions because ECL requires a simple equality operator
  // it can identify.  So we generate a non-null version of a join condition along with the full null-aware version.
  // The non-null version is used by ECL to perform the join and the result is filtered by the null-aware version to remove
  // join pairs that shouln't be included.
  EXPORT __NNEQ(o1, o2) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    RETURN __v1.v = __v2.v;
  ENDMACRO;
  // Exact EQual operator: true if both not null and values same, true if both are null, false otherwise
  EXPORT __EEQP(o1, o2) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    RETURN (__v1.v = __v2.v) AND (__NullStatusAsFlag(__v1) = __NullStatusAsFlag(__v2));
  ENDMACRO;
  EXPORT __EEQ(o1, o2) := FUNCTIONMACRO
    RETURN ROW({ __EEQP(o1, o2), __NotNullFlag }, Kel.typ.nbool);
  ENDMACRO;
  // Is Not 'Not Equals' - i.e. the values are equal or one of the two is null
  EXPORT __NTNTEQ(o1, o2) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    RETURN ROW({ __v1.v = __v2.v OR __NullStatusAsBool(__v1) OR __NullStatusAsBool(__v2), __NotNullFlag }, Kel.typ.nbool);
  ENDMACRO;
  // Null Test (Is Null) function
  EXPORT __NT(o) := FUNCTIONMACRO
    LOCAL __v := o;
    RETURN ROW({ __NullStatusAsBool(__v), __NotNullFlag }, Kel.typ.nbool);
  ENDMACRO;
  // Nullable type cast
  // the first parameter is a non-nullable type; the result of __CAST() is the associated NULLABLE type
  EXPORT __CAST(t, o) := FUNCTIONMACRO
    LOCAL __v := o;
    LOCAL __r := (t) __v.v;
    RETURN ROW({ IF(__NullStatusAsBool(__v), __DefaultFromType(t), __r), __NullStatusAsFlag(__v) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Nullable type cast to type of expression
  EXPORT __CastTo(o, t) := FUNCTIONMACRO
    LOCAL __v := o;
    LOCAL __to := t;
    LOCAL __r := (TYPEOF(__to.v)) __v.v;
    RETURN ROW({ IF(__NullStatusAsBool(__v), __DefaultFromItem(__to), __r), __NullStatusAsFlag(__v) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Truncate - Truncate a nullable value to just the value (using the default when null)
  EXPORT __T(o) := FUNCTIONMACRO
    LOCAL __v := o;
    RETURN __v.v;
  ENDMACRO;
  // Clean - Clear all of the flags field except NullFlag
  EXPORT __CLEAN(o) := FUNCTIONMACRO
    LOCAL __v := o;
    RETURN ROW({__v.v, __v.f&__NotNullFlag}, RECORDOF(__v));
  ENDMACRO;
	
  // Wrapper for unary operators on nullable types
  EXPORT __OP1(op, o) := FUNCTIONMACRO
    LOCAL __v := o;
    LOCAL __r := op __v.v;
   RETURN ROW({ IF(__NullStatusAsBool(__v), __DefaultFromItem(__r), __r), __NullStatusAsFlag(__v) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Wrapper for binary operators on nullable types
  EXPORT __OP2(o1, op, o2) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    LOCAL __NullStatus := __NullStatusAsBool(__v1) OR __NullStatusAsBool(__v2);
    LOCAL __r := __v1.v op __v2.v;
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__r), __r), __NullStatusBoolToFlag(__NullStatus) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Wrapper for single parameter functions on nullable types
  EXPORT __FN1(func, o1) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __NullStatus := __NullStatusAsBool(__v1);
    LOCAL __r := func(__v1.v);
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__r), __r), __NullStatusBoolToFlag(__NullStatus) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Wrapper for two parameter functions on nullable types
  EXPORT __FN2(func, o1, o2) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    LOCAL __NullStatus := __NullStatusAsBool(__v1) OR __NullStatusAsBool(__v2);
    LOCAL __r := func(__v1.v, __v2.v);
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__r), __r), __NullStatusBoolToFlag(__NullStatus) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Wrapper for three parameter functions on nullable types
  EXPORT __FN3(func, o1, o2, o3) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    LOCAL __v3 := o3;
    LOCAL __NullStatus := __NullStatusAsBool(__v1) OR __NullStatusAsBool(__v2) OR __NullStatusAsBool(__v3);
    LOCAL __r := func(__v1.v, __v2.v, __v3.v);
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__r), __r), __NullStatusBoolToFlag(__NullStatus) }, __NullableTypeOf(__r));
  ENDMACRO;
  // Wrapper for four parameter functions on nullable types
  EXPORT __FN4(func, o1, o2, o3, o4) := FUNCTIONMACRO
    LOCAL __v1 := o1;
    LOCAL __v2 := o2;
    LOCAL __v3 := o3;
    LOCAL __v4 := o4;
    LOCAL __NullStatus := __NullStatusAsBool(__v1) OR __NullStatusAsBool(__v2) OR __NullStatusAsBool(__v3) OR __NullStatusAsBool(__v4);
    LOCAL __r := func(__v1.v, __v2.v, __v3.v, __v4.v);
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__r), __r), __NullStatusBoolToFlag(__NullStatus) }, __NullableTypeOf(__r));
  ENDMACRO;
  
  // Constructor for nullable value
  EXPORT __CN(o) := FUNCTIONMACRO
    #IF(#TEXT(o)='\'\'')
      RETURN ROW({ '', __NotNullFlag }, Kel.typ.nstr);
    #ELSE
      LOCAL __v := o;
      RETURN ROW({ __v, __NotNullFlag }, __NullableTypeOf(__v));
    #END
  ENDMACRO;
  // Constructor for nullable value using the given value and null status
  EXPORT __BN(v, f) := FUNCTIONMACRO
    LOCAL __value := v;
    LOCAL __flag := f;
    RETURN ROW({ __value, IF(__flag, __NullFlag, __NotNullFlag) }, __NullableTypeOf(__value));
  ENDMACRO;
  // Constructor for nullable value using the given value and flags
  EXPORT __BN2(v, f) := FUNCTIONMACRO
    LOCAL __value := v;
    LOCAL __flag := f;
    RETURN ROW({ __value, __flag }, __NullableTypeOf(__value));
  ENDMACRO;
  // Constructor for nullable value of same type as second item (usually the destination)
  EXPORT __CreateNullFor(o, t) := FUNCTIONMACRO
    LOCAL __v := o;
    LOCAL __to := t;
    LOCAL __r := (TYPEOF(__to.v)) __v;
    RETURN ROW({ __r, __NotNullFlag }, __NullableTypeOf(__r));
  ENDMACRO;
  // Null constant of type t
  EXPORT __N(t) := FUNCTIONMACRO
    RETURN ROW({ __DefaultFromType(t), __NullFlag }, __NullableTypeOf(t));
  ENDMACRO;
  // PROJECT that preserves nulls status of the base dataset
  EXPORT __PROJECT(b, t) := FUNCTIONMACRO
    LOCAL __ds := b;
    LOCAL __p := PROJECT(__ds.v, t);
    LOCAL __NullStatus := __NullStatusAsBool(__ds);
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__p), __p), __NullStatusAsFlag(__ds) }, __NullableTypeOf(__p));
  ENDMACRO;
  // Filter that preserves nulls status of the base dataset
  EXPORT __FILTER(b, c) := FUNCTIONMACRO
    LOCAL __base := b;
    LOCAL __NullStatus := __NullStatusAsBool(__base);
    LOCAL __f := __base.v(c);
    RETURN ROW({ IF(__NullStatus, __DefaultFromItem(__f), __f), __NullStatusAsFlag(__base) }, __NullableTypeOf(__f));
  ENDMACRO;
  // Filter for child joins
  EXPORT __CHILDJOINFILTER(b, c) := FUNCTIONMACRO
    LOCAL __base := b;
    LOCAL __v := __base.v;
    LOCAL __cc := c(__v);
    RETURN __v(__cc);
  ENDMACRO;
  // Unwrap nullable fields (records with value:v and flags:f fields) and turn them into
  // field pairs with the first field the value (with the name of the parent record) and
  // the second field the flags with a name of __<field>_flags.
  //
  // The tricky thing is handling nested datasets.  These have to be turned into nested
  // TABLE statements to unroll the nested dataset as well.
  EXPORT __UNWRAP(s) := FUNCTIONMACRO
    LoadXml('<xml/>');
    LOCAL __src := s;
    #EXPORTXML(fields, s)
    #DECLARE(InRecord)
    #DECLARE(InDataset)
    #DECLARE(LastWasDataset)
    #DECLARE(Prefix)
    #DECLARE(Parent)
    #DECLARE(Code)
    #SET(InRecord, 0)
    #SET(InDataset, 0)
    #SET(Prefix, '__src')
    #SET(Code, 'TABLE(__src, {');
    #FOR(fields)
      #FOR(field)
        #IF (%@IsRecord%=1)
          #SET(InRecord, %InRecord%+1)
          #SET(Parent, %'@label'%)
          #SET(Prefix, %'Prefix'%+'.'+%'@label'%)
        #END
        #IF (%InRecord% > %InDataset%)
          #IF (%'@label'% = 'v' AND %@IsDataset%=1)
            #APPEND(Code, 'DATASET ' + %'Parent'% + ' := TABLE(' + %'Prefix'% + '.v, {')
            #SET(Prefix, %'Prefix'% + '.v')
            #SET(InDataset, %InDataset%+1)
          #END
          #IF (%'@label'% = 'v' AND %@IsDataset%=0 AND %@IsRecord%=0)
            #APPEND(Code, 'TYPEOF(' + %'Prefix'% + '.v) ' + %'Parent'% + ' := ' + %'Prefix'% + '.v,')
          #END
          #IF (%'@label'% = 'f' AND %@IsRecord%=0)
            #APPEND(Code, 'Kel.Typ.flags __' + %'Parent'% + '_flags := ' + %'Prefix'% + '.f ^ __NotNullFlag,')
          #END
        #END
        #IF (%InRecord% = %InDataset% AND %@IsDataset%=0 AND %@IsEnd%=0)
          #APPEND(Code, 'TYPEOF(' + %'Prefix'% + '.' + %'@label'% + ') ' + %'@label'% + ' := ' + %'Prefix'% + '.' + %'@label'% + ',')
        #END
        #IF (%@IsEnd%=1)
          #SET(Prefix, REGEXREPLACE('^(.*)\\.[^.]+$', %'Prefix'%, '$1'))
          #SET(Parent, REGEXREPLACE('^.*\\.([^.]+)$', %'Prefix'%, '$1'))
        #END
        #IF (%@IsEnd%=1 AND %InRecord% = %InDataset%)
          #SET(InDataset, %InDataset%-1)
          #APPEND(Code, '}),')
        #ELSE
          #IF (%@IsEnd%=1 AND %InRecord% > %InDataset%)
            #SET(InRecord, %InRecord%-1)
          #END
        #END
      #END
    #END
    #APPEND(Code, '})')
    RETURN #EXPAND(%'Code'%);
  ENDMACRO;
  // Convert a single nullable value into a more user friendly format
  EXPORT __UNWRAPVALUE(__v) := FUNCTIONMACRO
    RETURN ROW({ __v.v, __v.f ^ __NotNullFlag }, { TYPEOF(__v.v) value, Kel.Typ.flags flags });
  ENDMACRO;
  
  EXPORT __BuildClean(din) := FUNCTIONMACRO
  // build assignments using the __CLEAN macro to clear un-needed flags
    LoadXml('<xml/>');
      #DECLARE(newFields) #SET(newFields, '')
      #DECLARE(Parent)
      #DECLARE(Depth)     #SET(Depth, 0)
      #EXPORTXML(fields, RECORDOF(din))
      #FOR(fields)
        #FOR(field)
          #IF (%@IsDataset%=1)
            #SET(Depth, %Depth%+1)
          #END	
          #IF (%@IsRecord%=1)
            #SET(Parent, %'@label'%)
            #SET(Depth, %Depth%+1)
          #END			
          #IF (%@IsEnd%=1)
            #SET(Depth, %Depth%-1)
          #END
          #IF (%'@label'% = 'v' AND %Depth%<3)
            #IF(%'newFields'% != '')
              #APPEND(newFields, ',');
            #END
            #APPEND(newFields, 'SELF.'+%'Parent'%+':=__CLEAN(LEFT.'+%'Parent'%+')')
          #END
        #END	
      #END
    #IF(%'newFields'% != '')
      #APPEND(newFields, ',');
    #END
    #APPEND(newFields, 'SELF:=LEFT')
    //#ERROR(%'newFields'%)
    RETURN %'newFields'%;
  ENDMACRO;
  EXPORT __CLEANANDDO(source, stmt) := FUNCTIONMACRO
    LOCAL __wrapped(TYPEOF(source) source) := stmt;  
    LOCAL __result := __wrapped(PROJECT(source, TRANSFORM(RECORDOF(source), #EXPAND(__BuildClean(source)) )));
    RETURN __result;
  ENDMACRO;
  
  EXPORT __CLEARFLAGS(source) := FUNCTIONMACRO
    // rationalle: only the outer model fields can be single valued - only they need to have MultipleValuesDetected cleared
    LOCAL __result := PROJECT( source, TRANSFORM(RECORDOF(source), #EXPAND(__BuildClean(source))) );
    RETURN __result;
    
  ENDMACRO;
  
END;
