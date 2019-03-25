
EXPORT fn_dedup(inputs):=FUNCTIONMACRO
    in_dst := DISTRIBUTE(inputs,hash(customer_account_number, FileName));
    in_srt := sort(in_dst , customer_account_number, FileName, record, except ProcessDate,unique_id, local);

    {inputs} RollupUpdate({inputs} l, {inputs} r) := 
    transform
        SELF.Unique_Id := if(l.Unique_Id < r.Unique_Id,l.Unique_Id, r.Unique_Id); // leave always previous Unique_Id 
        self := l;
    end;

    in_ddp := rollup( in_srt
        ,RollupUpdate(left, right)
        ,Record																						
        ,except ProcessDate,unique_id
        ,local
    );
    return in_ddp;
ENDMACRO;