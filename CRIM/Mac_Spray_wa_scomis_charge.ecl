export Mac_Spray_wa_scomis_charge(source_machine,sourcefile_with_path,fd,recordsize) := 
macro

#uniquename(file_charge)
#uniquename(file_charge_dated)
//#uniquename(layout_charge_dated)
#uniquename(append_date)
#uniquename(spray_it)
#uniquename(build_it)
#uniquename(filepath)

// spray the file

%filepath% := '~thor_data400::in::crim_court::'+fd+'::wa_scomis_charge';


%spray_it% := FileServices.SprayFixed(_Control.IPAddress.edata12,
			sourcefile_with_path,
			recordsize,
			'thor_200',
			%filepath%,-1,,,true,true);


// append the file date
%file_charge% := dataset('~thor_data400::in::crim_court::'+fd+'::wa_scomis_charge',
							CRIM.Layout_WA_Scomis.layout_charge,thor);
/*
%layout_charge_dated% := record
string8 the_filedate;
CRIM.Layout_WA_Scomis.layout_charge;
end;
*/


CRIM.Layout_WA_Scomis.layout_charge_dated %append_date%(CRIM.Layout_WA_Scomis.layout_charge l) := transform
self := l;
self.filedate := fd;
end;

%file_charge_dated% := project(%file_charge%,%append_date%(left));
// write this file somewhere
%build_it% := output(%file_charge_dated%,,'~thor_data400::in::crim_court::wa_scomis_charge_'+fd+'_dated',overwrite);

// superfile shuffle
sequential
(
%spray_it%,
%build_it%,
Fileservices.AddSuperFile('~thor_data400::in::crim_court::wa_scomis_charge_superfile',
							'~thor_data400::in::crim_court::wa_scomis_charge_'+fd+'_dated')
)
 
endmacro;