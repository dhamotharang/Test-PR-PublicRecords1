EXPORT Layouts := module 

EXPORT ECLAttributeLayout := RECORD
    STRING              module_name     {XPATH('ModuleName')};
    STRING              name            {XPATH('Name')};
    STRING              attribute_type  {XPATH('Type')};
    STRING              version         {XPATH('Version')};
    STRING              latest_version  {XPATH('LatestVersion')};
    STRING              flags           {XPATH('Flags')};
    STRING              access          {XPATH('Access')};
    STRING              is_locked       {XPATH('IsLocked')};
    STRING              is_checked_out  {XPATH('IsCheckedOut')};
    STRING              is_sandbox      {XPATH('IsSandbox')};
    STRING              is_orphan       {XPATH('IsOrphaned')};
    STRING              result_type     {XPATH('ResultType')};
    STRING              modified_by     {XPATH('ModifiedBy')};
    STRING              modified_date   {XPATH('ModifiedDate')};
    STRING              description     {XPATH('Description')};
    STRING              checksum        {XPATH('Checksum')};
END;

EXPORT out := 
RECORD
  ECLAttributeLayout;
  STRING attribute;
 END;

END ;