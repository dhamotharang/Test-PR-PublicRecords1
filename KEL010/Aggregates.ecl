IMPORT KEL010 AS KEL;
IMPORT * FROM KEL010.Null;

EXPORT Aggregates := MODULE

    // ************************************************************
    // Non-rank-based aggregates 
    // ************************************************************

    // internal helper functions 	
    // ------------------------------------------------------------
    EXPORT CalcRange(inset, field) := FUNCTIONMACRO
        RETURN MAX(inset, field)-MIN(inset, field);
    ENDMACRO;
    EXPORT CalcStdDev(inset, field) := FUNCTIONMACRO
        RETURN SQRT(VARIANCE(inset, field));
    ENDMACRO;
    EXPORT CalcAveNZ(inset, field) := FUNCTIONMACRO
        #IF(#TEXT(inset) = 'GROUP')
            RETURN AVE(inset, field, field != 0);
        #ELSE
            RETURN AVE(inset(field != 0), field);
        #END
    ENDMACRO;

    // aggregates on nullable values in a non-nullable set
    // all but SUM are NULL if the set is empty
    // ------------------------------------------------------------

    // Wrapper for built-in functions
    EXPORT AggN(func, inset, field) := FUNCTIONMACRO
        LOCAL __fs := inset(__NN(field));
        LOCAL __v := #EXPAND(#TEXT(func) + '(__fs, __T(' + #TEXT(field) + '))');
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;

    // Specific instances of AggN
    EXPORT MinN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggN(MIN, inset, field); ENDMACRO;
    EXPORT MaxN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggN(MAX, inset, field); ENDMACRO;
    EXPORT AveN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggN(AVE, inset, field); ENDMACRO;
    EXPORT VarianceN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggN(VARIANCE, inset, field); ENDMACRO;
    EXPORT CalcStdDevN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggN(Kel.Aggregates.CalcStdDev, inset, field); ENDMACRO;

    // Sum is null aware but does not return a nullable value - it returns 0 on an empty set
    EXPORT SumN(inset, field) := FUNCTIONMACRO
        LOCAL __fs := inset(__NN(field));
        RETURN SUM(__fs, __T(field));
    ENDMACRO;
        
    EXPORT CalcRangeN(inset, field) := FUNCTIONMACRO
        RETURN __OP2(Kel.Aggregates.MaxN(inset, field),-,Kel.Aggregates.MinN(inset, field));
    ENDMACRO;
        
    EXPORT CalcAveNZN(inset, field) := FUNCTIONMACRO
        LOCAL __fs := inset(__T(field) != 0);
        LOCAL __v := AVE(__fs, __T(field));
        RETURN IF(COUNT(__fs) = 0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;

    //  weighted versions

    EXPORT WAveN(inset, field) := FUNCTIONMACRO
        LOCAL __fs := inset(__NN(field));
        LOCAL __num := SUM(__fs, __T(field)*__RecordCount);
        LOCAL __den := SUM(__fs, __RecordCount);
        LOCAL __v := __num / __den;
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
        
    EXPORT WVarianceN(inset, field) := FUNCTIONMACRO 
    //TODO: this algorithm can have precision and stability problems esp. with large datasets but we follow HPCC to match results
    //TODO: there is a ticket (12177) requesting the two-pass algorithm (mean square difference from the population mean) and we should change when they do
        LOCAL __fs := inset(__NN(field));
        LOCAL __ssq := SUM(__fs, __T(field)*__T(field)*__RecordCount);
        LOCAL __sum := SUM(__fs, __T(field)*__RecordCount);
        LOCAL __ct  := SUM(__fs, __RecordCount);
        LOCAL __v := ( __ssq - (__sum*__sum/__ct) ) / __ct;
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
        
    EXPORT WStdDevN(inset, field) := FUNCTIONMACRO   
        LOCAL __i1 := Kel.Aggregates.WVarianceN(inset, field);
        RETURN IF(NOT __NN(__i1), __N(Kel.Typ.float), __CN(SQRT(__T(__i1))));
    ENDMACRO;

    // Sum is null aware but does not return a nullable value - it returns 0 on an empty set
    EXPORT WSumN(inset, field) := FUNCTIONMACRO
        LOCAL __fs := inset(__NN(field));
        RETURN SUM(__fs, __T(field)*__RecordCount);
    ENDMACRO;
        
    EXPORT WAveNZN(inset, field) := FUNCTIONMACRO       
        LOCAL __fs := inset(__T(field) != 0);      // we rely on __T(NULL)==0
        LOCAL __num := SUM(__fs, __T(field)*__RecordCount);
        LOCAL __den := SUM(__fs, __RecordCount);
        Local __v := __num / __den;
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
                
    EXPORT WCount(inset) := FUNCTIONMACRO
        RETURN SUM(inset, __RecordCount);
    ENDMACRO;
        
    EXPORT WCount2(inset, truth) := FUNCTIONMACRO
        #IF(#TEXT(inset) = 'GROUP')
            RETURN SUM(inset, __RecordCount, truth);
        #ELSE
            RETURN SUM(inset(truth), __RecordCount);
        #END
    ENDMACRO;    
        
    // aggregates on nullable values in a nullable set (GROUP is never a nullable set)
    // all but SUM and COUNT are NULL if the set is empty
        
    // NOTE: SUM and COUNT are coded to give NULL if the set is NULL, but ingest and filters don't make empty sets, so you don't really see any
    //       the only for-sure NULL sets are from logic properties with false predicates
    // ------------------------------------------------------------
    
    EXPORT AggNN(func, inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__NN(field));
        LOCAL __v := #EXPAND(#TEXT(func) + '(__fs, __T(' + #TEXT(field) + '))');
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;

    // Specific instances of AggNN
    EXPORT MinNN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNN(MIN, inset, field); ENDMACRO;
    EXPORT MaxNN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNN(MAX, inset, field); ENDMACRO;
    EXPORT AveNN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNN(AVE, inset, field); ENDMACRO;
    EXPORT VarianceNN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNN(VARIANCE, inset, field); ENDMACRO;
    EXPORT CalcStdDevNN(inset, field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNN(Kel.Aggregates.CalcStdDev, inset, field); ENDMACRO;

    // SumNN returns a nullable value but it is null only if the set itself is null
    EXPORT SumNN(inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__NN(field));
        LOCAL __v := SUM(__fs, __T(field));
        RETURN IF(__NL(inset), __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
        
    // Versions of non-builtin (for ECL) aggregates for nullable values and nullable sets
    EXPORT CalcRangeNN(inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        RETURN IF(NOT __NN(inset), __N(TYPEOF(__T(field))), __OP2(Kel.Aggregates.AggN(MAX, __s, field),-,Kel.Aggregates.AggN(MIN, __s, field)));
    ENDMACRO;
        
    EXPORT CalcAveNZNN(inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__T(field) != 0);
        LOCAL __result := AVE(__fs, __T(field));
        RETURN IF(COUNT(__fs) = 0, __N(TYPEOF(__result)), __CN(__result));
    ENDMACRO;

    // no field, but the set is nullable
    EXPORT CountN(inset) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        RETURN IF(NOT __NN(inset), __N(Kel.Typ.int), __CN(COUNT(__s)));
    ENDMACRO;
        
    //  weighted versions

    EXPORT WAveNN(inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__NN(field));
        LOCAL __num := SUM(__fs, __T(field)*__RecordCount);
        LOCAL __den := SUM(__fs, __RecordCount);
        LOCAL __v := __num / __den;
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
        
    EXPORT WVarianceNN(inset, field) := FUNCTIONMACRO 
    //TODO: this algorithm can have precision and stability problems esp. with large datasets but it follows HPCC currently
    //TODO: there is a ticket (12177) requesting the two-pass algorithm (mean square difference from the population mean) and we should follow
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__NN(field));
        LOCAL __ssq := SUM(__fs, __T(field)*__T(field)*__RecordCount);
        LOCAL __sum := SUM(__fs, __T(field)*__RecordCount);
        LOCAL __ct  := SUM(__fs, __RecordCount);
        LOCAL __v := ( __ssq - (__sum*__sum/__ct) ) / __ct;
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
        
    EXPORT WStdDevNN(inset, field) := FUNCTIONMACRO   
        LOCAL __i1 := Kel.Aggregates.WVarianceNN(inset, field);
        RETURN IF(NOT __NN(__i1), __N(Kel.Typ.float), __CN(SQRT(__T(__i1))));
    ENDMACRO;

    // SumNN returns a nullable value but it is null only if the set itself is null
    EXPORT WSumNN(inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__NN(field));
        LOCAL __v := SUM(__fs, __T(field)*__RecordCount);
        RETURN IF(__NL(inset), __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;

    EXPORT WAveNZNN(inset, field) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        LOCAL __fs := __s(__T(field) != 0);     // we rely on __T(NULL)==0
        LOCAL __num := SUM(__fs, __T(field)*__RecordCount);
        LOCAL __den := SUM(__fs, __RecordCount);
        LOCAL __v := __num / __den;
        RETURN IF(COUNT(__fs)=0, __N(TYPEOF(__v)), __CN(__v));
    ENDMACRO;
                
    EXPORT WCountN(inset) := FUNCTIONMACRO
        LOCAL __s := __T(inset);
        RETURN IF(NOT __NN(inset), __N(Kel.Typ.int), __CN(SUM(__s, __RecordCount)));
    ENDMACRO;
        
    // aggregates on nullable expressions in grouped sets
    // all but SUM are NULL if the set is empty
    // ------------------------------------------------------------     
        
    // Wrapper for grouped aggregates on nullable expressions.  Grouped aggregates have to
    // be constructed differently because a grouped aggregrate won't work inside a ROW
    // construct.  So instead of returning a ROW the grouped aggregate macro returns a
    // record definition which is used as the type of field in the TABLE expression.
    //
    // MIN and MAX also have to be handled specially because they don't support a filter.
    // Instead the test expression is modified so that null is always higher or lower than
    // any other possible value.
    EXPORT MinMaxExp(agg, field, minmax) := FUNCTIONMACRO
        #IF(REGEXFIND('^integer', #GETDATATYPE(__T(field)), NOCASE))
            LOCAL __extreme := #IF(minmax > 0) Kel.Typ.MININT #ELSE Kel.Typ.MAXINT #END;
        #ELSEIF(REGEXFIND('^string', #GETDATATYPE(__T(field)), NOCASE))
            LOCAL __extreme := #IF(minmax > 0) '\'\'' #ELSE #ERROR('Attempt to use filtered MIN(GROUP) on string value') #END;
        #ELSE
            LOCAL __extreme := #IF(minmax > 0) Kel.Typ.MINFLOAT #ELSE Kel.Typ.MAXFLOAT #END;
        #END
        RETURN #EXPAND(#TEXT(agg) + '(GROUP, IF(__NL(' + #TEXT(field) + '),' + __extreme + ',__T(' + #TEXT(field) + ')))');
    ENDMACRO;
    EXPORT MinMaxNull(field) := FUNCTIONMACRO
        #IF(REGEXFIND('^string', #GETDATATYPE(__T(field)), NOCASE))
            RETURN '\'\'';
        #ELSE
            RETURN 0;
        #END
    ENDMACRO;

    EXPORT AggNG(agg, field, minmax) := FUNCTIONMACRO
      LOCAL __empty := COUNT(GROUP, __NN(field))=0;
      #IF(minmax!=0)
        LOCAL __val := IF(__empty, Kel.Aggregates.MinMaxNull(field), Kel.Aggregates.MinMaxExp(agg, field, minmax));
      #ELSE
        LOCAL __val := #EXPAND(#TEXT(agg) + '(GROUP, __T(' + #TEXT(field) + '), __NN(' + #TEXT(field) + '))');
      #END
      LOCAL __flag := IF(__empty, __NullFlag, __NotNullFlag);
      RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;

    EXPORT CalcStdDevNGHelp(inset, field, filter) := FUNCTIONMACRO
        RETURN SQRT(VARIANCE(inset, field, filter));
    ENDMACRO;

    EXPORT MinNG(field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNG(MIN, field, -1); ENDMACRO;
    EXPORT MaxNG(field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNG(MAX, field, 1); ENDMACRO;
    EXPORT AveNG(field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNG(AVE, field, 0); ENDMACRO;
    EXPORT VarianceNG(field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNG(VARIANCE, field, 0); ENDMACRO;
    EXPORT CalcStdDevNG(field) := FUNCTIONMACRO RETURN Kel.Aggregates.AggNG(Kel.Aggregates.CalcStdDevNGHelp, field, 0); ENDMACRO;

    // Sum is null aware but does not return a nullable value
    EXPORT SumNG(field) := FUNCTIONMACRO
        RETURN SUM(GROUP, __T(field), __NN(field));
    ENDMACRO;

    // This version does return a nullable value for use in certain cases where a multi-valued property has to be
    // normalized and grouped rather than calculating the aggregate directly on the mvp.  In this case the result
    // needs to be nullable.
    EXPORT SumNNG(field) := FUNCTIONMACRO
        LOCAL __val := SUM(GROUP, __T(field), __NN(field));
        LOCAL __flag := __NotNullFlag;
        RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;

    // Versions of non-builtin aggregates for grouped aggregates
    EXPORT CalcRangeNG(field) := FUNCTIONMACRO
      LOCAL __empty := COUNT(GROUP, __NN(field))=0;
      LOCAL __val := IF(__empty, 0, Kel.Aggregates.MinMaxExp(MAX, field, 1) - Kel.Aggregates.MinMaxExp(MIN, field, -1));
      LOCAL __flag := IF(__empty, __NullFlag, __NotNullFlag);
      RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;
        
    EXPORT CalcAveNZNG(field) := FUNCTIONMACRO
      LOCAL __val := AVE(GROUP, __T(field), __T(field)!=0);
      LOCAL __flag := IF(COUNT(GROUP, __NN(field))=0, __NullFlag, __NotNullFlag);
      RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;

    //  weighted versions

    EXPORT WAveNG(field) := FUNCTIONMACRO
        LOCAL __flag := IF(COUNT(GROUP, __NN(field))=0, __NullFlag, __NotNullFlag);
        LOCAL __num := SUM(GROUP, __T(field)*__RecordCount, __NN(field));
        LOCAL __den := SUM(GROUP, __RecordCount, __NN(field));
        LOCAL __val := __num / __den;
        RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;
        
    EXPORT WVarianceNG(field) := FUNCTIONMACRO 
    //TODO: this algorithm can have precision and stability problems esp. with large datasets but it follows HPCC currently
    //TODO: there is a ticket (12177) requesting the two-pass algorithm (mean square difference from the population mean) and we should follow
        LOCAL __flag := IF(COUNT(GROUP, __NN(field))=0, __NullFlag, __NotNullFlag);
        LOCAL __ssq := SUM(GROUP, __T(field)*__T(field)*__RecordCount, __NN(field));
        LOCAL __sum := SUM(GROUP, __T(field)*__RecordCount, __NN(field));
        LOCAL __ct  := SUM(GROUP, __RecordCount, __NN(field));
        LOCAL __val := ( __ssq - (__sum*__sum/__ct) ) / __ct;
        RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;
        
    EXPORT WStdDevNG(field) := FUNCTIONMACRO   
        LOCAL __i1 := Kel.Aggregates.WVarianceNN(field);
        RETURN IF(NOT __NN(__i1), __N(Kel.Typ.float), __CN(SQRT(__T(__i1))));
    ENDMACRO;

    EXPORT WSumNG(field) := FUNCTIONMACRO
         RETURN SUM(GROUP, __T(field)*__RecordCount, __NN(field));
    ENDMACRO;

    EXPORT WAveNZNG(field) := FUNCTIONMACRO
        LOCAL __flag := IF(COUNT(GROUP, __NN(field))=0, __NullFlag, __NotNullFlag);
        LOCAL __num := SUM(GROUP, __T(field)*__RecordCount, __NN(field) AND __T(field)!=0);
        LOCAL __den := SUM(GROUP, __RecordCount, __NN(field) AND __T(field)!=0);
        LOCAL __val := __num / __den;
        RETURN { TYPEOF(__val) v := __val, Kel.Typ.flags f := __flag };
    ENDMACRO;
        
    // (Count grouped doesn't happen)       

    // ************************************************************
    // Rank-based aggregates
    // ************************************************************

    // The type of an expanded and ranked dataset.
    EXPORT RankedField := RECORD
      KEL.Typ.int number;      // Which rankField (see RankingPrepare) this value is from
      KEL.Typ.float value;     // The value of the rankField
      KEL.Typ.int pos;         // The position (rank) of the value in the group
      KEL.Typ.int size;        // The size of the group
    END;

    // The type of an expanded and ranked dataset - nullable version
    EXPORT RankedFieldN := RECORD
      KEL.Typ.int number;      // Which rankField (see RankingPrepare) this value is from
      KEL.Typ.nfloat value;    // The value of the rankField
      KEL.Typ.int pos;         // The position (rank) of the value in the group
      KEL.Typ.int size;        // The size of the group
    END;

    // Selector for which RankedField type
    EXPORT RankedFieldAs(nullable) := FUNCTIONMACRO
      #IF(nullable)
        RETURN KEL.Aggregates.RankedFieldN;
      #ELSE
        RETURN KEL.Aggregates.RankedField;
      #END
    ENDMACRO;

    // Return the default value for the value field in a RankedField record - must match field above
    EXPORT RankedFieldDefault(nullable) := FUNCTIONMACRO
      #IF(nullable)
        RETURN __N(KEL.typ.float);
      #ELSE
        RETURN 0;
      #END
    ENDMACRO;

    // Cast a field to the type of a ranked field - must match field above
    EXPORT RankedFieldCast(f, nullable) := FUNCTIONMACRO
      #IF(nullable)
        RETURN __CAST(KEL.typ.float, f);
      #ELSE
        RETURN f;
      #END
    ENDMACRO;

    // Projects dIn to the layout lOut and expands all fields in fieldList into numbered records for
    // each field (similar to ML.ToField).  Unlike ML.ToField this macro can duplicate additional
    // fields from the input into the output.
    EXPORT ExpandFields(dIn, lOut, fieldList, nullable) := FUNCTIONMACRO
      LoadXml('<xml/>');
      #DECLARE(expandList) #SET(expandList, 'COUNTER')
      #DECLARE(listSize) #SET(listSize, 0)
      #EXPORTXML(fields, dIn)
      #FOR(fields)
        #FOR(field)
          #IF(REGEXFIND(','+%'@label'%+',', ','+fieldList+',',NOCASE))
            #SET(listSize, %listSize%+1)
            #APPEND(expandList, ',' + %'listSize'% + '=>KEL.Aggregates.RankedFieldCast(LEFT.'+%'@label'% + ',' + #TEXT(nullable) + ')')
          #END
        #END
      #END
      RETURN NORMALIZE(dIn, %listSize%, TRANSFORM(lOut, SELF.number:=COUNTER,
                                                  SELF.value:=CASE(#EXPAND(%'expandList'%),KEL.Aggregates.RankedFieldDefault(nullable)),
                                                  SELF:=LEFT, SELF:=[]));
    ENDMACRO;

    // Build a partial record definition based on the given dataset and the given list of fields
    EXPORT BuildRecord(dIn, fieldList) := FUNCTIONMACRO
      #IF(fieldList)
          LoadXml('<xml/>');
          #DECLARE(newFields) #SET(newFields, '')
          #EXPORTXML(fields, RECORDOF(dIn))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+fieldList+',',NOCASE))
                #IF(%'newFields'%)
                  #APPEND(newFields, ',')
                #END
                #APPEND(newFields, #TEXT(dIn)+'.'+%'@label'%)
              #END
            #END
          #END
          RETURN %'newFields'% + ',';
      #ELSE
          RETURN '';
      #END
    ENDMACRO;

    // Build a sort specification based on the given dataset and the given list of fields
    EXPORT BuildSortSpec(dIn, groupList, nullable) := FUNCTIONMACRO
      #IF(NOT nullable)
          RETURN 'RECORD';
      #ELSE
        LoadXml('<xml/>');
        #DECLARE(spec) #SET(spec, '')
        #IF(groupList)
          #EXPORTXML(fields, RECORDOF(dIn))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+groupList+',',NOCASE))
                #APPEND(spec, ',' + %'@label'%)
              #END
            #END
          #END
        #END
        #APPEND(spec, ', number, __NullStatusAsSort(value), __T(value)')
        RETURN %'spec'%;
      #END
    ENDMACRO;

    // Build a filter to count only non-null values
    EXPORT BuildCountCriteria(nullable) := FUNCTIONMACRO
      #IF(nullable)
        RETURN ', __NN(value)';
      #ELSE
        RETURN '';
      #END
    ENDMACRO;

    // Create a dataset which ranks each field in rankFields within the entire input dataset.
    // For every original record there will be a N new records (where N is the number of fields
    // in rankFields) where each new record has the index of it's rank field, the value of it's
    // rank field and the rank of that value within the dataset.
    //
    // This macro doesn't handle datasets with nullable rankFields because the COUNT could be
    // different for each field.  RankingPrepareGrouped has to be used with such datasets.
    EXPORT RankingPrepare(inset, rankFields) := FUNCTIONMACRO
      LOCAL __MaxRank := COUNT(inset);
      LOCAL __Expanded := KEL.Aggregates.ExpandFields(inset, KEL.Aggregates.RankedFieldAs(nullable), rankFields, FALSE);
      LOCAL __Ordered := SORT(__Expanded, number, value);
      RETURN PROJECT(__Ordered, TRANSFORM(KEL.Aggregates.RankedField, SELF.pos:=COUNTER-__MaxRank*(LEFT.number-1), SELF.size:=__MaxRank, SELF:=LEFT));
    ENDMACRO;

    // Same as RankingPrepare except that groupFields are retained from the input recordset
    // and ranks are calculated within each group defined by those fields.
    EXPORT RankingPrepareGrouped(inset, groupFields, rankFields, nullable, weighted, smart) := FUNCTIONMACRO
      LoadXml('<xml/>');

      // Expand the dataset
      LOCAL __FullLayout := { #EXPAND(KEL.Aggregates.BuildRecord(inset, groupFields)) KEL.Aggregates.RankedFieldAs(nullable) 
                             #IF(weighted)
                               , inset.__RecordCount
                             #END
                            };
      LOCAL __Expanded := KEL.Aggregates.ExpandFields(inset, __FullLayout, rankFields, nullable);

      // Sort the dataset and add raw position number
      LOCAL __Ordered := SORT(__Expanded #EXPAND(KEL.Aggregates.BuildSortSpec(inset, groupFields, nullable)));
      LOCAL __Ordered1 :=
        #IF(weighted)
          NORMALIZE(__Ordered, LEFT.__RecordCount, TRANSFORM(LEFT));
        #ELSE
          __Ordered;
        #END
      LOCAL __Counted := PROJECT(__Ordered1, TRANSFORM(__FullLayout, SELF.pos:=COUNTER, SELF.size:=0, SELF:=LEFT));

      // Find the minimum raw position for each group
      #DECLARE(groupSpec) #SET(groupSpec, groupFields)
      #IF(groupFields)
        #APPEND(groupSpec,  ',')
      #END
      LOCAL __Mins := TABLE(__Counted, { KEL.typ.int minpos := MIN(GROUP, pos),
                                         KEL.typ.int size := COUNT(GROUP #EXPAND(KEL.Aggregates.BuildCountCriteria(nullable))),
                                         #EXPAND(%'groupSpec'%) number },
                                         #EXPAND(%'groupSpec'%) number, FEW);

      // Build a join condition for the group
      #DECLARE(joinCond) #SET(joinCond, '')
      #IF(groupFields)
        #EXPORTXML(fields, inset);
        #FOR(fields)
          #FOR(field)
            #IF(REGEXFIND(','+%'@label'%+',', ','+groupFields+',',NOCASE))
              #APPEND(joinCond, ' AND LEFT.'+%'@label'%+'=RIGHT.'+%'@label'%)
            #END
          #END
        #END
      #END

      // Join these minimums back in order to make each group it's own sequence
      RETURN JOIN(__Counted, __Mins, LEFT.number=RIGHT.number #EXPAND(%'joinCond'%), TRANSFORM(RECORDOF(__Counted), SELF.pos:=LEFT.pos-RIGHT.minpos+1, SELF.size:=RIGHT.size, SELF:=LEFT), 
                  #IF(smart) SMART #ELSE HASH #END);
    ENDMACRO;

    // Calculate the weight of this particular item when calculating an NTile value.
    // 'tiles' is the number of breaks (percentile=100, quadtile=4, median=2),
    // 'tile' is the particular break (which percentile, which quadtile, or 1 for median),
    // 'itemCount' is the total number of items in the sequence,
    // 'item' is the index of this particular item within the sequence.
    //
    // Essentially, the value for a given ntile comes from one or two
    // values in the sequence.  If one of the items in the sequence
    // is exactly at the ntile rank then the value at the item is
    // used.  If the exact ntile rank occurs between two items then
    // we use both values and do a linear interpolation between them.
    //
    // This function calculates the weight to give each item in the
    // sequence when calculating this value.  The weight will be 0 for
    // every item except one or two around the correct ntile rank.
    // The non-zero weights will always add up to 'tiles'.  These
    // weights must be divided by 'tiles' before the final correct
    // value is calculated.  This is done to avoid possibly inaccurate
    // floating point comparisons when the dataset is filtered on these
    // weights.
    EXPORT NTileWeight(KEL.Typ.int tiles, KEL.Typ.int tile, KEL.Typ.int itemCount, KEL.Typ.int item) := FUNCTION
      LOCAL __discriminant := tile*(itemCount-1)+tiles;
      LOCAL __base := __discriminant DIV tiles;     // __base is the closest position below the ntile rank
      LOCAL __weight := __discriminant % tiles;     // __weight measures how close the rank is to the next value
      RETURN MAP(
                 itemCount = 0 AND item = 1 => 1,       // All values are null - use the first one
                 itemCount = 0              => 0,
                 item > itemCount           => 0,
                 __base = 0                   => IF(item = 1, tiles, 0),
                 __base >= itemCount          => IF(item = itemCount, tiles, 0),
                 item = __base                => tiles - __weight,
                 item = __base + 1            => __weight,
                 /* ELSE */                    0);
    END;

    EXPORT RankWeight(KEL.Typ.int r, KEL.Typ.int itemCount, KEL.Typ.int item) := FUNCTION
        RETURN MAP(itemCount = 0 AND item = 1          => 1,
                   itemCount = 0                       => 0,
                   r >= itemCount AND item = itemCount => 1,
                   r >= itemCount                      => 0,
                   r = item                            => 1,
                   /* ELSE */                             0);
    END;


    EXPORT RankWeightDown(KEL.Typ.int r, KEL.Typ.int itemCount, KEL.Typ.int item) := FUNCTION
        LOCAL __ra := itemCount-r+1;
        LOCAL __r  := IF(__ra <= 0, 1, __ra);
        RETURN MAP(itemCount = 0 AND item = 1          => 1,
                   itemCount = 0                       => 0,
                   __r = item                          => 1,
                   /* ELSE */                             0);
    END;

    // Table project dIn into lWeights and then filter the result so that
    // only fields with a non-zero value in one of the 'aggs' fields
    // are retained.
    EXPORT RankingSelect(dIn, lWeights, tWeights, nullable) := FUNCTIONMACRO
      // Build a selection condition for the rows with a non-zero weight
      LoadXml('<xml/>');
      #DECLARE(filter) #SET(filter, '')
      #EXPORTXML(fields, lWeights);
      #FOR(fields)
        #FOR(field)
          #APPEND(filter, ' OR '+%'@label'%+'!=0')
        #END
      #END

      LOCAL __Weighted := PROJECT(dIn, TRANSFORM({dIn, lWeights}, SELF:=ROW(tWeights(ROW(LEFT, KEL.Aggregates.RankedFieldAs(nullable)))), SELF:=LEFT));
      RETURN __Weighted(FALSE #EXPAND(%'filter'%));
    ENDMACRO;

    // Aggregate the records in dIn (which contains a value field generated
    // in RankingPrepare and which contains a set of weights generally calculated
    // using NTileWeights and RankingsSelect.
    //
    // This routine aggregates up the sum of the value field multiplied by the weight
    // for each weight field (i.e. the fields in lWeights).
    EXPORT RankAggTransformHelper(l,v,r) := FUNCTIONMACRO
      RETURN IF(__NN(v),__CreateNullFor(l * __T(v) + __T(r), r), r);
    ENDMACRO;
    EXPORT RankAggMergeHelper(r1,r2) := FUNCTIONMACRO
      LOCAL __r1n := __NullStatusAsBool(r1);
      LOCAL __r2n := __NullStatusAsBool(r2);
      RETURN MAP(__r1n AND __r2n => r1, __r1n => r2, __r2n => r1, __CN(__T(r1) + __T(r2)));
    ENDMACRO;
    EXPORT RankingsGather(dIn, lOut, lWeights, groupFields, nullable) := FUNCTIONMACRO
      LoadXml('<xml/>');
      #DECLARE(eTransform) #SET(eTransform, '')
      #DECLARE(eMerge) #SET(eMerge, '')
      #EXPORTXML(fields, lWeights)
      #FOR(fields)
        #FOR(field)
          #IF(nullable)
            #APPEND(eTransform, 'SELF.'+%'@label'%+':=KEL.Aggregates.RankAggTransformHelper(LEFT.'+%'@label'%+',LEFT.value,RIGHT.'+%'@label'%+'),')
            #APPEND(eMerge, 'SELF.'+%'@label'%+':=KEL.Aggregates.RankAggMergeHelper(RIGHT1.'+%'@label'%+',RIGHT2.'+%'@label'%+'),')
          #ELSE
            #APPEND(eTransform, 'SELF.'+%'@label'%+':=RIGHT.'+%'@label'%+'+LEFT.'+%'@label'%+'*LEFT.value,')
            #APPEND(eMerge, 'SELF.'+%'@label'%+':=RIGHT1.'+%'@label'%+'+RIGHT2.'+%'@label'%+',')
          #END
        #END
      #END

      #DECLARE(groupSpec) #SET(groupSpec, '')
      #EXPORTXML(fields, lOut)
      #FOR(fields)
        #FOR(field)
          #IF(%'@label'% != '' AND REGEXFIND(','+%'@label'%+',', ','+groupFields+',',NOCASE))
            #APPEND(groupSpec, 'LEFT.'+%'@label'%+',')
          #END
        #END
      #END

      RETURN AGGREGATE(dIn, lOut, TRANSFORM(lOut, #EXPAND(%'eTransform'%) SELF:=LEFT, SELF:=[]), TRANSFORM(lOut, #EXPAND(%'eMerge'%) SELF:=RIGHT1), #EXPAND(%'groupSpec'%) FEW);
    ENDMACRO;

    // Calculate a set of ranked aggregates against an entire dataset.
    //   dIn = Input dataset
    //   rankFields = The fields the aggregates will be calculated against
    //   lWeights = A record which will hold the weight values for each aggregate
    //   lResult = The layout of the result
    //   tWeights = A transform which will calculate the weights for each input record
    //   tNormalize = A transform which will normalize the final result after the weighted sum is calculated
    EXPORT RankingSimple(dIn, rankFields, lWeights, lResult, tWeights, tNormalize, nullable) := FUNCTIONMACRO
      LOCAL __Numbered := KEL.Aggregates.RankingPrepare(dIn, rankFields, nullable);
      LOCAL __Weights := KEL.Aggregates.RankingSelect(__Numbered, lWeights, tWeights, nullable);
      LOCAL __PreResults := KEL.Aggregates.RankingsGather(Weights, lResult, lWeights, '', TRUE);
      RETURN PROJECT(__PreResults, tNormalize(LEFT));
    ENDMACRO;


    // Calculate a set of ranked aggregates for each group within a dataset.  This method can be used on
    // datasets with a fairly small number of groups (where the set of unique combinations of groupFields
    // can reside on a single node).
    //   dIn = Input dataset
    //   rankFields = The fields the aggregates will be calculated against
    //   groupFields = The set of fields which define a group
    //   lWeights = A record which will hold the weight values for each aggregate
    //   lResult = The layout of the result
    //   tWeights = A transform which will calculate the weights for each input record
    //   tNormalize = A transform which will normalize the final result after the weighted sum is calculated
    //   smart = Use smart joins
    EXPORT RankingGroupedSmall(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, weighted) := FUNCTIONMACRO
      RETURN KEL.Aggregates.RankingGroupedSmall2(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, weighted, TRUE);
    ENDMACRO;
    EXPORT RankingGroupedSmall2(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, weighted, smart) := FUNCTIONMACRO
      LOCAL __Numbered := KEL.Aggregates.RankingPrepareGrouped(dIn, groupFields, rankFields, nullable, weighted, smart);
      LOCAL __Weights := KEL.Aggregates.RankingSelect(__Numbered, lWeights, tWeights, nullable);
      LOCAL __PreResults := KEL.Aggregates.RankingsGather(__Weights, lResult, lWeights, groupFields, TRUE);
      RETURN PROJECT(__PreResults, tNormalize(LEFT));
    ENDMACRO;

    // Calculate a set of ranked aggregates for each group within a dataset.  This method can be used on
    // datasets with a large number of groups as long as no one group has so many records it cannot reside
    // on a single node.
    //   dIn = Input dataset
    //   rankFields = The fields the aggregates will be calculated against
    //   groupFields = The set of fields which define a group
    //   lWeights = A record which will hold the weight values for each aggregate
    //   lResult = The layout of the result
    //   tWeights = A transform which will calculate the weights for each input record
    //   tNormalize = A transform which will normalize the final result after the weighted sum is calculated
    //   smart = Use smart joins
    EXPORT RankingGroupedLarge(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable) := FUNCTIONMACRO
      RETURN KEL.Aggregates.RankingGroupedLarge2(dIn, rankFields, groupFields, lWeigths, lResult, tWeigths, tNormalize, nullable, TRUE);
    ENDMACRO;
    EXPORT RankingGroupedLarge2(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, smart) := FUNCTIONMACRO
      lResult RollGroup(RECORDOF(dIn) r, DATASET(RECORDOF(dIn)) g) := TRANSFORM
        UngroupedResults := {lResult AND NOT [#EXPAND(groupFields)]};
        #IF(nullable)
            Numbered := KEL.Aggregates.RankingPrepareGrouped(g, '', rankFields, TRUE, smart);
        #ELSE
            Numbered := KEL.Aggregates.RankingPrepare(g, rankFields);
        #END
        Weights := KEL.Aggregates.RankingSelect(Numbered, lWeights, tWeights, nullable);
        SELF := KEL.Aggregates.RankingsGather(Weights, UngroupedResults, lWeights, '', TRUE)[1];
        SELF := r;
      END;
      Rolled := ROLLUP(GROUP(dIn, #EXPAND(groupFields), ALL), GROUP, RollGroup(LEFT, ROWS(LEFT)));
      RETURN PROJECT(Rolled, tNormalize(LEFT));
    ENDMACRO;

    // Calculate a set of ranked aggregates for each group within a dataset.  This method can be used on
    // any dataset but the Small and Large variants should be used directly if there is sufficient information
    // about the dataset.
    EXPORT RankingGrouped(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, smart) := FUNCTIONMACRO
      RETURN KEL.Aggregates.RankingGrouped2(dIn, rankFields, groupFields, lWeigths, lResult, tWeights, tNormalize, nullable, TRUE);
    ENDMACRO;
    EXPORT RankingGrouped2(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, smart) := FUNCTIONMACRO
      LOCAL __MaxSmallCount := 10000000;
      LOCAL __MinLargeCount := 1000;
      LOCAL __MaxGroupSize := 100000;
      LOCAL __GroupCounts := TABLE(dIn, {KEL.Typ.int c:=COUNT(GROUP)}, #EXPAND(groupFields));
      LOCAL __InvalidDataset := (COUNT(__GroupCounts) >= __MaxSmallCount) AND (MAX(__GroupCounts,c) >= __MaxGroupSize);
      LOCAL __UseLarge := (COUNT(__GroupCounts) > __MaxSmallCount) OR ((COUNT(__GroupCounts) > __MinLargeCount) AND (MAX(__GroupCounts,c) < __MaxGroupSize));
      LOCAL __LargeResult := KEL.Aggregates.RankingGroupedLarge2(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, smart);
      LOCAL __SmallResult := KEL.Aggregates.RankingGroupedSmall2(dIn, rankFields, groupFields, lWeights, lResult, tWeights, tNormalize, nullable, smart);
      RETURN IF(__InvalidDataset, ERROR(lResult, 'Dataset has too many groups and is too skewed on grouping fields "' + groupFields + '" to calculate ranking'),
             IF(__UseLarge, __LargeResult, __SmallResult));
    ENDMACRO;
END;
