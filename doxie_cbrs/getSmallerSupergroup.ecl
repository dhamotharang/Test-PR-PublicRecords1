IMPORT Business_Header;
EXPORT getSmallerSupergroup(
  UNSIGNED6 thebdid,
  UNSIGNED4 maxsg) :=
  FUNCTION
    RETURN
      fn_getSmallerSupergroup(
        DATASET([{
          0,
          thebdid,
          0}],
          doxie_cbrs.layout_supergroup),
        maxsg);
  END;
