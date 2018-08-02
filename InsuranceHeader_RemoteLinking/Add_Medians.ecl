/***********************************************************/
/**	Developed:  Matt Rumsey																**/
/**							(Enhanced by) Richard Taylor							**/
/**																												**/
/**	Functino:		Add median to dataset based on a grouping	**/
/**								attribute that is passed in at runtime	**/	
/**																												**/
/**	Input:																								**/
/**				InFile	- Input Dataset(Any Format)							**/
/**				GroupBy - Attribute on which to group						**/
/**				Compute	-	Attribute on which to compute meidans	**/
/**				OutFile	-	Output Filename												**/
/***********************************************************/

/***********************************************************/
/**	Add the following line of at the top of your code 		**/
/**		that calls this MACRO if you get a 10099 Error			**/
/**	#OPTION('outputLimit', 100);													**/
/***********************************************************/

IMPORT ML,STD;

EXPORT Add_Medians(InFile, GroupBy, Compute, OutFile) := MACRO                        

  #uniquename(unique_list)
  %unique_list% := SORT(PROJECT(InFile, 
                                TRANSFORM({STRING25 GroupBy},
                                          SELF.GroupBy := (STRING)LEFT.GroupBy)),
                         GroupBy);

  #uniquename(infile_dist)
  %infile_dist% := DISTRIBUTE(InFile, HASH32((STRING)GroupBy));

  #uniquename(num_rec)
  %num_rec% := RECORD   
    UNSIGNED8 Number;
    STRING25  GroupBy;
  END;

  #uniquename(add_num)
  %num_rec% %add_num%(%Unique_List% Le, INTEGER C) := TRANSFORM
    SELF.Number    :=   C;
    SELF.GroupBy   :=   Le.GroupBy;
  END;

  #uniquename(dds_numeric_group)
  %dds_numeric_group% := DEDUP(PROJECT(%unique_list%, %add_num%(LEFT, COUNTER)),Groupby);

  #uniquename(base_calc_tbl)
  %base_calc_tbl% := TABLE(%infile_dist%,{GroupBy,Compute},LOCAL); 

  #uniquename(XF) 
  ML.Types.NumericField %XF%(%base_calc_tbl% Le, %dds_numeric_group% Ri, INTEGER C) := TRANSFORM
    SELF.ID := C;
    SELF.Number := Ri.Number;
    SELF.Value := Le.Compute;
  END;

  #uniquename(base_calculation)
  %base_calculation% := JOIN(%base_calc_tbl%, 
                             DISTRIBUTE(%dds_numeric_group%, HASH32((STRING)GroupBy)),
                             LEFT.GroupBy = RIGHT.GroupBy,
                             %XF%(LEFT, RIGHT, COUNTER),
                             LOCAL);

  #uniquename(median_table)
  %median_table% := ML.FieldAggregates(%base_calculation%).Medians;

  #uniquename(prep_rec)
  %prep_rec% := RECORD
    STRING25 GroupBy;
    DECIMAL9_1 Median;
  END;

  #uniquename(matchback)
  %prep_rec% %matchback%(%dds_numeric_group% Le, %median_table% Ri) := transform
    SELF.GroupBy := Le.GroupBy;
    SELF.Median := Ri.Median;
  END;
  #uniquename(return_group)
  %Return_Group%   := JOIN(  DISTRIBUTE(%dds_numeric_group%, Number), 
                             DISTRIBUTE(%median_table%, Number),
                             LEFT.Number = RIGHT.Number,
                             %matchback%(LEFT, RIGHT),
                             LOCAL);
  #uniquename(outrec)
  %outrec% := RECORD
    RECORDOF(InFile);
    DECIMAL9_1 Median;
  END;

  #uniquename(add_med)
  %outrec% %add_med%(InFile Le, %Return_Group% Ri) := TRANSFORM
    SELF.median := Ri.Median;
    SELF             := Le;
  END;

  OutFile := JOIN(%infile_dist%,
                  DISTRIBUTE(%Return_Group%, HASH32((STRING)GroupBy)),
                  (STRING)LEFT.GroupBy = (STRING)RIGHT.GroupBy,
                  %add_med%(LEFT, RIGHT),
                  LOCAL);                      

ENDMACRO;