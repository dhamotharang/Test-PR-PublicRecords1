IMPORT STD;

EXPORT Create_Super_Files :=sequential(
		       
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::orbit');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::orbit_father');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::bankruptcy');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::bankruptcy_father');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::lien');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::lien_father');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::masterlist');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::masterlist_father');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::collegelocator');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::collegelocator_father');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::courtlocator');
STD.File.CreateSuperFile('~thor_data400::in::vendor_src::courtlocator_father');		
);
		