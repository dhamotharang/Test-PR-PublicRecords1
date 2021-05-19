#!node

let arg = process.argv.slice(2);
let use_mr = false;
let use_dep = false;
let pid = '0';
let mrid = '0';
let tok = '';

let argct = 0;
for (let a of arg) {
  if (a.toLowerCase() == '-m') use_mr = true;
  else if (a.toLowerCase() == '-d') use_dep = true;
  else {
    switch(argct) {
      case 0: pid = a; break;
      case 1: mrid = a; break;
      case 2: tok = a; break;
      default: break;
    }
    argct++;
  }
}

const fs = require('fs');
const ut = require('./utility_lib.js');

let LogControl = function() {
  this.methods = ["log", "debug", "warn", "info", "error"];
  this.buffer = {};

  // buffer logging functions
  for (let item of this.methods) this.buffer[item] = console[item];

  this.disable = function() {
    for (let item of this.methods) {
      console[item] = function() {}
    }
  }

  this.enable = function() {
    for (let item of this.methods) {
      console[item] = this.buffer[item];
    }
  }
}

// main function
let main = async function() {
  let out = new Set();
  let ok = false;

  // getting list directly from merge request is default
  if (!use_mr && !use_dep) use_mr = true;

  // disable console logging so we don't get status msgs in output
  let ctrl = new LogControl();
  ctrl.disable();

  let info = await ut.getMergeRequest(pid, mrid, tok, true);

  // if we're using merge request results, add to our set
  if (use_mr) {
    if (info) {
      if (info.roxie_data && info.roxie_data.deploy_list) {
        for (let item of info.roxie_data.deploy_list) {
          out.add(item.toLowerCase());
        }
      }
      ok = true;
    }
  }

  // if we're using dependency checking, also add to our set
  if (use_dep) {
    if (info && info.roxie_data && info.roxie_data.change_list) {
      let deps = await ut.findDependencies(info.roxie_data.change_list);
      if (deps) {
        for (let item of deps) {
          out.add(item.toLowerCase());
        }
        ok = true;
      }
    }
  }

  // now we can log again
  ctrl.enable();
  
  // output our results
  for (let item of out) {
    console.log(item);
  }

  return ok;
}

// run the main function
if (arg.length == 0 || pid.toLowerCase() == '--help') {
  console.log('Usage:');
  console.log('get_mr_query_list.js <project_id> <merge_request_id> [gitlab_access_token] [-d/-m]');
}
else main().then((ok) => { 
  process.exit((ok) ? 0 : 2);
});
