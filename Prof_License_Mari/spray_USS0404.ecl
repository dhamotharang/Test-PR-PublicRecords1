// spray US Lenders/Veterans Administration File   
import ut, _control, Prof_License_Mari, Lib_FileServices;


export spray_USS0404(string filedate) := MODULE
#workunit('name','Spray USS0404'); 


SHARED STRING7 code						:= 'USS0404';
SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
SHARED superfile 							:= destination + 'using::' + 'mtg_license';


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));



TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_USS0404.raw,csv(SEPARATOR('\t'),QUOTE('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_USS0404.common, SELF.ln_filedate := filedate; 
																																				 SELF.VA_LENDER_ID := trim(left.LENDER_ID) + trim(left.BRANCH_UNIQUE_ID);
																																				 SELF := LEFT; self:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filedate + '::' +filename);

END;		
	


//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'lenderfile.txt','tab');
	);



//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('lenderfile.txt'),, 	destination + filedate + '::lenderfile.txt',	csv(SEPARATOR('\t'),QUOTE('"')), OVERWRITE),
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('lenderfile.txt'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::lenderfile.raw'),
							 );
							 
							 

//  Spray All Files
export S0404_SprayFiles := SEQUENTIAL(clear_super, spray_all, xform_all, super_all,remove_raw);
																			

END;


