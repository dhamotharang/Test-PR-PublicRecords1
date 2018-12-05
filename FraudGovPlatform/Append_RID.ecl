IMPORT Header, FraudShared, ut;
EXPORT Append_RID(DATASET(FraudShared.Layouts.Base.Main) FileBase) := FUNCTION
    
    Previous_Build := FraudShared.Files().Base.Main.built;
    max_rid := max(Previous_Build.Record_ID) :	global;

    Current_Build_Dist := distribute(FileBase,hash32(source + source_rec_id));
    Previous_Build_Dist := distribute(Previous_Build,hash32(source + source_rec_id));
    
    previous_RIDs  := 
        join(   Current_Build_Dist,
                Previous_Build_Dist,
                left.source = right.source
                and left.source_rec_id = right.source_rec_id,
                transform(	FraudShared.Layouts.Base.Main, 
					self.record_id := if(	Left.source = Right.source and Left.source_rec_id = Right.source_rec_id, Right.record_id, 0); self := Left)	,
                left outer,
                local);

    FraudShared.Layouts.Base.Main Set_RID(FraudShared.Layouts.Base.Main L, integer cnt) := transform  
        self.record_id := IF(L.record_id > 0, L.record_id, max_rid + cnt);            
        self := L;
    end;
			 
	
    new_RIDs := 	 project(previous_RIDs(record_id = 0), Set_RID(LEFT, COUNTER));

    Final_RIDs := previous_RIDs(record_id > 0) + new_RIDs;	

    return Final_RIDs;
END;

