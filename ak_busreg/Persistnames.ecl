import lib_fileservices;
export Persistnames :=
module
   
   shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
   
   export StandardizeInput    := root + 'Standardize_Input' ;
   export UpdateBase             := root + 'Update_Base'          ;
   export AppendIdsDid           := root + 'Append_Ids::Did'      ;
   export AppendIdsBdid       := root + 'Append_Ids::Bdid'  ;
   export AppendIdsBid        := root + 'Append_Ids::Bid'  ;
   export AsBusinessHeader    := root + 'As_Business.Header'   ;
   export AsBusinessContact   := root + 'As_Business.Contact';
      export All := dataset([
       {StandardizeInput   }
      ,{UpdateBase            }
      ,{AppendIdsDid       }
      ,{AppendIdsBdid         }
      ,{AppendIdsBid         }
      ,{AsBusinessHeader   }
      ,{AsBusinessContact  }
      
   ], lib_fileservices.FsLogicalFileNameRecord);
end;
