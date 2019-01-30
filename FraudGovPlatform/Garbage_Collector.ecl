import STD,ut,tools;
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

export create_super := tools.mod_Utilities.createsuper(super_filename);

files_rec tr1(filelist L) := transform
	supers_cnt := count(STD.File.LogicalFileSuperowners('~'+L.name));
	modified := trim(regexreplace('-',L.modified[1..10],''));
	self.modified := modified;
	self.supers := supers_cnt;
	self.DaysOld := ut.DaysApart(modified, today);
	self := L;
end;

shared p1 :=  project(filelist,tr1(left));

export delete_list	:= p1(name != '' and supers = 0 and DaysOld > days_limit and owner  = 'skasavajjala_prod'); // Delete Orphan Files older than days_limit from nightly builds
export archive_list	:= p1(name != '' and supers = 0 and DaysOld > days_limit and owner != 'skasavajjala_prod'); // Backup Orphan Files created by our Data Team.

export Delete := apply(delete_list,STD.File.DeleteLogicalFile( delete_list.name ));
export Archive := apply(archive_list,STD.File.AddSuperFile( super_filename, archive_list.name ));

export Run 
	:= sequential(	  create_super
				, Delete
				, Archive );

end;