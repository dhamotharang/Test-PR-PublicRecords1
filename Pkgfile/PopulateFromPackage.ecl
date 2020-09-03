import std, ut;

EXPORT PopulateFromPackage(string clustername) := function

	dsxml_ := dataset('~file::databuilddev01.risk.regn.net::home::rpt_srv_acct::public_html::pkgfiles::' + STD.Str.ToLowerCase(clustername) + 'pkg.txt.bk',
                    pkgfile.layouts.xml_layouts.packageid,
                    xml('RoxiePackages/Package')); 

  // Remove backup data package entries
  dsxml := dsxml_(~regexfind('(GENERATION)[1-9]+$', id, nocase));

// Queries

pkgfile.layouts.flat_layouts.packageid flattenqueries(dsxml l) := transform
	self.pkgcode := 'Q';
	self.whenupdated := (string8)Std.Date.Today() + ut.getTime();
	self := l;
end;

queryds := project(dsxml(count(superfiles) <= 0),flattenqueries(left))(id <> 'EnvironmentVariables');

// environments

pkgfile.layouts.flat_layouts.packageid flattenenvs(dsxml l,pkgfile.layouts.xml_layouts.environment r) := transform
	self.pkgcode := 'E';
	self.whenupdated := (string8)Std.Date.Today() + ut.getTime();
	self.environmentid := r.id;
	self.environmentval := r.val;
	self := l;
end;

getenvs := dsxml(count(environments) > 0);

envds := normalize(getenvs,left.environments,flattenenvs(left,right));

// Superkeys

subfile := record
			string value := '';
		end;

string_rec := record, maxlength(500000)
pkgfile.layouts.flat_layouts.packageid;
dataset(subfile) subfiles;
end;


string_rec flattensupers(dsxml l,pkgfile.layouts.xml_layouts.superfile r) := transform
	self.pkgcode := 'K';
	self.whenupdated := (string8)Std.Date.Today() + ut.getTime();
	self.superfileid := r.id;
	
	//self.subfilevalue := r.val;
	self := l;
	self := r;
end;

getsupers := dsxml(count(superfiles) > 0);

supersds := normalize(getsupers,left.superfiles,flattensupers(left,right));

pkgfile.layouts.flat_layouts.packageid flattensubs(supersds l, subfile r) := transform
	self.subfilevalue := r.value;
	self := l;
end;

subsds := normalize(supersds,left.subfiles,flattensubs(left,right));

pkgfile.Promote(clustername).New(queryds + envds + subsds,'flat',promoted,WORKUNIT[2..]);

return promoted;
end;