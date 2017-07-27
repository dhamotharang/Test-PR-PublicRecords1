export mac_roll_DFS(dfs_name) := macro
	self.dfs_name := if((integer)r.dfs_name = 0 or ((integer)l.dfs_name > 0 and l.dfs_name < r.dfs_name), l.dfs_name, r.dfs_name);
endmacro; 