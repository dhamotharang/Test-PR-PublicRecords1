IMPORT Std;

EXPORT _Function := MODULE

	//Function Combines the OrbitTable with the InScope File to Create the Combined Lookup Table
	EXPORT fn_roxiePackageGlobalSID(string rpName):= FUNCTION 
	
		orbitTable	:= CCPA.File_Global_SID.orbitTable(stringlib.stringfind(roxie_packages,rpName,1)>0);
		inScope			:= CCPA.File_Global_SID.inScopeFile(stringlib.stringfind(packages,rpName,1)>0);

		srtOrbTabl	:= sort(distribute(orbitTable, hash(dataset_id)), dataset_id, local);
		srtInScope	:= sort(distribute(inScope, hash(dataset_id)), dataset_id, local);

		CCPA.Layout_Global_SID.lookupTableLayout bldTr(srtInScope l, srtOrbTabl r):= transform
			self.roxie_packages := std.str.FindReplace(std.str.FindReplace(r.roxie_packages,'Keys', ''), 'FCRA_', '');
			self.field_name			:= '';
			self.source_codes		:= if(r.source_codes<>'NULL', r.source_codes, '');
			self.global_sid			:= r.glb_srcid;
			self 								:= l;
		end;

		joinDI 			:= join(srtInScope, srtOrbTabl,
												left.dataset_id = right.dataset_id,
												bldTr(left, right), left outer, local);

		ddComb			:= dedup(sort(distribute(joinDI, hash(dataset_id)), record, local), record, local);
		
		RETURN ddComb;
	
	END;
	
END;