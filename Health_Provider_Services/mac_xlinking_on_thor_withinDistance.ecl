// Macro returns all the records if weight is >= score and records are within distance of the max weight of first record
export mac_xlinking_on_thor_withinDistance (infile,REF = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
															Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',
															Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_LIC_NBR = '',
															Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
															Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
															Input_SOURCE_RID = '',OutFile, forcePull = false, score = 38, distance = 6) := MACRO
															
#uniquename(asindex)
%asIndex% := if(forcePull = true, false, if(thorlib.nodes() < 400 or count(infile) < 7000000, true, false));
															
															
/*-------------------------------- Thor Search -------------------------------------------*/
#uniquename(result_thor)
Health_Provider_Services.MAC_MEOW_xLNPID_Batch(infile,REF,Input_FNAME,Input_MNAME,Input_LNAME,Input_SNAME,
											Input_GENDER,
											Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_NAME,Input_ST,Input_ZIP,
											Input_SSN,Input_SSN,Input_DOB,Input_DOB,Input_PHONE,Input_LIC_STATE,Input_LIC_NBR,
											Input_TAX_ID,Input_TAX_ID,Input_DEA_NUMBER,Input_VENDOR_ID,Input_NPI_NUMBER,Input_NPI_Number,
											Input_UPIN,Input_DID,Input_BDID,
											Input_SRC,Input_SOURCE_RID,,,,,,,%result_thor%,%asIndex%);

/*------- Final Result ----*/
#uniquename(result)
%result% := %result_thor%;
//output (%result%);

#uniquename(xform)
recordof(%result%) %xform%(%result% l) := transform
	maxScore 			:= if(count(l.results) > 1, l.results[1].weight, 0);
	self.results  := l.results(weight >= score and weight >= (maxscore - distance));
	self := l;
end;

// output('test');
// output(%result_thor%);
outfile := project(%result%, %xform%(left));
// outfile := %result%;

endmacro;