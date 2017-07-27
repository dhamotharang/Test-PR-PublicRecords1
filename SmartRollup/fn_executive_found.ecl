import doxie_cbrs;
export fn_executive_found(string inTitle) := function
    execExceptions := ['PSD','VD','PRIN'];
    foundExec := exists(doxie_cbrs.executive_titles(stored_title=inTitle));
	  foundException := inTitle in execExceptions;
	  found := foundExec or foundException;
  return found;
end;