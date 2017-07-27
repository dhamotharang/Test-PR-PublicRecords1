IMPORT VM_Misc;

// defines a number of input parameters for Deadco services;

//doxie.MAC_Header_Field_Declare
//business_header.doxie_MAC_Field_Declare()
//export string stored_bdid_val := '' : stored('BDID');

EXPORT Params := MODULE

  EXPORT ReportIn := MODULE (Vm_Misc.ServiceFrame.IReportIn)
    string14 did_value := '' : stored('did');
    shared unsigned6 did := (unsigned6) did_value;

    // Get Deadco unique id 
    shared string14 vtid_value := '' : stored('VTID');

    //SSN mask
    string6 ssn_mask_val := 'NONE' : stored ('SSNMask');
    shared string6 ssn_mask_value := StringLib.StringToUpperCase (ssn_mask_val) : global;


    export GetIntValue     (string name, integer def = 0) := MAP (
      StringLib.StringToUpperCase (name) = 'DID' => did,
      def);
    export GetStringValue  (string name, string def = '') := MAP (
      StringLib.StringToUpperCase (name) = 'VTID' => vtid_value,
      StringLib.StringToUpperCase (name) = 'SSNMask' => ssn_mask_value,
      def);
    
    export GetBooleanValue (string name, boolean def = false) := FALSE;
    export GetSetValue     (string name, SET def_value = []) := [];
  END;

END;