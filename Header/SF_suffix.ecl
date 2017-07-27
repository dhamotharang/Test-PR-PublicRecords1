export SF_suffix(boolean pFastHeader = false) := function

return if(pFastHeader,'_fheader','_header');

end;
