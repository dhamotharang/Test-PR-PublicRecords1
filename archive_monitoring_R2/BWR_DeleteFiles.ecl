// The purpose is to delete old files (for example, input files which are older than 3 months)

IMPORT lib_FileServices;

unsigned BEFORE_YEAR  := 2008;
unsigned BEFORE_MONTH := 02;
unsigned BEFORE_DAY   := 29;

unsigned BEFORE_DATE := BEFORE_YEAR * 10000 + BEFORE_MONTH * 100 + BEFORE_DAY;

string FILE_MASK := '*::in::NCO::*' + BEFORE_YEAR + '*';

// date format in FileServices is "2008-04-10T17:47:11"
boolean IsBefore (string19 dt_stamp) := 
  (unsigned) (dt_stamp[1..4] + dt_stamp[6..7] + dt_stamp[9..10]) <= BEFORE_DATE;

ds_in := FileServices.LogicalFileList (FILE_MASK, true, false, true);

filerec := lib_FileServices.FsLogicalFileInfoRecord;
filerec ChooseFiles (filerec L) := transform
  Self.name := '~' + L.name;
  Self := L;
end;


ds_files := PROJECT (ds_in (IsBefore (modified)), ChooseFiles (Left));

DeleteFile (string name) := FileServices.DeleteLogicalFile (name, true);
act_delete := NOTHOR (APPLY (ds_files, DeleteFile (name)));
sequential (output (count (ds_files)), act_delete);
