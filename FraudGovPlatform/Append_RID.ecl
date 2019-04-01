IMPORT Header, FraudShared, ut;
EXPORT Append_RID(
	 dataset(FraudShared.Layouts.Base.Main) FileBase
	,dataset(FraudShared.Layouts.Base.Main) Previous_Build = IF(_Flags.FileExists.Base.Main, FraudShared.Files().Base.Main.Built, DATASET([], FraudShared.Layouts.Base.Main))
) := FUNCTION
    
    max_rid := max(Previous_Build, Previous_Build.Record_ID) :	global;

    Current_Build_Dist := distribute(FileBase,hash32(Source + source_rec_id));
    Previous_Build_Dist := distribute(Previous_Build,hash32(Source + source_rec_id));
    
    previous_RIDs  := 
        join(   Current_Build_Dist,
                Previous_Build_Dist,
                left.Source = right.Source
                and left.source_rec_id = right.source_rec_id,
                transform(	FraudShared.Layouts.Base.Main, 
					self.record_id := if(	left.Source = right.Source and Left.source_rec_id = Right.source_rec_id, Right.record_id, 0); self := Left)	,
                left outer,
                local);

    FraudShared.Layouts.Base.Main Set_RID(FraudShared.Layouts.Base.Main L, integer cnt) := transform  
        self.record_id := max_rid + cnt;            
        self := L;
    end;
			 
    new_RIDs := 	 project(previous_RIDs(record_id = 0), Set_RID(LEFT, COUNTER));

    Final_RIDs := previous_RIDs(record_id > 0) + new_RIDs;	

    sort_Final_RIDs := sort(Final_RIDs, record_id, -did_score,local);
    dedup_Final_RIDs := dedup(sort_Final_RIDs,record_id,local);    

    return dedup_Final_RIDs;
END;

