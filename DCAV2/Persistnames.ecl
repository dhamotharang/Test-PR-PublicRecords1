import lib_fileservices;
export Persistnames(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	
	export Root := _Constants(pUseOtherEnvironment).persistTemplate;
	
	export AsBusinessHeader				:= root + 'As_Business_Header'						;
	export AsBusinessContact			:= root + 'As_Business_Contact'						;
	export AsPOE									:= root + 'As_POE'												;
	export IngestCompanies				:= root + 'Ingest_Companies'							;
	export AppendAIDCompanies			:= root + 'Update_Companies.Append_AID'		;
	export AppendBDIDCompanies		:= root + 'Update_Companies.Append_BDID'	;
	export AppendPhonesCompanies	:= root + 'Update_Companies.Append_Phones';
	export PrepInput							:= root + 'PrepInput'											;
	export SplitInputCompanies		:= root + 'Split_Input.Companies'					;

	export PrepInputAppendDates		:= root + 'Prep_Input.Append_Dates'			;

	export SplitInputContacts			:= root + 'Split_Input.Contacts'					;
	export IngestContacts					:= root + 'Ingest_Contacts'								;
	export AppendAIDContacts			:= root + 'Update_Contacts.Append_AID'		;
	export AppendDIDContacts			:= root + 'Update_Contacts.Append_DID'		;
	export AppendBDIDContacts			:= root + 'Update_Contacts.Append_BDID'		;
	export AppendPhonesContacts		:= root + 'Update_Contacts.Append_Phones'	;
  export UpdateContacts     		:= root + 'Update_Contacts.New_Base'	;

	export FileKeybuild						:= root + 'File_Keybuild'									;
	export FileKeybuildNonFilt		:= root + 'File_KeybuildNonFilt'					;
	export FileHierarchy					:= root + 'File_Hierarchy'								;

	export All := dataset([
		  {AsPOE									}
		 ,{IngestCompanies				}
		 ,{IngestContacts					}
		 ,{AppendAIDCompanies			}
		 ,{AppendBDIDCompanies		}
		 ,{AppendPhonesCompanies	}
		 ,{PrepInputAppendDates		}
		 ,{SplitInputCompanies		}
		 ,{SplitInputContacts			}
		 ,{PrepInput							}
		 ,{AppendAIDContacts			}
		 ,{AppendDIDContacts			}
		 ,{AppendBDIDContacts			}
		 ,{AppendPhonesContacts		}
		 ,{FileKeybuild						}
		 ,{FileKeybuildNonFilt		}
		 ,{FileHierarchy					}
		 
		], lib_fileservices.FsLogicalFileNameRecord);
	
end;
