EXPORT Prep_Build := module

  export applyVoters( base ) := functionmacro
    import VotersV2;
    
    return VotersV2.Regulatory.applyVoters(base);  
  
  endmacro;


end;
