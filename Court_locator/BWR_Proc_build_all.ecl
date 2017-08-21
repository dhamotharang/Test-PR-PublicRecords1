

//***********************************************************************
//****** Steps needed to process new courtlocatorlookup raw file. *******
//***********************************************************************

Process_date := '20130205';

//Step1: Add new courtlocatorlookup raw file to superfile. Run below code in BWR.
SEQUENTIAL(
//FileServices.CreateSuperFile('~thor_data400::in::courtlocatorlookup_father'),
FileServices.StartSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::in::courtlocatorlookup_father'),
FileServices.AddSuperFile('~thor_data400::in::courtlocatorlookup_father','~thor_data400::in::courtlocatorlookup',, true),
FileServices.ClearSuperFile('~thor_data400::in::courtlocatorlookup'),
FileServices.AddSuperFile('~thor_data400::in::courtlocatorlookup','~thor_data400::courtlocator-2013-01.xlsx'),
FileServices.FinishSuperFileTransaction()
);

//Step2: Create new lkp base file and new lkp key files. Run below code in BWR. 

              SEQUENTIAL(Court_locator.map_lookup_base(Process_date),
							           Court_locator.proc_build_lookup_keys(Process_date)); 