#!node

let arg = process.argv.slice(2);
let file = null;
let per = 1;
let discard_nofast = false;
let only_nofast = false;

// process arguments
for (let a of arg) {
  if (a.toLowerCase() == '-n') discard_nofast = true;
  else if (a.toLowerCase() == '-o') only_nofast = true;
  else if (isNaN(a)) file = a;
  else per = parseFloat(a);
}

const fs = require('fs');
const ut = require('./utility_lib.js');

const temp_ecl_file = "../_tmp_ecl.ecl";
const warnings_file = "_syn_check_warnings.log";
const exceptions_file = "nofast_queries.txt";

let workpath = '..';

// main function
let main = async function() {
  let lines = (file) ? ut.getServicesFromFile(file) : await ut.getServices(per);
  let errs = [];
  let warn = [];
  let len = lines.length;
  let num = 0;
  let total = 0;
  let pass = 0;
  let total_time = 0;
  let worst = { name: '', time: 0 };
  let dStart = Date.now();
  
  // make sure any exceptions are loaded prior to syntax check
  let exceptions = ut.getExceptions(exceptions_file);
  
  console.log('Starting Syntax Check at: ' + ut.getDateString());
  console.log('Checking ' + len + ' Queries...');
  console.log('----------------------------------------------------------');
  console.log('');
  
  for (let item of lines) {
    let isLib = ut.isLibrary(item);
    let path = ut.findPath(item, workpath);
    let fast = !(exceptions.has(item.toLowerCase()));
    
    // record percent done
    num++;
    let prog = Math.round((num/len) * 100);
    let pstr = (num + '').padStart(3, ' ') + ' ' + (prog + '%').padStart(4, ' ');
    
    // ignore files that don't exist and skip fast/nofast files as needed
    if (!path) {
      console.log(pstr + '  []      ' + '   ----  ' + item);
      continue;
    }
    else if ((discard_nofast && !fast) || (only_nofast && fast)) {
      console.log(pstr + '  [SKIP]  ' + '   ----  ' + item);
      continue;
    }
    else total++;
    
    // for services, use a temp file that calls the service macro
    if (!isLib) {
      let cmd = item + '()\n';
      try {
        fs.writeFileSync(temp_ecl_file, cmd);
        path = temp_ecl_file;
      }
      catch (err) {}
    }
    
    let t0 = process.hrtime();
    let res = await ut.syntax_check_async(path, workpath, fast);
    let tdd = process.hrtime(t0);
    let tdelt = (tdd[0] * 1000000000 + tdd[1]) / 1000000000;
    let time = (tdelt.toFixed(1) + 's').padStart(7, ' ');
    let lib_msg = (isLib) ? ' [lib]' : '';
    let fast_msg = (fast) ? '' : ' [nofast]';
    
    if (res.ok) {
      let warn_msg = '';

      if (res.stderr) {
        warn.push({ query: item, res: res });
        warn_msg = ' [w]';
      }
      console.log(pstr + '  [OK]    ' + time + '  ' + item + fast_msg + lib_msg + warn_msg);
      pass++;
    }
    else {
      errs.push({ query: item, res: res });
      console.log(pstr + '  [ERROR] ' + time + '  ' + item + fast_msg + lib_msg);
    }
    
    // calculate worst and average time
    total_time += tdelt;
    if (tdelt > worst.time) worst = { name: item, time: tdelt };
  }

  // export the warnings to a file (as there may be a lot of them)
  console.log('\n');
  ut.exportWarnings(warn, warnings_file);
  
  // print out error details
  if (errs.length > 0) {
    console.log('\n\nVerification ERRORS:');
    console.log('----------------------------------------------------------\n');
    
    for (let item of errs) {
      console.log('[[ ' + item.query + ' ]]');
      console.log('----------------------------------------------------------');
      console.log(item.res.stderr);
      console.log('----------------------------------------------------------');
      console.log('');
    }
    console.log('');
  }
  
  let dEnd = Date.now();
  let dsecs = Math.round((dEnd - dStart) / 1000);
  let dhrs = Math.floor(dsecs / 3600); dsecs -= (dhrs * 3600);
  let dmins = Math.floor(dsecs / 60); dsecs -= (dmins * 60);
  console.log('\nScript Finished at: ' + ut.getDateString());
  console.log('Elapsed Time: ' + dhrs + ' hrs, ' + dmins + ' mins, ' + dsecs + ' secs');
  
  if (total > 0) {
    let avg = total_time / total;
    console.log('\nAvg Query Time: ' + avg.toFixed(1) + 's');
    console.log('Max Query Time: ' + worst.time.toFixed(1) + 's  [' + worst.name + ']');
  }
  
  console.log('\n----------------------------------------------------------\nFinal Results: (' + pass + '/' + total + ') Passed');

  // missing queries
  if (total < len) {
    console.log('Missing Queries: ' + (len - total));
  }

  // report warnings
  if (warn.length > 0) {
    console.log('Warning Queries: ' + warn.length);
  }
  
  // throw an error so the task fails if errors were detected
  if (pass < total) {
    console.log('Failed Queries: ' + (total - pass));
    return false;
  }
  else return true;
}

// run the main function
console.log('Running Verification Check:');
main().then((ok) => { 
  if (ok) console.log('Verification PASSED');
  else console.log('Verification FAILED');

  process.exit((ok) ? 0 : 2);
});
