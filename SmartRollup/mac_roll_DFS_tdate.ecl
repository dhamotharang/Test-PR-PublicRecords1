export mac_roll_DFS_tdate(dfs_name) := macro
  l_dfs_int := iesp.ECL2ESP.DateToInteger(l.dfs_name);
  r_dfs_int := iesp.ECL2ESP.DateToInteger(r.dfs_name);
	self.dfs_name := if(r_dfs_int = 0 or (l_dfs_int > 0 and l_dfs_int < r_dfs_int), l.dfs_name, r.dfs_name);
endmacro; 