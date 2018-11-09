/*
Suppress.File_New_Suppression is a replacement for doxie.Key_PullSSN
Usage: InFile = input file to be checked
			 childFile = This is a disassociated (not embedded) dataset file that contains the data to be filtered
			 outFile = output file
			 InApplicationType =  Request Application Type (see AutoStandardI.InterfaceTranslator	Global ApplicationType 'GOV' 'LE')
			 inLinkType =  The Suppression Linking_Type Field Examples (DID, BDID, SSN, '' etc) Entity Based suppression
			 inLinkID =  The field in the InFile that will be joined to the Suppression file to see if it exists and need to be suppressed
			 parent_link_key = This is the field that links the child_set_name or childFile to the InFile so the record can be filtered
			 child_set_name = This is the field of the embeded child dataset that contains the data that need to be filtered
			 isEmbedded =  Is the child set embedded in the record or is the child file a separate linked file
*/

export MAC_Suppress_Child := module

			export keyLinked(inFile, childFile='\'\'', outFile, inApplicationType, 
										 inLinkType='\'\'', inLinkID='\'\'', 
										 parent_link_key='\'\'', child_set_name='\'\'', 
										 isEmbedded=false) := macro

        IMPORT suppress;			
				#uniquename(suppressFile)
				#uniquename(validCriteria)
				#uniquename(isEmbedded)
				#uniquename(newChild)
				#uniquename(joinedChild)
				#uniquename(leftRec)
				#uniquename(xfrmRec)
				#uniquename(outfile1)
				
				%suppressFile% := suppress.Key_New_Suppression();


				#uniquename (suppress_set)
				Suppress.MAC_Suppress_Set(inApplicationType,%suppress_set%);

				#uniquename(FormatID)
				string %FormatID% (string str_ID, string _type) := 
					map (stringlib.StringToUppercase (_type) =  Suppress.Constants.LinkTypes.DID => intformat ((integer) str_ID, 12, 1),
//							stringlib.StringToUppercase (_type) = Suppress.Constants.LinkTypes.BDID => intformat ((integer) str_ID, 12, 1),
							stringlib.StringToUppercase (_type) = Suppress.Constants.LinkTypes.SSN => intformat ((integer) str_ID, 9, 1),
							str_ID);

				#uniquename(NumericID)
				string %NumericID% (string str_ID) := if(ut.isNumeric(str_ID),(string)(unsigned)str_ID,str_ID);
				
				#if(isEmbedded)
				%newChild% := record
					recordof(inFile);
					recordof(inFile.child_set_name);
				end;
				#end
				
				%leftRec% := 				
						#if(isEmbedded)
							normalize(inFile,left.child_set_name,transform(%newChild%, self:=left,self:=right));
						#else
							childFile;
						#end

				%xfrmRec% := record
					%leftRec%.parent_link_key;
				end;


				%joinedChild% := join(%leftRec%,%suppressFile%,
													// prevent suppressing records where IDs are blank or contain zeros only
													((integer) left.inLinkID != 0)
													and keyed(right.product in %suppress_set%)
													and keyed(right.linking_type = inLinkType)
													and keyed(right.Linking_ID = (string)left.inLinkID or 
																		right.Linking_ID = %FormatID%((string)left.inLinkID, (string)inLinkType) or
																		right.Linking_ID = %NumericID%((string)left.inLinkID)),
													transform(%xfrmRec%, self := left),
                          KEEP (1), LIMIT (0));

				%outFile1% := join(inFile,%joinedChild%,
                           left.parent_link_key=right.parent_link_key,
                           transform(recordof(inFile),self:=left),left only);

				%validCriteria% := inLinkType <> '';
											 
				outFile := if (%validCriteria%,%outFile1%,inFile);
			endmacro;

				/*
					Handle the situation when no key exists for linking the two items together.
				*/

			export nokeyLinked(inFile, childFile='\'\'', outFile, inApplicationType, 
										 inLinkType='\'\'', inLinkID='\'\'', 
										 parent_link_key='\'\'', child_set_name='\'\'', 
										 isEmbedded=false) := macro
			
				#uniquename(addCount)
				#uniquename(counted)
				#uniquename(pulled)
				
				// add a counter for uniqueness
				{ inFile; unsigned2 cntLink; } %addCount%(inFile L, unsigned2 C) := transform
					self.cntLink := C;
					self := L;
				end;
				%counted% := project(inFile,%addCount%(left,counter));
				
				// do the suppression
				Suppress.MAC_Suppress_Child.keyLinked(%counted%, childFile, %pulled%, inApplicationType,
															inLinkType, inLinkID, cntLink, child_set_name, isEmbedded);
				
				// strip the counter
				outFile := project(%pulled%, transform(recordof(inFile),self:=left));

			endmacro;
end;