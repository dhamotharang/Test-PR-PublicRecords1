IMPORT STD, NeustarWireless;
//script to setup superfiles and run initial builds the first time the code is deployed to prod
SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::main',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::main_father',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::main_grandfather',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::main_delete',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::activity_status',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::activity_status_father',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::activity_status_grandfather',,true);
 STD.File.CreateSuperfile('~thor_data400::base::neustar_wireless::activity_status_delete',,true);
 STD.File.FinishSuperFileTransaction(),
 NeustarWireless.proc_build_all('20180903'),
 NeustarWireless.proc_build_all('20181002'),
 NeustarWireless.proc_build_all('20181111')
);

  