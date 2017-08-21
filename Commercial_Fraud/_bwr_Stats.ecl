pversion 		:= '20100224';
pOutAppend	:= commercial_fraud.files().Dell_out_Append.built;

#workunit('name','Commercial Fraud stats ' + pversion);

sequential(
	 output(Commercial_Fraud.Query_Samples(pOutAppend))
	,Commercial_Fraud.Stats(pversion,pOutAppend)
);