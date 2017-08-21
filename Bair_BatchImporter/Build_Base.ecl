//Defines full build process
export Build_Base := module 
		export MAC_Build_Input(pNewInputs, pLayoutIn, pNewFilename, pDelta, pLinkflags, pCSV, pUseProd = false) := functionmacro
			//output('pNewFilename: ' + pNewFilename + ' | pDelta: ' + pDelta + ' | pLinkflags: ' + pLinkflags);
			import bair,VersionControl,STD; 
			#uniquename(delta)
			%delta%			:= pDelta; 
			#uniquename(linkflags)
			%linkflags%			:= 	pLinkflags;
			#uniquename(LayoutIn)
			%LayoutIn% := pLayoutIn;
			
			
			#uniquename(prev_deltas)
			#if (pCSV)
				%prev_deltas% :=   dataset(%delta%,%LayoutIn%,CSV(SEPARATOR('~|~'), TERMINATOR('~<EOL>~'), QUOTE('')));
			#else
				%prev_deltas% :=	dataset(%delta%,%LayoutIn%,THOR,OPT); 
			#end
			
			#uniquename(res)			
			#uniquename(base_f)
			%base_f% :=  pNewInputs;
 			delta_superfile_subcnt 	:= NOTHOR(STD.File.GetSuperFileSubCount(%delta%));
			//-- Remove and Insert touched records
 			bair.MAC_Join(%res%,%prev_deltas%,%base_f%,%linkflags%);
 			base_r := if(delta_superfile_subcnt >= 1, %res%, %base_f%);
			//-- Write Logical File
 			return BuildNewLogicalFile(pNewFilename, base_r, pCSV);
		endmacro;

		export MAC_Build_Input_Log(pNewInputs, pLayoutIn, pNewFilename, pDelta, pLinkflags, pCSV, pUseProd = false) := functionmacro
			//output('pNewFilename: ' + pNewFilename + ' | pDelta: ' + pDelta + ' | pLinkflags: ' + pLinkflags);
			import bair,VersionControl,STD; 
			#uniquename(delta)
			%delta%			:= pDelta; 
			#uniquename(linkflags)
			%linkflags%			:= 	pLinkflags;
			#uniquename(LayoutIn)
			%LayoutIn% := pLayoutIn;
			
			
			#uniquename(prev_deltas)
			#if (pCSV)
				%prev_deltas% :=   dataset(%delta%,%LayoutIn%,CSV(SEPARATOR('~|~'), TERMINATOR('~<EOL>~'), QUOTE('')))(datetime >= (unsigned8)((string8)std.date.today() + ut.getTime())-_Constants.ONE_DAY);
			#else
				%prev_deltas% :=	dataset(%delta%,%LayoutIn%,THOR,OPT)(datetime >= (unsigned8)((string8)std.date.today() + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S'))-_Constants.ONE_DAY); 
			#end
			
			#uniquename(res)			
			#uniquename(base_f)
			%base_f% :=  pNewInputs;
 			delta_superfile_subcnt 	:= NOTHOR(STD.File.GetSuperFileSubCount(%delta%));
			//-- Remove and Insert touched records
 			bair.MAC_Join(%res%,%prev_deltas%,%base_f%,%linkflags%);
 			base_r := if(delta_superfile_subcnt >= 1, %res%, %base_f%);
			//-- Write Logical File
 			return BuildNewLogicalFile(pNewFilename, base_r, pCSV);
		endmacro;

		
		export MAC_Build_Stats_Event(out1, out2, out3) := functionmacro
				
				import bair,VersionControl,STD; 
				
				#uniquename(xform_filescnt)
				 out1 %xform_filescnt%( out1 l ,  out1 r) := transform
										self.filesCountTable := l.filesCountTable + r.filesCountTable;
										self := l;
				end;
				#uniquename(j1)
					%j1% := join(out1, out2, left.providerid = right.providerid, %xform_filescnt%(left, right), left outer);
				#uniquename(stats_report)
					%stats_report% := join(%j1%, out3, left.providerid = right.providerid, %xform_filescnt%(left, right), left outer);

				base_r := %stats_report%;
				
				return base_r;				
		endmacro;		

		export MAC_Dedup_Input(pFilename, pLayout, pLinkflags) := functionmacro
		
			#uniquename(linkflags)
			%linkflags% := pLinkflags;
			#uniquename(Filename)
			%Filename% := pFilename;
			#uniquename(Layout)
			%Layout% := pLayout;
			#uniquename(input__rdi)
			%input__rdi% := if(nothor(STD.File.GetSuperFileSubCount(%Filename%)) = 0,
						dataset([],%Layout%), 
						dataset(%Filename%,%Layout%,CSV(SEPARATOR('~|~'), TERMINATOR('~<EOL>~'), QUOTE(''))));
						
			input__P:=project(%input__rdi%,{%input__rdi%,boolean keepIt:=false});
			input__Dist:=distribute(input__P,hash(#expand(%linkflags%)));
			
			input__Srt1:=sort(input__Dist,#expand(%linkflags%),LOCAL);
			input__Grp:=group(input__Srt1,#expand(%linkflags%));
			input__Srt2:=sort(input__Grp,-timestamp);

			input__Ite:=group(iterate(input__Srt2
								,transform({input__Srt2}
									,self.keepIt:=if(left.timestamp='' or left.timestamp=right.timestamp and left.keepIt=true,true,false)
									,self:=right
								)));
			return project(input__Ite(keepIt=TRUE),{input__Ite}-[keepIt]); 
		endmacro;	
		

end;