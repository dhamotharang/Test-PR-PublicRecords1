export AssignRecordSidOnly(MaxRec,NewData,NewDataRec,isdelta=true):=functionmacro

    PrevBase := MaxRec;
    RecordLayout:=NewDataRec;
    DataToAdd:=NewData;

    RecordLayout tCreateAdds(RecordLayout L, RecordLayout R):=TRANSFORM
    SELF.Record_Sid:=IF (l.Record_Sid=0, PrevBase+1, l.Record_Sid+thorlib.nodes());
    self.delta_ind:=if(isDelta,1,0);
    self:=R;
    end;

    FinalAdds:=iterate(DataToAdd,tCreateAdds(left,right));

    return FinalAdds;
endmacro;