EXPORT Layouts := MODULE
  
  EXPORT lnpid_segmentation := RECORD
    UNSIGNED8 lnpid;
    STRING30  segmentation_ind;
    UNSIGNED8 best_lexid;
    STRING10  best_lexid_seg;
  END;

  EXPORT summary := RECORD
    STRING version;
    STRING id1;
    STRING sharedid;
    STRING id2;
    STRING attribute;
    STRING value;
  END;
  
END;