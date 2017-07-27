////////////////////////////////////////////////////////////////////////////////////////////
// -- macf_FilesIndex macro/module
// -- Parameters:
// --		pIndexInfo			  -- Index information passed as string, i.e. 'dataset,{index fields},{payload fields}'
// -- 	pfilenameversions	-- result of call to Tools.mod_FilenamesBuild  Example follows
// --
// -- This module will give you access to all versions of a build key
// -- i.e., the following code:
// --   keynames    := tools.mod_FilenamesBuild('~thor_data400::base::zoom::@version@::data','20060328');
// -- 	Key_files   := tools.macf_FilesIndex('base_files.built, {bdid}, {record_type}', keynames);
// -- 
// -- This gives you access to:
// -- Key_files.Building	  = index(base_files.Building	    ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::Building::Member::bdid'		);
// -- Key_files.Built		    = index(base_files.Built		    ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::Built::Member::bdid'		  );
// -- Key_files.QA			    = index(base_files.QA			      ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::QA::Member::bdid'			    );
// -- Key_files.Prod		    = index(base_files.Prod		      ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::Prod::Member::bdid'			  );
// -- Key_files.Father		  = index(base_files.Father		    ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::Father::Member::bdid'		  );
// -- Key_files.Grandfather	= index(base_files.Grandfather	,{bdid} ,(record_type} ,'~thor_data400::key::BBB::Grandfather::Member::bdid');
// -- Key_files.Delete		  = index(base_files.Delete		    ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::Delete::Member::bdid'		  );
// -- Key_files.New			    = index(base_files.New			    ,{bdid} ,(record_type} ,'~thor_data400::key::BBB::20060328::Member::bdid'		);
////////////////////////////////////////////////////////////////////////////////////////////           
export macf_FilesIndex(

   pIndexInfo
  ,pfilenameversions

) :=
functionmacro
	
	return
	module
	
		shared fKey(string pname)	:= index(#EXPAND(pIndexInfo),	pname);
		
		export Building			:= fKey(pfilenameversions.building		);
		export Built				:= fKey(pfilenameversions.built				);
		export QA						:= fKey(pfilenameversions.qa					);
		export Prod					:= fKey(pfilenameversions.prod				);
		export Father				:= fKey(pfilenameversions.father			);
		export Grandfather	:= fKey(pfilenameversions.grandfather	);
		export Delete				:= fKey(pfilenameversions.delete			);
		export New					:= fKey(pfilenameversions.New					);
		export Logical  		:= fKey(pfilenameversions.Logical			);
	end;
	
endmacro;
