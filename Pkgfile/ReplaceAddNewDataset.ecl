// add a new dataset or replace a version for existing dataset
// Parameters

// datasetname - same as dataset name in the package
// location - B for Boca, A for Alpharetta
// eflag - F for FCRA, N for nonFCRA
// bool - Y to get the boolean keys in addition to nonfcra keys, N to get only nonfcra keys
import dops;
EXPORT ReplaceAddNewDataset(string dopsdatasetname, string filedate, string location = 'B', string environmentflag = 'N', string daliip = '') := module
	// get roxie keys from Prod DOPS
	export GetKeysFromDops := sort(dops.GetKeysByDataset(dopsdatasetname, location, environmentflag, 'Q', 'prod'), -updateflag, superkey);

	// converts to package flat layout
	export ConvertToPkgLayout() := function
		pkgfile.layouts.flat_layouts.FileRecord ConvertToPkg(GetKeysFromDops l) := transform
			self.packageid := dopsdatasetname;
			self.superfile := l.superkey;
			self.subfile := l.logicalkey;
			self.isfullreplace := l.updateflag = 'F';
			self.isdeltareplace := l.updateflag = 'DR';
			self.daliip := daliip;
		end;

		inPkgLayout := project(GetKeysFromDops, ConvertToPkg(left) );
	
		return inPkgLayout;
	end;
	// adds the keys to package
	export AddtoPkg := pkgfile.add().Sfiles(ConvertToPkgLayout());
	
end;