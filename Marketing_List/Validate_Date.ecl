EXPORT Validate_Date(

   unsigned4  pDt_xxx_Seen
  ,string     pversion

) :=
function

    result := if(
          pDt_xxx_Seen > (unsigned4)(pversion[1..8])
      or  (unsigned)(trim((string)pDt_xxx_Seen,left,right)[5..6]) > 12
      or  (unsigned)(trim((string)pDt_xxx_Seen,left,right)[7..8]) > 31    ,0
                                                                          ,pDt_xxx_Seen
    );
        
    return result;
  
end;