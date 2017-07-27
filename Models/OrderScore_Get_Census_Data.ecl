IMPORT EASI, Models, RiskWise, Risk_Indicators;

EXPORT OrderScore_Get_Census_Data (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam) := FUNCTION

 	
 /* ***********************************************************************************
 * Build Easi census data                                                             *
 ***********************************************************************************  */
 
layout_ineasi := record
    UNSIGNED4 easi_seq;
		recordof(EASI.Key_Easi_Census) easi;
	END;	
	
layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_ineasi                             BT_Census;
		layout_ineasi                             ST_Census;  
END;
	
	
	/*  join the Bill to address to the geolink field on the Census Key*/   
	layout_ineasi joinBT(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
	  self.easi_seq  := le.Bill_To_Out.seq;                //pass the sequence number of the Bill To
		self.easi      := ri;                                //pick up just the census data for this Bill To 
		self	         := [];                                //the ship to fields can be empty  
	END;	


	BT_Census_Results :=   join(clam, Easi.Key_Easi_Census,
			keyed(right.geolink = left.Bill_To_Out.shell_input.st + left.Bill_To_Out.shell_input.county + left.Bill_To_Out.shell_input.geo_blk),
		       joinBT(left, right), 
		       left outer,
		       atmost(RiskWise.max_atmost),
		       keep(1));
  
	
	/*  join the ship to address to the geolink field on the Census Key*/
	 layout_ineasi JoinST(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
      self.easi_seq := le.Ship_To_Out.seq;	              //pass the sequence number of the Ship To	  
			self.easi     := ri;                                //pick up just the census data for this Ship To 
		  self          := [];                                //the bill to fields can be empty
	  END;
		
	 
  
	ST_Census_Results := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink = left.Ship_To_Out.shell_input.st + left.Ship_To_Out.shell_input.county + left.Ship_To_Out.shell_input.geo_blk),
				 joinST(left,right),
				 left outer,
				 ATMOST(RiskWise.max_atmost),
				 keep(1));

    
	/* Add "bill to" Census data to the BTST clam   */    
	layout_model_in    Clam_plus_BT(clam le, BT_Census_Results ri) := TRANSFORM
		SELF.bs          := le;                              //fill in the entire BTST clam 
		SELF.BT_Census   := ri;                              //fill in the censu data for the "bill to"
		SELF.ST_Census   := [];                              //the ship to is blank on this transform
	END;
	
	clam_with_BTeasi := join(clam, BT_Census_Results, 
		    left.bill_to_out.seq = (right.easi_seq), 
		    Clam_plus_BT(left,right), 
				left outer);

/* Add "ship to" Census data to the BTST clam   */  
layout_model_in    Clam_plus_ST(clam_with_BTeasi le, ST_Census_Results ri) := TRANSFORM
		SELF.bs         := le.bs;                            //fill in the entire BTST clam  
		SELF.BT_Census  := le.BT_Census;                     //fill in the "bill to" Census data from the left
		SELF.ST_Census  := ri;                               //fill in the "ship to" Census data from the right 
	END;
	
  clam_with_easi := join(clam_with_BTeasi, ST_Census_Results, 
		    left.bs.ship_to_out.seq = (right.easi_seq), 
		    Clam_plus_ST(left,right), 
				left outer);
				
	RETURN(clam_with_easi);
END;    
				
		
		