IF(FileServices.SuperFileExists('~thor_data400::base::watchdog_universal_slim'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::watchdog_universal_slim'));
IF(FileServices.SuperFileExists('~thor_data400::base::watchdog_universal_slim_father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::watchdog_universal_slim_father'));
IF(FileServices.SuperFileExists('~thor_data400::base::watchdog_universal_slim_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::watchdog_universal_slim_Delete'));
