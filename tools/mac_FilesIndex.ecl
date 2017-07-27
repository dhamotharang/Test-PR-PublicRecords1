////////////////////////////////////////////////////////////////////////////////////////////
// -- mac_FilesIndex macro/module
// -- Parameters:
// --		pDataset			-- Dataset to build key on
// --		pKeyfields			-- index fields for key
// --		pPayload			-- Payload fields for key
// -- 		pfilenameversions	-- result of call to Tools.mod_FilenamesBuild  Example follows
// --		pOutput				-- Output parameter
// --
// -- This module will give you access to all versions of a build key
// -- i.e., the following code:
// -- 	export Bdidkeynames	:= Tools.mod_FilenamesBuild('~thor_data400::key::BBB::@version@::Member::bdid','20060328');
// -- 	Tools.mBuildKeyVersions(base_files.built, {bdid}, {record_type}, Bdidkeynames, Key_files);
// -- 
// -- This gives you access to:
// -- Key_files.Building	 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::Building::Member::bdid'		);
// -- Key_files.Built		 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::Built::Member::bdid'		);
// -- Key_files.QA			 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::QA::Member::bdid'			);
// -- Key_files.Prod		 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::Prod::Member::bdid'			);
// -- Key_files.Father		 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::Father::Member::bdid'		);
// -- Key_files.Grandfather	 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::Grandfather::Member::bdid'	);
// -- Key_files.Delete		 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::Delete::Member::bdid'		);
// -- Key_files.New			 = index(base_files.built, {bdid}, (record_type}, '~thor_data400::key::BBB::20060328::Member::bdid'		);
////////////////////////////////////////////////////////////////////////////////////////////           
export mac_FilesIndex(pIndexInfo,pfilenameversions,  pOutput) :=
macro
	
	export pOutput := 
	module
	
//		shared fKey(string name)	:= index(#EXPAND(pIndexInfo),	name);
		
		export Building			:= index(#EXPAND(pIndexInfo),pfilenameversions.building		);
		export Built				:= index(#EXPAND(pIndexInfo),pfilenameversions.built			);
		export QA						:= index(#EXPAND(pIndexInfo),pfilenameversions.qa					);
		export Prod					:= index(#EXPAND(pIndexInfo),pfilenameversions.prod				);
		export Father				:= index(#EXPAND(pIndexInfo),pfilenameversions.father			);
		export Grandfather	:= index(#EXPAND(pIndexInfo),pfilenameversions.grandfather);
		export Delete				:= index(#EXPAND(pIndexInfo),pfilenameversions.delete			);
		export New					:= index(#EXPAND(pIndexInfo),pfilenameversions.New				);
	end;
	
endmacro;
