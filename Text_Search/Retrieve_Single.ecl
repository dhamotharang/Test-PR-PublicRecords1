export Retrieve_Single(FileName_Info info, Types.Stage stage, 
											Layout_Search_operand oprnd,
											SET OF Types.PartitionID partList,
											BOOLEAN hasDups = FALSE) := FUNCTION
	Indx := Indx_Nominals(info);
	Layout_MergeFlat copyAIS(Indx x) := TRANSFORM
		SELF.kwp 				:= x.kwp;
		SELF.wip				:= x.wip;
		SELF.termID			:= oprnd.id;
		SELF.seg				:= x.seg;
		SELF.subSeg			:= 0;
		SELF.docRef.src := x.src;
		SELF.docRef.doc := x.doc;
		SELF.part				:= x.part;
		SELF.stage 			:= stage;
	END;
	Indx_Value := Indx.nominal + Indx.suffix;
	OprTstVal  := oprnd.nominals[1] + oprnd.suffixes[1];
	OprTstVal2 := oprnd.nominals[2] + oprnd.suffixes[2];
  f_IN := Indx.nominal IN oprnd.nominals;
  f_GE := Indx.nominal >= oprnd.nominals[1];
  f_GT := Indx.nominal >= oprnd.nominals[1];	// see g test
  f_LE := Indx.nominal <= oprnd.nominals[1];
  f_LT := Indx.nominal <= oprnd.nominals[1];	// see g test
  f_EQ := Indx.nominal = oprnd.nominals[1];
  f_RNG := Indx.nominal >= oprnd.nominals[1] AND Indx.nominal <= oprnd.nominals[2];
  fd := (oprnd.filterType=Types.NominalFilter.IN_Filter AND f_IN) OR
        (oprnd.filterType=Types.NominalFilter.GT_Filter AND f_GT) OR
        (oprnd.filterType=Types.NominalFilter.GE_Filter AND f_GE) OR
        (oprnd.filterType=Types.NominalFilter.LT_Filter AND f_LT) OR
        (oprnd.filterType=Types.NominalFilter.LE_Filter AND f_LE) OR
        (oprnd.filterType=Types.NominalFilter.EQ_Filter AND f_EQ) OR
        (oprnd.filterType=Types.NominalFilter.RNG_Filter AND f_RNG);
  g_IN := Indx_Value IN oprnd.fullNominals;
  g_GE := Indx_Value 	>= OprTstVal;
  g_GT := Indx_Value  >  OprTstVal;
  g_LE := Indx_Value  <= OprTstVal;
  g_LT := Indx_Value  <  OprTstVal;
  g_EQ := Indx_Value  =  OprTstVal;
  g_RNG := Indx_Value >= OprTstVal AND Indx_Value <= OprTstVal2;
  gd := (oprnd.filterType=Types.NominalFilter.IN_Filter AND g_IN) OR
        (oprnd.filterType=Types.NominalFilter.GT_Filter AND g_GT) OR
        (oprnd.filterType=Types.NominalFilter.GE_Filter AND g_GE) OR
        (oprnd.filterType=Types.NominalFilter.LT_Filter AND g_LT) OR
        (oprnd.filterType=Types.NominalFilter.LE_Filter AND g_LE) OR
        (oprnd.filterType=Types.NominalFilter.EQ_Filter AND g_EQ) OR
        (oprnd.filterType=Types.NominalFilter.RNG_Filter AND g_RNG);
	x0  := Indx(KEYED(part IN partList AND typ=oprnd.typ AND fd) 
							AND seg IN oprnd.segList AND gd);
	x		:= LIMIT(x0, Limits.Max_Read, 
							FAIL(Limits.Read_Code, Limits.Read_Msg));
  ais := PROJECT(x, copyAIS(LEFT));  
	sorted_ais := SORT(ais, part, docRef, seg, subSeg, kwp, wip);
	rslt := IF(oprnd.postSort, sorted_ais, ais);
	RETURN rslt;
END;