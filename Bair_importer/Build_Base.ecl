//Defines full build process
export Build_Base := module 
		export MAC_Build_Input(pNewInputs, pLayoutIn, pNewFilename, pDelta, pPinkflags, pCSV, pUseProd = false) := functionmacro
			//output('pNewFilename: ' + pNewFilename + ' | pDelta: ' + pDelta + ' | pPinkflags: ' + pPinkflags);
			import bair,VersionControl,STD; 
			#uniquename(delta)
			%delta%			:= pDelta; 
			#uniquename(linkflags)
			%linkflags%			:= 	pPinkflags;
			#uniquename(LayoutIn)
			%LayoutIn% := pLayoutIn;
			
			
			#uniquename(prev_deltas)
			#if (pCSV)
				%prev_deltas% :=   dataset(%delta%,%LayoutIn%,CSV(SEPARATOR('~|~'), TERMINATOR('~<EOL>~'), QUOTE('\'"\'')));
			#else
				%prev_deltas% :=	dataset(%delta%,%LayoutIn%,THOR,OPT); 
			#end
			
			#uniquename(res)			
			#uniquename(base_f)
			%base_f% :=  pNewInputs;
 			delta_superfile_subcnt 	:= NOTHOR(STD.File.GetSuperFileSubCount(%delta%));
			//-- Remove and Insert touched records
 			bair.MAC_Join(%res%,%prev_deltas%,%base_f%,%linkflags%);
 			base_r := distribute(if(delta_superfile_subcnt >= 1, %res%, %base_f%),random());
			//-- Write Logical File
 			return bair_importer.BuildNewLogicalFile(pNewFilename, base_r, pCSV);
		endmacro;
		
		export MAC_Build_Stats_Event(out1, out2, out3) := functionmacro
				
				import bair,VersionControl,STD; 
				
				#uniquename(xform_filescnt)
				 out1 %xform_filescnt%( out1 l ,  out1 r) := transform
										self.filesCountTable := l.filesCountTable + r.filesCountTable;
										self := l;
				end;
				#uniquename(j1)
					%j1% := join(out1, out2, left.providerid = right.providerid, %xform_filescnt%(left, right), left outer,lookup);
				#uniquename(stats_report)
					%stats_report% := join(%j1%, out3, left.providerid = right.providerid, %xform_filescnt%(left, right), left outer,lookup);

				base_r := distribute(%stats_report%,random());
				
				return base_r;				
		endmacro;		
		
		
		// export MAC_Build_Stats(pNewFilename, out1, out2, out3, out4) := functionmacro
				
				
				// #uniquename(xform_filescnt)
				 // out1 %xform_filescnt%( out1 l ,  out1 r) := transform
										// self.filesCountTable := l.filesCountTable + r.filesCountTable;
										// self := l;
				// end;
				// #uniquename(j1)
					// %j1% := join(out1, out2, left.providerid = right.providerid, %xform_filescnt%(left, right));
				// #uniquename(stats_report)
					// %stats_report% := join(%j1%, out3, left.providerid = right.providerid, %xform_filescnt%(left, right));
				
				// #uniquename(xform_delete)
				 // out1 %xform_delete%( out1 l ,  out1 r) := transform
										// self.deletedTable := l.deletedTable + r.deletedTable;
										// self := l;
				// end;
				
				// #uniquename(stats_report_)
					// %stats_report_% := join(%stats_report%, out4, left.providerid = right.providerid, %xform_delete%(left, right));
				
				// base_r := %stats_report_%;
					
				
				// import STD;			
				// fileservices.clearsuperfile('~thor_data400::in::prepped::statsreport::qa', false);
				// fileservices.clearsuperfile('~thor_data400::in::prepped::statsreport::built', false);
				// STD.File.DeleteLogicalFile(pNewFilename);
				
				
				// return bair_importer.BuildNewLogicalFile(pNewFilename, base_r, false);				
		// endmacro;		
end;