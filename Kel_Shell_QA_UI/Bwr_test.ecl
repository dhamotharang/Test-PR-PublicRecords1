ECL_TEXT:='output(\'test\')';
Environment:=Kel_Shell_QA_UI.Constants.Public_Records_EW;

Kel_Shell_QA_UI.fSubmitNewWorkunit(ECL_TEXT,'hthor_dev','',Environment);																											
																	
EXPORT Bwr_test := 'todo';