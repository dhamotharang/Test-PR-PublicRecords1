/*
Suppress.Key_New_Suppression is a replacement for doxie.Key_PullSSN
Usage: InFile = input file to be checked
			 outFile = output file
			 InApplicationType =  Request Application Type (see AutoStandardI.InterfaceTranslator	Global ApplicationType 'GOV' 'LE')
			 inLinkType =  The Suppression Linking_Type Field Examples (DID, BDID, SSN, '' etc) Entity Based suppression
			 inLinkID =  The field in the InFile that will be joined to the Suppression file to see if it exists and need to be suppressed
			 inDocType =  The Suppression Document_Type Field Examples (ln_fares_id, offender_key, '' etc) Row Based suppression
			 inDocID =  The field in the InFile that will be joined to the Suppression file to see if it exists and need to be suppressed
			 batch =  Is this a batch or a simply dataset
			 demo_cust =  Is this a demo customer (see suppress.DemoPartition)
*/

export MAC_Suppress (inFile, outFile, inApplicationType, inLinkType = '\'\'', inLinkID = '\'\'', 
										 inDocType = '\'\'', inDocID = '\'\'', batch = false, demo_cust = '\'\'', use_acctno = false) := macro
	import suppress;
				#uniquename(tra)
				#uniquename(suppressFile)
				#uniquename(validCriteria)
				#uniquename(outfile1)
				
				%suppressFile% := suppress.Key_New_Suppression();


				#if(batch)
				inFile %tra%(inFile l, %suppressFile% r) := transform
					#if(use_acctno)
						self.acctno := l.acctno;
					#else
						self.seq := l.seq;
					#end
					self := if((inLinkType <> '' and r.Linking_ID = '') or
										 (inDocType <> '' and r.Document_ID = ''),
											l);
				end;
				#end
				
				#uniquename (suppress_set)
				Suppress.MAC_Suppress_Set(inApplicationType,%suppress_set%);

				#uniquename(FormatID)
				string %FormatID% (string str_ID, string _type) := 
					map (stringlib.StringToUppercase (_type) =  Suppress.Constants.LinkTypes.DID => intformat ((integer) str_ID, 12, 1),
//							stringlib.StringToUppercase (_type) = Suppress.Constants.LinkTypes.BDID => intformat ((integer) str_ID, 12, 1),
							stringlib.StringToUppercase (_type) = Suppress.Constants.LinkTypes.SSN => intformat ((integer) str_ID, 9, 1),
							(string) (integer) str_ID);

				%outFile1% := join(inFile, %suppressFile%, 

											#if(inLinkType <> '')
													// prevent suppressing records where IDs are blank or contain zeros only
													((integer) left.inLinkID != 0)
													and keyed(right.product in %suppress_set%)
													and keyed(right.linking_type = inLinkType)
													and keyed(right.Linking_ID = (string)left.inLinkID or 
																		right.Linking_ID = %FormatID%((string)left.inLinkID, (string)inLinkType))
											// else it is a document-type suppression
											#else
													keyed(right.product in %suppress_set%)
													and keyed (right.linking_type='') and keyed (right.Linking_ID='')
													and keyed(right.document_type = inDocType) 
											    and keyed(right.Document_ID = (string)left.inDocID)
											#end
											,
											#if(batch)
													%tra%(left, right), left outer, keep (1) //keep is a formality here
											 #else
													transform(recordof(inFile),self := left), left only
											 #end
											 );

				%validCriteria% := inLinkType <> '' or inDocType <> '';
				
											 
				outFile := if(inLinkType=Suppress.Constants.LinkTypes.DID and ~suppress.DemoPartition(demo_cust).include_all,
                      inFile(suppress.DemoPartition(demo_cust).retainDID((unsigned6)inLinkID)),
                      if (%validCriteria%,%outFile1%,inFile));
	endmacro;
