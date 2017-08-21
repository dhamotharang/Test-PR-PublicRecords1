import _control, lib_stringlib, PromoteSupers;

/* 
MONTHLY BUILD CYCLE	
	Spray to thor -
	Map File to base layout -
  Generates 1 payload key -
*/

export Proc_Build_All(string filedate) := function

New_Inputs		:= nothor(fileservices.superfilecontents('~thor_data400::in::phones::acclog', 1))[1].name <>'';
							
// File_Name		:= '~thor_data400::in::phones::acclog_'+filedate;
						
// Spray_File	:= FileServices.SprayVariable(_control.IPAddress.edata12 , '/thor_back5/phones/'+input_filename, 2096,
							// '\\t,\\~' ,,,'thor400_92', File_Name,,,,true,true,true);

Super_Clear		:= fileservices.clearsuperfile('~thor_data400::in::phones::acclog');

// Super_Add		:= fileservices.addsuperfile('~thor_data400::in::phones::acclog', File_Name);

PromoteSupers.MAC_SF_BuildProcess(InstantId_logs.Map_InstantID_Logs_Base(filedate), '~thor_data400::base::instantid_logs', Swapfiles, 2);

// Build_Key		:= instantid_logs.proc_build_keys(filedate); // not needed

Create_Build := 
		if(~new_inputs, output('No New Instant ID Input Files on Thor'),
			sequential(
			  // Super_Clear,
				// output('Spraying...',named('Instant_ID_Process_')),
				// Spray_File,
				// output('Adding New File to Super...',named('Instant_ID_Process__')),
				// Super_Add,
				output('Begin Mapping...',named('Instant_ID_Process___')),
				SwapFiles,
				super_clear));
		
return sequential(Create_Build);
end;