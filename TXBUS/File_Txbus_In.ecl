export File_Txbus_In := module

  export File_raw(string8 filedate) := function
    return dataset(Constants.Cluster + 'in::Txbus::'+ filedate +'::stact_raw', Txbus.Layouts_txbus.Layout_Raw_crlf, thor);
  end;
  
  export File_Cleaned_Super := dataset(Constants.Cluster + 'in::Txbus::Superfile', Txbus.Layouts_txbus.Layout_Common, thor);

end;

