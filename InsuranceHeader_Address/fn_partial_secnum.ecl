EXPORT fn_partial_secnum (string secnum) := FUNCTION

len     := length(secnum);
partial := IF(len > 2, secnum[1..len-1], secnum); 
output(len);

RETURN partial;
END;