import InsuranceHeader_Address;

input  := InsuranceHeader_Address.files().addr_link_sfds;

iter    := InsuranceHeader_Address.Proc_Iterate(workunit,input).DoAll; 
samples := InsuranceHeader_Address.Proc_Iterate(workunit,input).OutputExtraSamples;

//--------------------------------------------------------------------------
// Start Super File Transaction
//--------------------------------------------------------------------------
SF_Start  := FileServices.StartSuperFileTransaction();

//--------------------------------------------------------------------------
// Replace Link file in Super File
//--------------------------------------------------------------------------
SF_Clear   := FileServices.ClearSuperFile(InsuranceHeader_Address.files().addr_link_sfname);
SF_Add     := FileServices.AddSuperFile(InsuranceHeader_Address.files().addr_link_sfname,InsuranceHeader_Address.files().addr_link_fname);

//--------------------------------------------------------------------------
// Finish Super File Transaction
//--------------------------------------------------------------------------
SF_Fin    := FileServices.FinishSuperFileTransaction();

SEQUENTIAL(iter,samples,sf_start,sf_clear,sf_add,sf_fin);
