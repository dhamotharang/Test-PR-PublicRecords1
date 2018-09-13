/* ************************************************************************************** 
PRTE2_Common_DevOnly.MAC_CrossTabCount
simplify cross tab reports by a single field (later figure syntax for multiple fields.
Returns a simplified table with two fields:  GroupBy and GroupCount
************************************************************************************** */

EXPORT MAC_CrossTabCount(infile,infield) := FUNCTIONMACRO

	#uniquename(rec_mac)
	%rec_mac% := RECORD
			GroupBy := infile.infield;
			INTEGER GroupCount := COUNT(GROUP);
	END;
	
	// let the caller decide how to sort and display counts.
	RETURN TABLE(infile,%rec_mac%,infield);

ENDMACRO;