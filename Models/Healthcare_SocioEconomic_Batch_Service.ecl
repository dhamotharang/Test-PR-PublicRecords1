
import Risk_indicators, Models, Std, Profilebooster, Luci, Ut;

export Healthcare_SocioEconomic_Batch_Service := MACRO

	batch_in := dataset([],Models.Layouts_Healthcare_Core.Layout_SocioEconomic_Batch_In) : stored('batch_in',few);
	unsigned1 DPPAPurpose_in := 1 : stored('DPPAPurpose');
	unsigned1 GLBPurpose_in := 0 : stored('GLBPurpose');
	string DataRestrictionMask_in := '' : stored('DataRestrictionMask');
	string50 DataPermissionMask_in := '' : stored('DataPermissionMask');
	boolean SuppressResultsForOptOuts := TRUE : stored('SuppressResultsForOptOuts');
	IF(DataRestrictionMask_in='', FAIL('A blank DataRestrictionMask value is supplied.'));
	IF(DataPermissionMask_in='', FAIL('A blank DataPermissionMask value is supplied.'));
	String Socio_Core_Option := '1' : stored('Options');
	unsigned1 Socio_TC_Model_Version_in := 2 : stored('Socio_TC_Model_Version');
	unsigned1 ofac_version_in     := 1        : stored('OFACVersion');
	gateways_in_ds := Gateway.Configuration.Get();
	IF(DPPAPurpose_in <> Models.Healthcare_Constants_Core.authorized_DPPA OR GLBPurpose_in <> Models.Healthcare_Constants_Core.authorized_GLBA, FAIL('Supplied Permissible Purpose Settings (GLBPurpose and/or DPPAPurpose) are invalid'));
	
	isCoreRequestValid := TRUE;

    //CCPA fields
    unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
    string TransactionID := '' : stored ('_TransactionId');
    string BatchUID := '' : stored('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : stored('_GCID');

	Models.Healthcare_SocioEconomic_Core_NoTrending(Socio_TC_Model_Version_in, SuppressResultsForOptOuts, isCoreRequestValid, batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, 
											trim(STD.Str.ToUpperCase(Socio_Core_Option),left,right), ofac_version_in, gateways_in_ds, coreResults,
                                            LexIdSourceOptout := LexIdSourceOptout, 
                                            TransactionID := TransactionID, 
                                            BatchUID := BatchUID, 
                                            GlobalCompanyID := GlobalCompanyID);

	batch_params := Models.Healthcare_SocioEconomic_Module_V5();

	Models.Healthcare_SocioEconomic_Transforms_Batch_Service_V5.doParamCheck(batch_params);

	FinalOutput := Models.Healthcare_SocioEconomic_Transforms_Batch_Service_V5.AddScoreCategories(
											coreResults,
											Socio_TC_Model_Version_in,
											SuppressResultsForOptOuts,
											batch_params
											);
    output(FinalOutput, NAMED('Results'));


ENDMACRO;	