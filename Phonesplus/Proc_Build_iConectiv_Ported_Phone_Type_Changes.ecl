﻿IMPORT Cellphone, Phonesplus_v2, Std;

	//DF-24550: Replace the Neustar Port File with the iConectiv One.
	
	//Generate two output files:
				//- Records where the phone type changed from Landline-to-Cell or Cell-to-Landline (All history).
				//- Records where the phone type changed from Landline-to-Cell and is_current.

EXPORT Proc_Build_iConectiv_Ported_Phone_Type_Changes(string version) := FUNCTION

	inFile 			:= Cellphone.Map_iConectiv_Ported_Phone_Type_Changes;	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Build Base Files////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//Reformat to Prexisting Neustar History Layout//////////////////////////////////////////////	
	/////////////////////////////////////////////////////////////////////////////////////////////
	reformiH		:= project(inFile(keep_rec='Y'), Phonesplus_v2.Layout_Neustar_History); 					//iConectiv History

	//Build iConectiv Port History Base
	buildBaseiH	:= output(reformiH,,'~thor_data400::base::neustar_history_' + version, __compressed__);

	/////////////////////////////////////////////////////////////////////////////////////////////
	//Reformat to Prexisting Neustar Cellphone Layout////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////
	CellPhone.layoutNeuStar ncTr(inFile l):= transform
		self.cellphone 			:= l.phone;
		self.lf							:= '';
	end;
	
	reformiC 		:= project(inFile(keep_rec='Y' and is_land_to_cell and is_current), ncTr(left)); //iConectiv Cellphones

	//Build iConectiv Cellphones
	buildBaseiC	:= output(reformiC,,'~thor_data400::base::neustarupdate_' + version, __compressed__);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clear Delete Files//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	clearDelete := sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::neustar_history_delete', true)),
														nothor(fileservices.clearsuperfile('~thor_data400::base::neustarupdate_delete', true)));	

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Move Base Files//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
																
	moveiHist		:= STD.File.PromoteSuperFileList(['~thor_data400::base::neustar_history',
																								'~thor_data400::base::neustar_history_father',
																								'~thor_data400::base::neustar_history_grandfather',
																								'~thor_data400::base::neustar_history_delete'], 
																								'~thor_data400::base::neustar_history_' + version, true);						

	moveiCell		:= STD.File.PromoteSuperFileList(['~thor_data400::base::neustarupdate',
																								'~thor_data400::base::neustarupdate_father',
																								'~thor_data400::base::neustarupdate_grandfather',
																								'~thor_data400::base::neustarupdate_delete'], 
																								'~thor_data400::base::neustarupdate_' + version, true);						

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Output Results///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	RETURN sequential(buildBaseiH, buildBaseiC, //Build Base Files
										clearDelete,							//Clear Delete Files
										moveiHist, moveiCell);		//Move Base Files

END;