
EXPORT Uber_Constants := MODULE

		export UBER_FieldData := DATASET([
			{'FNAME',1} 
			,{'PFNAME',2} 
			,{'MNAME',3} 
			,{'LNAME',4} 
			,{'DPH_LNAME',5} 
			,{'PRANGE',6} 
			,{'PREDIR',7} 
			,{'PNAME',8} 
			,{'SUFFIX',9} 
			,{'POSTDIR',10} 
			,{'UNIT_DESIG',11} 
			,{'SEC_RANGE',12} 
			,{'CITY',13} 
			,{'STATE',14} 
			,{'ZIP',15} 
			,{'DOB',16} 
			,{'ADDR',17}],AUTOKEY.LAYOUT_UBER.FIELD_DEFINITION);


END;

