import lib_fileservices;
export Persistnames :=
module
   
   shared root := _Dataset.thor_cluster_Persists + 'persist::' + _Dataset.name + '::';
   
   export StandardizeCompanies    := root + 'Standardize_Companies' ;
   export StandardizeContacts    := root + 'Standardize_Contacts' ;
   export UpdateBase             := root + 'Update_Base'          ;
   export AppendIdsDid           := root + 'Append_Ids::Did'      ;
   export AppendIdsBdid       := root + 'Append_Ids::Bdid'  ;
   export AsBusinessHeader    := root + 'As_Business.Header'   ;
   export AsBusinessContact   := root + 'As_Business.Contact';
	 
      export All := dataset([
       {StandardizeCompanies   }
      ,{StandardizeContacts   }
      ,{UpdateBase            }
      ,{AppendIdsDid       }
      ,{AppendIdsBdid         }
      ,{AsBusinessHeader   }
      ,{AsBusinessContact  }
      
   ], lib_fileservices.FsLogicalFileNameRecord);
end;
