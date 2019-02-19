import STD,ut,tools,lib_FileServices;
export Garbage_Collector := module

shared files_rec := record
	string name;
	string owner;
	string8 modified;
	unsigned supers;
	unsigned DaysOld;	
end;

shared filelist := STD.File.LogicalFileList('fraudgov*');
shared today := (STRING8)Std.Date.Today();
shared super_filename := _Dataset().thor_cluster_Files + 'backup::files';
shared days_limit := 5;

export create_backup_super := tools.mod_Utilities.createsuper(super_filename);

files_rec tr1(filelist L) := transform
	supers_cnt := count(STD.File.LogicalFileSuperowners('~'+L.name));
	modified := trim(regexreplace('-',L.modified[1..10],''));
	self.modified := modified;
	self.supers := supers_cnt;
	self.DaysOld := ut.DaysApart(modified, today);
	self := L;
end;

shared p1 :=  nothor(project(filelist,tr1(left)));

// Delete Orphan Files older than days_limit from nightly builds
export delete_list	:= p1(name != '' and supers = 0 and DaysOld > days_limit and owner  = 'skasavajjala_prod'); 

// Backup Orphan Files created by our Data Team.
export archive_list	:= p1(name != '' and supers = 0 and DaysOld > days_limit and owner != 'skasavajjala_prod'); 


delete_file (string filename) := FileServices.DeleteLogicalFile(filename);
export ExecDeleteStmt := NOTHOR (APPLY( delete_list, delete_file('~'+delete_list.name)));

archive_file (string filename) := FileServices.AddSuperFile(super_filename, filename);
export ExecArchiveStmt := NOTHOR (APPLY( archive_list, archive_file('~'+archive_list.name)));

export Run 
	:= sequential(	  create_backup_super
				, output(delete_list,named('Delete_List'))
				, output(archive_list,named('Archive_List'))
				, ExecDeleteStmt
				, ExecArchiveStmt);

end;